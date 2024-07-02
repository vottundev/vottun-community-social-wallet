import 'package:freezed_annotation/freezed_annotation.dart';

part 'smart_contracts_deployed_model.freezed.dart';
part 'smart_contracts_deployed_model.g.dart';

@freezed
class SmartContractsDeployedModel with _$SmartContractsDeployedModel {
  const factory SmartContractsDeployedModel({
    required String id,
    required String txHash,
    required String address,
    required String network,
    required String symbol,
    required String explorer,
    required String owner,
    required int creationTimestamp,
  }) = _SmartContractsDeployedModel;

  factory SmartContractsDeployedModel.fromJson(Map<String, dynamic> json) => _$SmartContractsDeployedModelFromJson(json);
}
