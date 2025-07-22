import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fmb_dart/fmb_dart.dart';

void main() {
  test('encryption and decryption test', () async {
    String encrypted =
        await FMBCrypt.handleText('encrypt', 'Hello World!', 'test password');
    expect(encrypted, isNotNull);
    if (kDebugMode) {
      print('encrypted: $encrypted');
    }
    String decrypted =
        await FMBCrypt.handleText('decrypt', encrypted, 'test password');
    expect(decrypted, isNotNull);
    expect(decrypted, equals('Hello World!'));
    if (kDebugMode) {
      print('decrypted: $decrypted');
    }
  });
}
