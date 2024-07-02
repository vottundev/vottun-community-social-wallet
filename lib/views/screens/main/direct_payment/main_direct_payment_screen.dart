import 'package:flutter/material.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/direct_payment/direct_payment_history_screen.dart';
import 'package:social_wallet/views/screens/main/direct_payment/direct_payment_screen.dart';

import 'cubit/direct_payment_cubit.dart';


class MainDirectPaymentScreen extends StatefulWidget {

  late DirectPaymentCubit cubit;
  MainDirectPaymentScreen({super.key}) {
    cubit = getDirectPaymentCubit();
  }

  @override
  _MainDirectPaymentScreenState createState() => _MainDirectPaymentScreenState();
}

class _MainDirectPaymentScreenState extends State<MainDirectPaymentScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<MainDirectPaymentScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabBar(
                  labelStyle: context.bodyTextMedium.copyWith(
                    fontSize: 20
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: getStrings().dirPayLabel),
                    Tab(text: getStrings().historyLabel)
                  ]
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                    children: [
                      DirectPaymentScreen(dirPayCubit: widget.cubit),
                      DirectPaymentHistoryScreen()
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
