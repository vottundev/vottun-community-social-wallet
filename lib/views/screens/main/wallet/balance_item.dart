import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/token_wallet_item.dart';
import 'package:social_wallet/models/tokens_info_model.dart';
import 'package:social_wallet/utils/app_colors.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';

class BalanceItem extends StatefulWidget {
  TokenWalletItem tokenWalletItem;
  Function(TokensInfoModel tokenInfoModel)? onClickToken;

  BalanceItem({
    super.key,
    required this.tokenWalletItem,
    this.onClickToken,
  });

  @override
  _BalanceItemState createState() => _BalanceItemState();
}

class _BalanceItemState extends State<BalanceItem> with WidgetsBindingObserver {

  ToggleStateCubit stateCubit = getToggleStateCubit();
  String balance = "";
  List<TokensInfoModel> tokenInfoListAux = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {

    if (widget.tokenWalletItem.mainTokenInfoModel != null) {
      balance = "${widget.tokenWalletItem.mainTokenInfoModel!.balance} ${widget.tokenWalletItem.mainTokenInfoModel!.tokenSymbol}";
      if (widget.tokenWalletItem.erc20TokensList != null) {
        tokenInfoListAux = widget.tokenWalletItem.erc20TokensList ?? [];
      }
    }


    return BlocBuilder<ToggleStateCubit, ToggleStateState>(
      bloc: stateCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: tokenInfoListAux.map((e) => Material(
            elevation: 1,
            child: InkWell(
              onTap: () {
                if (widget.onClickToken != null) {
                  widget.onClickToken!(e);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Image.asset(
                              "assets/ic_polygon.png",
                              height: 28,
                              width: 28),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              e.tokenSymbol,
                              maxLines: 1,
                              style: context.bodyTextMedium
                                  .copyWith(
                                  fontSize: 16,
                                  overflow: TextOverflow
                                      .ellipsis,
                                  color: Colors.black,
                                  fontWeight:
                                  FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${e.balance} ${e.tokenSymbol}",
                            maxLines: 1,
                            style: context.bodyTextMedium
                                .copyWith(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15),
                          ),
                          Text(
                            e.fiatPrice != 0.0 ? "${e.fiatPrice.toStringAsFixed(2)} €" : "0€",
                            maxLines: 1,
                            style: context.bodyTextMedium
                                .copyWith(
                                color: AppColors.walletFiatPriceColor,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
              .toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
