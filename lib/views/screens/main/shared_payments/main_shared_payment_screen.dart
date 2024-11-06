import 'package:flutter/material.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payments_history_screen.dart';
import 'package:social_wallet/views/screens/main/shared_payments/shared_payments_screen.dart';

class MainSharedPaymentScreen extends StatefulWidget {

  const MainSharedPaymentScreen({super.key});

  @override
  _MainSharedPaymentScreenState createState() => _MainSharedPaymentScreenState();
}

class _MainSharedPaymentScreenState extends State<MainSharedPaymentScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<MainSharedPaymentScreen> {

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
                  tabs: const [
                    Tab(text: "Active"),
                    Tab(text: "History")
                  ]
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SharedPaymentsScreen(),
                      SharedPaymentsHistoryScreen()
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
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
