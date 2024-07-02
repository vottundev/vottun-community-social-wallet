import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/web3_core_repository.dart';
import 'package:social_wallet/models/available_contract_specs_model.dart';

part 'available_contract_state.dart';

class AvailableContractCubit extends Cubit<AvailableContractState> {

  Web3CoreRepository web3CoreRepository;

  AvailableContractCubit({
    required this.web3CoreRepository,
  }) : super(AvailableContractState());

  void getAvailableContractsFromVottunPlatform() async {
    emit(state.copyWith(
      status: AvailableContractStatus.loading
    ));
    try {
      List<AvailableContractSpecsModel> response = await web3CoreRepository.getAvailableContractSpecs() ?? [];
      emit(state.copyWith(
          status: AvailableContractStatus.success,
          availableContractsList: response.where((element) => element.owned == true).toList().reversed.toList()
      ));
    } catch (exception) {
      print(exception);
      emit(state.copyWith(
          status: AvailableContractStatus.error,
          availableContractsList: []
      ));
    }
  }
}
