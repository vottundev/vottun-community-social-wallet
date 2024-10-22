import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
//import 'package:flutter_vottun/vottun.dart';
import 'package:get_it/get_it.dart';
import 'package:social_wallet/api/repositories/auth_repository.dart';
import 'package:social_wallet/api/repositories/balance_repository.dart';
import 'package:social_wallet/api/repositories/wallet_repository.dart';
import 'package:social_wallet/api/repositories/web3_core_repository.dart';
import 'package:social_wallet/services/local_db/database_helper.dart';
import 'package:social_wallet/views/screens/login/cubit/auth_cubit.dart';
import 'package:social_wallet/views/screens/main/contacts/cubit/search_contact_cubit.dart';
import 'package:social_wallet/views/screens/main/contacts/cubit/user_contact_cubit.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/direct_payment_bottom_dialog_cubit.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/direct_payment_cubit.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/dirpay_history_cubit.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/send_verification_code_cubit.dart';
import 'package:social_wallet/views/screens/main/shared_payments/cubit/end_shared_payment_cubit.dart';
import 'package:social_wallet/views/screens/main/shared_payments/cubit/shared_payment_contacts_cubit.dart';
import 'package:social_wallet/views/screens/main/shared_payments/cubit/shared_payment_item_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/available_contract_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/balance_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/create_nft_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/deployed_contracts_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/wallet_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/wallet_nfts_cubit.dart';
import 'package:social_wallet/views/widget/cubit/network_cubit.dart';
import 'package:social_wallet/views/widget/cubit/network_selector_cubit.dart';

import '../api/utils/dio_service.dart';
import '../services/local_storage/key_value_storage_service.dart';
import '../services/network/api_endpoint.dart';
import '../services/network/api_service.dart';
import '../services/network/interceptor/api_interceptor.dart';
import '../services/network/interceptor/logging_interceptor.dart';
import '../utils/locale/app_localization.dart';
import '../views/screens/main/shared_payments/cubit/shared_payment_cubit.dart';
import '../views/screens/main/shared_payments/cubit/shared_payment_history_cubit.dart';
import '../views/widget/cubit/toggle_state_cubit.dart';


GetIt getIt = GetIt.instance;

void registerDependencyInjection() {

  _registerFlutterAppAuth();
  _registerApiCallService();
  _registerKeyValueStorage();
  _registerDioService();
  _registerAuthRepository();
  _registerWeb3CoreRepository();
  _registerNetworkCubit();
  _registerBalanceRepository();
  _registerNetworkSelectorCubit();
  _registerBalanceCubit();
  _registerToggleStateCubit();
  _registerWalletCubit();
  _registerWalletRepository();
  _registerSearchContactCubit();
  _registerDatabaseHelper();
  _registerUserContactCubit();
  _registerDirectPaymentCubit();
  _registerEndSharedPaymentCubit();
  _registerSharedPaymentCubit();
  _registerDirPayHistoryCubit();
  _registerSharedPaymentItemCubit();
  _registerSendVerificationCodeCubit();
  _registerSharedPaymentContactsCubit();
  _registerDirectPaymentBottomDialogCubit();
  _registerWalletNFTsCubit();
  _registerCreateNftCubit();
  _registerAvailableContractCubit();
  _registerDeployedContractsCubit();
  _registerSharedPaymentHistoryCubit();
  _registerAuthCubit();
  _registerGetStrings();
}

void testingVottunSDK() {
 // Vottun vottun = Vottun("", "");
}

FlutterAppAuth getFlutterAppAuth() {
  return getIt<FlutterAppAuth>();
}
AppLocalization getStrings() {
  return getIt<AppLocalization>();
}

void _registerGetStrings() {
  getIt.registerLazySingleton<AppLocalization>(() => AppLocalization());
}
void _registerApiCallService() {
  getIt.registerLazySingleton<ApiService>(() => ApiService(getDioService(), getFlutterAppAuth()));
}

ApiService getApiService() {
  return getIt<ApiService>();
}

