import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/models/db/shared_payment_users.dart';
import 'package:social_wallet/models/send_tx_request_model.dart';
import 'package:social_wallet/models/send_tx_response_model.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/config/config_props.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/shared_payments/cubit/end_shared_payment_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/verification_code_component.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';

import '../../../../di/injector.dart';
import '../../../../models/db/shared_payment_response_model.dart';
import '../../../../models/db/user.dart';
import '../../../../models/enum_shared_payment_status.dart';
import '../../../widget/custom_button.dart';

class SharedPaymentDetailsBottomDialog extends StatelessWidget {
  SharedPaymentResponseModel sharedPaymentResponseModel;

  // TxStatusResponseModel txResponse;
  bool isOwner;
  Function() onBackFromCreateDialog;
  EndSharedPaymentCubit endSharedPaymentCubit = getEndSharedPaymentCubit();
  String userAddress = getKeyValueStorage().getUserAddress() ?? "";
  SharedPaymentUsers? sharedPaymentUsers;
  User? currUser;
  ToggleStateCubit toggleInitPaymentCubit = getToggleStateCubit();
  ToggleStateCubit toggleSubmitPaymentCubit = getToggleStateCubit();
  ToggleStateCubit toggleApprovePaymentCubit = getToggleStateCubit();
  ToggleStateCubit toggleExecutePaymentCubit = getToggleStateCubit();

  String pin = "";

  SharedPaymentDetailsBottomDialog(
      {super.key,
      required this.isOwner,
      required this.currUser,
      required this.onBackFromCreateDialog,
      required this.sharedPaymentResponseModel});

