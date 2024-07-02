import 'package:freezed_annotation/freezed_annotation.dart';

part 'deployed_sc_response_model.freezed.dart';
part 'deployed_sc_response_model.g.dart';

@freezed
class DeployedSCResponseModel with _$DeployedSCResponseModel {
  const factory DeployedSCResponseModel({
    required String txHash,
    required String contractAddress,
}) = _DeployedSCResponseModel;

  factory DeployedSCResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeployedSCResponseModelFromJson(json);
}