void _registerFlutterAppAuth() {
  getIt.registerLazySingleton<FlutterAppAuth>(() => const FlutterAppAuth());
}

DioService getDioService() {
  return getIt<DioService>();
}

void _registerDioService() {
  getIt.registerLazySingleton<DioService>(() =>
      DioService(
          dioClient: getSocialWalletDio(),
          interceptors: [
            ApiInterceptor(),
            if (kDebugMode) LoggingInterceptor()
          ]
      )
  );
}


SearchContactCubit getSearchContactCubit() {
  return getIt<SearchContactCubit>();
}

void _registerSearchContactCubit() {
  getIt.registerLazySingleton<SearchContactCubit>(() => SearchContactCubit(walletRepository: getWalletRepository()));
}


void _registerWeb3CoreRepository() {
  getIt.registerLazySingleton<Web3CoreRepository>(() => Web3CoreRepository(apiService: getApiService()));
}

Web3CoreRepository getWeb3CoreRepository() {
  return getIt<Web3CoreRepository>();
}

void _registerBalanceRepository() {
  getIt.registerLazySingleton<BalanceRepository>(() => BalanceRepository(apiService: getApiService()));
}

BalanceRepository getBalanceRepository() {
  return getIt<BalanceRepository>();
}


NetworkCubit getNetworkCubit() {
  return getIt<NetworkCubit>();
}

void _registerNetworkCubit() {
  getIt.registerLazySingleton<NetworkCubit>(() => NetworkCubit(networkRepository: getWeb3CoreRepository()));
}

void _registerWalletRepository() {
  getIt.registerFactory<WalletRepository>(() => WalletRepository(apiService: getApiService()));
}

WalletRepository getWalletRepository() {
  return getIt<WalletRepository>();
}


WalletCubit getWalletCubit() {
  return getIt<WalletCubit>();
}

void _registerWalletCubit() {
  getIt.registerLazySingleton<WalletCubit>(() => WalletCubit(balanceRepository: getBalanceRepository(),  walletRepository: getWalletRepository(), ));
}

WalletNFTsCubit getWalletNFTsCubit() {
  return getIt<WalletNFTsCubit>();
}

void _registerWalletNFTsCubit() {
  getIt.registerLazySingleton<WalletNFTsCubit>(() => WalletNFTsCubit(balanceRepository: getBalanceRepository(),  walletRepository: getWalletRepository()));
}


BalanceCubit getBalanceCubit() {
  return getIt<BalanceCubit>();
}

void _registerBalanceCubit() {
  getIt.registerLazySingleton<BalanceCubit>(() => BalanceCubit(balanceRepository: getBalanceRepository()));
}

NetworkSelectorCubit getNetworkSelectorCubit() {
  return getIt<NetworkSelectorCubit>();
}

void _registerNetworkSelectorCubit() {
  getIt.registerFactory<NetworkSelectorCubit>(() => NetworkSelectorCubit());
}

KeyValueStorageService getKeyValueStorage() {
  return getIt<KeyValueStorageService>();
}

void _registerKeyValueStorage() {
  getIt.registerLazySingleton<KeyValueStorageService>(() => KeyValueStorageService());
}

DatabaseHelper getDbHelper() {
  return getIt<DatabaseHelper>();
}

void _registerDatabaseHelper() {
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}

ToggleStateCubit getToggleStateCubit() {
  return getIt<ToggleStateCubit>();
}

UserContactCubit getUserContactCubit() {
  return getIt<UserContactCubit>();
}

void _registerUserContactCubit() {
  getIt.registerLazySingleton<UserContactCubit>(() => UserContactCubit());
}

DirectPaymentCubit getDirectPaymentCubit() {
  return getIt<DirectPaymentCubit>();
}

void _registerDirectPaymentCubit() {
  getIt.registerFactory<DirectPaymentCubit>(() => DirectPaymentCubit(walletRepository: getWalletRepository()));
}

SendVerificationCodeCubit getSendVerificationCodeCubit() {
  return getIt<SendVerificationCodeCubit>();
}