  @override
  Widget build(BuildContext context) {
    sharedPaymentResponseModel.sharedPaymentUser?.forEach((element) {
      if (element.userAddress == userAddress) {
        sharedPaymentUsers = element;
      }
    });

    if (isOwner) {
      endSharedPaymentCubit.getTxNumConfirmations(
          (sharedPaymentResponseModel.sharedPayment.id ?? 0) - 1, sharedPaymentResponseModel.sharedPayment.networkId);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                Tab(text: getStrings().txDetailsText),
                //Tab(text: "Tx History"),
              ],
            ),
            Expanded(
                child: TabBarView(
              children: [
                BlocBuilder<EndSharedPaymentCubit, EndSharedPaymentState>(
                  bloc: endSharedPaymentCubit,
                  builder: (context, state) {
                    if (state.status == EndSharedPaymentStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RichText(
                                            text: TextSpan(
                                                text: "${getStrings().statusText}: ",
                                                style: context.bodyTextMedium.copyWith(
                                                    fontSize: 18,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w500),
                                                children: [
                                              TextSpan(
                                                text: sharedPaymentResponseModel.sharedPayment.status,
                                                style: context.bodyTextMedium
                                                    .copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),
                                              )
                                            ])),
                                      ),
                                    ],
                                  ),
                                  if (sharedPaymentResponseModel.sharedPayment.status ==
                                          ESharedPaymentStatus.CONFIRMED.name &&
                                      !isOwner) ...[
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${getStrings().youHavePayedText}: ${sharedPaymentUsers?.userAmountToPay ?? 0.0} ${sharedPaymentResponseModel.sharedPayment.currencySymbol}",
                                            textAlign: TextAlign.start,
                                            style: context.bodyTextMedium
                                                .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          !isOwner
                                              ? getStrings().requestPaymentToYouMessage(
                                                  sharedPaymentResponseModel.sharedPayment.ownerUsername,
                                                  (sharedPaymentUsers?.userAmountToPay ?? 0.0).toString(),
                                                  sharedPaymentResponseModel.sharedPayment.currencySymbol,
                                                  sharedPaymentResponseModel.sharedPayment.currencyName)
                                              : getStrings().requestedPaymentMessage(
                                                  sharedPaymentResponseModel.sharedPayment.totalAmount.toString(),
                                                  sharedPaymentResponseModel.sharedPayment.currencySymbol,
                                                  sharedPaymentResponseModel.sharedPaymentUser
                                                          ?.map((e) => e.username)
                                                          .join(", ") ??
                                                      '',
                                                  sharedPaymentResponseModel.sharedPayment.currencyName),
                                          textAlign: TextAlign.start,
                                          maxLines: 20,
                                          style: context.bodyTextMedium.copyWith(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isOwner) ...[
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "${getStrings().numConfirmationsText}: ",
                                                  style: context.bodyTextMedium.copyWith(
                                                      fontSize: 18,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w500),
                                                  children: [
                                                TextSpan(
                                                  text: state.txCurrentNumConfirmations.toString(),
                                                  style: context.bodyTextMedium
                                                      .copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),
                                                )
                                              ])),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                              text: TextSpan(
                                                  text: "${getStrings().totalRequiredConfirmations}: ",
                                                  style: context.bodyTextMedium.copyWith(
                                                      fontSize: 18,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w500),
                                                  children: [
                                                TextSpan(
                                                  text: sharedPaymentResponseModel.sharedPayment.numConfirmations
                                                      .toString(),
                                                  style: context.bodyTextMedium
                                                      .copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),
                                                )
                                              ])),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (sharedPaymentResponseModel.sharedPayment.status ==
                                          ESharedPaymentStatus.READY.name &&
                                      isOwner) ...[
                                    const SizedBox(height: 10),
                                    VerificationCodeComponent(
                                        strategy: currUser?.strategy ?? 0,
                                        onWriteCode: (value) {
                                          if (value != null) {
                                            pin = value;
                                            toggleInitPaymentCubit.toggleState();
                                          }
                                        }),
                                  ] else if ((sharedPaymentResponseModel.sharedPayment.status ==
                                              ESharedPaymentStatus.APPROVE.name ||
                                          sharedPaymentResponseModel.sharedPayment.status ==
                                              ESharedPaymentStatus.PAY.name) &&
                                      !isOwner) ...[
                                    const SizedBox(height: 10),
                                    VerificationCodeComponent(
                                        strategy: currUser?.strategy ?? 0,
                                        onWriteCode: (value) {
                                          if (value != null) {
                                            pin = value;
                                            toggleSubmitPaymentCubit.toggleState();
                                            toggleApprovePaymentCubit.toggleState();
                                          }
                                        }),
                                  ]
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              if (!isOwner) ...[
                                if (sharedPaymentResponseModel.sharedPayment.status ==
                                    ESharedPaymentStatus.APPROVE.name) ...[
                                  BlocBuilder<ToggleStateCubit, ToggleStateState>(
                                    bloc: toggleApprovePaymentCubit,
                                    builder: (context, approveState) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (state.status == EndSharedPaymentStatus.loading) ...[
                                            const CircularProgressIndicator()
                                          ] else ...{
                                            Expanded(
                                              child: CustomButton(
                                                buttonText: getStrings().approveTransactionText,
                                                elevation: 3,
                                                radius: 10.0,
                                                enabled: approveState.isEnabled,
                                                backgroundColor: Colors.blue,
                                                onTap: () async {
                                                  SendTxResponseModel? sendTxResponseModel =
                                                      await endSharedPaymentCubit.approveToken(
                                                          shaPayId: sharedPaymentResponseModel.sharedPayment.id ?? 0,
                                                          tokenAddress: sharedPaymentResponseModel
                                                                  .sharedPayment.currencyAddress ??
                                                              "",
                                                          blockchainNetwork:
                                                              sharedPaymentResponseModel.sharedPayment.networkId,
                                                          sender: getKeyValueStorage().getUserAddress() ?? "",
                                                          params: [
                                                            ConfigProps.sharedPaymentCreatorAddress,
                                                            AppConstants.toWei(
                                                                sharedPaymentUsers?.userAmountToPay ?? 0.0,
                                                                sharedPaymentResponseModel
                                                                        .sharedPayment.tokenDecimals ??
                                                                    0)
                                                          ],
                                                          pin: pin);
                                                  if (sendTxResponseModel != null) {
                                                    AppRouter.pop();
                                                    onBackFromCreateDialog();
                                                  }
                                                },
                                              ),
                                            ),
                                          },
                                        ],
                                      );
                                    },
                                  ),
                                  // ] else if (sharedPaymentResponseModel.sharedPayment.status == "PENDING" && !isOwner) ...[
                                ] else if (sharedPaymentResponseModel.sharedPayment.status ==
                                    ESharedPaymentStatus.PAY.name) ...[
                                  BlocBuilder<ToggleStateCubit, ToggleStateState>(
                                    bloc: toggleSubmitPaymentCubit,
                                    builder: (context, submitState) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (state.status == EndSharedPaymentStatus.loading) ...[
                                            const CircularProgressIndicator()
                                          ] else ...{
                                            Expanded(
                                              child: CustomButton(
                                                buttonText: getStrings().payText,
                                                elevation: 1,
                                                enabled: submitState.isEnabled,
                                                inverseColors: true,
                                                radius: 10.0,
                                                onTap: () async {
                                                  SendTxResponseModel? sendTxResponseModel;
                                                  if (sharedPaymentUsers != null) {
                                                    sendTxResponseModel =
                                                        await endSharedPaymentCubit.sendTxToSmartContract(
                                                            sharedPaymentResponseModel: sharedPaymentResponseModel,
                                                            sharedPaymentUsers: sharedPaymentUsers!,
                                                            pin: pin);
                                                    if (sendTxResponseModel != null) {
                                                      AppRouter.pop();
                                                      onBackFromCreateDialog();
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          },
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ] else if (sharedPaymentResponseModel.sharedPayment.status == "READY") ...[
                                const SizedBox(height: 5),
                                BlocBuilder<ToggleStateCubit, ToggleStateState>(
                                  bloc: toggleExecutePaymentCubit,
                                  builder: (context, submitState) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (state.status == EndSharedPaymentStatus.loading) ...[
                                          const CircularProgressIndicator()
                                        ] else ...{
                                          Expanded(
                                            child: CustomButton(
                                              buttonText: getStrings().approveTransactionText,
                                              elevation: 1,
                                              enabled: true,
                                              backgroundColor: Colors.blueAccent,
                                              radius: 10.0,
                                              onTap: () async {
                                                SendTxResponseModel? sendTxResponseModel =
                                                    await endSharedPaymentCubit.submitTxReq(SendTxRequestModel(
                                                        sender: getKeyValueStorage().getUserAddress() ?? "",
                                                        blockchainNetwork:
                                                            sharedPaymentResponseModel.sharedPayment.networkId,
                                                        //todo check why not accepting value param for native token transaction to sc
                                                        //value: AppConstants.toWei(sharedPaymentUsers?.userAmountToPay ?? 0.0, sharedPaymentResponseModel.sharedPayment.tokenDecimals ?? 0).toInt(),
                                                        contractSpecsId: ConfigProps.contractSpecsId,
                                                        method:
                                                            sharedPaymentResponseModel.sharedPayment.currencyAddress ==
                                                                    null
                                                                ? "executeNativeSharedPayment"
                                                                : "executeSharedPayment",
                                                        params: sharedPaymentResponseModel
                                                                    .sharedPayment.currencyAddress ==
                                                                null
                                                            ? [
                                                                (sharedPaymentResponseModel.sharedPayment.id ?? 0) - 1,
                                                                sharedPaymentResponseModel.sharedPayment.ownerAddress
                                                              ]
                                                            : [(sharedPaymentResponseModel.sharedPayment.id ?? 0) - 1],
                                                        pin: pin));
                                                if (sendTxResponseModel != null) {
                                                  AppRouter.pop();
                                                  onBackFromCreateDialog();
                                                }
                                              },
                                            ),
                                          ),
                                        },
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
