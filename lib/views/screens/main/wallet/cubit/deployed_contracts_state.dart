part of 'deployed_contracts_cubit.dart';


enum DeployedContractsStatus {
  initial, loading, walletCreated, success, error
}

class DeployedContractsState {

  final DeployedContractsStatus status;

  List<SmartContractsDeployedModel>? deployedContractsList;

  DeployedContractsState({
    this.status = DeployedContractsStatus.initial,
    this.deployedContractsList,
  });

  DeployedContractsState copyWith({
    DeployedContractsStatus? status,
    List<SmartContractsDeployedModel>? deployedContractsList
  }) {
    return DeployedContractsState(
        status: status ?? this.status,
        deployedContractsList: deployedContractsList ?? this.deployedContractsList
    );
  }
}
