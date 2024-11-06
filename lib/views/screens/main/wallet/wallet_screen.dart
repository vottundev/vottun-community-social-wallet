import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/wallet/create_wallet_webview_bottom_dialog.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/balance_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/wallet_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/wallet_nfts_screen.dart';
import 'package:social_wallet/views/screens/main/wallet/wallet_tokens_screen.dart';
import 'package:social_wallet/views/widget/custom_button.dart';

import '../../../../models/db/user.dart';
import '../../../../models/wallet_hash_response_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';

class WalletScreen extends StatefulWidget {

  WalletScreen({super.key});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<WalletScreen> {

  bool isWalletCreated = false;
  late String userAddress;
  late String userName;
  BalanceCubit balanceCubit = getBalanceCubit();
  User? user = getKeyValueStorage().getCurrentUser();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    userAddress = user?.accountHash ?? "";
    userName = user?.username ?? "";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: userAddress.isEmpty
            ? getCreateWalletBody()
            : BlocBuilder<WalletCubit, WalletState>(
                bloc: getWalletCubit(),
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "0€",
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: context.bodyTextMedium.copyWith(fontSize: 50, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppConstants.trimAddress(address: getKeyValueStorage().getUserAddress()),
                              textAlign: TextAlign.center,
                              style: context.bodyTextMedium.copyWith(fontSize: 25, fontWeight: FontWeight.w500),
                            )),
                            Icon(Icons.copy, color: AppColors.primaryColor)
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                    labelStyle: context.bodyTextMedium.copyWith(fontSize: 20),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    tabs: const [Tab(text: "Tokens"), Tab(text: "NFTs")]),
                                Expanded(
                                  child: TabBarView(physics: const NeverScrollableScrollPhysics(), children: [WalletTokensScreen(), WalletNFTsScreen()]),
                                ),
                              ],
                            )),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Widget getCreateWalletBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomButton(
                  buttonText: "CREATE WALLET",
                  elevation: 3,
                  onTap: () async {
                    WalletHashResponseModel? response = await getWalletCubit().createWallet();

                    if (response != null) {
                      if (mounted) {
                        AppConstants.showBottomDialog(
                            context: context,
                            isScrollControlled: true,
                            heightBoxConstraintRate: 0.95,
                            body: CreateWalletWebViewBottomDialog(
                              username: getKeyValueStorage().getCurrentUser()?.userEmail ?? "",
                              hash: response.hash,
                              onCreatedWallet: (createdWalletResponse, selectedStrategy) async {
                                getWalletCubit().onCreatedWallet(createdWalletResponse: createdWalletResponse, selectedStrategy: selectedStrategy);
                              },
                            ));
                      }
                    }
                  }),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

// @override
// void didChangeAppLifecycleState(AppLifecycleState state) {
//   switch (state) {
//     case AppLifecycleState.resumed:
//       setState(() {
//       });
//       break;
//     case AppLifecycleState.inactive:
//       break;
//     case AppLifecycleState.paused:
//       break;
//     case AppLifecycleState.detached:
//       break;
//   }
// }
}
