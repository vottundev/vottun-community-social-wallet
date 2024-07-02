import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/send_tx_request_model.dart';
import 'package:social_wallet/models/tokens_info_model.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/direct_payment_bottom_dialog_cubit.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/direct_payment_cubit.dart';
import 'package:social_wallet/views/screens/main/wallet/verification_code_component.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../widget/custom_button.dart';

class CryptoPaymentBottomDialog extends StatefulWidget {

  SendTxRequestModel sendTxRequestModel;
  List<String> amountToSendResult;
  DirectPaymentState state;
  TokensInfoModel tokenInfoModel;
  String recipientAddress;
  int strategy;
  double value;

  CryptoPaymentBottomDialog({
    super.key,
    required this.sendTxRequestModel,
    required this.amountToSendResult,
    required this.tokenInfoModel,
    required this.recipientAddress,
    required this.value,
    required this.strategy,
    required this.state,
  });

  @override
  _CryptoPaymentBottomDialogState createState() => _CryptoPaymentBottomDialogState();
}

class _CryptoPaymentBottomDialogState extends State<CryptoPaymentBottomDialog> with WidgetsBindingObserver {

  TextEditingController verificationCodeController = TextEditingController(text: '');
  DirectPaymentBottomDialogCubit directPaymentBottomDialogCubit = getDirectPaymentBottomDialogCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: BlocBuilder<DirectPaymentBottomDialogCubit, DirectPaymentBottomDialogState>(
          bloc: directPaymentBottomDialogCubit,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  "Payment Summary",
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: context.bodyTextLarge.copyWith(fontWeight: FontWeight.w600, fontSize: 20, overflow: TextOverflow.ellipsis),
                                )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "From: ",
                                maxLines: 1,
                                style: context.bodyTextLarge.copyWith(fontWeight: FontWeight.w600, fontSize: 18, overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  AppConstants.trimAddress(address: widget.sendTxRequestModel.sender),
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  style: context.bodyTextLarge.copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "To: ",
                                maxLines: 1,
                                style: context.bodyTextLarge.copyWith(fontWeight: FontWeight.w600, fontSize: 18, overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  AppConstants.trimAddress(address: widget.state.selectedContactAddress),
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  style: context.bodyTextLarge.copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Amount to sent: ",
                                maxLines: 1,
                                style: context.bodyTextLarge.copyWith(fontWeight: FontWeight.w600, fontSize: 18, overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Expanded(
                                child: Text(
                                  widget.amountToSendResult.first,
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  style: context.bodyTextLarge.copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Network: ",
                                maxLines: 1,
                                style: context.bodyTextLarge.copyWith(fontWeight: FontWeight.w600, fontSize: 18, overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  widget.tokenInfoModel.tokenName,
                                  maxLines: 1,
                                  textAlign: TextAlign.end,
                                  style: context.bodyTextLarge.copyWith(fontSize: 18, overflow: TextOverflow.ellipsis),
                                ))
                          ],
                        ),
                        const SizedBox(height: 20),
                        VerificationCodeComponent(
                          strategy: widget.strategy,
                          onWriteCode: (value) {
                            if (value != null) {
                              verificationCodeController.text = value;
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              AppRouter.pop();
                            },
                            child: Text(
                                "Cancelar", textAlign: TextAlign.end, style: context.bodyTextMedium.copyWith(fontSize: 18, color: Colors.blue)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonText: "PAY",
                            radius: 10,
                            elevation: 5,
                            backgroundColor: AppColors.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            onTap: () async {

                              directPaymentBottomDialogCubit.doDirectPayment(context,
                                  sendTxRequestModel: widget.sendTxRequestModel,
                                  tokenInfoModel: widget.tokenInfoModel,
                                  recipientAddress: widget.recipientAddress,
                                  pin: verificationCodeController.text,
                                  value: widget.value
                              );

                              /*User? currUser = AppConstants.getCurrentUser();

                              if (currUser != null) {
                                if (verificationCodeController.text.isNotEmpty) {
                                  String verificationCode = verificationCodeController.text;

                                  SendTxRequestModel sendReqModel = widget.sendTxRequestModel.copyWith(pin: verificationCode);

                                  SendTxResponseModel? response;

                                  if (widget.tokenInfoModel.isNative) {
                                    sendReqModel = SendTxRequestModel(
                                        recipient: widget.recipientAddress,
                                        sender: sendReqModel.sender,
                                        value: sendReqModel.params?[1] ?? 0,
                                        blockchainNetwork: sendReqModel.blockchainNetwork,
                                        pin: sendReqModel.pin);
                                    response = await getDirectPaymentBottomDialogCubit().sendNativeCryptoTx(sendReqModel, currUser.strategy ?? 0);
                                  } else {
                                    response = await getDirectPaymentBottomDialogCubit().sendCryptoTx(sendReqModel, currUser.strategy ?? 0);
                                  }

                                  if (response != null) {
                                    int? savedResponse = await getDbHelper().insertDirectPayment(DirectPaymentModel(
                                        ownerId: currUser.id ?? 0,
                                        networkId: widget.tokenInfoModel.networkId,
                                        creationTimestamp: DateTime
                                            .now()
                                            .millisecondsSinceEpoch,
                                        payedAmount: sendReqModel.params?[1] ?? 0,
                                        ownerUsername: currUser.username ?? "",
                                        currencyName: widget.tokenInfoModel.tokenName,
                                        currencySymbol: widget.tokenInfoModel.tokenSymbol));
                                    if (savedResponse != null && mounted) {
                                      AppConstants.showToast(context, "Amount send it!");
                                      AppRouter.pop();
                                    }
                                  }
                                }
                              }*/
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
