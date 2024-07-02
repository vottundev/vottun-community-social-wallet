part of 'send_verification_code_cubit.dart';


enum SendVerificationCodeStatus {
  initial, loading, success, successAgain, error
}

class SendVerificationCodeState {

  final SendVerificationCodeStatus status;


  SendVerificationCodeState({
    this.status = SendVerificationCodeStatus.initial
  });

  SendVerificationCodeState copyWith({
    SendVerificationCodeStatus? status
  }) {
    return SendVerificationCodeState(
      status: status ?? this.status
    );
  }
}
