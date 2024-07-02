import 'package:flutter/material.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../utils/app_colors.dart';

class CustomButton extends StatefulWidget {
  final String buttonText;
  double? radius;
  final Function() onTap;
  bool inverseColors;
  bool enabled;
  double? textSize;
  double? elevation;
  EdgeInsets? padding;
  Color? backgroundColor;

  CustomButton(
      {Key? key,
        required this.buttonText,
        this.radius,
        this.textSize,
        this.elevation,
        this.padding,
        this.enabled = true,
        this.inverseColors = false,
        this.backgroundColor,
        required this.onTap})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: widget.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius ?? 25),
          ),
          textStyle: context.textButtonTheme,
          //foregroundColor: AppColors.primaryWhite,
          backgroundColor: widget.inverseColors
              ? AppColors.primaryWhite
              : (widget.backgroundColor ?? AppColors.primaryColor),
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 15),
          side: widget.inverseColors
              ? const BorderSide(width: 1, color: AppColors.primaryColor)
              : null),
      onPressed: widget.enabled
          ? () {
              widget.onTap();
            }
          : null,
      child: Text(
        widget.buttonText,
        maxLines: 1,
        style: context.bodyTextMediumW700.copyWith(
            overflow: TextOverflow.ellipsis,
            color: widget.inverseColors
                ? AppColors.primaryColor
                : AppColors.primaryWhite,
            fontSize: widget.textSize ?? 16),
      ),
    );
  }
}
