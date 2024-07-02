import 'package:freezed_annotation/freezed_annotation.dart';

part 'contract_metadata_model.freezed.dart';
part 'contract_metadata_model.g.dart';

@freezed
class ContractMetadataModel with _$ContractMetadataModel {
  const factory ContractMetadataModel({
    required String name,
    required String symbol,
    required String totalSupply,
    required String tokenType,
}) = _ContractMetadataModel;

  factory ContractMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$ContractMetadataModelFromJson(json);
}
