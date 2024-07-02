import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_metadata_model.freezed.dart';
part 'token_metadata_model.g.dart';

@freezed
class TokenMetadataModel with _$TokenMetadataModel {
  const factory TokenMetadataModel({
    required int decimals,
    String? logo,
    required String name,
    required String symbol,
}) = _TokenMetadataModel;

  factory TokenMetadataModel.fromJson(Map<String, dynamic> json) =>
      _$TokenMetadataModelFromJson(json);
}
