import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:social_wallet/utils/app_constants.dart';

void main() {
  test("EthereumTools", () {
    double tokenBalance = 0.05;

    ByteData byteData = ByteData(16);
    byteData.setFloat64(0, tokenBalance);
    List<int> bytes = byteData.buffer.asUint8List();
    String hexString = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');

    print(hexString);
    String parsedValue = AppConstants.toWeiString(hexString, 18);

    print("hola $parsedValue");
  });
}
