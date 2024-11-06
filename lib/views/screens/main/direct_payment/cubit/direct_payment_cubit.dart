import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/wallet_repository.dart';

part 'direct_payment_state.dart';

class DirectPaymentCubit extends Cubit<DirectPaymentState> {

  WalletRepository walletRepository;

  DirectPaymentCubit({
    required this.walletRepository
  }) : super(DirectPaymentState());

  void setContactInfo(String contactName, String address) {
    emit(
      state.copyWith(
        selectedContactName: contactName,
        selectedContactAddress: address
      )
    );
  }
}
