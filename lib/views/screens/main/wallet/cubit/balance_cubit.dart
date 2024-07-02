import 'package:bloc/bloc.dart';
import 'package:social_wallet/api/repositories/balance_repository.dart';
import 'package:social_wallet/models/balance_response_model.dart';
import 'package:social_wallet/models/binance_token_price_response_model.dart';
import 'package:social_wallet/models/network_info_model.dart';
import 'package:social_wallet/models/token_wallet_item.dart';
import 'package:social_wallet/models/tokens_info_model.dart';


part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {

  BalanceRepository balanceRepository;

  BalanceCubit({
    required this.balanceRepository
  }) : super(BalanceState());

  Future<void> getAccountBalance({
    required String accountToCheck,
    NetworkInfoModel? networkInfoModel,
    int? networkId
  }) async {
    emit(state.copyWith(status: BalanceStatus.loading));
    try {
      BalanceResponseModel? response = await balanceRepository.getNativeCryptoBalance(
          accountAddress: accountToCheck,
          networkId: networkId ?? 421614
      );
      String nativeSymbol = "";
      String networkName = "";
      switch(networkId) {
        case 80002:
          nativeSymbol = "MATIC";
          networkName = "Polygon Amoy";
          break;
        case 421614:
          nativeSymbol = "ETH";
          networkName = "Arbitrum Sepolia";
          break;
        case 11155111:
          nativeSymbol = "ETH";
          networkName = "Ethereum Sepolia";
          break;
        case 97:
          nativeSymbol = "BNB";
          networkName = "Binance Testnet";
          break;
        default:
          nativeSymbol = "ETH";
          networkName = "Arbitrum Sepolia";
      }

      networkInfoModel ??= NetworkInfoModel(id: networkId ?? 421614, name: networkName, symbol: nativeSymbol, isMainnet: false);

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
            networkId: networkId ?? 421614,
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

        tokenWalletItem.erc20TokensList?.add(
            TokensInfoModel(
                networkId: networkId ?? 421614,
                tokenName: "Vottun",
                tokenAddress: '0x000',
                tokenSymbol:"VTN",
                decimals: 18,
                fiatPrice: 0,
                balance: "0",
                isNative: false
            )
        );

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
}
