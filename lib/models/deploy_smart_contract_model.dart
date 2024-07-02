import 'package:freezed_annotation/freezed_annotation.dart';

part 'deploy_smart_contract_model.freezed.dart';
part 'deploy_smart_contract_model.g.dart';

@freezed
class DeploySmartContractModel with _$DeploySmartContractModel {
  const factory DeploySmartContractModel({
    required int contractSpecsId,
    required String sender,
    required int blockchainNetwork,
    required int gasLimit,
    required List<dynamic> params,
}) = _DeploySmartContractModel;

  factory DeploySmartContractModel.fromJson(Map<String, dynamic> json) =>
      _$DeploySmartContractModelFromJson(json);
}
