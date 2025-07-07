import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';

enum AsisteeCustomTextFieldType { PHONE_NUMBER, PASSWORD, FIRST_NAME, LAST_NAME, NONE }

class AsisteeCustomTextField extends StatefulWidget {
  final AsisteeCustomTextFieldType customTextFieldType;
  final TextEditingController textEditingController;

  // ----- [focus] -----
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  // ----- [input decoration] -----
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget suffixIcon;

  // ----- [input decoration] -----
  final bool obscureText;

  // final bool showClearButton;

  const AsisteeCustomTextField({
    super.key,
    required this.customTextFieldType,
    required this.textEditingController,
    // focus
    required this.focusNode,
    this.nextFocusNode,
    // input decoration
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.suffixIcon,
    // bool utils
    this.obscureText = false,
    // this.showClearButton = false,
  });

  @override
  State<StatefulWidget> createState() => _AsisteeCustomTextField();
}

class _AsisteeCustomTextField extends State<AsisteeCustomTextField> {
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    widget.focusNode.addListener(() {
      setState(() {
        _isFocused = widget.focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      cursorColor: AppColors.primary,
      cursorHeight: TextStyles.text14Regular.height,
      cursorRadius: Radius.circular(2),
      style: TextStyles.text14Regular.copyWith(color: AppColors.secondary),
      obscureText: _obscureText,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
          filled: true,
          fillColor: _isFocused
              ? AppColors.white
              : AppColors.mediumDarkGray.withAlpha(23),
          labelText: widget.labelText,
          labelStyle:
          TextStyles.text14Regular.copyWith(color: AppColors.primary),
          floatingLabelBehavior:
          widget.customTextFieldType == AsisteeCustomTextFieldType.PASSWORD
              ? !_isFocused
              ? FloatingLabelBehavior.never
              : FloatingLabelBehavior.auto
              : FloatingLabelBehavior.auto,
          floatingLabelStyle:
          TextStyles.text14Regular.copyWith(color: AppColors.primary),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.secondary,
              width: 1,
            ),
          ),
          suffixIcon: widget.customTextFieldType != AsisteeCustomTextFieldType.PASSWORD
              ? widget.suffixIcon
              : GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: SvgPicture.asset(
              !_isFocused
                  ? Assets.images.svg.passwordCheck.path
                  : _obscureText
                  ? Assets.images.svg.eye.path
                  : Assets.images.svg.eyeSlash.path,
              width: 20,
              height: 20,
              fit: BoxFit.none,
            ),
          )),
    );
  }
}
