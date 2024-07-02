import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/available_contract_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/create_nft_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/deployed_contracts_cubit.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';
import 'package:social_wallet/views/widget/top_toolbar.dart';

import '../../../../../utils/app_colors.dart';

class ContractsDeployedScreen extends StatefulWidget {

  CreateNftCubit createNftCubit = getCreateNftCubit();
  ToggleStateCubit showImageStateCubit = getToggleStateCubit();
  int contractSpecId;
  ContractsDeployedScreen({
    super.key,
    required this.contractSpecId
  });

  @override
  _ContractsDeployedScreenState createState() => _ContractsDeployedScreenState();
}

class _ContractsDeployedScreenState extends State<ContractsDeployedScreen> with WidgetsBindingObserver {


  @override
  void initState() {
    getDeployedContractsCubit().getDeployedContractBySpecId(widget.contractSpecId);
    super.initState();
  }

  //TODO PASS A BLOC
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: TopToolbar(
        enableBack: true,
        toolbarTitle: "Deployed Contracts",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text("Contracts deployed by: Contract Name",
                    maxLines: 2,
                    style: context.bodyTextMedium.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<DeployedContractsCubit, DeployedContractsState>(
            bloc: getDeployedContractsCubit(),
            builder: (context, state) {
              if (state.status == AvailableContractStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.deployedContractsList != null) {
                if (state.deployedContractsList!.isEmpty) {
                  return Center(
                    child: Text("You have not uploaded a contract to Vottun Platform"),
                  );
                }
              }
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: state.deployedContractsList?.map((e) =>
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Material(
                            elevation: 0,
                            color: AppColors.appBackgroundColor,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/ic_smart_contract.svg",
                                    width: 45,
                                    height: 45,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text("${e.network} #${e.owner} ${DateTime.fromMillisecondsSinceEpoch(e.creationTimestamp).toIso8601String()}",
                                                maxLines: 2,
                                                style: context.bodyTextMedium.copyWith(
                                                    fontSize: 16,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(AppConstants.trimAddress(address: e.address),
                                                maxLines: 4,
                                                style: context.bodyTextMedium.copyWith(
                                                  overflow: TextOverflow.ellipsis,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ).toList() ?? [],
                  ),
                ),
              );
            },
          ),
        ],
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
