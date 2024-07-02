import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_nfts_model.freezed.dart';
part 'user_nfts_model.g.dart';

@freezed
class UserNfTsModel with _$UserNfTsModel {
  const factory UserNfTsModel({
    int? id,
    required String contractAddress,
    required String creationTxHash,
    required int ownerId,
    required String nftName,
    required String ownerAddress,
    required String nftSymbol,
    String? nftAlias,
    required int networkId,
    required int creationTimestamp,
  }) = _UserNfTsModel;

  factory UserNfTsModel.fromJson(Map<String, dynamic> json) => _$UserNfTsModelFromJson(json);
}
