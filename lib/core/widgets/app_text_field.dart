import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../gen/fonts.gen.dart';
import '../themes/app_colors.dart';
import '../themes/text_styles.dart';
import '../utils/app_extension.dart';
import 'app_text_field_label.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;

  // ----- [focus] -----
  final FocusNode focusNode;
  final bool autoFocus;
  final FocusNode? nextFocusNode;

  // ----- [keyboard] -----
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  // ----- [input utils] -----
  final List<String>? autofillHints;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormat;
  final TextMagnifierConfiguration? magnifierConfiguration;

  // ----- [bool utils] -----
  final bool autocorrect;
  final bool expands;
  final bool readOnly;
  final bool obscureText;
  final String obscuringCharacter;
  final bool showRequiredMark;
  final bool showClearButton;

  // ----- [text limits] -----
  final int? minLines;
  final int? maxLines;
  final int? maxLength;

  // ----- [styling] -----
  final Color? cursorColor;
  final Color? inputTextColor;
  final double? inputTextFontSize;
  final FontWeight? inputTextFontWeight;
  final double? letterSpacing;
  final double? wordSpacing;
  final String fontFamily;

  // ----- [input decoration] -----
  final BoxConstraints? constraints;
  final bool? isDense;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? filledColor;
  final Color? focusColor;
  final String? hintText;
  final Color? hintTextColor;
  final double? hintTextFontSize;
  final FontWeight? hintTextFontWeight;
  final bool? alignLabelWithHint;
  final Widget? labelWidget;
  final String? labelText;
  final Color? labelTextColor;
  final double? labelTextFontSize;
  final FontWeight? labelTextFontWeight;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextStyle? floatingLabelTextStyle;
  final String? counterText;
  final Color? errorTextColor;
  final double? errorTextFontSize;
  final FontWeight? errorTextFontWeight;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color? disabledBorderColor;
  final double borderRadius;
  final Widget? suffixWidget;
  final Widget? prefixIcon;
  final Widget? prefix;

  // ----- [methods] -----
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onClear;
  final Function? onEditingComplete;
  final Function? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;

  // ----- [validation] -----
  final AutovalidateMode? autoValidateMode;
  final String? Function(String? value)? validator;

  @override
  State<AppTextField> createState() => _AppTextFieldNewState();

  const AppTextField({
    super.key,
    required this.textEditingController,
    // focus
    required this.focusNode,
    this.autoFocus = false,
    this.showClearButton = false,
    this.nextFocusNode,
    // keyboard
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    // input utils
    this.autofillHints,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormat = const [],
    this.magnifierConfiguration,
    // bool utils
    this.autocorrect = true,
    this.expands = false,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.showRequiredMark = false,
    // text limits
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    // styling
    this.cursorColor,
    this.inputTextColor,
    this.inputTextFontSize,
    this.inputTextFontWeight,
    this.letterSpacing,
    this.wordSpacing,
    this.fontFamily = FontFamily.passengerSans,
    // input decoration
    this.constraints,
    this.isDense,
    this.enabled = true,
    this.contentPadding,
    this.filled,
    this.filledColor,
    this.focusColor,
    this.hintText,
    this.hintTextColor,
    this.hintTextFontSize,
    this.hintTextFontWeight,
    this.alignLabelWithHint,
    this.labelWidget,
    this.labelText,
    this.labelTextColor,
    this.labelTextFontSize,
    this.labelTextFontWeight,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
    this.floatingLabelTextStyle,
    this.counterText,
    this.errorTextColor,
    this.errorTextFontSize,
    this.errorTextFontWeight,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.disabledBorderColor,
    this.borderRadius = 8,
    this.suffixWidget,
    this.prefixIcon,
    this.prefix,
    // methods
    this.onChanged,
    this.onTap,
    this.onClear,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onTapOutside,
    // validation
    this.autoValidateMode,
    this.validator,
  });
}

class _AppTextFieldNewState extends State<AppTextField> {
  bool _textFieldIsFocused = false;
  bool _textFieldIsEmpty = true;

