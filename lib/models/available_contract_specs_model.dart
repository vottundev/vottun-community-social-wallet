import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_contract_specs_model.freezed.dart';
part 'available_contract_specs_model.g.dart';

@freezed
class AvailableContractSpecsModel with _$AvailableContractSpecsModel {
  const factory AvailableContractSpecsModel({
    required int id,
    required String name,
    required String description,
    required bool owned,
    required bool shared,
  }) = _AvailableContractSpecsModel;

  factory AvailableContractSpecsModel.fromJson(Map<String, dynamic> json) => _$AvailableContractSpecsModelFromJson(json);
}
