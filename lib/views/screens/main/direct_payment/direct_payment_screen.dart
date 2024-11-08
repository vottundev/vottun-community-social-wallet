import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/models/network_info_model.dart';
import 'package:social_wallet/models/send_tx_request_model.dart';
import 'package:social_wallet/models/tokens_info_model.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/direct_payment/crypto_payment_bottom_dialog.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/direct_payment_cubit.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';
import 'package:social_wallet/views/widget/network_selector.dart';
import 'package:social_wallet/views/widget/select_contact_bottom_dialog.dart';

import '../../../../di/injector.dart';
import '../../../../models/db/user.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';


class DirectPaymentScreen extends StatelessWidget {

  NetworkInfoModel? netInfoModel;

  DirectPaymentScreen({super.key});

  ToggleStateCubit cubit = getToggleStateCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          BlocBuilder<DirectPaymentCubit, DirectPaymentState>(
            bloc: getDirectPaymentCubit(),
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            AppConstants.showBottomDialog(
                                context: context,
                                body: SelectContactsBottomDialog(onClickContact: (_, contactName, address) {
                                  getDirectPaymentCubit().setContactInfo(contactName, address ?? "");
                                }));
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration:
                                        BoxDecoration(border: Border.all(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(50)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      //make border radius more than 50% of square height & width
                                      child: Image.asset(
                                        "assets/nano.jpg",
                                        height: 100.0,
                                        width: 100.0,
                                        fit: BoxFit.cover, //change image fill type
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text(state.selectedContactName ?? "Search in contacts")],
                              ),
                              if (state.selectedContactAddress != null) ...[
                                if (state.selectedContactAddress!.isNotEmpty) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        AppConstants.trimAddress(address: state.selectedContactAddress ?? ""),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: context.bodyTextMedium.copyWith(overflow: TextOverflow.ellipsis),
                                      ))
                                    ],
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    //TODO PENDING GET CURRENCIES SYMBOL , NETOWRK ID AND CURRENCY NAME
                  ],
                ),
              );
            },
          ),
          Flexible(
            child: DefaultTabController(
              length: 1,
              child: Column(
                children: [
                  TabBar(
                    labelStyle: context.bodyTextMedium.copyWith(
                      fontSize: 21,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const [
                      Tab(text: "Crypto"),
                      //Tab(text: "Fiat"),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        //todo pendiente mostrar redes disponibles al seleccionar la moneda
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NetworkSelector(
                            selectedNetworkInfoModel: netInfoModel,
                            onClickNetwork: (selectedNetwork) {
                              if (selectedNetwork != null) {
                                netInfoModel = selectedNetwork;
                              }
                            },
                            onClickToken: (tokenInfoModel) {
                              startCryptoPayment(tokenInfoModel, context);
                            },
                          ),
                        ),
                        // BlocBuilder<ToggleStateCubit, ToggleStateState>(
                        //   bloc: cubit,
                        //   builder: (context, toggleSate) {
                        //     return Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Expanded(
                        //                 flex: 5,
                        //                 child: CustomTextField(
                        //                   labelText: "Write amount to send",
                        //                   inputStyle: context.bodyTextLarge,
                        //                   keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        //                   textInputAction: TextInputAction.next,
                        //                   validator: FormValidator.emptyValidator,
                        //                   onTap: () {},
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           Row(
                        //             children: [
                        //               Expanded(
                        //                 child: CustomButton(
                        //                   buttonText: "Start payment",
                        //                   radius: 15,
                        //                   elevation: 0,
                        //                   backgroundColor: !cubit.state.isEnabled ? Colors.grey : AppColors.primaryColor,
                        //                   padding: const EdgeInsets.symmetric(vertical: 10),
                        //                   onTap: () async {
                        //
                        //                   },
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startCryptoPayment(TokensInfoModel? tokensInfoModel, BuildContext context) async {
    //todo pending get contract address of selected crypto
    if (getKeyValueStorage().getUserAddress() != null &&
        netInfoModel != null &&
        getDirectPaymentCubit().state.selectedContactAddress != null
    ) {
      User? currUser = AppConstants.getCurrentUser();

      if (getKeyValueStorage().getUserAddress()!.isNotEmpty && currUser != null) {
        if (context.mounted) {
          List<String>? amountToSendResult = await AppConstants.showCustomTextInputDialog(
              context: context,
              title: "Amount to sent",
              okLabel: "Continue",
              cancelLabel: "Cancel",
              textFields: [
                const DialogTextField(keyboardType: TextInputType.numberWithOptions(decimal: true))
              ]
          );

          if (amountToSendResult != null) {
            if (amountToSendResult.isNotEmpty) {
              if (amountToSendResult.first.isNotEmpty) {
                try {
                  String amountString = amountToSendResult.first;
                  if (amountToSendResult.first.contains(",")) {
                    amountString = amountToSendResult.first.replaceFirst(RegExp(","), ".");
                  }
                  double parsedValue = double.parse(amountString);

                  if (parsedValue <= (double.parse(tokensInfoModel!.balance)) && parsedValue > 0.0) {
                    SendTxRequestModel sendTxRequestModel = SendTxRequestModel(
                        contractAddress: tokensInfoModel.tokenAddress ?? "",
                        //MATIC ??
                        sender: getKeyValueStorage().getUserAddress() ?? "",
                        blockchainNetwork: netInfoModel!.id,
                        params: [
                          getDirectPaymentCubit().state.selectedContactAddress,
                          AppConstants.toWei(parsedValue, tokensInfoModel.decimals),
                        ]);
                    if (context.mounted) {
                      AppConstants.showBottomDialog(
                          context: context,
                          body: CryptoPaymentBottomDialog(
                            strategy: currUser.strategy ?? 0,
                            sendTxRequestModel: sendTxRequestModel,
                            amountToSendResult: amountToSendResult,
                            recipientAddress: getDirectPaymentCubit().state.selectedContactAddress ?? "",
                            state: getDirectPaymentCubit().state,
                            tokenInfoModel: tokensInfoModel,
                            value: parsedValue,
                          ));
                    }
                  } else {
                    if (parsedValue == 0.0) {
                      if (context.mounted) {
                        AppConstants.showToast(context, "Amount cannot be 0");
                      }
                    } else {
                      if (context.mounted) {
                        AppConstants.showToast(context, "Exceeded your wallet balance. add funds");
                      }
                    }
                  }
                } catch (exception) {
                  print(exception);
                  if (context.mounted) {
                    AppConstants.showToast(context, "Something went wrong. Thanks for your patience :)");
                  }
                }
              }
            }
          }
        }
      } else {
        if (context.mounted) {
          AppConstants.showToast(context, "Create a wallet first");
        }
      }
    } else {
      if (getKeyValueStorage().getUserAddress() == null) {
        AppConstants.showToast(context, "Create a wallet first");
      }
      if (netInfoModel == null) {
        AppConstants.showToast(context, "Select a network first");
      }
      if (getDirectPaymentCubit().state.selectedContactAddress == null) {
        AppConstants.showToast(context, "Select a contact first");
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
