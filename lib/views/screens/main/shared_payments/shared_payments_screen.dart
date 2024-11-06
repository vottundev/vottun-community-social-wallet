import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/shared_payments/create_shared_payment_bottom_dialog.dart';
import 'package:social_wallet/views/screens/main/shared_payments/cubit/shared_payment_cubit.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payment_details_bottom_dialog.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payment_item.dart';

import '../../../../di/injector.dart';
import '../../../../models/db/user.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/select_contact_bottom_dialog.dart';

class SharedPaymentsScreen extends StatefulWidget {

  SharedPaymentsScreen({super.key}) {
    getSharedPaymentCubit().getUserSharedPayments();
  }

  @override
  _SharedPaymentsScreenState createState() => _SharedPaymentsScreenState();
}

class _SharedPaymentsScreenState extends State<SharedPaymentsScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<SharedPaymentCubit, SharedPaymentState>(
              bloc: getSharedPaymentCubit(),
              builder: (context, state) {
                if (state.status == SharedPaymentStatus.loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state.sharedPaymentResponseModel != null) {
                  if (state.sharedPaymentResponseModel?.isEmpty ?? true) {
                    return Expanded(
                        child: Center(
                            child: Text(
                      "Not created any shared payment yet! :(",
                      style: context.bodyTextMedium.copyWith(fontSize: 18),
                    )));
                  }
                }
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            getSharedPaymentCubit().getUserSharedPayments();
                          },
                          child: ListView(children: state.sharedPaymentResponseModel!.map((e) {
                              String currUserEmail = getKeyValueStorage().getCurrentUser()?.userEmail ?? "";
                              return SharedPaymentItem(
                                element: e,
                                isOwner: e.sharedPayment.ownerEmail == currUserEmail,
                                onClickItem: (sharedPayInfo) async {
                                  User? currUser = AppConstants.getCurrentUser();
                                  //TxStatusResponseModel? txStatusResponseModel = await getWeb3CoreRepository().getTxStatus(txHash: e.sharedPayment.creationTxHash ?? "", networkId: e.sharedPayment.networkId);

                                  if (currUser != null && mounted) {
                                    AppConstants.showBottomDialog(
                                        context: context,
                                        isScrollControlled: true,
                                        body: SharedPaymentDetailsBottomDialog(
                                          sharedPaymentResponseModel: e,
                                          currUser: currUser,
                                          // txResponse: txStatusResponseModel,
                                          isOwner: e.sharedPayment.ownerId == currUser.id,
                                          onBackFromCreateDialog: () {
                                            getSharedPaymentCubit().getUserSharedPayments();
                                          },
                                        ));
                                  }
                                },
                              );
                            }).toList()),
                          ),
                        ),

                    ],
                  ),
                );
              },
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: "Create Shared Payment",
                        radius: 10,
                        elevation: 1,
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        onTap: () {
                          AppConstants.showBottomDialog(
                              context: context,
                              isScrollControlled: false,
                              body: SelectContactsBottomDialog(
                                  title: "Select recipient",
                                  onClickContact: (userId, contactName, userAddress) {
                                    if (userId != 0 && userAddress != null) {
                                      AppConstants.showBottomDialog(
                                          context: context,
                                          body: CreateSharedPaymentBottomDialog(
                                            userId: userId,
                                            userAddressTo: userAddress,
                                            onBackFromCreateDialog: () {
                                              getSharedPaymentCubit().getUserSharedPayments();
                                            },
                                          ));
                                    }
                                  }));
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: "Request Shared Payment",
                        radius: 10,
                        elevation: 1,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        onTap: () {
                          AppConstants.showBottomDialog(
                              context: context,
                              body: CreateSharedPaymentBottomDialog(
                                userAddressTo: getKeyValueStorage().getUserAddress() ?? "",
                                onBackFromCreateDialog: () {
                                  getSharedPaymentCubit().getUserSharedPayments();
                                },
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
