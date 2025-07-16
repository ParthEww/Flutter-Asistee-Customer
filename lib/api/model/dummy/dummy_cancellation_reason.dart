import 'dart:ffi';

class DummyCancellationReason {
  final int? id;
  final String? reasonName;
  bool isSelected;

  DummyCancellationReason({
    this.id,
    this.reasonName = "",
    this.isSelected = false,
  });

  // Manual copyWith implementation
  DummyCancellationReason copyWith({
    int? id,
    String? reasonName,
    bool? isSelected,
  }) {
    return DummyCancellationReason(
      id: id ?? this.id,
      reasonName: reasonName ?? this.reasonName,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
