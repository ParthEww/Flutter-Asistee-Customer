import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/core/utils/common_utils.dart';
import 'package:flutter_yay_rider_driver/core/utils/common_utils.dart';
import 'package:flutter_yay_rider_driver/core/utils/common_utils.dart';
import 'package:flutter_yay_rider_driver/core/utils/common_utils.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../api/api_constant.dart';
import '../../api/model/static/google_place_model.dart';
import '../../constants/global.dart';
import '../../core/themes/app_strings.dart';
import '../../core/utils/app_logger.dart';
import '../../core/utils/dialog_utils.dart';

class GooglePlaceService with ChangeNotifier {
  static final _dio = Dio();

  static Future<List> getGooglePlaceSuggestion(
    String query, {
    bool requireFields = true,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    var url = '';
    url = requireFields
        ? '${Constants.mapApiBaseUrl}/place/autocomplete/json?input=$query&fields=place_id,geometry,formatted_address,name&types=establishment&key=${CommonUtils.googleMapKey}&sessiontoken=1234567890'
        : '${Constants.mapApiBaseUrl}/place/autocomplete/json?input=$query&key=${CommonUtils.googleMapKey}&sessiontoken=1234567890';
    logger.log('URL -- $url');
    final response = await _dio.get(url);
    List tList = [];
    for (int i = 0; i < response.data['predictions'].length; i++) {
      tList.add(response.data['predictions'][i]);
    }

    return tList;
  }

  static Future<GooglePlaceModel> getPlaceDetails({
     required GooglePlaceModel googlePlaceModel,
    LatLong? latLng,
    CancelToken? cancelToken,
  }) async {
    var url = latLng == null
        ? '${Constants.mapApiBaseUrl}/place/details/json?placeid=${googlePlaceModel.placeId}&key=${CommonUtils.googleMapKey}'
        : '${Constants.mapApiBaseUrl}/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=${CommonUtils.googleMapKey}';

    print('URL -- $url');

    if (await InternetConnectionChecker.instance.hasConnection) {
      final response = await _dio.get(url, cancelToken: cancelToken);

      dynamic responseDataResult;

      if (latLng == null) {
        responseDataResult = response.data['result'];
      } else {
        if ((response.data['results'] as List).isNotEmpty) {
          responseDataResult = (response.data['results'])[0];
        } else {
          return GooglePlaceModel();
        }
      }

      double latitude = responseDataResult['geometry']['location']['lat'];
      double longitude = responseDataResult['geometry']['location']['lng'];

      String country = '';
      String state = '';
      String city = '';
      String postalCode = '';

      String subLocality = '';
      String locality = '';

      String formattedAddress = responseDataResult['formatted_address'];
      String shortAddressName = (latLng == null
              ? responseDataResult['name']
              : responseDataResult['premise']) ??
          formattedAddress;

      List list = responseDataResult['address_components'];
      if (list.isNotEmpty) {
        for (int i = 0; i < list.length; i++) {
          var data = list[i]['types'];

          // country
          if (data.toString().contains('country')) {
            country = list[i]['long_name'].toString();
          }

          // state
          else if (data.toString().contains('administrative_area_level_1')) {
            state = list[i]['long_name'].toString();
          }

          // city
          else if (data.toString().contains('administrative_area_level_3')) {
            city = list[i]['long_name'].toString();
          } else if (!data.toString().contains('administrative_area_level_3') &&
              data.toString().contains('neighborhood')) {
            city = list[i]['long_name'].toString();
          }

          // sub locality
          else if (data.toString().contains('sublocality_level_1')) {
            subLocality = list[i]['long_name'].toString();
          } else if (!data.toString().contains('sublocality_level_1') &&
              data.toString().contains('route')) {
            subLocality = list[i]['long_name'].toString();
          }

          // locality
          else if (data.toString().contains('locality')) {
            locality = list[i]['long_name'].toString();
          }

          // postal code
          else if (data.toString().contains('postal_code')) {
            postalCode = list[i]['long_name'].toString();
          }
        }
      }

      return googlePlaceModel.copyWith(lat: latitude, lng: longitude);
    } else {
      DialogUtils.showSnackBar(
        AppStrings.noInternetConnection,
        snackbarType: SnackbarType.failure,
      );
      return GooglePlaceModel();
    }
  }
}
