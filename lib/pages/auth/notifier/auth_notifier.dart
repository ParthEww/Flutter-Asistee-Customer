import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yay_rider_driver/api/api_client/api_client.dart';
import 'package:flutter_yay_rider_driver/api/api_repository.dart';
import 'package:flutter_yay_rider_driver/api/api_response.dart';
import 'package:flutter_yay_rider_driver/api/collect_resource_stream.dart';
import 'package:flutter_yay_rider_driver/api/model/response/init/init_data.dart';
import 'package:flutter_yay_rider_driver/api/model/response/userdata/user_data.dart';
import 'package:flutter_yay_rider_driver/api/resource.dart';
import 'package:flutter_yay_rider_driver/di/app_provider.dart';
import 'package:flutter_yay_rider_driver/repository/local_repository/local_repository.dart';
import 'package:flutter_yay_rider_driver/routes/route_observer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/api_constant.dart';
import '../../../core/enum/app_status.dart';
import '../../../core/themes/app_strings.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../repository/remote_repository/remote_repository.dart';
import '../../../routes/navigation_service.dart';
import '../state/auth_state.dart';
part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final LocalRepository localRepository = ref.read(localRepositoryProvider);
  late final RemoteRepository remoteRepository = ref.read(remoteRepositoryProvider);
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
}
