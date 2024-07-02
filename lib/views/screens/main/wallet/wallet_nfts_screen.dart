import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/routes/routes.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/wallet_nfts_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/nft_item.dart';
import 'package:social_wallet/views/widget/custom_button.dart';
import 'package:social_wallet/views/widget/network_selector.dart';

class WalletNFTsScreen extends StatefulWidget {
  bool emptyFormations = false;

  WalletNFTsScreen({super.key});

  @override
  _WalletNFTsScreenState createState() => _WalletNFTsScreenState();
}

class _WalletNFTsScreenState extends State<WalletNFTsScreen> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<WalletNFTsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            NetworkSelector(
              selectedNetworkInfoModel: getWalletNFTsCubit().state.selectedInfoNetwork,
              showMakePaymentText: false,
              showList: false,
              onClickNetwork: (selectedValue) {
                if (selectedValue != null) {
                  getWalletNFTsCubit().setSelectedNetwork(selectedValue);
                  getWalletNFTsCubit().getAccountNFTs(selectedNetworkInfo: selectedValue, networkId: selectedValue.id);
                }
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<WalletNFTsCubit, WalletNFTsState>(
              bloc: getWalletNFTsCubit(),
              builder: (context, state) {
                if (state.ownedNFTsList == null && state.status != WalletNFTsStatus.loading) {
                  if (state.status == WalletNFTsStatus.initial) {
                    return const Expanded(
                      child: Center(
                        child: Text("NFTs not found :("),
                      ),
                    );
                  }
                  return const Center(
                    child: Column(
                      children: [
                        Text("Something happened, thanks for your patience :)!"),
                      ],
                    ),
                  );
                }
                if (state.status == WalletNFTsStatus.loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state.ownedNFTsList?.isEmpty == true) {
                  return const Expanded(
                    child: Center(
                      child: Text("NFTs not found :("),
                    ),
                  );
                }
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: state.ownedNFTsList
                            ?.map((e) => NftItem(onClickNft: () {
                                  AppRouter.pushNamed(RouteNames.NFTDetailScreenRoute.name);
                                }))
                            .toList() ??
                        [],
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                      radius: 10,
                      enabled: true,
                      buttonText: "NFT Zone",
                      onTap: () {
                        AppRouter.pushNamed(RouteNames.CreateNftScreenRoute.name);
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
