import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/wallet_repository.dart';
import 'package:social_wallet/models/network_info_model.dart';

part 'direct_payment_state.dart';

class DirectPaymentCubit extends Cubit<DirectPaymentState> {
  WalletRepository walletRepository;

  DirectPaymentCubit({required this.walletRepository}) : super(DirectPaymentState());

  void setContactInfo(String contactName, String address) {
    emit(state.copyWith(selectedContactName: contactName, selectedContactAddress: address));
  }

  void setSelectedNetwork(NetworkInfoModel? selectedNetwork) {
    emit(state.copyWith(selectedNetwork: selectedNetwork));
  }

  void resetValues() {
    emit(state.copyWith(
        status: DirectPaymentStatus.initial,
        selectedContactAddress: "",
        selectedContactName: null,
        selectedNetwork: null,
        selectedNetworkId: null));
  }
}
