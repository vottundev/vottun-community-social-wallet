import 'package:freezed_annotation/freezed_annotation.dart';

part 'binance_token_price_response_model.freezed.dart';
part 'binance_token_price_response_model.g.dart';

@freezed
class BinanceTokenPriceResponseModel with _$BinanceTokenPriceResponseModel {
  const factory BinanceTokenPriceResponseModel({
    required String symbol,
    required String price,
  }) = _BinanceTokenPriceResponseModel;

  factory BinanceTokenPriceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BinanceTokenPriceResponseModelFromJson(json);
}
