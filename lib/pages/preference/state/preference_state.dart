import 'package:flutter/material.dart';
import 'package:flutter_yay_rider_driver/api/model/static/google_place_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_state.freezed.dart';

@freezed
class PreferenceState with _$PreferenceState {
  const factory PreferenceState({
    TextEditingController? addressTextController,
    TextEditingController? nationalityController,
    @Default([])List<GooglePlaceModel> addressSuggestionList
  }) = _PreferenceState;
}
