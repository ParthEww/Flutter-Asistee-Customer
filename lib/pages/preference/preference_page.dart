import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_yay_rider_driver/core/utils/add_delay.dart';
import 'package:flutter_yay_rider_driver/core/utils/dialog_utils.dart';
import 'package:flutter_yay_rider_driver/core/widgets/app_button.dart';
import 'package:flutter_yay_rider_driver/core/widgets/custom/address_suggestion_list_view.dart';
import 'package:flutter_yay_rider_driver/pages/preference/notifier/preference_notifier.dart';

import '../../api/model/static/google_place_model.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_strings.dart';
import '../../core/utils/app_validator.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/custom/custom_text_filed.dart';
import '../../gen/assets.gen.dart';
import 'google_place_service.dart';

class PreferencePage extends ConsumerWidget {

  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferenceState = ref.watch(preferenceNotifierProvider);
    final preferenceNotifier = ref.read(preferenceNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
                children: [
                  AppTextField(
                    textEditingController: preferenceState.addressTextController!,
                    focusNode: FocusScopeNode(),
                    hintText: "Search Text",
                    textInputAction: TextInputAction.done,
                    onChanged: (value) async {
                      if (value.isEmpty) {
                        preferenceNotifier.clearAddressSuggestionList();
                      }
                      var list = (await GooglePlaceService.getGooglePlaceSuggestion(
                          value,
                          requireFields: false,
                      )).map((e)=>GooglePlaceModel.fromJson(e)).toList();
                      AddDelay().run(() async {
                        preferenceNotifier.updateAddressSuggestionList(list);
                      });
                      print(list[0]);
                    },
                    validator:
                        (value) =>
                        AppValidator.emptyValidator(
                          value: value,
                          errorString: "Type your location",
                        ),
                  ),
                  AddressSuggestionListView(
                    locationList: preferenceState.addressSuggestionList,
                    listHeight: 300,
                    onTapPlace: (googlePlaceModel) {
                      // Get.context!.showLoading();
                         
                      preferenceState.addressTextController!.text = "${googlePlaceModel.lat} ${googlePlaceModel.lng}";

                      preferenceNotifier.clearAddressSuggestionList();

                      // Get.context!.hideLoading();
                    },
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}