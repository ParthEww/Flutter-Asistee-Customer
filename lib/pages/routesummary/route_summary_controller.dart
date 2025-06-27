import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_structure/core/widgets/bottom_sheet/common_dropdown_selection_bottom_sheet.dart';

import '../../api/model/dummy/dummy_cancellation_reason.dart';
import '../../core/enum/app_status.dart';
import '../../repository/local_repository/local_repository.dart';
import '../../repository/remote_repository/remote_repository.dart';
import '../../routes/app_pages.dart';

class RouteSummaryController extends GetxController {
  final _localRepository = Get.find<LocalRepository>();
  final _remoteRepository = Get.find<RemoteRepository>();

  AppStatus appStatus = AppStatus.normal;

  // ----- [route name] -----
  FocusNode routeNameFocusNode = FocusNode();
  final TextEditingController routeNameController = TextEditingController();

  Rx<CommonDropdownSelectionBottomSheetDialogType?> dialogType = Rx<CommonDropdownSelectionBottomSheetDialogType?>(null);
  RxInt selectedItemIndex = RxInt(-1);

  final RxList<DummyCancellationReason> nationalityList =
      <DummyCancellationReason>[
    DummyCancellationReason(id: 1, reasonName: "Afghan", isSelected: true),
    DummyCancellationReason(id: 2, reasonName: "Algerian"),
    DummyCancellationReason(id: 3, reasonName: "Angolan"),
    DummyCancellationReason(id: 4, reasonName: "Argentine"),
    DummyCancellationReason(id: 5, reasonName: "Austrian"),
    DummyCancellationReason(id: 6, reasonName: "Bangladeshi"),
    DummyCancellationReason(id: 7, reasonName: "Belgian"),
    DummyCancellationReason(id: 8, reasonName: "Brazilian"),
    DummyCancellationReason(id: 9, reasonName: "British"),
    DummyCancellationReason(id: 10, reasonName: "Bulgarian"),
    DummyCancellationReason(id: 11, reasonName: "Cameroonian"),
    DummyCancellationReason(id: 12, reasonName: "Canadian"),
    DummyCancellationReason(id: 13, reasonName: "Chilean"),
    DummyCancellationReason(id: 14, reasonName: "Chinese"),
    DummyCancellationReason(id: 15, reasonName: "Colombian"),
    DummyCancellationReason(id: 16, reasonName: "Croatian"),
    DummyCancellationReason(id: 17, reasonName: "Czech"),
    DummyCancellationReason(id: 18, reasonName: "Danish"),
    DummyCancellationReason(id: 19, reasonName: "Dutch"),
    DummyCancellationReason(id: 20, reasonName: "Egyptian"),
    DummyCancellationReason(id: 21, reasonName: "Ethiopian"),
    DummyCancellationReason(id: 22, reasonName: "Finnish"),
    DummyCancellationReason(id: 23, reasonName: "French"),
    DummyCancellationReason(id: 24, reasonName: "German"),
    DummyCancellationReason(id: 25, reasonName: "Greek"),
    DummyCancellationReason(id: 26, reasonName: "Hungarian"),
    DummyCancellationReason(id: 27, reasonName: "Indian"),
    DummyCancellationReason(id: 28, reasonName: "Indonesian"),
    DummyCancellationReason(id: 29, reasonName: "Iranian"),
    DummyCancellationReason(id: 30, reasonName: "Iraqi"),
    DummyCancellationReason(id: 31, reasonName: "Irish"),
    DummyCancellationReason(id: 32, reasonName: "Israeli"),
    DummyCancellationReason(id: 33, reasonName: "Italian"),
    DummyCancellationReason(id: 34, reasonName: "Japanese"),
    DummyCancellationReason(id: 35, reasonName: "Jordanian"),
    DummyCancellationReason(id: 36, reasonName: "Kenyan"),
  ].obs;

  final RxList<DummyCancellationReason> frequencyList =
      <DummyCancellationReason>[
    DummyCancellationReason(id: 1, reasonName: "Daily", isSelected: true),
    DummyCancellationReason(id: 2, reasonName: "Weekly"),
    DummyCancellationReason(id: 3, reasonName: "Monthly"),
    DummyCancellationReason(id: 4, reasonName: "Yearly")
  ].obs;

  final RxList<DummyCancellationReason> daysOfTheWeekList =
      <DummyCancellationReason>[
    DummyCancellationReason(id: 1, reasonName: "Sunday", isSelected: true),
    DummyCancellationReason(id: 2, reasonName: "Monday"),
    DummyCancellationReason(id: 3, reasonName: "Tuesday"),
    DummyCancellationReason(id: 4, reasonName: "Wednesday"),
    DummyCancellationReason(id: 5, reasonName: "Thursday"),
    DummyCancellationReason(id: 6, reasonName: "Friday"),
    DummyCancellationReason(id: 7, reasonName: "Saturday")
  ].obs;
  RxList<DateTime> selectedDaysList = [
    DateTime(2025, 6, 2),
    DateTime(2025, 6, 10),
    DateTime(2025, 6, 18),
    DateTime(2025, 6, 26),
    DateTime(2025, 6, 30)
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onGoToDefineRule() async {
    Get.toNamed(Routes.defineBookingRule);
  }

  void onGoToRouteSummary() async {
    Get.toNamed(Routes.routeSummary);
  }

  void onGoToDashboard() async {
    Get.offAllNamed(Routes.dashboard);
  }

  void onGoToPromoCode() async {
    Get.toNamed(Routes.promoCodes);
  }
}
