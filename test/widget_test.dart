import 'package:cbor/cbor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:koronapassi/misc/pass.dart';
import 'package:koronapassi/misc/util.dart';

final inst = Cbor();

String data = "";

String qrTest() {
  Pass? pass = parseQR(data);
  debugPrint(pass.toString());
  return '';
}

void main() {
  testWidgets('Test 1', (WidgetTester tester) async {
    qrTest();
  });
}
