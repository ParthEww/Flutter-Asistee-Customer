import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_yay_rider_driver/core/utils/dialog_utils.dart';
import 'package:flutter_yay_rider_driver/core/widgets/app_button.dart';

import '../../core/themes/app_colors.dart';

class PreferencePage extends ConsumerWidget {

  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(PreferenceNotifierProvider);
    // final authNotifier = ref.read(PreferenceNotifierProvider.notifier);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: AppButton(
              buttonText: 'Show Snackbar',
              onPressed: () async {
                DialogUtils.showSnackBar(
                  "This is custom snackbar",
                  snackbarType: SnackbarType.success,
                );
              },
              buttonRadius: 100,
              buttonHeight: 55,
              buttonColor: AppColors.primary,
              textColor: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}