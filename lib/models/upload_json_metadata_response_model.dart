import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_json_metadata_response_model.freezed.dart';
part 'upload_json_metadata_response_model.g.dart';

UploadJsonMetadataResponseModel uploadJsonMetadataResponseModelFromJson(String str) => UploadJsonMetadataResponseModel.fromJson(json.decode(str));

String uploadJsonMetadataResponseModelToJson(UploadJsonMetadataResponseModel data) => json.encode(data.toJson());

@freezed
class UploadJsonMetadataResponseModel with _$UploadJsonMetadataResponseModel {
  const factory UploadJsonMetadataResponseModel({
    required String ipfsHash,
    required int pinSize,
    required String timestamp,
  }) = _UploadJsonMetadataResponseModel;

  factory UploadJsonMetadataResponseModel.fromJson(Map<String, dynamic> json) => _$UploadJsonMetadataResponseModelFromJson(json);
}
