import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/web3_core_repository.dart';
import 'package:social_wallet/models/smart_contracts_deployed_model.dart';

part 'deployed_contracts_state.dart';

class DeployedContractsCubit extends Cubit<DeployedContractsState> {

  Web3CoreRepository web3CoreRepository;

  DeployedContractsCubit({
    required this.web3CoreRepository,
  }) : super(DeployedContractsState());

  void getDeployedContractBySpecId(int contractSpecId) async {
    emit(state.copyWith(
      status: DeployedContractsStatus.loading
    ));
    try {
      List<SmartContractsDeployedModel> response = await web3CoreRepository.getSmartContractDeployedByContractSpecId(contractSpecId) ?? [];
      emit(state.copyWith(
          status: DeployedContractsStatus.success,
          deployedContractsList: response
      ));
    } catch (exception) {
      print(exception);
      emit(state.copyWith(
          status: DeployedContractsStatus.error,
          deployedContractsList: []
      ));
    }
  }
}
