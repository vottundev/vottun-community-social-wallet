import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/balance_repository.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/balance_response_model.dart';
import 'package:social_wallet/models/binance_token_price_response_model.dart';
import 'package:social_wallet/models/network_info_model.dart';
import 'package:social_wallet/models/token_metadata_model.dart';
import 'package:social_wallet/models/token_wallet_item.dart';
import 'package:social_wallet/models/tokens_info_model.dart';
import 'package:social_wallet/utils/app_constants.dart';

import '../../../../../api/repositories/alchemy_repository.dart';
import '../../../../../models/owned_token_account_info_model.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {

  BalanceRepository balanceRepository;
  AlchemyRepository alchemyRepository;

  BalanceCubit({
    required this.balanceRepository,
    required this.alchemyRepository
  }) : super(BalanceState());



  Future<void> getAccountBalance({
    required String accountToCheck,
    required NetworkInfoModel networkInfoModel,
    required int networkId
  }) async {
    emit(state.copyWith(status: BalanceStatus.loading));
    try {
      BalanceResponseModel? response = await balanceRepository.getNativeCryptoBalance(
          accountAddress: accountToCheck,
          networkId: networkId
      );
      String nativeSymbol = "";
      switch(networkId) {
        case 80002:
          nativeSymbol = "MATIC";
          break;
        case 421614:
          nativeSymbol = "ETH";
          break;
        case 11155111:
          nativeSymbol = "ETH";
          break;
        case 97:
          nativeSymbol = "BNB";
          break;
        default:
          nativeSymbol = "ETH";
      }

      //todo get native token address when possible
      BinanceTokenPriceResponseModel? nativeTokenPriceResponseModel = await balanceRepository.getTokenPrice(
          tokenSymbol: nativeSymbol
      );

      TokenWalletItem tokenWalletItem = TokenWalletItem();

      if (response != null && nativeTokenPriceResponseModel != null) {
      //if (response != null) {
        double userBalance = response.balance;
        double tokenPrice = double.parse(nativeTokenPriceResponseModel.price);
        //double tokenPrice = 0.0;

        double fiatBalance = 0.0;

        fiatBalance = userBalance * tokenPrice;
        //fiatBalance = userBalance;

        int fixedValue = response.balance == 0 ? 2: 4;
        //todo native token
        TokensInfoModel tokenInfoModel = TokensInfoModel(
            networkId: networkId,
            decimals: 18,
            tokenName: networkInfoModel.name,
            tokenSymbol: networkInfoModel.symbol,
            balance: response.balance.toStringAsFixed(fixedValue),
            fiatPrice: fiatBalance,
            isNative: true
        );
        tokenWalletItem.mainTokenInfoModel = tokenInfoModel;
        tokenWalletItem.erc20TokensList = List.empty(growable: true);
        tokenWalletItem.erc20TokensList?.add(tokenInfoModel);
        //todo get erc20 list from local storage

        OwnedTokenAccountInfoModel? ownedTokens = await _getAccountTokenBalance(userAddress: accountToCheck, networkId: networkId, refresh: true);

        if (ownedTokens != null) {
          for (var element in ownedTokens.tokenBalances) {
            TokenMetadataModel? tokenMetadata = await alchemyRepository.getTokenMetadata(tokenAddress: element.contractAddress, networkId: networkId);
            if (tokenMetadata != null) {
              BinanceTokenPriceResponseModel? tokenPriceResponseModel = await balanceRepository.getTokenPrice(
                  tokenSymbol: tokenMetadata.symbol
              );
              double fiatPrice = 0.0;
              double userBalance = double.parse(AppConstants.parseTokenBalanceFromHex(element.tokenBalance, tokenMetadata.decimals));
              if (tokenPriceResponseModel != null) {
                fiatPrice = userBalance * double.parse(tokenPriceResponseModel.price);
              }
              tokenWalletItem.erc20TokensList?.add(
                  TokensInfoModel(
                      networkId: networkId,
                      tokenName: tokenMetadata.name,
                      tokenAddress: element.contractAddress,
                      tokenSymbol: tokenMetadata.symbol,
                      decimals: tokenMetadata.decimals,
                      fiatPrice: fiatPrice,
                      balance: AppConstants.parseTokenBalanceFromHex(element.tokenBalance, tokenMetadata.decimals),
                      isNative: false
                  )
              );
            }
          }
        }

        emit(
            state.copyWith(
              networkInfoModel: networkInfoModel,
              walletTokenItemList: tokenWalletItem,
              status: BalanceStatus.success,
            )
        );
      }
    } catch (error) {
      emit(state.copyWith(status: BalanceStatus.error));
    }
  }

  Future<OwnedTokenAccountInfoModel?> _getAccountTokenBalance({required String userAddress, required int networkId, bool refresh = false}) async {
    try {
      OwnedTokenAccountInfoModel? localStorage = getKeyValueStorage().getOwnedTokenAccountInfoModel();
      if (localStorage == null || refresh) {
        OwnedTokenAccountInfoModel? response = await alchemyRepository.getTokenInfoOwnedByAddress(userAddress: userAddress, networkId: networkId);
        if (response != null) {
          getKeyValueStorage().setOwnedTokenAccountInfoModel(response);
        }
        return response;
      }
      return localStorage;
    } catch (error) {
      print(error);
      return null;
      //emit(state.copyWith(status: WalletStatus.error));
    }
  }
}