  @override
  void initState() {
    _onFocusNodeEvent();
    _onTextControllerEvent();

    widget.focusNode.addListener(_onFocusNodeEvent);
    widget.textEditingController.addListener(_onTextControllerEvent);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusNodeEvent);
    widget.textEditingController.removeListener(_onTextControllerEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    InputDecorationTheme inputDecorationTheme = theme.inputDecorationTheme;

    // input text style
    TextStyle inputTextStyle = TextStyles.text12Medium.copyWith(
      color: widget.inputTextColor ?? AppColors.black,
      fontSize: widget.inputTextFontSize,
      fontWeight: widget.inputTextFontWeight,
      letterSpacing: widget.letterSpacing,
      wordSpacing: widget.wordSpacing,
      fontFamily: widget.fontFamily,
    );

    // label text style
    TextStyle? labelTextStyle = inputDecorationTheme.labelStyle?.copyWith(
      color: widget.labelTextColor,
      fontSize: widget.labelTextFontSize,
      fontWeight: widget.labelTextFontWeight,
      letterSpacing: widget.letterSpacing,
      wordSpacing: widget.wordSpacing,
      fontFamily: widget.fontFamily,
    );

    // hint text style
    TextStyle? hintTextStyle = inputDecorationTheme.hintStyle?.copyWith(
      color: widget.hintTextColor,
      fontSize: widget.hintTextFontSize,
      fontWeight: widget.hintTextFontWeight,
      letterSpacing: widget.letterSpacing,
      wordSpacing: widget.wordSpacing,
      fontFamily: widget.fontFamily,
    );

    // error text style
    TextStyle? errorTextStyle = inputDecorationTheme.errorStyle?.copyWith(
      color: widget.errorTextColor,
      fontSize: widget.errorTextFontSize,
      fontWeight: widget.errorTextFontWeight,
      letterSpacing: widget.letterSpacing,
      wordSpacing: widget.wordSpacing,
      fontFamily: widget.fontFamily,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showRequiredMark)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 6),
            /*child: AppTextFieldLabel(
              label: widget.labelText.toString(),
              showRequiredMark: widget.showRequiredMark,
            ),*/
          ),
        TextFormField(
          controller: widget.textEditingController,

          // focus
          focusNode: widget.focusNode,
          autofocus: widget.autoFocus,

          // keyboard
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,

          // input utils
          autofillHints: widget.autofillHints,
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          inputFormatters:
              widget.inputFormat.isEmpty ? null : widget.inputFormat,
          magnifierConfiguration: widget.magnifierConfiguration,

          // bool utils
          autocorrect: widget.autocorrect,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          expands: widget.expands,
          obscureText: widget.obscureText,
          obscuringCharacter: widget.obscuringCharacter,

          // text limits
          maxLength: widget.maxLength,
          minLines: widget.minLines,
          maxLines: widget.obscureText ? 1 : widget.maxLines,

          // styling
          cursorColor: widget.cursorColor,
          style: inputTextStyle,

          // input decoration
          decoration: InputDecoration(
            constraints: widget.constraints,
            isDense: widget.isDense,
            enabled: widget.enabled,
            contentPadding: widget.contentPadding,
            filled: widget.filled,
            fillColor: widget.filledColor,
            focusColor: widget.focusColor,
            hintText: widget.hintText,
            hintStyle: hintTextStyle,
            // label: floatingLabelWidget ?? widget.labelWidget,
            // labelText: floatingLabelWidget == null ? (widget.showRequiredMark) ? '${widget.labelText}*' : widget.labelText : null,
            labelText: widget.labelText,
            labelStyle: labelTextStyle,
            floatingLabelBehavior: widget.floatingLabelBehavior,
            alignLabelWithHint: widget.alignLabelWithHint,
            floatingLabelStyle:
                widget.floatingLabelTextStyle,
            counterText: widget.counterText,
            // counterStyle: widget.counterStyle,
            errorStyle: errorTextStyle,
            errorMaxLines: 3,
            enabledBorder:
                _getInputBorder(borderColor: widget.enabledBorderColor),
            focusedBorder:
                _getInputBorder(borderColor: widget.focusedBorderColor),
            errorBorder: _getInputBorder(borderColor: widget.errorBorderColor),
            focusedErrorBorder:
                _getInputBorder(borderColor: widget.focusedErrorBorderColor),
            disabledBorder:
                _getInputBorder(borderColor: widget.disabledBorderColor),
            prefixIcon: widget.prefixIcon,
            prefix: widget.prefix,
            suffixIcon: widget.suffixWidget == null &&
                    (widget.showClearButton && !_textFieldIsEmpty)
                ? IconButton(
                    onPressed: () {
                      //widget.textEditingController.clear();
                      widget.onClear?.call();
                      context.hideKeyboard();
                      setState(() {});
                    },
                    icon: Icon(Icons.clear_rounded),
                  )
                : widget.suffixWidget,
          ),

          // methods
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          onTap: () {
            widget.onTap?.call();
          },
          onEditingComplete: () {
            widget.onEditingComplete?.call();
          },
          onFieldSubmitted: (value) {
            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted?.call();
            } else {
              if (widget.textInputAction == TextInputAction.done) {
                context.hideKeyboard();
              } else if (widget.textInputAction == TextInputAction.next) {
                FocusScope.of(context).requestFocus(
                  widget.nextFocusNode,
                );
              }
            }
          },
          onTapOutside: (event) {
            if (widget.onTapOutside == null) {
              context.hideKeyboard();
            } else {
              widget.onTapOutside?.call(event);
            }
          },

          // validation
          autovalidateMode: widget.autoValidateMode,
          validator: widget.validator,
        ),
      ],
    );
  }

  InputBorder? _getInputBorder({
    Color? borderColor,
  }) {
    if (borderColor != null) {
      return OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      );
    }
    return null;
  }

  //
  void _onFocusNodeEvent() {
    if (mounted) {
      bool newState = widget.focusNode.hasFocus;
      if (newState != _textFieldIsFocused) {
        setState(() => _textFieldIsFocused = newState);
      }
    }
  }

  void _onTextControllerEvent() {
    if (mounted) {
      bool newState = widget.textEditingController.text.isEmpty;
      if (newState != _textFieldIsEmpty) {
        setState(() => _textFieldIsEmpty = newState);
      }
    }
  }
}
