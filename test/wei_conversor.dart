import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:social_wallet/utils/app_constants.dart';

void main() {
  test("EthereumTools", () {
    double tokenBalance = 0.05;
    String parsedValue = AppConstants.toWei(tokenBalance, 18);
    print("parsed value less than 1 $parsedValue");

    double tokenBalance2 = 183945.53234;
    double parsedValueNum = 0;

    int decimalPartLength = tokenBalance2.toString().split(".")[1].length;
    if (decimalPartLength > 0) {
      parsedValueNum = tokenBalance2 * pow(10, decimalPartLength);
    }

    String parsedValue2 = AppConstants.toWei(parsedValueNum, 18 - decimalPartLength);
    print("parsed value greater than 1 $parsedValue2");
  });
}
