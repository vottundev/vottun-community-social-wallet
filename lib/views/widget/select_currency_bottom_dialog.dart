
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/currency_model.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../utils/app_constants.dart';


class SelectCurrencyBottomDialog extends StatefulWidget {

  bool isUserAddressNull;
  Function(CurrencyModel currModel) onClickCurrency;

  SelectCurrencyBottomDialog({super.key, 
    required this.onClickCurrency,
    required this.isUserAddressNull
  });

  @override
  _SelectCurrencyBottomDialogState createState() => _SelectCurrencyBottomDialogState();
}

class _SelectCurrencyBottomDialogState extends State<SelectCurrencyBottomDialog>
    with WidgetsBindingObserver {


  List<CurrencyModel> currenciesList = [
    const CurrencyModel(
        imagePath: "euro.svg",
        currencyName: "Euro",
        isCrypto: false
    ),
    const CurrencyModel(
        imagePath: "ic_bitcoin.svg",
        currencyName: "Crypto",
        isCrypto: true
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getStrings().selectCurrencyToDoPayment,
                    style: context.bodyTextMedium.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: currenciesList.map((e) {
                bool isCryptoAndAddressNotNull = e.isCrypto && !widget.isUserAddressNull;
                return InkWell(
                  onTap: () {
                    if (isCryptoAndAddressNotNull) {
                      widget.onClickCurrency(e);
                      AppRouter.pop();
                    } else if (!e.isCrypto) {
                      widget.onClickCurrency(e);
                      AppRouter.pop();
                    } else {
                      AppConstants.showToast(context, getStrings().createWalletFirstMessage);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/${e.imagePath}",
                          width: 32,
                          height: 32,
                          colorFilter: (!isCryptoAndAddressNotNull && e.isCrypto) ? const ColorFilter.mode(Colors.grey, BlendMode.srcIn) : null,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e.currencyName,
                          style: context.bodyTextMedium.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              ).toList(),
            ),
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}
