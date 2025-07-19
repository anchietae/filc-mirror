import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firka/fmb_crypt.dart';

void main() {
  test('encryption and decryption test', () {
    String? encrypted =
        FMBCrypt.handleText('encrypt', 'Hello World!', 'test password');
    expect(encrypted, isNotNull);
    expect(encrypted!.length, greaterThan(16));
    if (kDebugMode) {
      print('encrypted: $encrypted');
    }
    String? decrypted =
        FMBCrypt.handleText('decrypt', encrypted, 'test password');
    expect(decrypted, isNotNull);
    expect(decrypted, equals('Hello World!'));
    if (kDebugMode) {
      print('decrypted: $decrypted');
    }
  });
}
