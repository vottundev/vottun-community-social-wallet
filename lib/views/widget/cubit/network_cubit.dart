import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_wallet/api/repositories/web3_core_repository.dart';
import 'package:social_wallet/models/bc_networks_model.dart';
import 'package:social_wallet/models/network_info_model.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/balance_cubit.dart';

import '../../../di/injector.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<BCNetworkState> {

  Web3CoreRepository networkRepository;

  NetworkCubit({
    required this.networkRepository
  }) : super(BCNetworkState());

  void getAndStoreLocalAvailableNetworks(BCNetworksModel? response) {

  }

  Future<void> getAvailableNetworks({bool? resetLocalAvailableNetworks = false, BalanceCubit? cubit}) async {
    emit(state.copyWith(status: BCNetworksStatus.loadingNetworks));
    try {
      BCNetworksModel? response = getKeyValueStorage().getNetworkInfo();

      if (response == null || resetLocalAvailableNetworks == true) {
        response = await networkRepository.getAvailableNetworksInfo();
        if (response != null) {
          getKeyValueStorage().setNetworksInfo(response);
        }
      }

      NetworkInfoModel? networkInfoModel;

      if (response != null) {
        if (response.mainnetNetworks.isNotEmpty && getKeyValueStorage().getIsMainnetEnabled()) {
          getNetworkSelectorCubit().setSelectedNetwork(selectedNetworkInfo: response.mainnetNetworks.first);
          networkInfoModel = response.mainnetNetworks.first;
        } else {
          getNetworkSelectorCubit().setSelectedNetwork(selectedNetworkInfo: response.testnetNetworks.first);
          networkInfoModel = response.testnetNetworks.first;
        }

      /*  getBalanceCubit().getCryptoNativeBalance(
            accountToCheck: "0x84fa37c1b4d9dbc87707e47440eae5285edd8e58",
            networkInfoModel: networkInfoModel,
            networkId: networkInfoModel.id
        );*/

        emit(
            state.copyWith(
              availableNetworksList: response,
              status: BCNetworksStatus.success,
            )
        );
      }
    } catch (error) {
      emit(state.copyWith(status: BCNetworksStatus.error));
    }
  }
}
