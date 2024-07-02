import 'package:flutter/material.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/create_nft_cubit.dart';
import 'package:social_wallet/views/widget/top_toolbar.dart';

import 'available_contracts_screen.dart';
import 'create_nft_screen.dart';
import 'deploy_nft_screen.dart';

class CreateNftMainScreen extends StatefulWidget {

  CreateNftMainScreen({
    super.key,
  });

  @override
  _CreateNftMainScreenState createState() => _CreateNftMainScreenState();
}

class _CreateNftMainScreenState extends State<CreateNftMainScreen> with WidgetsBindingObserver {
  bool isCreatingSharedPayment = false;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController symbolController = TextEditingController(text: '');
  TextEditingController aliasController = TextEditingController(text: '');
  int? selectedNetworkId;
  CreateNftCubit createNftCubit = getCreateNftCubit();

  @override
  void initState() {
    super.initState();
  }

  //TODO PASS A BLOC
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopToolbar(
        enableBack: true,
        toolbarTitle: "NFT",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                      labelStyle: context.bodyTextMedium.copyWith(fontSize: 18),
                      tabs: const [
                        Tab(text: "Create NFT"),
                        Tab(text: "Contracts"),
                        Tab(text: "Community")
                      ]
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
                      CreateNftScreen(),
                      AvailableContractsScreen(),
                      DeployNftScreen(),
                    ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

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
