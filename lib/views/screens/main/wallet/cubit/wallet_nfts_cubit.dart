import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/balance_repository.dart';
import 'package:social_wallet/api/repositories/wallet_repository.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/owned_nfts_data.dart';
import 'package:social_wallet/models/owned_nfts_response.dart';

import '../../../../../models/network_info_model.dart';

part 'wallet_nfts_state.dart';

class WalletNFTsCubit extends Cubit<WalletNFTsState> {

  BalanceRepository balanceRepository;
  WalletRepository walletRepository;

  WalletNFTsCubit({
    required this.balanceRepository,
    required this.walletRepository
  }) : super(WalletNFTsState());


  void setSelectedNetwork(NetworkInfoModel? selectedNetworkInfo) {

  }

  Future<void> getAccountNFTs({required NetworkInfoModel selectedNetworkInfo, required int networkId}) async {
    emit(state.copyWith(
        status: WalletNFTsStatus.loading
    ));
    try {
      String? currUserAddress = getKeyValueStorage().getUserAddress() ?? "";

      /*if (response != null) {
        state.selectedInfoNetwork = selectedNetworkInfo;
       emit(state.copyWith(
         ownedNFTsList: response.ownedNfts,
           status: WalletNFTsStatus.success
       ));
      } else {
        emit(state.copyWith(
            ownedNFTsList: [],
            status: WalletNFTsStatus.success
        ));
      }*/
    } catch (error) {
      print(error);
      emit(state.copyWith(
          ownedNFTsList: [],
          status: WalletNFTsStatus.success
      ));
    }
  }
}
