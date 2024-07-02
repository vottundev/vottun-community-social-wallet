import 'package:flutter/cupertino.dart';
import 'package:social_wallet/utils/config/config_props.dart';

@immutable
class ApiEndpoint {
  const ApiEndpoint._();

/// It is supplied at the time of building the apk or running the app:
/// ------------------------
/// BUILD CONFIGS
/// ------------------------
/// -- PRE --
/// flutter build apk --debug --flavor pre --dart-define=PROD=false
/// flutter build apk --release --flavor pre --dart-define=PROD=false
/// flutter build appbundle --debug --flavor pre --dart-define=PROD=false
/// flutter build ipa --debug --dart-define=PROD=false
/// flutter build ipa --release --dart-define=PROD=false
/// -- PRO --
/// flutter build apk --release --flavor pro --dart-define=PROD=true
/// flutter build apk --debug --flavor pro --dart-define=PROD=true
/// flutter build appbundle --release --flavor pro --dart-define=PROD=true
/// flutter build ipa --debug --dart-define=PROD=true
/// flutter build ipa --release --dart-define=PROD=true
/// -------------------------
/// RUN (Example)
/// flutter run --debug --flavor pre --dart-define=PROD=false
/// ...
///

  static const bool isProEnvironment = bool.fromEnvironment(
    'PROD',
    defaultValue: false,
  );

  static const String baseUrl = "https://api.vottun.tech/";
  static const String baseVottunProdUrl = "https://api.vottun.io/prodapi/v1/contract";
  static const String dexToolsOpenApiUrl = "https://open-api.dextools.io/free/v2";
  static const String binanceBaseApiUrl = "https://data-api.binance.vision";
  static const String vottunLoginUrl = "https://api.vottun.io/coreauth/v1/applogin";
  static const String vottunLoginOtpUrl = "https://api.vottun.io/coreauth/v1/applogin/otp";
  static const String corePath = "core/v1/evm";
  static const String ercApiPath = "erc/v1";
  static const String ipfsPath = "ipfs/v2";
  static const String custWallPath = "cwll/v1";


  static String auth(AuthEndpoint endpoint, {String? otpCode}) {
    var loginPath = vottunLoginUrl;
    var sendOtpPath = vottunLoginOtpUrl;
    switch (endpoint) {
      case AuthEndpoint.authorization: return loginPath;
      case AuthEndpoint.sendOtp: return '$sendOtpPath/$otpCode?save=false';
    }
  }
  static String smartContract(SmartContractEndpoint endpoint) {
    var path = corePath;
    switch (endpoint) {
      case SmartContractEndpoint.deploySmartContract: return '$path/contract/deploy';
      case SmartContractEndpoint.querySmartContract: return '$path/transact/view';
      case SmartContractEndpoint.getContractSpecs: return '$path/info/specs';
    }
  }

  static String network(NetworkEndpoint endpoint, {String? token, String? txHash, String? networkId}) {
    var path = corePath;
    switch (endpoint) {
      case NetworkEndpoint.getAvailableNetworks: return '$path/info/chains';
      case NetworkEndpoint.getTxStatus: return '$path/info/transaction/$txHash/status?network=$networkId';
    }
  }

  static String alchemyBaseUrl({required int networkId}) {
    switch (networkId) {
      case 421614: return ConfigProps.alchemyArbitrumSepoliaUrl;
      case 5: return ConfigProps.alchemyApiKeySepoliaiUrl;
      case 80002: return ConfigProps.alchemyPolygonAmoyUrl;
      default:
        return ConfigProps.alchemyApiKeySepoliaiUrl;
    }
  }

  static String vottunProd(VottunProdEndpoint endpoint, {required int contractSpecId, int? paginationAmount, bool fromMainnet = false}) {
    String path = baseVottunProdUrl;
    switch (endpoint) {
      case VottunProdEndpoint.getContractDeployedSmartContract: return '$path/$contractSpecId/deployments?o=0&n=${paginationAmount ?? 5}&mainnet=${fromMainnet == true ? 1 : 0}';
    }
  }

