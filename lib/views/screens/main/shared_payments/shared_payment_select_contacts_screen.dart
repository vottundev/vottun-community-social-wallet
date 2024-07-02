import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/shared_contact_model.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/utils/helpers/extensions/string_extensions.dart';
import 'package:social_wallet/views/screens/main/shared_payments/cubit/shared_payment_contacts_cubit.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_contact_item.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payment_verification_code_bottom_dialog.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';
import 'package:social_wallet/views/widget/top_toolbar.dart';

import '../../../../models/db/shared_payment.dart';
import '../../../../models/db/user.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/select_contact_bottom_dialog.dart';

class SharedPaymentSelectContactsScreen extends StatefulWidget {
  double allSumAmount = 0.0;
  SharedPayment sharedPayment;
  SharedPaymentContactsCubit sharedPayContactsCubit =
      getSharedPaymentContactsCubit();

  SharedPaymentSelectContactsScreen({super.key, required this.sharedPayment});

  @override
  _SharedPaymentSelectContactsScreenState createState() =>
      _SharedPaymentSelectContactsScreenState();
}

class _SharedPaymentSelectContactsScreenState
    extends State<SharedPaymentSelectContactsScreen>
    with WidgetsBindingObserver {
  bool isCreatingSharedPayment = false;

  ToggleStateCubit showMyQuantityButtonCubit = getToggleStateCubit();

  @override
  void initState() {
    showInitDialogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: TopToolbar(enableBack: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<SharedPaymentContactsCubit,
              SharedPaymentContactsState>(
            bloc: widget.sharedPayContactsCubit,
            builder: (context, state) {
              List<SharedContactModel> sharedContactsList =
                  state.selectedContactsList ?? [];
              double pendingAmount = state.totalAmount != null
                  ? state.totalAmount! - (state.allSumAmount ?? 0.0)
                  : 0.0;
              pendingAmount =
                  pendingAmount.toStringAsPrecision(5).parseToDouble();

              return Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                          children: sharedContactsList
                              .map((e) => SharedContactItem(
                                  sharedContactModel: e,
                                  onClick: () async {
                                    if (e.amountToPay == 0.0) {
                                      setAddedUserAmount(
                                          sharedContactModel: e,
                                          selectedContactsList:
                                              state.selectedContactsList ?? []);
                                    }
                                  }))
                              .toList()),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "${getStrings().totalAmountText}: ${(state.totalAmount ?? 0.0).toStringAsFixed(AppConstants.getNumDecimalsAfterPoint(state.totalAmount ?? 0.0))}",
                                style: context.bodyTextMedium
                                    .copyWith(fontSize: 18),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "${getStrings().pendingAmountText}: $pendingAmount",
                                style: context.bodyTextMedium
                                    .copyWith(fontSize: 18),
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state.allSumAmount != state.totalAmount ||
                          state.allSumAmount == 0.0 ||
                          state.allSumAmount == null,
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonText: getStrings().addUserText,
                              radius: 15,
                              elevation: 5,
                              backgroundColor: AppColors.lightPrimaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onTap: () async {
                                AppConstants.showBottomDialog(
                                    context: context,
                                    isScrollControlled: false,
                                    body: SelectContactsBottomDialog(
                                        excludedId:
                                            widget.sharedPayment.ownerId,
                                        onClickContact:
                                            (userId, username, userAddress) {
                                          onClickContact(
                                              state,
                                              userId,
                                              username,
                                              userAddress,
                                              state.selectedContactsList ?? []);
                                        }));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<ToggleStateCubit, ToggleStateState>(
                      bloc: showMyQuantityButtonCubit,
                      builder: (context, state) {
                        return Visibility(
                          visible: state.isEnabled,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                  buttonText: getStrings().addMyAmountText,
                                  radius: 15,
                                  elevation: 5,
                                  backgroundColor: AppColors.sendTagTextColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  onTap: () async {

                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Visibility(
                      visible: (state.allSumAmount != null &&
                              state.totalAmount != null) &&
                          (state.allSumAmount == state.totalAmount &&
                              state.totalAmount != 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              buttonText: getStrings().startPaymentText,
                              radius: 15,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              onTap: () async {
                                createSharedPayment(
                                    state.selectedContactsList ?? []);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //FundedByComponent(),
                  ]);
            },
          ),
        ),
      ),
    );
  }

  void showInitDialogs() {
    Future.delayed(const Duration(milliseconds: 100), () async {
      List<String>? results = await AppConstants.showCustomTextInputDialog(
          context: context,
          title: getStrings().totalAmountText,
          message: getStrings().introTotalAmountToPayText,
          okLabel: getStrings().proceedText,
          cancelLabel: getStrings().cancelText,
          textFields: [
            const DialogTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true)),
          ]);
      if (results != null) {
        if (results.isNotEmpty) {
          if (results.first.isNotEmpty) {
            double totalAmount = 0.0;
            try {
              totalAmount = double.parse(results.first);
            } on Exception catch (e) {
              print(e.toString());
            }
            widget.sharedPayment =
                widget.sharedPayment.copyWith(totalAmount: totalAmount);
            widget.sharedPayContactsCubit.updateAmount(totalAmount);

            User? currUser = AppConstants.getCurrentUser();
            if (mounted) {
              if (currUser?.id != widget.sharedPayment.ownerId) {
                List<String>? resultsCurrUserAmount =
                await AppConstants.showCustomTextInputDialog(
                    context: context,
                    title: getStrings().yourAmountToPay,
                    message: getStrings().introYourTotalAmountToPayText,
                    okLabel: getStrings().proceedText,
                    cancelLabel: getStrings().cancelText,
                    barrierDismissible: false,
                    textFields: [
                      const DialogTextField(
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true)),
                    ]);

                if (resultsCurrUserAmount != null) {
                  if (resultsCurrUserAmount.isNotEmpty) {
                    if (resultsCurrUserAmount.first.isNotEmpty) {
                      sumSelectedAmount(resultsCurrUserAmount.first);
                    } else {
                      insertCurrUser(0.0);
                    }
                  }
                } else {
                  insertCurrUser(0.0);
                }
              }
            }
          } else {
            if (mounted) {
              AppConstants.showToast(context, getStrings().totalAmountCannotBeEmptyMessage);
            }
            AppRouter.pop();
          }
        }

      } else {
        AppRouter.pop();
      }
    });
  }

  void sumSelectedAmount(String results) {
    double currUserAmount = 0.0;
    try {
      currUserAmount = double.parse(results);
      if (currUserAmount >
          (widget.sharedPayment.tokenSelectedBalance ?? 0.0)) {
        currUserAmount = 0.0;
        if (!showMyQuantityButtonCubit.state.isEnabled) {
          showMyQuantityButtonCubit.toggleState();
        }
        if (mounted) {
          AppConstants.showToast(
              context, getStrings().exceededAmountOfWalletMessage);
        }
      } else {
        widget.allSumAmount += currUserAmount;
        if (widget.allSumAmount >
            (widget.sharedPayContactsCubit.state.totalAmount ??
                0.0)) {
          widget.allSumAmount -= currUserAmount;
        }
        widget.sharedPayContactsCubit
            .updatePendingAmount(widget.allSumAmount);
        insertCurrUser(currUserAmount);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void insertCurrUser(double userAmount) async {
    User? currUser = AppConstants.getCurrentUser();
    if (currUser != null) {
      if (currUser.userEmail != widget.sharedPayment.ownerEmail) {
        widget.sharedPayContactsCubit.updateSelectedContactsList([
          SharedContactModel(
              userId: currUser.id ?? 0,
              contactName: currUser.username ?? "",
              userAddress: currUser.accountHash ?? "",
              imagePath: "",
              amountToPay: userAmount)
        ]);
      }
    }
  }

  void setAddedUserAmount(
      {required SharedContactModel sharedContactModel,
      required List<SharedContactModel> selectedContactsList}) async {
    List<String>? resultsCurrUserAmount =
        await AppConstants.showCustomTextInputDialog(
            context: context,
            title: getStrings().yourAmountToPay,
            message: getStrings().introYourTotalAmountToPayText,
            okLabel: getStrings().proceedText,
            cancelLabel: getStrings().cancelText,
            barrierDismissible: false,
            textFields: [
          const DialogTextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true)),
        ]);

    if (resultsCurrUserAmount != null && mounted) {
      widget.sharedPayContactsCubit.setUserAmountToPay(context,
          resultsCurrUserAmount: resultsCurrUserAmount,
          selectedContactsList: selectedContactsList,
          sharedContactModel: sharedContactModel,
          sharedPayment: widget.sharedPayment,
          allSumAmount: widget.allSumAmount);
    }
  }

  void createSharedPayment(
      List<SharedContactModel> selectedContactsList) async {
    User? currUser = AppConstants.getCurrentUser();
    List<String> userAddressList = List.empty(growable: true);

    for (var element in selectedContactsList) {
      userAddressList.add(element.userAddress);
    }

    if (currUser != null && mounted) {
      AppConstants.showBottomDialog(
          context: context,
          body: SharedPaymentVerificationCodeBottomDialog(
            userAddressList:
                selectedContactsList.map((e) => e.userAddress).toList(),
            sharedPayUsersName:
                selectedContactsList.map((e) => e.contactName).join(", "),
            sharedPayment: widget.sharedPayment,
            sharedPaymentContactsCubit: widget.sharedPayContactsCubit,
            strategy: currUser.strategy ?? 0,
            onCreatedSharedPayment: (entityId) async {
              if (entityId != null) {
                widget.sharedPayContactsCubit.updateSharedPaymentUsers(
                    entityId: entityId,
                    sharedPayment: widget.sharedPayment,
                    selectedContactsList: selectedContactsList);
                AppRouter.pop();
              } else {
                AppConstants.showToast(context, getStrings().commonErrorMessage);
                AppRouter.pop();
              }
            },
          ));
    }
  }

  void onClickContact(
      SharedPaymentContactsState state,
      int userId,
      String contactName,
      String? address,
      List<SharedContactModel> selectedContactsList) async {
    List<String>? results = await AppConstants.showCustomTextInputDialog(
        context: context,
        title: getStrings().amountForMessage(contactName),
        message: getStrings().introAmountForMessage(contactName),
        okLabel: getStrings().proceedText,
        cancelLabel: getStrings().cancelText,
        barrierDismissible: false,
        canPop: false,
        textFields: [
          const DialogTextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true))
        ]);

    if (results != null) {
      widget.sharedPayContactsCubit.onClickContact(
          results: results,
          selectedContactsList: selectedContactsList,
          allSumAmount: widget.allSumAmount,
          contactUserId: userId,
          contactName: contactName,
          contactAddress: address ?? "");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
