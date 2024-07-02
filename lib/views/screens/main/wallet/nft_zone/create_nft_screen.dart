import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/config/config_props.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/utils/helpers/extensions/string_extensions.dart';
import 'package:social_wallet/utils/helpers/form_validator.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/create_nft_cubit.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';
import 'package:social_wallet/views/widget/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../widget/custom_button.dart';
import '../../../../widget/network_selector.dart';

class CreateNftScreen extends StatefulWidget {
  CreateNftScreen({
    super.key,
  });

  @override
  _CreateNftScreenState createState() => _CreateNftScreenState();
}

class _CreateNftScreenState extends State<CreateNftScreen> with WidgetsBindingObserver {
  bool isCreatingSharedPayment = false;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController symbolController = TextEditingController(text: '');
  TextEditingController baseUriController = TextEditingController(text: '');
  TextEditingController costPerNftController = TextEditingController(text: '');
  TextEditingController maxSupplyController = TextEditingController(text: '');
  int? selectedNetworkId;
  int? tokenDecimals;
  CreateNftCubit createNftCubit = getCreateNftCubit();
  ToggleStateCubit createNftStateCubit = getToggleStateCubit();

  @override
  void initState() {
    super.initState();
  }

  //TODO PASS A BLOC
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NetworkSelector(
          selectedNetworkInfoModel: null,
          showMakePaymentText: false,
          showList: false,
          onClickNetwork: (selectedValue) {
            if (selectedValue != null) {
              selectedNetworkId = selectedValue.id;
            } else {
              selectedNetworkId = 0;
            }
          },
        ),
        const SizedBox(height: 10),
        BlocBuilder<CreateNftCubit, CreateNftState>(
          bloc: createNftCubit,
          builder: (context, state) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              validator: FormValidator.emptyValidator,
                              labelText: "Name*",
                              controller: nameController,
                              labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              validator: FormValidator.emptyValidator,
                              labelText: "Symbol*",
                              maxLines: 1,
                              controller: symbolController,
                              alignLabelWithHint: true,
                              labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              validator: FormValidator.emptyValidator,
                              labelText: "Base Uri",
                              maxLines: 1,
                              controller: baseUriController,
                              alignLabelWithHint: true,
                              labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              textInputAction: TextInputAction.done,
                              validator: FormValidator.emptyValidator,
                              labelText: "Cost per NFT*",
                              maxLines: 1,
                              controller: costPerNftController,
                              alignLabelWithHint: true,
                              labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              validator: FormValidator.emptyValidator,
                              labelText: "Max Supply*",
                              maxLines: 1,
                              controller: maxSupplyController,
                              alignLabelWithHint: true,
                              labelStyle: context.bodyTextMedium.copyWith(fontSize: 16, color: AppColors.hintTexFieldGrey),
                            ),
                            const SizedBox(height: 15),
                            RichText(
                                text: TextSpan(
                                    text: "Smart contract will be deployed by address:\n",
                                    style: context.bodyTextMedium.copyWith(
                                      fontSize: 18
                                    ),
                                    children: [
                                      TextSpan(
                                          style: context.bodyTextMedium.copyWith(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              decoration: TextDecoration.underline,
                                              decorationColor: Colors.blue
                                          ),
                                          text: AppConstants.trimAddress(address: ConfigProps.adminAddress, trimLength: 12),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                            var url = "${AppConstants.mumbaiScannerUrl}${ConfigProps.adminAddress}";
                                            if (await canLaunchUrl(Uri.parse(url))) {
                                              await launchUrl(Uri.parse(url));
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                          }),
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<ToggleStateCubit, ToggleStateState>(
                    bloc: createNftStateCubit,
                    builder: (context, state) {
                      if (state.isEnabled) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                                radius: 10,
                                buttonText: "Create NFT",
                                onTap: () {
                                  createERC721();
                                }),
                          )
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void createERC721() async {
    String name = nameController.text;
    String symbol = symbolController.text;
    String baseUri = baseUriController.text;
    double costPerNft = costPerNftController.text.parseToDouble();
    int totalSupply = int.parse(maxSupplyController.text);

    if (name.isNotEmpty && symbol.isNotEmpty && baseUri.isNotEmpty && costPerNft != 0.0 && baseUri.isNotEmpty && selectedNetworkId != null && totalSupply != 0) {
      createNftStateCubit.toggleState();
      //todo set token decimals
      int? result = await createNftCubit.createERC721(
          name: name, symbol: symbol, baseUri: baseUri, costPerNftTokenDecimals: 18, costPerNft: costPerNft, maxSupply: totalSupply, network: selectedNetworkId!);

      if (result != null) {
        AppRouter.pop();
      }
    } else {
      AppConstants.showToast(context, "Complete all fields please");
    }
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
