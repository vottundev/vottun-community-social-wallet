// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'es';

  static m0(contactName) => "Amount for ${contactName}";

  static m1(contactName) => "Introduce amount for${contactName}";

  static m2(ownerUsername, amountToPay, currencySymbol, currencyName) => "${ownerUsername} has requested you to PAY ${amountToPay} ${currencySymbol} (x\$). \n\nReason: ${currencyName}";

  static m3(totalAmount, currencySymbol, participantsUsername, currencyName) => "Requested ${totalAmount} ${currencySymbol} (x\$) to: ${participantsUsername} \n\nReason: ${currencyName}";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'activeText': MessageLookupByLibrary.simpleMessage('Active'),
    'addContact': MessageLookupByLibrary.simpleMessage('Add Contact'),
    'addMyAmountText': MessageLookupByLibrary.simpleMessage('Add my amount'),
    'addUserText': MessageLookupByLibrary.simpleMessage('Add User'),
    'amountCannotBeZeroTitle': MessageLookupByLibrary.simpleMessage('Amount cannot be 0'),
    'amountForMessage': m0,
    'amountToPay': MessageLookupByLibrary.simpleMessage('Amount to pay'),
    'amountToSendSuccessMessage': MessageLookupByLibrary.simpleMessage('Amount send it!'),
    'amountToSentTitle': MessageLookupByLibrary.simpleMessage('Amount to sent'),
    'approveTransactionText': MessageLookupByLibrary.simpleMessage('Approve Transaction'),
    'backText': MessageLookupByLibrary.simpleMessage('Back'),
    'cancelText': MessageLookupByLibrary.simpleMessage('Cancel'),
    'commonErrorMessage': MessageLookupByLibrary.simpleMessage('Something went wrong. Thanks for your patience :)'),
    'configurationText': MessageLookupByLibrary.simpleMessage('Configuration'),
    'contactAlreadyAddedText': MessageLookupByLibrary.simpleMessage('Contact already added'),
    'contactsBottomLabel': MessageLookupByLibrary.simpleMessage('Contacts'),
    'continueText': MessageLookupByLibrary.simpleMessage('Continue'),
    'createSchedulePaymentText': MessageLookupByLibrary.simpleMessage('Create Shared Payment'),
    'createText': MessageLookupByLibrary.simpleMessage('Create'),
    'createWalletFirstMessage': MessageLookupByLibrary.simpleMessage('Create a wallet first'),
    'cryptoLabel': MessageLookupByLibrary.simpleMessage('Crypto'),
    'dirPayBottomLabel': MessageLookupByLibrary.simpleMessage('Dir. Pay'),
    'dirPayLabel': MessageLookupByLibrary.simpleMessage('Dir. Payment'),
    'directPaymentText': MessageLookupByLibrary.simpleMessage('Direct payment'),
    'doneText': MessageLookupByLibrary.simpleMessage('Done'),
    'emailText': MessageLookupByLibrary.simpleMessage('Email'),
    'emailTextInstructions': MessageLookupByLibrary.simpleMessage('Your email'),
    'emptyContactsMessage': MessageLookupByLibrary.simpleMessage('You don\'t have contacts, add new contact to start doing payments!'),
    'emptyDirectPaymentsMessage': MessageLookupByLibrary.simpleMessage('You don\'t have any record yet :('),
    'emptyErrorMessage': MessageLookupByLibrary.simpleMessage('Error'),
    'emptySchedulePayment': MessageLookupByLibrary.simpleMessage('Not created any shared payment yet! :('),
    'errorText': MessageLookupByLibrary.simpleMessage('Error'),
    'exceededAmountOfWalletMessage': MessageLookupByLibrary.simpleMessage('Exceeded amount of your wallet'),
    'exceededTotalAmount': MessageLookupByLibrary.simpleMessage('Exceeded total amount'),
    'exceededWalletBalance': MessageLookupByLibrary.simpleMessage('Exceeded your wallet balance, please add funds'),
    'executeTx': MessageLookupByLibrary.simpleMessage('Execute Tx'),
    'exploreText': MessageLookupByLibrary.simpleMessage('Explorer'),
    'forgottenPassText': MessageLookupByLibrary.simpleMessage('¿Have you forget your password?'),
    'historyLabel': MessageLookupByLibrary.simpleMessage('History'),
    'incorrectCredentialsTitle': MessageLookupByLibrary.simpleMessage('Incorrect username or password'),
    'incorrectOtpCodeMessage': MessageLookupByLibrary.simpleMessage('Incorrect OTP code'),
    'introAmountForMessage': m1,
    'introTotalAmountToPayText': MessageLookupByLibrary.simpleMessage('Introduce total amount to pay'),
    'introYourTotalAmountToPayText': MessageLookupByLibrary.simpleMessage('Introduce your total amount to pay'),
    'logOutText': MessageLookupByLibrary.simpleMessage('Log out'),
    'loginText': MessageLookupByLibrary.simpleMessage('Sign In'),
    'mainnetEnabledText': MessageLookupByLibrary.simpleMessage('Mainnet enabled'),
    'networkText': MessageLookupByLibrary.simpleMessage('Network'),
    'numConfirmationsText': MessageLookupByLibrary.simpleMessage('Num confirmations'),
    'otpAuthenticationTitle': MessageLookupByLibrary.simpleMessage('OTP Authentication'),
    'otpCodeHint': MessageLookupByLibrary.simpleMessage('Write OTP code'),
    'otpCodeLabelText': MessageLookupByLibrary.simpleMessage('OTP Code'),
    'otpEmailSendSuccessMessage': MessageLookupByLibrary.simpleMessage('Verification code sent to your email'),
    'otpValidationCodeText': MessageLookupByLibrary.simpleMessage('OTP Validation code'),
    'otpVerificationText': MessageLookupByLibrary.simpleMessage('OTP Verification'),
    'passwordText': MessageLookupByLibrary.simpleMessage('Password'),
    'passwordTextInstructions': MessageLookupByLibrary.simpleMessage('Your password'),
    'payText': MessageLookupByLibrary.simpleMessage('PAY'),
    'pendingAmountText': MessageLookupByLibrary.simpleMessage('Pending amount'),
    'proceedText': MessageLookupByLibrary.simpleMessage('Proceed'),
    'recoverPassTitle': MessageLookupByLibrary.simpleMessage('Recover your password.'),
    'registerErrorMessage': MessageLookupByLibrary.simpleMessage('Error on register user'),
    'requestPaymentToYouMessage': m2,
    'requestSharedPaymentText': MessageLookupByLibrary.simpleMessage('Request Shared Payment'),
    'requestedAmountToText': MessageLookupByLibrary.simpleMessage('Requested amount'),
    'requestedPaymentMessage': m3,
    'requestedToText': MessageLookupByLibrary.simpleMessage('Requested to'),
    'resendText': MessageLookupByLibrary.simpleMessage('Resend'),
    'searchByHintText': MessageLookupByLibrary.simpleMessage('Search contact by username or email'),
    'searchContacts': MessageLookupByLibrary.simpleMessage('Search in contacts'),
    'selectContactMessage': MessageLookupByLibrary.simpleMessage('Select a contact first'),
    'selectCurrencyToDoPayment': MessageLookupByLibrary.simpleMessage('Select currency to do the payment'),
    'selectNetworkFirstMessage': MessageLookupByLibrary.simpleMessage('Select a network first'),
    'selectNetworkText': MessageLookupByLibrary.simpleMessage('Select network'),
    'selectRecipientText': MessageLookupByLibrary.simpleMessage('Select recipient'),
    'sendText': MessageLookupByLibrary.simpleMessage('Send'),
    'sendVerificationCodeText': MessageLookupByLibrary.simpleMessage('Send Verification Code'),
    'sharedPayBottomLabel': MessageLookupByLibrary.simpleMessage('Shared Pay'),
    'signUpText': MessageLookupByLibrary.simpleMessage('Sign Up'),
    'singleUseCodeMessage': MessageLookupByLibrary.simpleMessage('Remember, this code is for single use only and is valid for 90 seconds.'),
    'socialWalletName': MessageLookupByLibrary.simpleMessage('SocialWallet'),
    'startPaymentText': MessageLookupByLibrary.simpleMessage('Start Payment'),
    'statusText': MessageLookupByLibrary.simpleMessage('Status'),
    'testnetEnabledText': MessageLookupByLibrary.simpleMessage('Testnet enabled'),
    'totalAmountCannotBeEmptyMessage': MessageLookupByLibrary.simpleMessage('Total amount cannot be empty'),
    'totalAmountText': MessageLookupByLibrary.simpleMessage('Total amount'),
    'totalRequiredConfirmations': MessageLookupByLibrary.simpleMessage('Total required confirmations'),
    'twoFAValidationCodeText': MessageLookupByLibrary.simpleMessage('2FA Validation code'),
    'txDetailsText': MessageLookupByLibrary.simpleMessage('Tx Details'),
    'usernameText': MessageLookupByLibrary.simpleMessage('Username'),
    'youHavePayedText': MessageLookupByLibrary.simpleMessage('You have payed'),
    'yourAmountToPay': MessageLookupByLibrary.simpleMessage('Your amount'),
    'yourContactsText': MessageLookupByLibrary.simpleMessage('Your contacts')
  };
}
