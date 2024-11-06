part of 'direct_payment_cubit.dart';


enum DirectPaymentStatus {
  initial, loading, success, error
}

class DirectPaymentState {

  final DirectPaymentStatus status;
  String? selectedContactName;
  String? selectedContactAddress;

  DirectPaymentState({
    this.status = DirectPaymentStatus.initial,
    this.selectedContactName,
    this.selectedContactAddress,
  });

  DirectPaymentState copyWith({
    DirectPaymentStatus? status,
    int? selectedNetworkId,
    String? selectedContactName,
    String? selectedContactAddress
  }) {
    return DirectPaymentState(
      status: status ?? this.status,
      selectedContactName: selectedContactName ?? this.selectedContactName,
      selectedContactAddress: selectedContactAddress ?? this.selectedContactAddress,
    );
  }
}
