// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firka/fmb_crypt.dart';

void main() {
  test('encryption and decryption test', () async {
    String? encrypted = FMBCrypt.handleText('encrypt', 'Hello World!', 'test password');
    expect(encrypted, isNotNull);
    expect(encrypted, equals('eBzx7LhjOE7NW5Ba'));
    if (kDebugMode) {
      print('encrypted: $encrypted');
    }
    String? decrypted = FMBCrypt.handleText('decrypt', encrypted!, 'test password');
    expect(decrypted, isNotNull);
    expect(decrypted, equals('Hello World!'));
    if (kDebugMode) {
      print('decrypted: $decrypted');
    }
  });
}
