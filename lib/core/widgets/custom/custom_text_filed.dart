import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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
  DROP_DOWN_SHEET_SEARCH_FIELD,
  HOME_PAGE_SEARCH_FIELD,
  ADDRESS_FIELD,
  NONE
}

// A customizable text field widget that handles various input types
class CustomTextField extends StatefulWidget {
  final CustomTextFieldType customTextFieldType;
  final TextEditingController textEditingController;
  final VoidCallback? onPressed;
  final ValueChanged<String>? onTextChanged;

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
    this.onTextChanged,
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
    // widget.focusNode.dispose();
    // widget.textEditingController.dispose();
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
      readOnly: widget.customTextFieldType == CustomTextFieldType.BUTTON ||
          widget.customTextFieldType == CustomTextFieldType.NATIONALITY||
          widget.customTextFieldType == CustomTextFieldType.AREA,
      showCursor: widget.customTextFieldType != CustomTextFieldType.BUTTON &&
          widget.customTextFieldType != CustomTextFieldType.NATIONALITY&&
          widget.customTextFieldType != CustomTextFieldType.AREA,
      cursorColor: AppColors.deepNavy,
      cursorHeight:
          widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
              ? TextStyles.text12Regular.height
              : widget.customTextFieldType == CustomTextFieldType.HOME_PAGE_SEARCH_FIELD ? TextStyles.text14Medium.height : TextStyles.text16Regular.height,

      // Field length constraints
      maxLength: widget.customTextFieldType == CustomTextFieldType.PHONE_NUMBER
          ? 11
          : 35,
      cursorRadius: const Radius.circular(2),

      // Text styling
      style: widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
          ? TextStyles.text12Regular.copyWith(color: AppColors.deepNavy)
          : widget.customTextFieldType == CustomTextFieldType.HOME_PAGE_SEARCH_FIELD ? TextStyles.text14Medium.copyWith(color: AppColors.deepNavy) : TextStyles.text16Regular.copyWith(color: AppColors.deepNavy),
      obscureText: _obscureText,

      // Input decoration
      decoration: InputDecoration(
        contentPadding:
            widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
                ? const EdgeInsets.only(left: 18, top: 11, bottom: 11)
                : const EdgeInsets.only(left: 22, top: 18, bottom: 18),
        counter: const SizedBox.shrink(),
        // Hide counter but keep space
        filled: true,
        fillColor: _getFillColor(),
        hintText: widget.hintText,
        hintStyle: _getHintStyle(),
        enabledBorder: _getBorder(),
        focusedBorder: _getBorder(),
        prefix: _buildPrefix(),
        suffixIcon: _buildSuffixIcon(),
      ),
      onTap: widget.customTextFieldType != CustomTextFieldType.PHONE_NUMBER && widget.customTextFieldType != CustomTextFieldType.EMAIL ? widget.onPressed != null ? () => widget.onPressed!() : null : null,
      onChanged: (value) {
        widget.textEditingController.addListener(() {
          setState(() {});
        });
        widget.onTextChanged?.call(value);
      },
    );
  }

  // Helper method to get fill color based on field type
  Color _getFillColor() {
    return widget.customTextFieldType != CustomTextFieldType.BUTTON
        ? widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
            ? AppColors.lightBlue
            : AppColors.secondary.withOpacityPrecise(0.3)
        : AppColors.deepNavy;
  }

  // Helper method to get hint style based on field type
  TextStyle _getHintStyle() {
    return widget.customTextFieldType != CustomTextFieldType.BUTTON
        ? widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
            ? TextStyles.text12Regular
                .copyWith(color: AppColors.deepNavy.withOpacityPrecise(0.5))
            : widget.customTextFieldType == CustomTextFieldType.HOME_PAGE_SEARCH_FIELD ? TextStyles.text14Medium
        .copyWith(color: AppColors.richBlack.withOpacityPrecise(0.5)) : TextStyles.text16Regular
                .copyWith(color: AppColors.richBlack.withOpacityPrecise(0.5))
        : TextStyles.text18SemiBold.copyWith(color: AppColors.white);
  }

  // Helper method to create consistent border
  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius:
          widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
              ? BorderRadius.circular(40)
              : BorderRadius.circular(82),
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
    // Determine margin based on field type
    final marginRight = widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
        ? 11
        : 4;

    // Calculate width based on field type and content
    double width;
    if (widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD) {
      width = 20;
    } else if (widget.customTextFieldType == CustomTextFieldType.PHONE_NUMBER) {
      width = widget.textEditingController.text.isEmpty ||
          widget.textEditingController.text.length < 8
          ? 52
          : 69;
    } else if (widget.customTextFieldType == CustomTextFieldType.EMAIL) {
      width = widget.textEditingController.text.isEmail ? 69 : 52;
    } else {
      width = 52;
    }

    // Determine height based on field type
    final height = widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
        ? 20
        : 52;

    // Configure decoration based on field type
    final decoration = BoxDecoration(
      color: widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
          ? null
          : AppColors.white,
      borderRadius: widget.customTextFieldType == CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD
          ? null
          : BorderRadius.circular(82),
    );

    return Container(
      margin: EdgeInsets.only(right: marginRight.toDouble()),
      width: width,
      height: height.toDouble(),
      decoration: decoration,
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
      case CustomTextFieldType.EMAIL:
        return _buildEmailSuffix();
      case CustomTextFieldType.DROP_DOWN_SHEET_SEARCH_FIELD:
        return _buildSearchFieldSuffix();
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
          _isFocused
              ? _obscureText = !_obscureText
              : widget.focusNode.unfocus();
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
    if (widget.textEditingController.text.length > 7) {
      return GestureDetector(
        onTap: widget.onPressed != null ? () => widget.onPressed!() : null,
        child: Center(
              child: Text(
                "Verify",
                style: TextStyles.text12SemiBold,
              ),
            ),
      );
    } else {
      return SvgPicture.asset(
            widget.suffixIcon,
            width: 20,
            height: 20,
            fit: BoxFit.none,
          );
    }
  }

  // Helper method to build email suffix (verify text or icon)
  Widget _buildEmailSuffix() {
    if (widget.textEditingController.text.isEmail) {
      return GestureDetector(
        onTap: widget.onPressed != null ? () => widget.onPressed!() : null,
        child: Center(
              child: Text(
                "Verify",
                style: TextStyles.text12SemiBold,
              ),
            ),
      );
    } else {
      return SvgPicture.asset(
            widget.suffixIcon,
            width: 20,
            height: 20,
            fit: BoxFit.none,
          );
    }
  }

  // Helper method to build search field suffix (icon)
  Widget _buildSearchFieldSuffix() {
    return widget.textEditingController.text.isEmpty ? SvgPicture.asset(
      widget.suffixIcon,
      width: 20,
      height: 20,
      fit: BoxFit.none,
    ) : SvgPicture.asset(
      Assets.images.svg.searchCancel.path,
      width: 20,
      height: 20,
      fit: BoxFit.none,
    );
  }
}
