import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_wallet/routes/app_router.dart';
import 'package:social_wallet/routes/routes.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';

class TopToolbar extends StatelessWidget implements PreferredSizeWidget {

  @override
  late Size preferredSize;
  bool enableBack;
  String toolbarTitle;

  TopToolbar({super.key, 
    this.enableBack = false,
    this.toolbarTitle = "SocialWallet"
}) : preferredSize = Size.fromHeight(AppConstants.getToolbarSize(AppRouter.navigatorKey.currentContext!));

  int? currIndex;
  int? prevIndex;

  @override
  Widget build(BuildContext context) {
    return getHomeTopToolbar(context);
  }

  Widget getHomeTopToolbar(BuildContext context) {
    return AppBar(
      leading: !enableBack ? Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset("assets/eth.svg", colorFilter: const ColorFilter.mode(
            Colors.white, BlendMode.srcIn),
        ),
      ) : GestureDetector(
        onTap: () {
          AppRouter.pop();
        },
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32.0,
          ),
        ),
      ),
      actions: [
        if (!enableBack)...[
          InkWell(
              highlightColor: Colors.transparent,
              onTap: () {
                AppRouter.pushNamed(RouteNames.ConfigurationScreenRoute.name);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/ic_settings.svg", width: 32, height: 32, color: Colors.white),
              )
          ),
          const SizedBox(width: 10),
        ],
      ],
      elevation: 10.0,
      titleTextStyle: context.bodyTextMedium.copyWith(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w700
      ),
      backgroundColor: AppColors.primaryColor,
      shadowColor: AppColors.primaryWhite,
      titleSpacing: 0,
      title: Text(toolbarTitle),
    );
  }


}
