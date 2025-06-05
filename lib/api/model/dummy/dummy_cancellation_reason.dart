class DummyCancellationReason {
  final String? reasonName;
  bool isSelected;

  DummyCancellationReason({
    this.reasonName = "",
    this.isSelected = false,
  });

  // Manual copyWith implementation
  DummyCancellationReason copyWith({
    String? reasonName,
    bool? isSelected,
  }) {
    return DummyCancellationReason(
      reasonName: reasonName ?? this.reasonName,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
