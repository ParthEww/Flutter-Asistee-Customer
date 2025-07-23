import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/core/utils/app_extension.dart';
import 'package:flutter_yay_rider_driver/di/app_provider.dart';
import 'package:flutter_yay_rider_driver/repository/local_repository/local_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repository/remote_repository/remote_repository.dart';
import '../state/auth_state.dart';

part 'auth_notifier.g.dart';

enum ResetDataType {
  LOGIN_DATA,
  REGISTER_DATA,
  VERIFY_OTP_DATA,
  FORGOT_PASSWORD_DATA,
  RESET_PASSWORD_DATA,
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final LocalRepository localRepository =
      ref.read(localRepositoryProvider);
  late final RemoteRepository remoteRepository =
      ref.read(remoteRepositoryProvider);

  @override
  AuthState build() {
    state = AuthState(
      emailOrPhoneNumberFocusNode: FocusNode(),
      emailOrPhoneNumberController: TextEditingController(),
      loginPasswordFocusNode: FocusNode(),
      loginPasswordController: TextEditingController(),
      forgotPasswordEmailOrPhoneNumberFocusNode: FocusNode(),
      forgotPasswordEmailOrPhoneNumberController: TextEditingController(),
      newPasswordFocusNode: FocusNode(),
      newPasswordController: TextEditingController(),
      confirmNewPasswordFocusNode: FocusNode(),
      confirmNewPasswordController: TextEditingController(),
      fullNameFocusNode: FocusNode(),
      fullNameController: TextEditingController(),
      phoneNumberFocusNode: FocusNode(),
      phoneNumberController: TextEditingController(),
      emailFocusNode: FocusNode(),
      emailController: TextEditingController(),
      registerPasswordFocusNode: FocusNode(),
      registerPasswordController: TextEditingController(),
      nationalIdFocusNode: FocusNode(),
      nationalIdController: TextEditingController(),
      nationalityFocusNode: FocusNode(),
      nationalityController: TextEditingController(),
      areaFocusNode: FocusNode(),
      areaController: TextEditingController(),
      isTermsAndConditionChecked: false,
    );
    return state;
  }

  void resetState(ResetDataType resetDataType) {
    switch (resetDataType) {
      case ResetDataType.LOGIN_DATA:
        state = state.copyWith(
          emailOrPhoneNumberFocusNode: FocusNode(),
          emailOrPhoneNumberController: TextEditingController(),
          loginPasswordFocusNode: FocusNode(),
          loginPasswordController: TextEditingController(),
        );
        break;
      case ResetDataType.REGISTER_DATA:
        state = state.copyWith(
          fullNameFocusNode: FocusNode(),
          fullNameController: TextEditingController(),
          phoneNumberFocusNode: FocusNode(),
          phoneNumberController: TextEditingController(),
          emailFocusNode: FocusNode(),
          emailController: TextEditingController(),
          registerPasswordFocusNode: FocusNode(),
          registerPasswordController: TextEditingController(),
          nationalIdFocusNode: FocusNode(),
          nationalIdController: TextEditingController(),
          nationalityFocusNode: FocusNode(),
          nationalityController: TextEditingController(),
          areaFocusNode: FocusNode(),
          areaController: TextEditingController(),
          isTermsAndConditionChecked: false,
        );
        resetState(ResetDataType.LOGIN_DATA);
        break;
      case ResetDataType.VERIFY_OTP_DATA:
        bool isDigitsOnly =
        state.emailOrPhoneNumberController!.text.toString().isDigitsOnly();
        bool isEmail =
        state.emailOrPhoneNumberController!.text.toString().isEmail();
        state = state.copyWith(
          forgotPasswordEmailOrPhoneNumberFocusNode: FocusNode(),
          forgotPasswordEmailOrPhoneNumberController: TextEditingController(),
          newPasswordFocusNode: FocusNode(),
          newPasswordController: TextEditingController(),
          confirmNewPasswordFocusNode: FocusNode(),
          confirmNewPasswordController: TextEditingController(),
        );
        break;
      case ResetDataType.FORGOT_PASSWORD_DATA:
        state = state.copyWith(
          forgotPasswordEmailOrPhoneNumberFocusNode: FocusNode(),
          forgotPasswordEmailOrPhoneNumberController: TextEditingController(),
        );
        break;
      case ResetDataType.RESET_PASSWORD_DATA:
        state = state.copyWith(
          newPasswordFocusNode: FocusNode(),
          newPasswordController: TextEditingController(),
          confirmNewPasswordFocusNode: FocusNode(),
          confirmNewPasswordController: TextEditingController(),
        );
        break;
      default:
        break;
    }
    state = state.copyWith(
      emailOrPhoneNumberFocusNode: FocusNode(),
      emailOrPhoneNumberController: TextEditingController(),
      loginPasswordFocusNode: FocusNode(),
      loginPasswordController: TextEditingController(),
      forgotPasswordEmailOrPhoneNumberFocusNode: FocusNode(),
      forgotPasswordEmailOrPhoneNumberController: TextEditingController(),
      newPasswordFocusNode: FocusNode(),
      newPasswordController: TextEditingController(),
      confirmNewPasswordFocusNode: FocusNode(),
      confirmNewPasswordController: TextEditingController(),
      fullNameFocusNode: FocusNode(),
      fullNameController: TextEditingController(),
      phoneNumberFocusNode: FocusNode(),
      phoneNumberController: TextEditingController(),
      emailFocusNode: FocusNode(),
      emailController: TextEditingController(),
      registerPasswordFocusNode: FocusNode(),
      registerPasswordController: TextEditingController(),
      nationalIdFocusNode: FocusNode(),
      nationalIdController: TextEditingController(),
      nationalityFocusNode: FocusNode(),
      nationalityController: TextEditingController(),
      areaFocusNode: FocusNode(),
      areaController: TextEditingController(),
      isTermsAndConditionChecked: false,
    );
  }

  void toggleTermsAndCondition() {
    state = state.copyWith(
        isTermsAndConditionChecked: !state.isTermsAndConditionChecked);
  }
}
