import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../api/model/static/google_place_model.dart';
import '../state/preference_state.dart';

part 'preference_notifier.g.dart';

@riverpod
class PreferenceNotifier extends _$PreferenceNotifier {

  @override
  PreferenceState build() {
    state = PreferenceState(
      addressTextController: TextEditingController(),
      addressSuggestionList: [],
    );
    return state;
  }

  void updateAddressSuggestionList(List<GooglePlaceModel> list) {
    state = state.copyWith(addressSuggestionList: list);
  }

  void clearAddressSuggestionList() {
    state = state.copyWith(addressSuggestionList: []);
  }
}
