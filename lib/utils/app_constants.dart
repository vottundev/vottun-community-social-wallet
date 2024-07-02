
import 'dart:io';
import 'dart:math';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_wallet/models/allowance_response_model.dart';
import 'package:social_wallet/models/db/shared_payment_response_model.dart';
import 'package:social_wallet/models/db/shared_payment_users.dart';
import 'package:social_wallet/models/enum_shared_payment_status.dart';
import 'package:web3dart/web3dart.dart';

import '../di/injector.dart';
import '../models/db/user.dart';
import '../utils/helpers/extensions/context_extensions.dart';
import 'app_colors.dart';
import 'locale/app_localization.dart';


@immutable
class AppConstants {
  const AppConstants._();

  static const double paddingHorizontalPercentage = 0.09;
  static const double percetageOfScreenHeightBottomSheet = 0.95;
  static const String vottunApi = "https://api.vottun.tech/core/v1/";
  //todo find out how to send blockchain explorer web
  static const String mumbaiScannerUrl = "https://mumbai.polygonscan.com/address/";

  //todo pending check actions for use email already registered in vottun service
  static const String testEmail = "test_srs_19@yopmail.com";
  static const String testUsername = "test_srs_19";
  static const String testPassword = "Doonamis.2022!";

  static String getCreateWalletUrl({required String hash, required String username}) {
    return "https://wallet.vottun.io/?hash=$hash&username=$username";
  }

  static AppLocalization getStrings(BuildContext context) {
    return AppLocalization.of(context)!;
  }
  static getHeightBoxConstraintForModalBottomSheet(BuildContext context, {double? value}) =>
      BoxConstraints(maxHeight: ContextUtils(context).screenHeight * (value ?? percetageOfScreenHeightBottomSheet));

  static EdgeInsetsGeometry getScreenPadding(BuildContext context) {
    return EdgeInsets.only(
      top: ContextUtils(context).screenHeight * 0.05,
      right: ContextUtils(context).screenWidth * paddingHorizontalPercentage,
      left: ContextUtils(context).screenWidth * paddingHorizontalPercentage,
      bottom: ContextUtils(context).screenHeight * 0.03
    );
  }

  static User? getCurrentUser() {
    return getKeyValueStorage().getCurrentUser();
  }

