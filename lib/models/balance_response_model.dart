import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_response_model.freezed.dart';
part 'balance_response_model.g.dart';

@freezed
class BalanceResponseModel with _$BalanceResponseModel {
  const factory BalanceResponseModel({
    required double balance,
}) = _BalanceResponseModel;

  factory BalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseModelFromJson(json);
}
