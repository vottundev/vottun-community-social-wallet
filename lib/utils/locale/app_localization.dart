import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../l10n/messages_all_locales.dart';

/// https://medium.com/@puneetsethi25/flutter-internationalization-switching-locales-manually-f182ec9b8ff0
/// Command to generate int_messages => once this command is executed => copy all intl_message content and paste to intl_es, intl_xx
/// flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/utils/locale/app_localization.dart
///
/// This command must be executed after above command. This command will generate messages_es.dart file that is needed to be able to change languages in app.
/// flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_messages.arb lib/l10n/intl_es.arb lib/utils/locale/app_localization.dart
class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  //region login screen
  String get socialWalletName {
    return Intl.message('SocialWallet', name: 'socialWalletName');
  }

  String get loginText {
    return Intl.message('Sign In', name: 'loginText');
  }

  String get signUpText {
    return Intl.message('Sign Up', name: 'signUpText');
  }

  String get emailText {
    return Intl.message('Email', name: 'emailText');
  }

  String get usernameText {
    return Intl.message('Username', name: 'usernameText');
  }

  String get emailTextInstructions {
    return Intl.message('Your email', name: 'emailTextInstructions');
  }

  String get passwordText {
    return Intl.message('Password', name: 'passwordText');
  }

  String get otpCodeLabelText {
    return Intl.message('OTP Code', name: 'otpCodeLabelText');
  }

  String get otpCodeHint {
    return Intl.message('Write OTP code', name: 'otpCodeHint');
  }

  String get passwordTextInstructions {
    return Intl.message('Your password', name: 'passwordTextInstructions');
  }

  String get forgottenPassText {
    return Intl.message('¿Have you forget your password?', name: 'forgottenPassText');
  }

  String get exploreText {
    return Intl.message('Explorer', name: 'exploreText');
  }

  String get recoverPassTitle {
    return Intl.message('Recover your password.', name: 'recoverPassTitle');
  }

  String get incorrectCredentialsTitle {
    return Intl.message('Incorrect username or password', name: 'incorrectCredentialsTitle');
  }

  //endregion

  //region commmon text
  String get backText {
    return Intl.message('Back', name: 'backText');
  }

  String get continueText {
    return Intl.message('Continue', name: 'continueText');
  }

  String get cancelText {
    return Intl.message('Cancel', name: 'cancelText');
  }

  String get commonErrorMessage {
    return Intl.message('Something went wrong. Thanks for your patience :)', name: 'commonErrorMessage');
  }

  String get totalAmountText {
    return Intl.message("Total amount", name: 'totalAmountText');
  }

  String get doneText {
    return Intl.message("Done", name: 'doneText');
  }

  //endregion

  //region Network Selector
  String get selectNetworkText {
    return Intl.message("Select network", name: 'selectNetworkText');
  }

  String get selectCurrencyToDoPayment {
    return Intl.message("Select currency to do the payment", name: 'selectCurrencyToDoPayment');
  }

  //endregion

  //region bottom tab bar options labels
  String get dirPayBottomLabel {
    return Intl.message('Dir. Pay', name: 'dirPayBottomLabel');
  }

  String get sharedPayBottomLabel {
    return Intl.message('Shared Pay', name: 'sharedPayBottomLabel');
  }

  String get contactsBottomLabel {
    return Intl.message('Contacts', name: 'contactsBottomLabel');
  }

  //endregion

  //region tab bar options labels
  String get dirPayLabel {
    return Intl.message('Dir. Payment', name: 'dirPayLabel');
  }

  String get historyLabel {
    return Intl.message('History', name: 'historyLabel');
  }

  String get cryptoLabel {
    return Intl.message('Crypto', name: 'cryptoLabel');
  }

  //endregion

  //region Amount to sent dialog
  String get amountToSentTitle {
    return Intl.message('Amount to sent', name: 'amountToSentTitle');
  }

  String get amountCannotBeZeroTitle {
    return Intl.message('Amount cannot be 0', name: 'amountCannotBeZeroTitle');
  }

  String get exceededWalletBalance {
    return Intl.message("Exceeded your wallet balance, please add funds", name: 'exceededWalletBalance');
  }

  //endregion

  //region Schedule Payments
  String get createSchedulePaymentText {
    return Intl.message('Create Shared Payment', name: 'createSchedulePaymentText');
  }

  String get requestSharedPaymentText {
    return Intl.message('Request Shared Payment', name: 'requestSharedPaymentText');
  }

  String get selectRecipientText {
    return Intl.message('Select recipient', name: 'selectRecipientText');
  }

  String get activeText {
    return Intl.message('Active', name: 'activeText');
  }

  String get emptySchedulePayment {
    return Intl.message('Not created any shared payment yet! :(', name: 'emptySchedulePayment');
  }

  String get amountToPay {
    return Intl.message('Amount to pay', name: 'amountToPay');
  }

  String get txDetailsText {
    return Intl.message('Tx Details', name: 'txDetailsText');
  }

  String get statusText {
    return Intl.message('Status', name: 'statusText');
  }

  String get youHavePayedText {
    return Intl.message('You have payed', name: 'youHavePayedText');
  }

  String get numConfirmationsText {
    return Intl.message('Num confirmations', name: 'numConfirmationsText');
  }

  String get totalRequiredConfirmations {
    return Intl.message('Total required confirmations', name: 'totalRequiredConfirmations');
  }

  String get approveTransactionText {
    return Intl.message('Approve Transaction', name: 'approveTransactionText');
  }

  String get payText {
    return Intl.message('PAY', name: 'payText');
  }

  String get executeTx {
    return Intl.message('Execute Tx', name: 'executeTx');
  }

  String get exceededTotalAmount {
    return Intl.message('Exceeded total amount', name: 'exceededTotalAmount');
  }

  String get totalAmountCannotBeEmptyMessage {
    return Intl.message('Total amount cannot be empty', name: 'totalAmountCannotBeEmptyMessage');
  }

  String get pendingAmountText {
    return Intl.message('Pending amount', name: 'pendingAmountText');
  }

  String get addUserText {
    return Intl.message('Add User', name: 'addUserText');
  }

  String get addMyAmountText {
    return Intl.message('Add my amount', name: 'addMyAmountText');
  }

  String get startPaymentText {
    return Intl.message('Start Payment', name: 'startPaymentText');
  }

  String get introTotalAmountToPayText {
    return Intl.message('Introduce total amount to pay', name: 'introTotalAmountToPayText');
  }

  String get proceedText {
    return Intl.message('Proceed', name: 'proceedText');
  }

  String get introYourTotalAmountToPayText {
    return Intl.message("Introduce your total amount to pay", name: 'introYourTotalAmountToPayText');
  }

  String get yourAmountToPay {
    return Intl.message('Your amount', name: 'yourAmountToPay');
  }

  String get exceededAmountOfWalletMessage {
    return Intl.message('Exceeded amount of your wallet', name: 'exceededAmountOfWalletMessage');
  }

  String get networkText {
    return Intl.message('Network', name: 'networkText');
  }

  String get createText {
    return Intl.message('Create', name: 'createText');
  }

  String get twoFAValidationCodeText {
    return Intl.message('2FA Validation code', name: 'twoFAValidationCodeText');
  }

  String get sendVerificationCodeText {
    return Intl.message('Send Verification Code', name: 'sendVerificationCodeText');
  }

  String get otpEmailSendSuccessMessage {
    return Intl.message('Verification code sent to your email', name: 'otpEmailSendSuccessMessage');
  }

  String get otpValidationCodeText {
    return Intl.message('OTP Validation code', name: 'otpValidationCodeText');
  }

  String get resendText {
    return Intl.message('Resend', name: 'resendText');
  }

  String get singleUseCodeMessage {
    return Intl.message('Remember, this code is for single use only and is valid for 90 seconds.',
        name: 'singleUseCodeMessage');
  }

  String amountForMessage(String contactName) {
    return Intl.message("Amount for $contactName", args: [contactName], name: 'amountForMessage');
  }

  String introAmountForMessage(String contactName) {
    return Intl.message("Introduce amount for$contactName", args: [contactName], name: 'introAmountForMessage');
  }

  String requestPaymentToYouMessage(
      String ownerUsername,
      String amountToPay,
      String currencySymbol,
      String currencyName) {
    return Intl.message(
        '$ownerUsername has requested you to PAY $amountToPay $currencySymbol (x\$). \n\nReason: $currencyName',
        args: [ownerUsername, amountToPay, currencySymbol, currencyName],
        name: 'requestPaymentToYouMessage');
  }

  String requestedPaymentMessage(
      String totalAmount,
      String currencySymbol,
      String participantsUsername,
      String currencyName) {
    return Intl.message(
        'Requested $totalAmount $currencySymbol (x\$) to: $participantsUsername \n\nReason: $currencyName',
        args: [totalAmount, currencySymbol, participantsUsername, currencyName],
        name: 'requestedPaymentMessage');
  }

  //endregion

  //region Contacts
  String get addContact {
    return Intl.message('Add Contact', name: 'addContact');
  }

  String get searchByHintText {
    return Intl.message('Search contact by username or email', name: 'searchByHintText');
  }

  String get contactAlreadyAddedText {
    return Intl.message('Contact already added', name: 'contactAlreadyAddedText');
  }

  //endregion

  //region Configuration
  String get configurationText {
    return Intl.message('Configuration', name: 'configurationText');
  }

  String get mainnetEnabledText {
    return Intl.message('Mainnet enabled', name: 'mainnetEnabledText');
  }

  String get testnetEnabledText {
    return Intl.message('Testnet enabled', name: 'testnetEnabledText');
  }

  String get logOutText {
    return Intl.message('Log out', name: 'logOutText');
  }

  //endregion

  //region direct payments
  String get directPaymentText {
    return Intl.message('Direct payment', name: 'directPaymentText');
  }

  String get searchContacts {
    return Intl.message('Search in contacts', name: 'searchContacts');
  }

  String get createWalletFirstMessage {
    return Intl.message("Create a wallet first", name: 'createWalletFirstMessage');
  }

  String get selectNetworkFirstMessage {
    return Intl.message("Select a network first", name: 'selectNetworkFirstMessage');
  }

  String get selectContactMessage {
    return Intl.message("Select a contact first", name: 'selectContactMessage');
  }

  String get emptyDirectPaymentsMessage {
    return Intl.message("You don't have any record yet :(", name: 'emptyDirectPaymentsMessage');
  }

  String get amountToSendSuccessMessage {
    return Intl.message('Amount send it!', name: 'amountToSendSuccessMessage');
  }

  //endregion

  //region OTP Screen
  String get otpAuthenticationTitle {
    return Intl.message("OTP Authentication", name: 'otpAuthenticationTitle');
  }

  String get incorrectOtpCodeMessage {
    return Intl.message("Incorrect OTP code", name: 'incorrectOtpCodeMessage');
  }

  String get otpVerificationText {
    return Intl.message("OTP Verification", name: 'otpVerificationText');
  }

  String get requestedToText {
    return Intl.message("Requested to", name: 'requestedToText');
  }

  String get requestedAmountToText {
    return Intl.message("Requested amount", name: 'requestedAmountToText');
  }

  //endregion

  //region Select contact bottom dialog
  String get yourContactsText {
    return Intl.message('Your contacts', name: 'yourContactsText');
  }

  String get sendText {
    return Intl.message('Send', name: 'sendText');
  }

  String get emptyContactsMessage {
    return Intl.message("You don't have contacts, add new contact to start doing payments!",
        name: 'emptyContactsMessage');
  }

  //endregion

  //region error messages
  String get emptyErrorMessage {
    return Intl.message('Error', name: 'emptyErrorMessage');
  }

  String get registerErrorMessage {
    return Intl.message('Error on register user', name: 'registerErrorMessage');
  }

  String get errorText {
    return Intl.message('Error', name: 'errorText');
  }
//endregion
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriddenLocale;

  const AppLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => ['es'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) => AppLocalization.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
