import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_yay_rider_driver/api/api_repository.dart';
import 'package:flutter_yay_rider_driver/api/model/request/loginRequest.dart';
import 'package:flutter_yay_rider_driver/api/model/response/init/init_data.dart';
import 'package:flutter_yay_rider_driver/api/model/response/userdata/user_data.dart';
import 'package:flutter_yay_rider_driver/api/resource.dart';
import '../../api/api_client/api_client.dart';

import '../../api/api_response.dart';

part 'remote_repository_impl.dart';

abstract class RemoteRepository {
  Stream<Resource<ApiResponse<InitData>>> initApi();
  Stream<Resource<ApiResponse<UserData>>> loginApi(LoginRequest loginRequest);
}
