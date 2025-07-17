import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/constants/global.dart';

extension ContextUtil on BuildContext {
  /// hide keyboard
  void hideKeyboard() {
    if (mounted) {
      FocusScope.of(this).requestFocus(FocusNode());
    }
  }
}

extension StringUtils on String? {
  String orEmpty() => this ?? '';
  bool isNotNullOrEmpty() {
    String? value = this;
    if (value != null && value.isNotEmpty) {
      return true;
    }
    return false;
  }
  bool isEmail(){
    String? value = this;
    if (value != null && Global.emailRegex.hasMatch(value)) {
      return true;
    }
    return false;
  }
  bool isDigitsOnly(){
    String? value = this;
    if (value != null && Global.digitRegex.hasMatch(value)) {
      return true;
    }
    return false;
  }
}

extension ColorExtensions on Color {
  /// Creates a new color with the given opacity (0.0 to 1.0)
  Color withOpacityPrecise(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((opacity * 255).round());
  }
}

extension ListLastIndexExtension<T> on List<T> {
  /// Returns the last valid index of the list, or `null` if the list is empty.
  int? get lastIndex => isNotEmpty ? length - 1 : null;
}

