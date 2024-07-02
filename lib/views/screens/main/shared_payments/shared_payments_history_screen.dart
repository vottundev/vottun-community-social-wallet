import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/shared_payments/cubit/shared_payment_history_cubit.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payment_details_bottom_dialog.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payment_item.dart';

import '../../../../di/injector.dart';
import '../../../../models/db/user.dart';

class SharedPaymentsHistoryScreen extends StatefulWidget {
  SharedPaymentsHistoryScreen({super.key}) {
    getSharedPaymentHistoryCubit().getUserSharedPayments();
  }

  @override
  _SharedPaymentsHistoryScreenState createState() => _SharedPaymentsHistoryScreenState();
}

class _SharedPaymentsHistoryScreenState extends State<SharedPaymentsHistoryScreen> with WidgetsBindingObserver {
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
            BlocBuilder<SharedPaymentHistoryCubit, SharedPaymentHistoryState>(
              bloc: getSharedPaymentHistoryCubit(),
              builder: (context, state) {
                if (state.status == SharedPaymentHistoryStatus.loading) {
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
                      getStrings().emptySchedulePayment,
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
                            getSharedPaymentHistoryCubit().getUserSharedPayments();
                          },
                          child: ListView(
                              children: state.sharedPaymentResponseModel!.map((e) {
                            String currUserEmail = getKeyValueStorage().getCurrentUser()?.userEmail ?? "";
                            return SharedPaymentItem(
                              element: e,
                              isOwner: e.sharedPayment.ownerEmail == currUserEmail,
                              onClickItem: (sharedPayInfo) async {
                                User? currUser = AppConstants.getCurrentUser();

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
                                          getSharedPaymentHistoryCubit().getUserSharedPayments();
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
          ],
        ),
      ),
    );
  }
}
