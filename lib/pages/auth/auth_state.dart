
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../api/model/response/init/init_data.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState({
    InitData? initDataModel,
    // Controllers and FocusNodes
    FocusNode? emailOrPhoneNumberFocusNode,
    TextEditingController? emailOrPhoneNumberController,
    FocusNode? loginPasswordFocusNode,
    TextEditingController? loginPasswordController,
    FocusNode? forgotPasswordEmailOrPhoneNumberFocusNode,
    TextEditingController? forgotPasswordEmailOrPhoneNumberController,
    FocusNode? newPasswordFocusNode,
    TextEditingController? newPasswordController,
    FocusNode? confirmNewPasswordFocusNode,
    TextEditingController? confirmNewPasswordController,
    FocusNode? fullNameFocusNode,
    TextEditingController? fullNameController,
    FocusNode? phoneNumberFocusNode,
    TextEditingController? phoneNumberController,
    FocusNode? emailFocusNode,
    TextEditingController? emailController,
    FocusNode? registerPasswordFocusNode,
    TextEditingController? registerPasswordController,
    FocusNode? nationalIdFocusNode,
    TextEditingController? nationalIdController,
    FocusNode? nationalityFocusNode,
    TextEditingController? nationalityController,
    FocusNode? areaFocusNode,
    TextEditingController? areaController,
    bool? isTermsAndConditionChecked,
}) = _AuthState;
}