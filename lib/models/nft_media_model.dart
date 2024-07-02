import 'package:freezed_annotation/freezed_annotation.dart';

part 'nft_media_model.freezed.dart';
part 'nft_media_model.g.dart';

@freezed
class NFTMediaModel with _$NFTMediaModel {
  const factory NFTMediaModel({
    required String gateway,
    String? thumbnail,
    required String raw,
    String? format
}) = _NFTMediaModel;

  factory NFTMediaModel.fromJson(Map<String, dynamic> json) =>
      _$NFTMediaModelFromJson(json);
}
