import 'dart:ffi';

class DummyCancellationReason {
  final String? id;
  final String? reasonName;
  bool isSelected;

  DummyCancellationReason({
    this.id,
    this.reasonName = "",
    this.isSelected = false,
  });

  // Manual copyWith implementation
  DummyCancellationReason copyWith({
    String? id,
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
