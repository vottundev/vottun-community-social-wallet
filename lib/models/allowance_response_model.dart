import 'package:freezed_annotation/freezed_annotation.dart';

part 'allowance_response_model.freezed.dart';
part 'allowance_response_model.g.dart';

@freezed
class AllowanceResponseModel with _$AllowanceResponseModel {
  const factory AllowanceResponseModel({
    required num allowance,
}) = _AllowanceResponseModel;

  factory AllowanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllowanceResponseModelFromJson(json);
}
