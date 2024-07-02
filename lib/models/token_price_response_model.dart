import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_price_response_model.freezed.dart';
part 'token_price_response_model.g.dart';

@freezed
class TokenPriceResponseModel with _$TokenPriceResponseModel {
  const factory TokenPriceResponseModel({
    required double price,
    required double variation24h,
  }) = _TokenPriceResponseModel;

  factory TokenPriceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenPriceResponseModelFromJson(json);
}
