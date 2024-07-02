
import 'package:flutter/material.dart';

@immutable
class Routes {
  const Routes._();

  // BASE
  static const String AppStartupScreenRoute = '/';
  //LOGIN
  static const String LoginScreenRoute = 'login';
  static const String SignUpScreenRoute = 'login/signup';
  static const String OtpScreenRoute = 'login/otp';

  //HOME
  static const String MainScreenRoute = 'main';

  //SHARED PAYMENT
  static const String SharedPaymentSelectContacsScreen = 'main/shared_payment/contacts';
  static const String ConfigurationScreenRoute = 'main/configuration';
  static const String AddContactsScreenRoute = 'main/add_contacts';
  static const String CreateNftScreenRoute = 'main/create_nft';
  static const String NFTDetailScreenRoute = 'main/nft_detail';
  static const String DeployedContractsScreenRoute = 'main/deployed_contracts';
}

enum RouteNames {
  AppStartupScreenRoute,
  LoginScreenRoute,
  SignUpScreenRoute,
  OtpScreenRoute,
  MainScreenRoute,
  SharedPaymentSelectContacsScreenRoute,
  ConfigurationScreenRoute,
  AddContactsScreenRoute,
  CreateNftScreenRoute,
  NFTDetailScreenRoute,
  DeployedContractsScreenRoute,
}


