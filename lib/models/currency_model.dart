import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_model.freezed.dart';
part 'currency_model.g.dart';

@freezed
class CurrencyModel with _$CurrencyModel {
  const factory CurrencyModel({
    required String imagePath,
    required String currencyName,
    required bool isCrypto,
}) = _CurrencyModel;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
}
