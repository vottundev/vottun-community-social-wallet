import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/routes/routes.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/config/config_props.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/available_contract_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/create_nft_cubit.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';

import '../../../../../utils/app_colors.dart';

class AvailableContractsScreen extends StatefulWidget {

  CreateNftCubit createNftCubit = getCreateNftCubit();
  ToggleStateCubit showImageStateCubit = getToggleStateCubit();

  AvailableContractsScreen({
    super.key,
  });

  @override
  _AvailableContractsScreenState createState() => _AvailableContractsScreenState();
}

class _AvailableContractsScreenState extends State<AvailableContractsScreen> with WidgetsBindingObserver {


  @override
  void initState() {
    getAvailableContractCubit().getAvailableContractsFromVottunPlatform();
    super.initState();
  }

  //TODO PASS A BLOC
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text("Uploaded contracts on Vottun",
                      maxLines: 2,
                      style: context.bodyTextMedium.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text("Owner: ${AppConstants.trimAddress(address: ConfigProps.adminAddress, trimLength: 8)}",
                      maxLines: 2,
                      style: context.bodyTextMedium.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<AvailableContractCubit, AvailableContractState>(
          bloc: getAvailableContractCubit(),
          builder: (context, state) {
            if (state.status == AvailableContractStatus.loading) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state.availableContractsList != null) {
              if (state.availableContractsList!.isEmpty) {
                return Center(
                  child: Text("You have not uploaded a contract to Vottun Platform"),
                );
              }
            }
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: state.availableContractsList?.map((e) =>
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Material(
                          elevation: 0,
                          color: AppColors.appBackgroundColor,
                          child: InkWell(
                            onTap: () {
                              AppRouter.pushNamed(RouteNames.DeployedContractsScreenRoute.name, args: e.id);
                            },
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
                                              child: Text("${e.name} #${e.id}",
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
                                              child: Text(e.description,
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
                        ),
                      )
                  ).toList() ?? [],
                ),
              ),
            );
          },
        ),
      ],
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
