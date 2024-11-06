import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/direct_payment/cubit/dirpay_history_cubit.dart';

import '../../../../di/injector.dart';
import '../../../../utils/app_colors.dart';



class DirectPaymentHistoryScreen extends StatefulWidget {

  DirectPaymentHistoryScreen({super.key});

  @override
  _DirectPaymentHistoryScreenState createState() => _DirectPaymentHistoryScreenState();
}

class _DirectPaymentHistoryScreenState extends State<DirectPaymentHistoryScreen>
    with WidgetsBindingObserver {

  @override
  void initState() {
    getDirPayHistoryCubit().getDirPayHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<DirPayHistoryCubit, DirPayHistoryState>(
      bloc: getDirPayHistoryCubit(),
      builder: (context, state) {
        if (state.dirPaymentHistoryList == null) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
        if (state.dirPaymentHistoryList?.isEmpty == true) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You don't have any record yet :(",
                style: context.bodyTextMedium.copyWith(
                  fontSize: 20
                ),
              )
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: state.dirPaymentHistoryList!.map((e) =>
                  Material(
                    elevation: 0,
                    color: AppColors.appBackgroundColor,
                    child: InkWell(
                      onTap: () {
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                //make border radius more than 50% of square height & width
                                child: Image.asset(
                                  "assets/nano.jpg",
                                  height: 60.0,
                                  width: 60.0,
                                  fit: BoxFit.cover, //change image fill type
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Direct payment ${e.id} ",
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  style: context.bodyTextMedium,
                                ),
                                Text(
                                  "Total amount: ${e.payedAmount.toString()} ${e.currencySymbol}",
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  style: context.bodyTextMedium.copyWith(
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13
                                  ),
                                ),
                              ],
                            )),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                  )
              ).toList(),
            ),
          ),
        );
      },
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
