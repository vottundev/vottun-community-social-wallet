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

class DirectPaymentScreen extends StatefulWidget {

  final DirectPaymentCubit dirPayCubit;
  const DirectPaymentScreen({super.key, required this.dirPayCubit});

  @override
  _DirectPaymentScreenState createState() => _DirectPaymentScreenState();
}
class _DirectPaymentScreenState extends State<DirectPaymentScreen> with AutomaticKeepAliveClientMixin {

  NetworkInfoModel? netInfoModel;
  ToggleStateCubit cubit = getToggleStateCubit();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          BlocBuilder<DirectPaymentCubit, DirectPaymentState>(
            bloc: widget.dirPayCubit,
            builder: (context, state) {
              return Expanded(
                child: Padding(
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
                                    widget.dirPayCubit.setContactInfo(contactName, address ?? "");
                                  }));
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: AppColors.primaryColor),
                                          borderRadius: BorderRadius.circular(50)),
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
                                  children: [
                                    Text(state.selectedContactName != null
                                        ? (state.selectedContactName!.isEmpty
                                            ? getStrings().searchContacts
                                            : state.selectedContactName!)
                                        : getStrings().searchContacts)
                                  ],
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
                                tabs: [
                                  Tab(text: getStrings().cryptoLabel),
                                  //Tab(text: "Fiat"),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: NetworkSelector(
                                        selectedNetworkInfoModel: state.selectedNetwork,
                                        onClickNetwork: (selectedNetwork) {
                                          netInfoModel = selectedNetwork;
                                          widget.dirPayCubit.setSelectedNetwork(selectedNetwork);
                                        },
                                        onClickToken: (tokenInfoModel) {
                                          startCryptoPayment(
                                              state.selectedNetwork, tokenInfoModel, context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void startCryptoPayment(
      NetworkInfoModel? networkInfoModel, TokensInfoModel? tokensInfoModel, BuildContext context) async {
    //todo pending get contract address of selected crypto
    if (getKeyValueStorage().getUserAddress() != null &&
        networkInfoModel != null &&
        widget.dirPayCubit.state.selectedContactAddress != null) {
      User? currUser = AppConstants.getCurrentUser();

      if (getKeyValueStorage().getUserAddress()!.isNotEmpty && currUser != null) {
        if (context.mounted) {
          List<String>? amountToSendResult = await AppConstants.showCustomTextInputDialog(
              context: context,
              title: getStrings().amountToSentTitle,
              okLabel: getStrings().continueText,
              cancelLabel: getStrings().cancelText,
              textFields: [const DialogTextField(keyboardType: TextInputType.numberWithOptions(decimal: true))]);

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
                        blockchainNetwork: networkInfoModel.id,
                        params: [
                          widget.dirPayCubit.state.selectedContactAddress,
                          AppConstants.toWei(parsedValue, tokensInfoModel.decimals),
                        ]);
                    if (context.mounted) {
                      AppConstants.showBottomDialog(
                          context: context,
                          body: CryptoPaymentBottomDialog(
                            strategy: currUser.strategy ?? 0,
                            sendTxRequestModel: sendTxRequestModel,
                            amountToSendResult: amountToSendResult,
                            recipientAddress: widget.dirPayCubit.state.selectedContactAddress ?? "",
                            state: widget.dirPayCubit.state,
                            tokenInfoModel: tokensInfoModel,
                            value: parsedValue,
                          ));
                    }
                  } else {
                    if (parsedValue == 0.0) {
                      if (context.mounted) {
                        AppConstants.showToast(context, getStrings().amountCannotBeZeroTitle);
                      }
                    } else {
                      if (context.mounted) {
                        AppConstants.showToast(context, getStrings().exceededWalletBalance);
                      }
                    }
                  }
                } catch (exception) {
                  print(exception);
                  if (context.mounted) {
                    AppConstants.showToast(context, getStrings().commonErrorMessage);
                  }
                }
              }
            }
          }
        }
      } else {
        if (context.mounted) {
          AppConstants.showToast(context, getStrings().createWalletFirstMessage);
        }
      }
    } else {
      if (getKeyValueStorage().getUserAddress() == null) {
        AppConstants.showToast(context, getStrings().createWalletFirstMessage);
      }
      if (widget.dirPayCubit.state.selectedNetwork == null) {
        AppConstants.showToast(context, getStrings().selectNetworkFirstMessage);
      }
      if (widget.dirPayCubit.state.selectedContactAddress == null) {
        AppConstants.showToast(context, getStrings().selectContactMessage);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}
