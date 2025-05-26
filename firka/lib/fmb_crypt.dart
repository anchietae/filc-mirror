import 'dart:typed_data';
import 'dart:convert';

/// FuckMyBytes v2
/// mnus.moe - 2025

/// since fmb works quite interesting, it may not throw an error on an un-decomposable string,
/// so it is recommended to check the string to see if it is intact

class FMBCrypt {
  static Uint8List generateKey(String password) {
    final key = Uint8List(32);
    int hash = 0;

    for (int i = 0; i < password.length; i++) {
      hash = ((hash << 5) - hash) + password.codeUnitAt(i);
      hash = hash & hash;
    }

    for (int i = 0; i < 32; i++) {
      hash = ((hash * 1664525 + 1013904223) & 0xFFFFFFFF);
      key[i] = hash & 0xFF;
    }

    return key;
  }

  static Uint8List generateStream(Uint8List key, int length) {
    final stream = Uint8List(length);
    final state = Uint32List(4);

    for (int i = 0; i < 4; i++) {
      state[i] = ((key[i * 4] << 24) |
              (key[i * 4 + 1] << 16) |
              (key[i * 4 + 2] << 8) |
              key[i * 4 + 3]) >>>
          0;
    }

    for (int i = 0; i < length; i++) {
      state[0] = (state[0] + state[1]) >>> 0;
      state[1] = ((state[1] << 7) | (state[1] >>> 25)) >>> 0;
      state[2] = (state[2] + state[3]) >>> 0;
      state[3] = ((state[3] << 13) | (state[3] >>> 19)) >>> 0;

      stream[i] = (state[0] ^ state[2]) & 0xFF;
    }

    return stream;
  }

  static Uint8List processData(dynamic data, String password) {
    try {
      final Uint8List inputData;
      if (data is Uint8List) {
        inputData = data;
      } else if (data is String) {
        inputData = Uint8List.fromList(utf8.encode(data));
      } else {
        throw ArgumentError('Data must be either String or Uint8List');
      }

      final key = generateKey(password);
      final stream = generateStream(key, inputData.length);

      final output = Uint8List(inputData.length);
      for (int i = 0; i < inputData.length; i++) {
        output[i] = inputData[i] ^ stream[i];
      }

      return output;
    } catch (error) {
      throw Exception('Failed to process data: ${error.toString()}');
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
        final encrypted = processData(input, password);
        return base64Encode(encrypted);
      } else {
        try {
          final decoded = base64Decode(input);
          final decrypted = processData(decoded, password);
          return utf8.decode(decrypted);
        } catch (e) {
          throw Exception('Failed to decrypt data: ${e.toString()}');
        }
      }
    } catch (error) {
      throw Exception('Failed to $action data: ${error.toString()}');
    }
  }
}
