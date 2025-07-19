import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// FuckMyBytes v4
/// anchietae.cc - 2025

// comments stolen from the website, bc was lazy to write acutally understandable stuff

class FMBCrypt {
  static final Random _random = Random.secure();

  static ({Uint8List key, Uint8List salt}) _generateKey(String password, [Uint8List? providedSalt]) {
    final salt = providedSalt ?? _generateRandomBytes(16);
    final passwordBytes = utf8.encode(password);

    // First round: PBKDF2 the password (SHA-256, 600,000x, 256 bits, salt)
    final pbkdf2First = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    pbkdf2First.init(Pbkdf2Parameters(salt, 600000, 32));
    final firstKey = pbkdf2First.process(passwordBytes);

    // Second round: PBKDF2 the result (SHA-512, 100,000x, 256 bits, salt)
    final pbkdf2Second = PBKDF2KeyDerivator(HMac(SHA512Digest(), 128));
    pbkdf2Second.init(Pbkdf2Parameters(salt, 100000, 32));
    final finalKey = pbkdf2Second.process(firstKey);

    // Clear key from mem
    firstKey.fillRange(0, firstKey.length, 0);
    
    return (key: finalKey, salt: salt);
  }

  static Uint8List _generateRandomBytes(int length) {
    final bytes = Uint8List(length);
    for (int i = 0; i < length; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  // data wiper
  static void _secureWipe(Uint8List buffer) {
    for (int i = 0; i < buffer.length; i++) {
      buffer[i] = _random.nextInt(256);
    }
    buffer.fillRange(0, buffer.length, 0);
  }

  static Uint8List _encrypt(String data, String password) {
    try {
      final keyResult = _generateKey(password);
      final key = keyResult.key;
      final salt = keyResult.salt;

      // Generate a 12-byte nonce for GCM
      final nonce = _generateRandomBytes(12);

      // Create associated data (version + salt + timestamp) for authentication
      final version = utf8.encode('FMB4');
      final timestamp = Uint8List(8);
      final now = DateTime.now().millisecondsSinceEpoch;
      
      for (int i = 7; i >= 0; i--) {
        timestamp[7 - i] = (now >> (i * 8)) & 0xff;
      }

      final associatedData = Uint8List(version.length + salt.length + timestamp.length);
      associatedData.setRange(0, version.length, version);
      associatedData.setRange(version.length, version.length + salt.length, salt);
      associatedData.setRange(version.length + salt.length, associatedData.length, timestamp);

      final inputData = utf8.encode(data);

      // Set up AES-256 in GCM mode (authenticated encryption)
      final cipher = GCMBlockCipher(AESEngine());
      final params = AEADParameters(
        KeyParameter(key), 
        128,
        nonce, 
        associatedData
      );
      cipher.init(true, params);

      final encrypted = Uint8List(inputData.length + 16);
      final len = cipher.processBytes(inputData, 0, inputData.length, encrypted, 0);
      final finalLen = len + cipher.doFinal(encrypted, len);

      final result = Uint8List(version.length + salt.length + timestamp.length + nonce.length + finalLen);
      result.setRange(0, version.length, version);
      result.setRange(version.length, version.length + salt.length, salt);
      result.setRange(version.length + salt.length, version.length + salt.length + timestamp.length, timestamp);
      result.setRange(version.length + salt.length + timestamp.length, version.length + salt.length + timestamp.length + nonce.length, nonce);
      result.setRange(version.length + salt.length + timestamp.length + nonce.length, result.length, encrypted.sublist(0, finalLen));

      _secureWipe(key);

      return result;
    } catch (error) {
      throw Exception('Encryption failed: ${error.toString()}');
    }
  }

  static String _decrypt(Uint8List encryptedData, String password) {
    try {
      if (encryptedData.length < 56) {
        throw Exception('Invalid encrypted data: too short');
      }

      final version = utf8.decode(encryptedData.sublist(0, 4));
      if (version != 'FMB4') {
        throw Exception('Invalid or unsupported file format');
      }

      final salt = encryptedData.sublist(4, 20);
      final timestamp = encryptedData.sublist(20, 28);
      final nonce = encryptedData.sublist(28, 40);
      final data = encryptedData.sublist(40);

      final versionBytes = utf8.encode('FMB4');
      final associatedData = Uint8List(versionBytes.length + salt.length + timestamp.length);
      associatedData.setRange(0, versionBytes.length, versionBytes);
      associatedData.setRange(versionBytes.length, versionBytes.length + salt.length, salt);
      associatedData.setRange(versionBytes.length + salt.length, associatedData.length, timestamp);

      final keyResult = _generateKey(password, salt);
      final key = keyResult.key;

      final cipher = GCMBlockCipher(AESEngine());
      final params = AEADParameters(
        KeyParameter(key),
        128,
        nonce,
        associatedData
      );
      cipher.init(false, params);

      final decrypted = Uint8List(data.length - 16);
      final len = cipher.processBytes(data, 0, data.length, decrypted, 0);
      final finalLen = len + cipher.doFinal(decrypted, len);

      _secureWipe(key);

      return utf8.decode(decrypted.sublist(0, finalLen));
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

    const maxTextSize = 50 * 1024 * 1024; // 50MB
    if (input.length > maxTextSize) {
      throw ArgumentError('Text too large. Maximum size is 50MB.');
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
