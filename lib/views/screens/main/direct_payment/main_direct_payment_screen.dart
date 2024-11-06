import 'package:flutter/material.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/direct_payment/direct_payment_history_screen.dart';
import 'package:social_wallet/views/screens/main/direct_payment/direct_payment_screen.dart';


class MainDirectPaymentScreen extends StatefulWidget {


  MainDirectPaymentScreen({super.key});

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
                  tabs: const [
                    Tab(text: "DirPayment"),
                    Tab(text: "History")
                  ]
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                    children: [
                      DirectPaymentScreen(),
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
