import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// FuckMyBytes v2-RNG
/// anchietae.cc - 2025

/// since fmb works quite interesting, it may not throw an error on an un-decomposable string,
/// so it is recommended to check the string to see if it is intact

class FMBCrypt {
  static final Random _random = Random.secure();

  static Uint8List _generateKey(String password, Uint8List salt) {
    final passwordBytes = utf8.encode(password);

    // PBKDF2 the password (SHA-256, 100000x, 256 bits, salt)
    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    pbkdf2.init(Pbkdf2Parameters(salt, 100000, 32));
    
    final key = pbkdf2.process(Uint8List.fromList(passwordBytes));
    return key;
  }

  static Uint8List _generateRandomBytes(int length) {
    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  static Uint8List _encrypt(String data, String password) {
    try {
      final salt = _generateRandomBytes(16);
      final key = _generateKey(password, salt);
      final iv = _generateRandomBytes(16);

      final inputData = Uint8List.fromList(utf8.encode(data));

      // AES in counter mode
      final cipher = CTRStreamCipher(AESEngine());
      final params = ParametersWithIV(KeyParameter(key), iv);
      cipher.init(true, params);

      final encrypted = Uint8List(inputData.length);
      cipher.processBytes(inputData, 0, inputData.length, encrypted, 0);

      // First 16 bytes: Salt, Next 16 bytes: Initialization vector, Remaining: data
      final result = Uint8List(salt.length + iv.length + encrypted.length);
      result.setRange(0, salt.length, salt);
      result.setRange(salt.length, salt.length + iv.length, iv);
      result.setRange(salt.length + iv.length, result.length, encrypted);

      return result;
    } catch (error) {
      throw Exception('Encryption failed: ${error.toString()}');
    }
  }

  static String _decrypt(Uint8List encryptedData, String password) {
    try {
      final salt = encryptedData.sublist(0, 16);
      final iv = encryptedData.sublist(16, 32);
      final data = encryptedData.sublist(32);

      final key = _generateKey(password, salt);

      final cipher = CTRStreamCipher(AESEngine());
      final params = ParametersWithIV(KeyParameter(key), iv);
      cipher.init(false, params);

      final decrypted = Uint8List(data.length);
      cipher.processBytes(data, 0, data.length, decrypted, 0);

      return utf8.decode(decrypted);
    } catch (error) {
      throw Exception('Decryption failed: ${error.toString()}');
    }
  }

  /// basic usage:
  /// String? encrypted = FMBCrypt.handleText('encrypt', 'Hello World', 'myPassword');
  /// String? decrypted = FMBCrypt.handleText('decrypt', encrypted!, 'myPassword');

  static String? handleText(String action, String input, String password) {
    if (password.isEmpty || input.isEmpty) {
      throw ArgumentError('Password and input cannot be empty');
    }

    try {
      if (action == 'encrypt') {
        final encrypted = _encrypt(input, password);
        return base64Encode(encrypted);
      } else {
        try {
          final decoded = base64Decode(input);
          final decrypted = _decrypt(decoded, password);
          return decrypted;
        } catch (e) {
          throw Exception('Failed to decrypt data: ${e.toString()}');
        }
      }
    } catch (error) {
      throw Exception('Failed to $action data: ${error.toString()}');
    }
  }
}
