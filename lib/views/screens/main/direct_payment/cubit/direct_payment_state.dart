part of 'direct_payment_cubit.dart';


enum DirectPaymentStatus {
  initial, loading, success, error
}

class DirectPaymentState {

  final DirectPaymentStatus status;
  String? selectedContactName;
  String? selectedContactAddress;
  NetworkInfoModel? selectedNetwork;

  DirectPaymentState({
    this.status = DirectPaymentStatus.initial,
    this.selectedContactName,
    this.selectedContactAddress,
    this.selectedNetwork,
  });

  DirectPaymentState copyWith({
    DirectPaymentStatus? status,
    int? selectedNetworkId,
    String? selectedContactName,
    String? selectedContactAddress,
    NetworkInfoModel? selectedNetwork
  }) {
    return DirectPaymentState(
      status: status ?? this.status,
      selectedContactName: selectedContactName ?? this.selectedContactName,
      selectedContactAddress: selectedContactAddress ?? this.selectedContactAddress,
      selectedNetwork: selectedNetwork ?? this.selectedNetwork,
    );
  }
}