  static String alchemy(AlchemyEdpoints endpoints, {required int networkId, required String address}) {
    var path = alchemyBaseUrl(networkId: networkId);
    switch (endpoints) {
      case AlchemyEdpoints.getNFTs: return '$path/getNFTs?owner=$address&withMetadata=true&excludeFilters[]=SPAM&excludeFilters[]=AIRDROPS&pageSize=100';
    }
  }

  static String ipfs(StorageEnpoints endpoints) {
    var path = ipfsPath;
    switch (endpoints) {
      case StorageEnpoints.uploadIpfsJSON: return '$path/file/metadata';
      case StorageEnpoints.uploadIpfsFile: return '$path/file/upload';
    }
  }

  static String balance(BalanceEndpoint endpoint, {String? networkName, String? tokenAddress, String? accountAddress, String? tokenSymbol, int? networkId}) {
    var pathEvm = corePath;
    var pathErcApi = ercApiPath;
    var pathBinance = binanceBaseApiUrl;

    switch (endpoint) {
      case BalanceEndpoint.getNativeBalance: return '$pathEvm/chain/$accountAddress/balance?network=$networkId';
      case BalanceEndpoint.getERC721Balance: return '$pathErcApi/erc721/balanceOf';
      case BalanceEndpoint.getNonNativeERC20Balance: return '$pathErcApi/erc20/balanceOf';
      case BalanceEndpoint.getTokenPrice: return '$pathBinance/api/v3/ticker/price?symbol=$tokenSymbol';
    }
  }

  static String custWallet(CustodiedWalletEndpoint endpoint, {int? strategy, String? userEmail}) {
    var path = custWallPath;
    var txPath = corePath;
    switch (endpoint) {
      case CustodiedWalletEndpoint.getNewHash: return '$path/hash/new';
      case CustodiedWalletEndpoint.getCustodiedWallets: return '$path/evm/wallet/custodied/list?o=0&n=100';
      case CustodiedWalletEndpoint.sendTransaction: return '$txPath/wallet/custodied/transact/mutable?strategy=$strategy';
      case CustodiedWalletEndpoint.sendOTP: return '$path/2fa/signature/otp/new?email=$userEmail';
      case CustodiedWalletEndpoint.sendTxFromCustodiedWallet: return '$txPath/wallet/custodied/transfer?strategy=$strategy';
    }
  }

  static String erc20(ERC20Endpoint endpoint) {
    var path = ercApiPath;
    switch (endpoint) {
      case ERC20Endpoint.transfer: return '$path/erc20/transfer';
      case ERC20Endpoint.transferFrom: return '$path/erc20/transferFrom';
      case ERC20Endpoint.getAllowance: return '$path/erc20/allowance';
    }
  }

  static String erc721(ERC721Endpoint endpoint) {
    var path = ercApiPath;
    switch (endpoint) {
      case ERC721Endpoint.deployNft: return '$path/erc721/deploy';
      case ERC721Endpoint.mintNft: return '$path/erc721/mint';
    }
  }

}

enum AuthEndpoint {
  authorization, sendOtp
}

enum NetworkEndpoint {
  getAvailableNetworks, getTxStatus
}

enum BalanceEndpoint {
  getNativeBalance, getERC721Balance, getNonNativeERC20Balance, getTokenPrice
}

enum CustodiedWalletEndpoint {
  getNewHash, getCustodiedWallets, sendTransaction, sendOTP, sendTxFromCustodiedWallet
}

enum ERC20Endpoint {
  transfer, transferFrom, getAllowance
}

enum SmartContractEndpoint {
  deploySmartContract, querySmartContract, getContractSpecs
}
enum AlchemyEdpoints {
  getNFTs
}

enum StorageEnpoints {
  uploadIpfsJSON, uploadIpfsFile
}

enum ERC721Endpoint {
  deployNft, mintNft
}

enum VottunProdEndpoint {
  getContractDeployedSmartContract
}
