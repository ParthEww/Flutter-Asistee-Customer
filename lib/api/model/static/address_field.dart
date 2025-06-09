import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class AddressField {
  final int id;
  final String hint;
  final String icon;
  String text;
  final FocusNode focusNode;
  final TextEditingController textEditingController;

  AddressField({
    required this.id,
    required this.hint,
    required this.icon,
    required this.text,
    required this.focusNode,
    required this.textEditingController,
  });
}
