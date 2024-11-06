import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:social_wallet/utils/app_constants.dart';

void main() {
  test("EthereumTools", () {
    double tokenBalance = 1231400;
    num result = AppConstants.toWei(tokenBalance, 18);

    num result2 = tokenBalance * pow(10, 18);
    BigInt bigInt = BigInt.from(result2);
    print('Resultadoo ${result.toString()}');
    print('Resultadoo2 ${result2.toString()}');
    print('BigInt ${bigInt}');
  });
}