void _registerSendVerificationCodeCubit() {
  getIt.registerFactory<SendVerificationCodeCubit>(() => SendVerificationCodeCubit(walletRepository: getWalletRepository()));
}

SharedPaymentContactsCubit getSharedPaymentContactsCubit() {
  return getIt<SharedPaymentContactsCubit>();
}

void _registerSharedPaymentContactsCubit() {
  getIt.registerFactory<SharedPaymentContactsCubit>(() => SharedPaymentContactsCubit());
}

EndSharedPaymentCubit getEndSharedPaymentCubit() {
  return getIt<EndSharedPaymentCubit>();
}

void _registerEndSharedPaymentCubit() {
  getIt.registerFactory<EndSharedPaymentCubit>(() => EndSharedPaymentCubit(walletRepository: getWalletRepository()));
}

CreateNftCubit getCreateNftCubit() {
  return getIt<CreateNftCubit>();
}

void _registerCreateNftCubit() {
  getIt.registerFactory<CreateNftCubit>(() => CreateNftCubit(web3CoreRepository: getWeb3CoreRepository()));
}

DirPayHistoryCubit getDirPayHistoryCubit() {
  return getIt<DirPayHistoryCubit>();
}

void _registerDirPayHistoryCubit() {
  getIt.registerLazySingleton<DirPayHistoryCubit>(() => DirPayHistoryCubit());
}

DirectPaymentBottomDialogCubit getDirectPaymentBottomDialogCubit() {
  return getIt<DirectPaymentBottomDialogCubit>();
}

void _registerDirectPaymentBottomDialogCubit() {
  getIt.registerFactory<DirectPaymentBottomDialogCubit>(() => DirectPaymentBottomDialogCubit(walletRepository: getWalletRepository()));
}

SharedPaymentCubit getSharedPaymentCubit() {
  return getIt<SharedPaymentCubit>();
}

void _registerSharedPaymentCubit() {
  getIt.registerLazySingleton<SharedPaymentCubit>(() => SharedPaymentCubit(dbHelper: getDbHelper(), web3CoreRepository: getWeb3CoreRepository()));
}

SharedPaymentHistoryCubit getSharedPaymentHistoryCubit() {
  return getIt<SharedPaymentHistoryCubit>();
}

void _registerSharedPaymentHistoryCubit() {
  getIt.registerLazySingleton<SharedPaymentHistoryCubit>(() => SharedPaymentHistoryCubit(dbHelper: getDbHelper(), web3CoreRepository: getWeb3CoreRepository()));
}

SharedPaymentItemCubit getSharedPaymentItemCubit() {
  return getIt<SharedPaymentItemCubit>();
}

void _registerSharedPaymentItemCubit() {
  getIt.registerFactory<SharedPaymentItemCubit>(() => SharedPaymentItemCubit(web3coreRepository: getWeb3CoreRepository()));
}

AuthCubit getAuthCubit() {
  return getIt<AuthCubit>();
}

void _registerAuthCubit() {
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
}


AuthRepository getAuthRepository() {
  return getIt<AuthRepository>();
}

void _registerAuthRepository() {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(apiService: getApiService()));
}

AvailableContractCubit getAvailableContractCubit() {
  return getIt<AvailableContractCubit>();
}

void _registerAvailableContractCubit() {
  getIt.registerLazySingleton<AvailableContractCubit>(() => AvailableContractCubit(web3CoreRepository: getWeb3CoreRepository()));
}

DeployedContractsCubit getDeployedContractsCubit() {
  return getIt<DeployedContractsCubit>();
}

void _registerDeployedContractsCubit() {
  getIt.registerLazySingleton<DeployedContractsCubit>(() => DeployedContractsCubit(web3CoreRepository: getWeb3CoreRepository()));
}

void _registerToggleStateCubit(){
  getIt.registerFactory<ToggleStateCubit>(() => ToggleStateCubit());
}

Dio getSocialWalletDio(){
  Dio dio = Dio();
  dio.options.baseUrl = ApiEndpoint.baseUrl;

  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  //dio.interceptors.add(ApiInterceptor());
  return dio;
}
