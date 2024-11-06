import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_wallet/di/injector.dart';
import 'package:social_wallet/models/network_info_model.dart';
import 'package:social_wallet/models/tokens_info_model.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';
import 'package:social_wallet/views/screens/main/wallet/cubit/balance_cubit.dart';
import 'package:social_wallet/views/widget/cubit/network_cubit.dart';

import '../../utils/app_colors.dart';
import '../screens/main/wallet/balance_item.dart';
import 'cubit/network_selector_cubit.dart';

class NetworkSelector extends StatefulWidget {
  bool? showList;
  NetworkInfoModel? selectedNetworkInfoModel;
  late BalanceCubit balanceCubit;
  late NetworkSelectorCubit networkSelectorCubit;
  bool? showMakePaymentText;
  Function(NetworkInfoModel? networkInfoModel)? onClickNetwork;
  Function(TokensInfoModel tokensInfoModel)? onClickToken;

  NetworkSelector({Key? key, this.onClickToken, this.selectedNetworkInfoModel, this.showMakePaymentText, this.showList, this.onClickNetwork}) : super(key: key) {
    balanceCubit = getBalanceCubit();
    networkSelectorCubit = getNetworkSelectorCubit();
  }

  @override
  _NetworkSelectorState createState() => _NetworkSelectorState();
}

class _NetworkSelectorState extends State<NetworkSelector> with AutomaticKeepAliveClientMixin<NetworkSelector> {
  @override
  void initState() {
    if (widget.selectedNetworkInfoModel != null) {
      if (widget.showList != null) {
        if (widget.showList == true) {
          widget.balanceCubit.getAccountBalance(
              accountToCheck: getKeyValueStorage().getUserAddress() ?? "",
              networkInfoModel: widget.selectedNetworkInfoModel!,
              networkId: widget.selectedNetworkInfoModel?.id ?? 0
          );
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, BCNetworkState>(
      bloc: getNetworkCubit(),
      builder: (context, state) {
        if (state.status == BCNetworksStatus.initial || state.status == BCNetworksStatus.loadingNetworks || state.availableNetworksList == null) {
          return const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          );
        }
        List<NetworkInfoModel> networksInfoList = List.empty(growable: true);
        if (state.availableNetworksList!.mainnetNetworks.isEmpty || !getKeyValueStorage().getIsMainnetEnabled()) {
          networksInfoList.addAll(state.availableNetworksList!.testnetNetworks);
        } else {
          networksInfoList.addAll(state.availableNetworksList!.mainnetNetworks);
        }

        return Column(
          children: [
            BlocBuilder<NetworkSelectorCubit, NetworkSelectorState>(
              bloc: widget.networkSelectorCubit,
              builder: (context, state) {
                NetworkInfoModel? selectedValue;
                if (widget.selectedNetworkInfoModel != null) {
                  selectedValue = widget.selectedNetworkInfoModel;
                } else {
                  selectedValue = state.selectedNetwork;
                }
                return Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/ic_network.svg",
                                height: 24,
                                width: 24,
                                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  selectedValue != null ? selectedValue.name : "Select network",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: networksInfoList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.name,
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue?.name,
                          onChanged: (value) {
                            NetworkInfoModel? networkInfoModel;
                            networkInfoModel = networksInfoList.where((element) => element.name == value).firstOrNull;
                            if (networkInfoModel != null) {
                              widget.balanceCubit.getAccountBalance(
                                  accountToCheck: getKeyValueStorage().getUserAddress() ?? "", networkInfoModel: networkInfoModel, networkId: networkInfoModel.id);
                              widget.networkSelectorCubit.setSelectedNetwork(selectedNetworkInfo: networkInfoModel);
                              widget.selectedNetworkInfoModel = networkInfoModel;
                              widget.onClickNetwork!(networkInfoModel);
                            }
                          },
                          buttonStyleData: ButtonStyleData(
                            height: 50,
                            width: 160,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.appBackgroundColor,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.black,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.appBackgroundColor,
                            ),
                            scrollbarTheme:
                                ScrollbarThemeData(radius: const Radius.circular(40), thickness: MaterialStateProperty.all(6), thumbVisibility: MaterialStateProperty.all(true)),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Visibility(
              visible: widget.showList ?? true,
              child: BlocBuilder<BalanceCubit, BalanceState>(
                bloc: widget.balanceCubit,
                builder: (context, balanceState) {
                  switch (balanceState.status) {
                    case BalanceStatus.initial:
                      return Container();
                    case BalanceStatus.loading:
                      return const Expanded(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    case BalanceStatus.success:
                      return Expanded(
                        child: Column(
                          children: [
                            Visibility(
                              visible: widget.showMakePaymentText ?? true,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Select currency to do the payment",
                                      style: context.bodyTextMedium.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                                child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    1,
                                    (index) => BalanceItem(
                                          tokenWalletItem: balanceState.walletTokenItemList!,
                                          onClickToken: (tokenInfo) {
                                            if (widget.onClickToken != null) {
                                              widget.onClickToken!(tokenInfo);
                                            }
                                          },
                                        )),
                              ),
                            )),
                          ],
                        ),
                      );
                    case BalanceStatus.error:
                      return const Expanded(
                          child: Center(
                        child: Text("Error"),
                      ));
                  }
                  return const Column(
                    children: [],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
