import 'package:freezed_annotation/freezed_annotation.dart';

import 'common_dropdown_notifier.dart';

part 'common_dropdown_state.freezed.dart';

@freezed
class CommonDropdownState with _$CommonDropdownState {
  const factory CommonDropdownState({
    required List<dynamic> items,
    required int? selectedId,
    required DaysDatesType daysDatesType,
    required bool isLoading,
    String? searchQuery,
    @Default(false) bool isDaysSelected,
  }) = _CommonDropdownState;
}