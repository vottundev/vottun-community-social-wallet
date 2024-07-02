import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../routes/app_router.dart';
import '../app_constants.dart';



/// A utility class that holds methods for validating different textFields.
/// This class has no constructor and all methods are `static`.
@immutable
class FormValidator{
  const FormValidator._();


  /// A method containing empty string validation logic for patient name input.
  static String? emptyValidator(String? text){
    if(text == null || text.isEmpty) {
      return AppConstants.getStrings(AppRouter.navigatorKey.currentContext!).emptyErrorMessage;
    }
    return null;
  }

  /// A method containing validation logic for email input.
  // static String? emailValidator(String? email){
  //   if(email == null || email.isEmpty) {
  //     return AppConstants.emptyEmailInputError;
  //   } else if (!email.isValidEmail) {
  //     return AppConstants.invalidEmailError;
  //   }
  //   return null;
  // }

  /// A method containing validation logic for password input.
  // static String? passwordValidator(String? password) {
  //   if (password!.isEmpty) {
  //     return AppConstants.emptyPasswordInputError;
  //   } else if (!AppConstants.isPasswordValid(password)) {
  //     return AppConstants.passwordRestrictionsInputError;
  //   }
  //   return null;
  // }

  /// A method containing validation logic for confirm password input.
  // static String? confirmPasswordValidator(String? confirmPw, String inputPw) {
  //   if (confirmPw == inputPw.trim()) return null;
  //   return AppConstants.invalidConfirmPwError;
  // }

  /// A method containing validation logic for current password input.
  // static String? currentPasswordValidator(String? inputPw, String currentPw) {
  //   if (inputPw == currentPw) return null;
  //   return AppConstants.invalidCurrentPwError;
  // }

  /// A method containing validation logic for new password input.
  // static String? newPasswordValidator(String? newPw, String currentPw) {
  //   if (newPw!.isEmpty) {
  //     return AppConstants.emptyPasswordInputError;
  //   }
  //   else if(newPw == currentPw) {
  //     return AppConstants.invalidNewPwError;
  //   }
  //   return null;
  // }

  /// A method containing validation logic for full name input.
  // static String? fullNameValidator(String? fullName) {
  //   if (fullName != null && fullName.isValidFullName) return null;
  //   return AppConstants.invalidFullNameError;
  // }

  /// A method containing validation logic for address input.
  // static String? addressValidator(String? address) {
  //   if (address!.isEmpty) return AppConstants.emptyAddressInputError;
  //   return null;
  // }


}
