import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_uri_model.freezed.dart';
part 'token_uri_model.g.dart';

@freezed
class TokenUriModel with _$TokenUriModel {
  const factory TokenUriModel({
    required String gateway,
    required String raw
}) = _TokenUriModel;

  factory TokenUriModel.fromJson(Map<String, dynamic> json) =>
      _$TokenUriModelFromJson(json);
}
