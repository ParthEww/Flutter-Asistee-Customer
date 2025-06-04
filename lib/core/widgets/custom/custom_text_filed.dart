import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_structure/core/utils/app_extension.dart';

import '../../../gen/assets.gen.dart';
import '../../themes/app_colors.dart';
import '../../themes/text_styles.dart';

// Enum defining all possible text field types
enum CustomTextFieldType {
  FULL_NAME,
  EMAIL_OR_PHONE_NUMBER,
  EMAIL,
  PHONE_NUMBER,
  PASSWORD,
  NATIONAL_ID,
  NATIONALITY,
  AREA,
  FIRST_NAME,
  LAST_NAME,
  BUTTON,
  NONE
}

// A customizable text field widget that handles various input types
class CustomTextField extends StatefulWidget {
  final CustomTextFieldType customTextFieldType;
  final TextEditingController textEditingController;
  final VoidCallback? onPressed;

  // Focus management
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  // Input decoration properties
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String suffixIcon;

  const CustomTextField({
    super.key,
    required this.customTextFieldType,
    required this.textEditingController,
    this.onPressed,
    // Focus
    required this.focusNode,
    this.nextFocusNode,
    // Input decoration
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.suffixIcon,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();

    // Initialize obscure text for password fields
    _obscureText = widget.customTextFieldType == CustomTextFieldType.PASSWORD;

    // Set up focus listener
    widget.focusNode.addListener(() {
      setState(() {
        _isFocused = widget.focusNode.hasFocus;
      });
    });

    // Special handling for phone number fields
    if (widget.customTextFieldType == CustomTextFieldType.PHONE_NUMBER) {
      widget.textEditingController.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    // Clean up focus node and controller
    widget.focusNode.dispose();
    widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,

      // Behavior customization based on field type
      readOnly: widget.customTextFieldType == CustomTextFieldType.BUTTON,
      showCursor: widget.customTextFieldType != CustomTextFieldType.BUTTON,
      cursorColor: AppColors.deepNavy,
      cursorHeight: TextStyles.text16Regular.height,

      // Field length constraints
      maxLength: widget.customTextFieldType == CustomTextFieldType.PHONE_NUMBER
          ? 11
          : 35,
      cursorRadius: const Radius.circular(2),

      // Text styling
      style: TextStyles.text16Regular.copyWith(color: AppColors.deepNavy),
      obscureText: _obscureText,

      // Input decoration
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 22, top: 18, bottom: 18),
        counter: const SizedBox.shrink(), // Hide counter but keep space
        filled: true,
        fillColor: _getFillColor(),
        hintText: widget.hintText,
        hintStyle: _getHintStyle(),
        enabledBorder: _getBorder(),
        focusedBorder: _getBorder(),
        prefix: _buildPrefix(),
        suffixIcon: _buildSuffixIcon(),
      ),
      onTap: widget.onPressed != null ? () => widget.onPressed!() : null,
    );
  }

  // Helper method to get fill color based on field type
  Color _getFillColor() {
    return widget.customTextFieldType != CustomTextFieldType.BUTTON
        ? AppColors.secondary.withOpacityPrecise(0.3)
        : AppColors.deepNavy;
  }

  // Helper method to get hint style based on field type
  TextStyle _getHintStyle() {
    return widget.customTextFieldType != CustomTextFieldType.BUTTON
        ? TextStyles.text16Regular.copyWith(
        color: AppColors.richBlack.withOpacityPrecise(0.5))
        : TextStyles.text18SemiBold.copyWith(color: AppColors.white);
  }

  // Helper method to create consistent border
  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(82),
      borderSide: BorderSide.none,
    );
  }

  // Helper method to build prefix for phone number field
  Widget? _buildPrefix() {
    if (widget.customTextFieldType == CustomTextFieldType.PHONE_NUMBER &&
        (_isFocused || widget.textEditingController.text.isNotEmpty)) {
      return Text(
        "+973 | ",
        style: TextStyles.text16SemiBold.copyWith(color: AppColors.deepNavy),
      );
    }
    return null;
  }

  // Helper method to build the suffix icon
  Widget _buildSuffixIcon() {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: widget.customTextFieldType != CustomTextFieldType.PHONE_NUMBER
          ? 52
          : widget.textEditingController.text.isEmpty || widget.textEditingController.text.length < 8 ? 52 : 69,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(82),
      ),
      child: _getSuffixChild(),
    );
  }

  // Helper method to determine suffix child widget
  Widget _getSuffixChild() {
    switch (widget.customTextFieldType) {
      case CustomTextFieldType.PASSWORD:
        return _buildPasswordSuffix();
      case CustomTextFieldType.PHONE_NUMBER:
        return _buildPhoneNumberSuffix();
      default:
        return SvgPicture.asset(
          widget.suffixIcon,
          width: 20,
          height: 20,
          fit: BoxFit.none,
        );
    }
  }

  // Helper method to build password suffix (eye icon)
  Widget _buildPasswordSuffix() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFocused ? _obscureText = !_obscureText : widget.focusNode.unfocus();
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
    );
  }

  // Helper method to build phone number suffix (verify text or icon)
  Widget _buildPhoneNumberSuffix() {
    return widget.textEditingController.text.length > 7
        ? Center(
      child: Text(
        "Verify",
        style: TextStyles.text12SemiBold,
      ),
    )
        : SvgPicture.asset(
      widget.suffixIcon,
      width: 20,
      height: 20,
      fit: BoxFit.none,
    );
  }
}
