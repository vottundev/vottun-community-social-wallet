
import 'package:flutter/material.dart';
import 'package:social_wallet/views/widget/network_selector.dart';

import '../../../../models/network_info_model.dart';


class WalletTokensScreen extends StatefulWidget {

  NetworkInfoModel? selectedNetwork;

  WalletTokensScreen({super.key});

  @override
  _WalletTokensScreenState createState() => _WalletTokensScreenState();
}

class _WalletTokensScreenState extends State<WalletTokensScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<WalletTokensScreen> {


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NetworkSelector(
            selectedNetworkInfoModel: widget.selectedNetwork,
            showMakePaymentText: false,
            onClickNetwork: (selectedValue) {
              widget.selectedNetwork = selectedValue;
            },
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

}