  static Future<void> showFilePicker({
    FileType? fileType,
    bool? allowMultiple,
    required Function(List<PlatformFile>? selectedFiles) onFilesSelected
  }) async {
    await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple ?? false,
        withReadStream: true,
        type: fileType ?? FileType.any
    ).then((filePickerResult) {
      onFilesSelected(filePickerResult?.files);
    });
  }

  static void showBottomDialog({
    required BuildContext context,
    required Widget body,
    bool? enableDrag,
    bool isScrollControlled = false,
    double? heightBoxConstraintRate
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: isScrollControlled,
        enableDrag: enableDrag ?? true,
        //constraints: AppConstants.getHeightBoxConstraintForModalBottomSheet(context, value: heightBoxConstraintRate ?? 0.75),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
        ),
        backgroundColor: AppColors.bottomDialogBackgroundColor,
        useSafeArea: true,
        builder: (context) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              body: body
          );
        });
  }

  static double getToolbarSize(BuildContext context) {
    return ContextUtils(context).screenHeight * 0.080;
  }

  static void showToast(BuildContext context, String message, {Function()? onError}) {
    if (onError != null) {
      onError();
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3);
  }

  static String trimAddress({String? address, int? trimLength}) {
    String userAddress = "";
    if (address != null) {
      if (address.isNotEmpty) {
        userAddress = address;
        userAddress = '${address.substring(0, trimLength ?? 8)}...${address.substring(address.length - (trimLength ?? 8), address.length)}';
      }
    }
    return userAddress;
  }

  static String parseTokenBalanceFromHex(String tokenBalance, int decimals) {
    BigInt intValue = BigInt.parse(tokenBalance);
    int fixedValue = intValue == BigInt.zero ? 2 : 4;
    String result = (intValue / BigInt.from(10).pow(decimals)).toStringAsFixed(fixedValue);
    return result;
  }

  static BigInt parseTokenBalanceBigInt(String tokenBalance, int decimals) {
    BigInt intValue = BigInt.parse(tokenBalance);
    String result = (intValue / BigInt.from(10).pow(decimals)).toStringAsFixed(2);
    return BigInt.parse(result);
  }

  //todo not working if token balance >= 10
  static num toWei2(double tokenBalance, int decimals) {
    num result = tokenBalance * pow(10, decimals);
    return result;
  }
  //todo not working if token balance >= 10
    static String toWei(double tokenBalance, int decimals) {
    double finalResult = 0.0;
    if (tokenBalance <= 1.0) {
      finalResult = tokenBalance * pow(10, decimals);
      return finalResult.round().toString();
    } else {
      EtherAmount result = EtherAmount.fromBigInt(EtherUnit.ether, BigInt.from(tokenBalance));
      return (result.getInEther / BigInt.from(pow(10, decimals))).toString();
    }
  }

  //todo not working if token balance >= 10
  static String toWeiString(String tokenBalance, int decimals) {
    EtherAmount result = EtherAmount.fromBase10String(EtherUnit.wei, tokenBalance.toString());
    return result.toString();
  }

  static String parseTokenBalance(String tokenBalance, int decimals) {
    double parsedValue = double.parse(tokenBalance);
    if (parsedValue == 0.0) {
      return "";
    }
    BigInt intValue = BigInt.parse(parsedValue.toInt().toString());
    String result = (intValue / BigInt.from(10).pow(decimals)).toStringAsFixed(2);
    return result;
  }

  static int getNumDecimalsAfterPoint(double value) {
    int numDecimals = value.toString().split(".")[1].length;
    if (numDecimals < 2) {
      numDecimals = 2;
    }
    return numDecimals;
  }

  static Future<List<String>?> showCustomTextInputDialog({
    required BuildContext context,
    required String title,
    String? message,
    bool? barrierDismissible,
    bool? canPop,
    required String okLabel,
    required String cancelLabel,
    required List<DialogTextField> textFields,
    bool? fullyCapitalizedForMaterial
  }) async {
    List<String>? result = await showTextInputDialog(
        context: context,
        title: title,
        message: message,
        cancelLabel: cancelLabel,
        okLabel: okLabel,
        canPop: canPop ?? true,
        barrierDismissible: barrierDismissible ?? true,
        fullyCapitalizedForMaterial: fullyCapitalizedForMaterial ?? false,
        style: Platform.isIOS ? AdaptiveStyle.iOS : AdaptiveStyle.material,
        textFields: textFields
    );
    return result;

  }

  static String getSharedPaymentStatus({
    required SharedPaymentResponseModel sharedPayment,
    required AllowanceResponseModel? allowanceResponseModel,
    required int txCurrNumConfirmation,
    required int txCurrTotalNumConfirmation,
    required bool isExecuted,
  }) {
    bool isOwner = (sharedPayment.sharedPayment.ownerAddress ?? '') == getKeyValueStorage().getUserAddress();
    int totalConfirmations = txCurrTotalNumConfirmation;
    SharedPaymentUsers? sharedPaymentUsers;

    if (!isOwner && sharedPayment.sharedPaymentUser != null) {
      sharedPaymentUsers = sharedPayment.sharedPaymentUser!.where((element) => (element.userAddress == getKeyValueStorage().getUserAddress()) && (getKeyValueStorage().getUserAddress()?.isNotEmpty ?? false)).firstOrNull;
    }
    if (txCurrNumConfirmation == 0) {
      if (isOwner) {
        return ESharedPaymentStatus.PENDING.name;
      }
      if (sharedPayment.sharedPayment.currencyAddress == null || sharedPayment.sharedPayment.currencyAddress?.isEmpty == true) {
        return ESharedPaymentStatus.PAY.name;
      }
      if (allowanceResponseModel != null && sharedPayment.sharedPayment.tokenDecimals != null) {
        if (allowanceResponseModel.allowance >= num.parse(AppConstants.toWei(sharedPaymentUsers?.userAmountToPay ?? 0.0, sharedPayment.sharedPayment.tokenDecimals!).toString())) {
          return ESharedPaymentStatus.PAY.name;
        }
      }
      return ESharedPaymentStatus.APPROVE.name;
    }
    if (txCurrNumConfirmation < totalConfirmations) {
      if (sharedPaymentUsers != null) {
        if (allowanceResponseModel != null) {
          if (allowanceResponseModel.allowance == 0 && sharedPaymentUsers.hasPayed == 0) {
            return ESharedPaymentStatus.APPROVE.name;
          }
        }
        if (sharedPaymentUsers.hasPayed == 0) {
          return ESharedPaymentStatus.PAY.name;
        } else if (sharedPaymentUsers.hasPayed == 1) {
          return ESharedPaymentStatus.CONFIRMED.name;
        }
      }

      return ESharedPaymentStatus.PENDING.name;
    } else if (txCurrNumConfirmation == totalConfirmations) {
      if (isOwner) {
        if (isExecuted) {
          return ESharedPaymentStatus.FINISHED.name;
        }
        return ESharedPaymentStatus.READY.name;
      } else {
        if (!isExecuted) {
          return ESharedPaymentStatus.CONFIRMED.name;
        }
        return ESharedPaymentStatus.FINISHED.name;
      }
    }
    return "";
  }

  static Color getSharedPaymentStatusColor({
    String? status
  }) {
    if (status == null) {
      return Colors.red;
    }
    if (ESharedPaymentStatus.STARTED.name == status) {
      return Colors.blue;
    }
    if (ESharedPaymentStatus.PENDING.name == status) {
      return Colors.orange;
    }
    if (ESharedPaymentStatus.APPROVE.name == status) {
      return Colors.green;
    }
    if (ESharedPaymentStatus.PAY.name == status) {
      return Colors.lightGreen;
    }
    if (ESharedPaymentStatus.FINISHED.name == status) {
      return Colors.blueGrey;
    }
    if (ESharedPaymentStatus.READY.name == status) {
      return Colors.green;
    }
    return Colors.red;
  }
}
