import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/views/screens/main/contacts/contacts_screen.dart';
import 'package:social_wallet/views/screens/main/direct_payment/main_direct_payment_screen.dart';
import 'package:social_wallet/views/screens/main/shared_payments/main_shared_payment_screen.dart';
import 'package:social_wallet/views/widget/top_toolbar.dart';

import '../../../utils/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;
  late PageController _pageController;
  PreferredSizeWidget? topToolbar;

  final bottomPages = [
    MainDirectPaymentScreen(key: const PageStorageKey<String>('MainDirectPaymentScreen')),
    const MainSharedPaymentScreen(key: PageStorageKey<String>('MainSharedPaymentScreen')),
    //WalletScreen(),
    ContactsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    topToolbar = TopToolbar();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: TopToolbar(),
          body: Column(
            children: [
              Expanded(
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: bottomPages.elementAt(pageIndex),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: buildMyNavBar(context, pageIndex))),
    );
  }

  Widget buildMyNavBar(BuildContext context, int currIndex) {
    return BottomNavigationBar(
      currentIndex: currIndex,
      selectedItemColor: AppColors.textBlack,
      iconSize: 24,
      enableFeedback: true,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: const Icon(Icons.directions, color: AppColors.primaryColor),
            label: getStrings().dirPayBottomLabel,
            activeIcon:
                const Icon(Icons.directions, color: AppColors.secondaryColor)),
        BottomNavigationBarItem(
            icon: const Icon(Icons.share_outlined, color: AppColors.primaryColor),
            label: getStrings().sharedPayBottomLabel,
            activeIcon:
                const Icon(Icons.share_outlined, color: AppColors.secondaryColor)),
        /*BottomNavigationBarItem(
          icon: Icon(Icons.wallet, color: AppColors.primaryColor),
          label: 'Wallet',
        ),*/
        BottomNavigationBarItem(
            icon: const Icon(Icons.group, color: AppColors.primaryColor),
            label: getStrings().contactsBottomLabel,
            activeIcon: const Icon(Icons.group, color: AppColors.secondaryColor)),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}