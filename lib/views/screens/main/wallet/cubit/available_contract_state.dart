part of 'available_contract_cubit.dart';


enum AvailableContractStatus {
  initial, loading, walletCreated, success, error
}

class AvailableContractState {

  final AvailableContractStatus status;

  List<AvailableContractSpecsModel>? availableContractsList;

  AvailableContractState({
    this.status = AvailableContractStatus.initial,
    this.availableContractsList,
  });

  AvailableContractState copyWith({
    AvailableContractStatus? status,
    List<AvailableContractSpecsModel>? availableContractsList
  }) {
    return AvailableContractState(
        status: status ?? this.status,
      availableContractsList: availableContractsList ?? this.availableContractsList
    );
  }
}
