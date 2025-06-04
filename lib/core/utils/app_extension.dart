import 'package:flutter/material.dart';

extension ContextUtil on BuildContext {
  /// hide keyboard
  void hideKeyboard() {
    if (mounted) {
      FocusScope.of(this).requestFocus(FocusNode());
    }
  }
}

extension StringUtils on String? {
  bool isNotNullOrEmpty() {
    String? value = this;
    if (value != null && value.isNotEmpty) {
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
