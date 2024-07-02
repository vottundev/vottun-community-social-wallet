import 'package:social_wallet/models/tokens_info_model.dart';

class TokenWalletItem {

  TokensInfoModel? mainTokenInfoModel;
  List<TokensInfoModel>? erc20TokensList;

  TokenWalletItem({
    this.mainTokenInfoModel,
    this.erc20TokensList
  });

}