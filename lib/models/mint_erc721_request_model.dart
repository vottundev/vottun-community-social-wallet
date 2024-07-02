import 'package:freezed_annotation/freezed_annotation.dart';

part 'mint_erc721_request_model.freezed.dart';
part 'mint_erc721_request_model.g.dart';


@freezed
class MintErc721RequestModel with _$MintErc721RequestModel {
  const factory MintErc721RequestModel({
    required String recipientAddress,
    required int tokenId,
    required String ipfsUri,
    required String ipfsHash,
    required int network,
    required String contractAddress,
    int? royaltyPercentage,
    int? gas,
  }) = _MintErc721RequestModel;

  factory MintErc721RequestModel.fromJson(Map<String, dynamic> json) => _$MintErc721RequestModelFromJson(json);
}
