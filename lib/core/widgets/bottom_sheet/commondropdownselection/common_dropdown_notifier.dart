import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common_dropdown_selection_bottom_sheet_old.dart';
import 'common_dropdown_selection_bottom_sheet.dart';
import 'common_dropdown_state.dart';

part 'common_dropdown_notifier.g.dart';

enum DaysDatesType {
  DAYS(title: "Repeat on Days"),
  DATES(title: "Repeat on Dates");

  final String title;
  const DaysDatesType({required this.title});
}

@riverpod
class CommonDropdownNotifier extends _$CommonDropdownNotifier {

  @override
  CommonDropdownState build() {
    state = const CommonDropdownState(
      items: [],
      selectedId: null,
      daysDatesType: DaysDatesType.DAYS,
      isLoading: false,
    );
    return state;
  }

  void toggleDaysDatesType() {
    state = state.copyWith(
      daysDatesType: state.daysDatesType == DaysDatesType.DAYS
          ? DaysDatesType.DATES
          : DaysDatesType.DAYS,
    );
  }

  void selectItem(int id) {
    state = state.copyWith(selectedId: id);
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void toggleItemSelection({required CommonDropdownSelectionBottomSheetDialogType dialogType, required int index}) {
    if (dialogType ==
        CommonDropdownSelectionBottomSheetDialogType.SELECT_MONTH) {
      final newItems = [...state.items];
      newItems[index] = newItems[index].copyWith(
        isSelected: !newItems[index].isSelected,
      );
      state = state.copyWith(items: newItems);
    } else {
      final position = state.items.indexWhere((it) => it.id == state.items[index].id);
      if (position == -1) return;
      final newList =
      state.items.map((bean) => bean.copyWith(isSelected: false)).toList();
      newList[position] = newList[position].copyWith(isSelected: true);
      state = state.copyWith(items: newList);
    }
  }
}
