import 'package:flutter/material.dart';

import '../../app_colors.dart';




extension ContextUtils on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;

  double get screenWidth => MediaQuery.of(this).size.width;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  TextStyle get bodyTextLarge => textTheme.bodyLarge!;
  TextStyle get bodyTextLargeW500 => textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get bodyTextLargeW700 => textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700);

  TextStyle get bodyTextMedium => textTheme.bodyMedium!;
  TextStyle get bodyTextBlackLightMedium => textTheme.bodyMedium!.copyWith(color: AppColors.textBlack);
  TextStyle get bodyTextMediumW500 => textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get bodyTextMediumW700 => textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700);

  TextStyle get bodyTextSmall => textTheme.bodySmall!;
  TextStyle get bodyTextSmallW500 => textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get bodyTextSmallW700 => textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700);

  TextStyle get titleTextLarge => textTheme.titleLarge!;
  TextStyle get titleTextLargeW500 => textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get titleTextLargeW700 => textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700);

  TextStyle get titleTextMedium => textTheme.titleMedium!;
  TextStyle get titleTextMediumW500 => textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get titleTextMediumW700 => textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700);

  TextStyle get titleTextSmall => textTheme.titleSmall!;
  TextStyle get titleTextSmallW500 => textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500);
  TextStyle get titleTextSmallW700 => textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700);


  TextStyle get textButtonTheme => textTheme.bodyLarge!.copyWith(color: AppColors.primaryWhite, fontSize: 16, fontWeight: FontWeight.w500);


// T read<T>(ProviderBase<T> provider) {
//   return ProviderScope.containerOf(this, listen: false).read(provider);
// }

}
