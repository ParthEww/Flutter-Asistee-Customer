import 'package:flutter_yay_rider_driver/api/model/response/userdata/user_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../api/model/response/init/init_data.dart';


part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState{
  factory SplashState ({
    InitData? initDataModel,
    UserData? userData,
}) = _SplashState;
}