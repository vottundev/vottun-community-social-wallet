
import 'package:flutter/material.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/balance_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/nft_item.dart';

import '../../../../models/network_info_model.dart';
import '../../../widget/top_toolbar.dart';


class NFTDetailScreen extends StatefulWidget {

  bool emptyFormations = false;
  NetworkInfoModel? selectedNetwork;

  NFTDetailScreen({super.key});

  @override
  _NFTDetailScreenState createState() => _NFTDetailScreenState();
}

class _NFTDetailScreenState extends State<NFTDetailScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<NFTDetailScreen> {

  bool isWalletCreated = false;
  late String userAddress;
  BalanceCubit balanceCubit = getBalanceCubit();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userAddress = getKeyValueStorage().getUserAddress() ?? "";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopToolbar(
        enableBack: true,
        toolbarTitle: "NFT Detail",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NftItem(
                        onClickNft: () {

                        }
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child
                    : Column(
                  children: [
                    Text("data")
                  ],
                ),
              )
            ],
          )
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
