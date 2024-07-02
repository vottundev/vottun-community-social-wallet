import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/wallet_repository.dart';

part 'send_verification_code_state.dart';

class SendVerificationCodeCubit extends Cubit<SendVerificationCodeState> {

  WalletRepository walletRepository;

  SendVerificationCodeCubit({
    required this.walletRepository
  }) : super(SendVerificationCodeState());




  Future<String?> sendOTP(String userEmail, {bool isResend = false}) async {
    if (isResend == true) {
      emit(state.copyWith(
          status: SendVerificationCodeStatus.success
      ));
    }
    String? response = await sendOTPVerificationCode(userEmail);
    if (response != null) {
      Future.delayed(const Duration(seconds: 90), (){
        emit(state.copyWith(status: SendVerificationCodeStatus.successAgain));
      });
      emit(state.copyWith(
        status: SendVerificationCodeStatus.success
      ));
    }
    return response;
  }

  Future<String?> sendOTPVerificationCode(String userEmail) async {
    try {
      String? response = await walletRepository.sendOTPCode(userEmail: userEmail);
      return response;
    } catch (exception) {
      print(exception);
    }
    return null;
  }

}
