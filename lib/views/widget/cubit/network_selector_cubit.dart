import 'package:bloc/bloc.dart';
import 'package:social_wallet/models/network_info_model.dart';

part 'network_selector_state.dart';

class NetworkSelectorCubit extends Cubit<NetworkSelectorState> {

  NetworkSelectorCubit() : super(NetworkSelectorState());

  Future<void> setSelectedNetwork({required NetworkInfoModel selectedNetworkInfo}) async {
    emit(state.copyWith(
      selectedNetwork: selectedNetworkInfo
    ));
  }

}
