import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_wallet/utils/helpers/extensions/context_extensions.dart';

import '../../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final double? width, height;
  final int? maxLength;
  final String? floatingText, labelText, hintText;
  final TextStyle labelStyle, errorStyle, inputStyle, hintStyle;
  final TextStyle? floatingStyle;
  final EdgeInsets? contentPadding;
  final void Function()? onTap;
  final void Function(String? value)? onSaved, onChanged;
  final Widget? prefix;
  final Widget? inputIcon;
  final InputCounterWidgetBuilder? buildCounter;
  final bool showCursor;
  final bool autofocus;
  final bool? readOnly;
  final int? maxLines;
  final bool? alignLabelWithHint;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool showErrorBorder;
  final bool outlined;
  final bool isPasswordField;
  final TextAlign textAlign;
  final InputBorder? border;
  final Alignment errorAlign, floatingAlign;
  final Color fillColor;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String? value) validator;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    this.suffixIcon,
    this.readOnly,
    this.focusNode,
    this.nextFocusNode,
    this.controller,
    this.width,
    this.height,
    this.maxLength,
    this.floatingText,
    this.floatingStyle,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.border,
    this.alignLabelWithHint,
    this.prefix,
    this.inputIcon,
    this.buildCounter,
    this.showCursor = true,
    this.showErrorBorder = false,
    this.autofocus = false,
    this.outlined = true,
    this.isPasswordField = false,
    this.textAlign = TextAlign.start,
    this.errorAlign = Alignment.centerRight,
    this.floatingAlign = Alignment.centerLeft,
    this.fillColor = AppColors.primaryWhite,
    this.hintText,
    this.hintStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.hintTexFieldColor,
    ),
    this.labelText,
    this.labelStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.hintTexFieldColor,
    ),
    this.errorStyle = const TextStyle(
      fontSize: 16,
      color: Colors.redAccent,
    ),
    this.inputStyle = const TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    this.contentPadding = const EdgeInsets.all(20),
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool hidePassword = true;

  bool get hasError => errorText != null;

  bool get showErrorBorder => widget.showErrorBorder && hasError;

  bool get hasFloatingText => widget.floatingText != null;

  bool get isPasswordField =>
      widget.keyboardType == TextInputType.visiblePassword;

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _onSaved(String? value) {
    value = value!.trim();
    widget.controller?.text = value;
    widget.onSaved?.call(value);
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      _runValidator(value);
      widget.onChanged!(value);
    }
  }

  String? _runValidator(String? value) {
    final error = widget.validator(value!.trim());
    setState(() {
      errorText = error;
    });
    return error;
  }

  void _togglePasswordVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  final double circularRadius = 12.0;

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.primaryColor));
  }

  OutlineInputBorder _mainStyleBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(8)));
  }

  OutlineInputBorder _normalBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: AppColors.primaryColor));
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
      borderSide: const BorderSide(
        color: Colors.redAccent,
        width: 1,
      ),
    );
  }

  UnderlineInputBorder _underlineFocusedBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
      borderSide: const BorderSide(
        //color: AppConstants.darkBlue,
        width: 1,
      ),
    );
  }

  UnderlineInputBorder _underlineNormalBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
      borderSide: const BorderSide(
        color: AppColors.disabledTextColor,
        width: 1,
      ),
    );
  }

  UnderlineInputBorder _underlineErrorBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
      borderSide: const BorderSide(
        color: Colors.redAccent,
        width: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Floating text
        if (hasFloatingText) ...[
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: Align(
              alignment: widget.floatingAlign,
              child: Text(
                widget.floatingText!,
                style: context.bodyTextSmall.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                // style: widget.floatingStyle ??
                //     context.bodyText1.copyWith(
                //       color: AppConstants.textGreyColor,
                //       fontSize: 17,
                //     ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],

        //TextField
        if (!widget.isPasswordField) ...{
          SizedBox(
            width: widget.width,
            child: TextFormField(
              readOnly: widget.readOnly ?? false,
              controller: widget.controller,
              textAlign: widget.textAlign,
              autofocus: widget.autofocus,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              buildCounter: widget.buildCounter,
              style: widget.inputStyle,
              showCursor: widget.showCursor,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textAlignVertical: TextAlignVertical.center,
              autovalidateMode: AutovalidateMode.disabled,
              cursorColor: Colors.black,
              onTap: _onTap,
              maxLines: widget.maxLines,
              validator: _runValidator,
              onFieldSubmitted: _runValidator,
              onSaved: _onSaved,
              onChanged: _onChanged,
              onEditingComplete: () {
                if (widget.nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                errorStyle: widget.errorStyle,
                errorMaxLines: 2,
                labelText: widget.labelText,
                labelStyle: widget.labelStyle,
                hintStyle: widget.hintStyle,
                hintText: widget.hintText,
                fillColor: widget.fillColor,
                alignLabelWithHint: widget.alignLabelWithHint,
                prefixIcon: widget.prefix,
                contentPadding: widget.contentPadding,
                isDense: true,
                filled: widget.outlined,
                counterText: '',
                enabledBorder: widget.border ??
                    (widget.outlined
                        ? _normalBorder()
                        : _underlineNormalBorder()),
                border: const OutlineInputBorder(),
                focusedBorder: widget.border ??
                    (widget.outlined
                        ? _focusedBorder()
                        : _underlineFocusedBorder()),
                focusedErrorBorder: widget.outlined
                    ? _focusedBorder()
                    : _underlineFocusedBorder(),
                errorBorder: showErrorBorder
                    ? (widget.outlined
                        ? _errorBorder()
                        : _underlineErrorBorder())
                    : null,
                suffixIconConstraints: widget.inputIcon != null
                    ? const BoxConstraints(
                        minHeight: 32,
                        minWidth: 32,
                      )
                    : null,
                suffixIcon: widget.inputIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: widget.inputIcon)
                    : (isPasswordField
                        ? InkWell(
                            onTap: _togglePasswordVisibility,
                            child: const Icon(
                              Icons.remove_red_eye_sharp,
                              color: AppColors.primaryColor,
                              size: 22,
                            ),
                          )
                        : (widget.suffixIcon)),
              ),
            ),
          ),
        } else ...{
          SizedBox(
            width: widget.width,
            child: TextFormField(
              readOnly: widget.readOnly ?? false,
              controller: widget.controller,
              textAlign: widget.textAlign,
              autofocus: widget.autofocus,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              buildCounter: widget.buildCounter,
              style: widget.inputStyle,
              showCursor: widget.showCursor,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              textAlignVertical: TextAlignVertical.center,
              autovalidateMode: AutovalidateMode.disabled,
              cursorColor: Colors.black,
              obscureText: true,
              obscuringCharacter: "*",
              onTap: _onTap,
              validator: _runValidator,
              onFieldSubmitted: _runValidator,
              onSaved: _onSaved,
              onChanged: _onChanged,
              onEditingComplete: () {
                if (widget.nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                errorStyle: widget.errorStyle,
                errorMaxLines: 2,
                labelText: widget.labelText,
                labelStyle: widget.labelStyle,
                hintStyle: widget.hintStyle,
                hintText: widget.hintText,
                fillColor: widget.fillColor,
                alignLabelWithHint: widget.alignLabelWithHint,
                prefixIcon: widget.prefix,
                contentPadding: widget.contentPadding,
                isDense: true,
                filled: widget.outlined,
                counterText: '',
                enabledBorder: widget.border ??
                    (widget.outlined
                        ? _normalBorder()
                        : _underlineNormalBorder()),
                border: const OutlineInputBorder(),
                focusedBorder: widget.border ??
                    (widget.outlined
                        ? _focusedBorder()
                        : _underlineFocusedBorder()),
                focusedErrorBorder: widget.outlined
                    ? _focusedBorder()
                    : _underlineFocusedBorder(),
                errorBorder: showErrorBorder
                    ? (widget.outlined
                        ? _errorBorder()
                        : _underlineErrorBorder())
                    : null,
                suffixIconConstraints: widget.inputIcon != null
                    ? const BoxConstraints(
                        minHeight: 32,
                        minWidth: 32,
                      )
                    : null,
                suffixIcon: widget.inputIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: widget.inputIcon)
                    : (isPasswordField
                        ? InkWell(
                            onTap: _togglePasswordVisibility,
                            child: const Icon(
                              Icons.remove_red_eye_sharp,
                              color: AppColors.primaryColor,
                              size: 22,
                            ),
                          )
                        : (widget.suffixIcon)),
              ),
            ),
          ),
        },
      ],
    );
  }
}
