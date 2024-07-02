import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_json_metadata_req_model.freezed.dart';
part 'upload_json_metadata_req_model.g.dart';

@freezed
class UploadJsonMetadataReqModel with _$UploadJsonMetadataReqModel {
  const factory UploadJsonMetadataReqModel({
    required String name,
    required String image,
    required String description,
    String? edition,
    String? external_url,
    String? animation_url,
    required List<Attribute> attributes,
    required dynamic data,
  }) = _UploadJsonMetadataReqModel;

  factory UploadJsonMetadataReqModel.fromJson(Map<String, dynamic> json) => _$UploadJsonMetadataReqModelFromJson(json);
}

@freezed
class Attribute with _$Attribute {
  const factory Attribute({
    required String traitType,
    required int value,
    int? max_value,
    String? display_type,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}

