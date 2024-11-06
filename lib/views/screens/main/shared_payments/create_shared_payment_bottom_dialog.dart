import 'package:flutter/material.dart';
import 'package:social_wallet/models/db/shared_payment.dart';
import 'package:social_wallet/utils/app_constants.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/utils/helpers/extensions/string_extensions.dart';
import 'package:social_wallet/views/widget/network_selector.dart';

import '../../../../di/injector.dart';
import '../../../../models/db/user.dart';
import '../../../../models/enum_shared_payment_status.dart';
import '../../../../routes/app_router.dart';
import '../../../../routes/routes.dart';
import '../wallet/cubit/balance_cubit.dart';

class CreateSharedPaymentBottomDialog extends StatelessWidget {
  BalanceCubit balanceCubit = getBalanceCubit();
  String userAddressTo;
  int? userId;
  Function() onBackFromCreateDialog;

  CreateSharedPaymentBottomDialog({
    super.key,
    required this.userAddressTo,
    this.userId,
    required this.onBackFromCreateDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: "Crypto"),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Select currency to do the payment",
                              textAlign: TextAlign.center,
                              style: context.bodyTextMedium.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: NetworkSelector(
                          selectedNetworkInfoModel: null,
                          onClickToken: (tokenInfo) async {
                            User? currUser = AppConstants.getCurrentUser();
                            if (userId != null) {
                              currUser = await getDbHelper().retrieveUserById(userId!);
                            }
                            if (currUser != null) {
                              SharedPayment sharedPayment = SharedPayment(
                                  id: 0,
                                  ownerId: currUser.id ?? 0,
                                  totalAmount: 0.0,
                                  ownerEmail: currUser.userEmail,
                                  ownerUsername: currUser.username ?? "",
                                  ownerAddress: currUser.accountHash,
                                  numConfirmations: 0,
                                  tokenSelectedBalance: tokenInfo.balance.parseToDouble(),
                                  tokenDecimals: tokenInfo.decimals,
                                  userAddressTo: userAddressTo,
                                  currencyName: tokenInfo.tokenName,
                                  currencySymbol: tokenInfo.tokenSymbol,
                                  currencyAddress: !tokenInfo.isNative ? tokenInfo.tokenAddress : null,
                                  networkId: tokenInfo.networkId,
                                  hasBeenExecuted: 0,
                                  creationTimestamp: DateTime.now().millisecondsSinceEpoch,
                                  status: ESharedPaymentStatus.STARTED.name);
                              AppRouter.pop();
                              AppRouter.pushNamed(RouteNames.SharedPaymentSelectContacsScreenRoute.name, args: sharedPayment, onBack: () {
                                onBackFromCreateDialog();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      AppRouter.pop();
                    },
                    child: Text(
                        "Cancelar",
                        textAlign: TextAlign.end,
                        style: context.bodyTextMedium.copyWith(
                            fontSize: 20,
                            color: Colors.blue
                        )
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
