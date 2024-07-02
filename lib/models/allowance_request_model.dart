import 'package:freezed_annotation/freezed_annotation.dart';

part 'allowance_request_model.freezed.dart';
part 'allowance_request_model.g.dart';

@freezed
class AllowanceRequestModel with _$AllowanceRequestModel {
  const factory AllowanceRequestModel({
    required String contractAddress,
    required int network,
    required String owner,
    required String spender,
  }) = _AllowanceRequestModel;

  factory AllowanceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AllowanceRequestModelFromJson(json);
}
