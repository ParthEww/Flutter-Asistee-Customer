import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';

// Enum to define different types of text fields
enum AsisteeCustomTextFieldType {
  PHONE_NUMBER,
  PASSWORD,
  FIRST_NAME,
  LAST_NAME,
  NONE
}

/// A customizable text field widget with various configurations
class AsisteeCustomTextField extends StatefulWidget {
  // ----- [Core Properties] -----
  final AsisteeCustomTextFieldType customTextFieldType;
  final TextEditingController textEditingController;

  // ----- [Focus Properties] -----
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  // ----- [Input Decoration Properties] -----
  final String labelText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget suffixIcon;

  // ----- [Behavior Properties] -----
  final bool obscureText;

  const AsisteeCustomTextField({
    super.key,
    required this.customTextFieldType,
    required this.textEditingController,

    // Focus properties
    required this.focusNode,
    this.nextFocusNode,

    // Input decoration properties
    required this.labelText,
    required this.keyboardType,
    required this.textInputAction,
    required this.suffixIcon,

    // Behavior properties
    this.obscureText = false,
  });

  @override
  State<StatefulWidget> createState() => _AsisteeCustomTextFieldState();
}

class _AsisteeCustomTextFieldState extends State<AsisteeCustomTextField> {
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;

    // Add focus listener to track focus changes
    widget.focusNode.addListener(() {
      setState(() {
        _isFocused = widget.focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // Clean up focus node
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

      // Cursor styling
      cursorColor: AppColors.primary,
      cursorHeight: TextStyles.text14Regular.height,
      cursorRadius: const Radius.circular(2),

      // Text styling
      style: TextStyles.text14Regular.copyWith(color: AppColors.secondary),
      obscureText: _obscureText,

      // Input decoration
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 13
        ),
        filled: true,
        fillColor: _isFocused
            ? AppColors.white
            : AppColors.mediumDarkGray.withAlpha(23),

        // Label styling
        labelText: widget.labelText,
        labelStyle: TextStyles.text14Regular.copyWith(
            color: AppColors.primary
        ),

        // Floating label behavior (special case for password fields)
        floatingLabelBehavior: widget.customTextFieldType ==
            AsisteeCustomTextFieldType.PASSWORD
            ? (!_isFocused
            ? FloatingLabelBehavior.never
            : FloatingLabelBehavior.auto)
            : FloatingLabelBehavior.auto,

        floatingLabelStyle: TextStyles.text14Regular.copyWith(
            color: AppColors.primary
        ),

        // Border styling
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

        prefix: widget.customTextFieldType == AsisteeCustomTextFieldType.PHONE_NUMBER ? Text("+91 | ", style: TextStyles.text14Regular.copyWith(
            color: AppColors.primary
        ),) : null,
        // Suffix icon handling (special case for password fields)
        suffixIcon: widget.customTextFieldType !=
            AsisteeCustomTextFieldType.PASSWORD
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
        ),
      ),
    );
  }
}
