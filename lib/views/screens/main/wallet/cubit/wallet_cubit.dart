import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/alchemy_repository.dart';
import 'package:social_wallet/api/repositories/balance_repository.dart';
import 'package:social_wallet/api/repositories/wallet_repository.dart';
import 'package:social_wallet/models/created_wallet_response.dart';
import 'package:social_wallet/models/owned_token_account_info_model.dart';
import 'package:social_wallet/models/wallet_hash_request_model.dart';
import 'package:social_wallet/models/wallet_hash_response_model.dart';

import '../../../../../di/injector.dart';
import '../../../../../models/custodied_wallets_info_response.dart';
import '../../../../../models/db/update_user_wallet_info.dart';
import '../../../../../models/db/user.dart';
import '../../../../../models/network_info_model.dart';
import '../../../../../utils/app_constants.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {

  BalanceRepository balanceRepository;
  WalletRepository walletRepository;
  AlchemyRepository alchemyRepository;
  User? user = AppConstants.getCurrentUser();

  WalletCubit({
    required this.balanceRepository,
    required this.walletRepository,
    required this.alchemyRepository
  }) : super(WalletState());

  Future<List<CustodiedWalletsInfoResponse>?> getCustomerCustiodedWallets() async {
    try {
      List<CustodiedWalletsInfoResponse>? response = await walletRepository.getCustomerCustodiedWallets();
      if (response != null) {
        return response;
      }
      return response;
    } catch (error) {
      return null;
    }
  }

  void setSelectedNetwork(NetworkInfoModel networkInfoModel) {
    emit(
        state.copyWith(
            selectedNetwork: networkInfoModel
        )
    );
  }

  Future<WalletHashResponseModel?> createWallet() async {
    emit(state.copyWith(status: WalletStatus.loading));
    try {
      if (user != null) {
        WalletHashRequestModel request = WalletHashRequestModel(
            username: user!.userEmail,
            strategies: [2, 3],
            callbackUrl: "https://callback.vottun.tech/rest/v1/success/",
            fallbackUrl: "https://fallback.vottun.tech/rest/v1/error/",
            cancelUrl: "https://fallback.vottun.tech/rest/v1/cancel/"
        );

        WalletHashResponseModel? response = await walletRepository.getNewHash(
            walletHashRequestModel: request
        );
        if (response != null) {
          emit(
              state.copyWith(
                walletHashResponseModel: response,
                status: WalletStatus.success,
              )
          );
          return response;
        }
      }
      return null;
    } catch (error, stacktrace) {
      print(stacktrace);
      emit(state.copyWith(status: WalletStatus.error));
      return null;
    }
  }

  Future<void> onCreatedWallet({
    required CreatedWalletResponse createdWalletResponse,
    required int selectedStrategy,
}) async {
    try {
      if (createdWalletResponse.accountAddress.isNotEmpty && user != null) {
        int? response = await getDbHelper().updateUserWalletInfo(
            user!.id ?? 0,
            UpdateUserWalletInfo(
                strategy: selectedStrategy,
                accountHash: createdWalletResponse.accountAddress
            )
        );
        if (response != null && getKeyValueStorage().getCurrentUser() != null) {
          getKeyValueStorage().setUserAddress(createdWalletResponse.accountAddress);
          getKeyValueStorage().setCurrentModel(
              getKeyValueStorage().getCurrentUser()!.copyWith(accountHash: createdWalletResponse.accountAddress, strategy: selectedStrategy));
        }
      }
    } catch (error, stacktrace) {
      print(stacktrace);
    }
  }
}
