import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/token_wallet_item.dart';
import 'package:social_wallet/models/tokens_info_model.dart';
import 'package:social_wallet/utils/app_colors.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/widget/cubit/toggle_state_cubit.dart';

class AllBalanceItem extends StatefulWidget {
  TokenWalletItem tokenWalletItem;
  Function(TokensInfoModel? tokenInfoModel)? onClickToken;

  AllBalanceItem({
    super.key,
    required this.tokenWalletItem,
    this.onClickToken,
  });

  @override
  _AllBalanceItemState createState() => _AllBalanceItemState();
}

class _AllBalanceItemState extends State<AllBalanceItem> with WidgetsBindingObserver {

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
        return ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            if (tokenInfoListAux.isNotEmpty) {
              stateCubit.toggleState();
            }
          },
          expandIconColor: AppColors.primaryColor,
          children: [
            ExpansionPanel(
              backgroundColor: AppColors.appBackgroundColor,
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    onTap: () {
                      if (tokenInfoListAux.isNotEmpty) {
                        stateCubit.toggleState();
                      }
                    },
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.tokenWalletItem.mainTokenInfoModel != null
                                ? widget.tokenWalletItem.mainTokenInfoModel!.tokenSymbol
                                : "",
                            maxLines: 1,
                            style: context.bodyTextMedium.copyWith(
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                balance,
                                style: context.bodyTextMedium
                                    .copyWith(color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                "0€",
                                maxLines: 1,
                                style: context.bodyTextMedium
                                    .copyWith(color: Colors.grey, fontSize: 14, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                isExpanded: state.isEnabled,
                body: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: tokenInfoListAux.map((e) => InkWell(
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
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                  "assets/ic_polygon.png",
                                                  height: 26,
                                                  width: 26),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                child: Text(
                                                  e.tokenSymbol,
                                                  maxLines: 2,
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
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  e.balance,
                                                  style: context.bodyTextMedium
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                ),
                                                Text(
                                                  "0€",
                                                  style: context.bodyTextMedium
                                                      .copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                  ),
                ))
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
