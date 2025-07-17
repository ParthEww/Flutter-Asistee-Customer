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

final List<DummyCancellationReason> nationalityList = [
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
];

final List<DummyCancellationReason> areaList = [
  DummyCancellationReason(id: 1, reasonName: "North America", isSelected: true),
  DummyCancellationReason(id: 2, reasonName: "South America"),
  DummyCancellationReason(id: 3, reasonName: "Central America"),
  DummyCancellationReason(id: 4, reasonName: "Caribbean"),
  DummyCancellationReason(id: 5, reasonName: "Western Europe"),
  DummyCancellationReason(id: 6, reasonName: "Eastern Europe"),
  DummyCancellationReason(id: 7, reasonName: "Northern Europe"),
  DummyCancellationReason(id: 8, reasonName: "Southern Europe"),
  DummyCancellationReason(id: 9, reasonName: "Middle East"),
  DummyCancellationReason(id: 10, reasonName: "North Africa"),
  DummyCancellationReason(id: 11, reasonName: "West Africa"),
  DummyCancellationReason(id: 12, reasonName: "East Africa"),
  DummyCancellationReason(id: 13, reasonName: "Southern Africa"),
  DummyCancellationReason(id: 14, reasonName: "Central Asia"),
  DummyCancellationReason(id: 15, reasonName: "South Asia"),
  DummyCancellationReason(id: 16, reasonName: "Southeast Asia"),
  DummyCancellationReason(id: 17, reasonName: "East Asia"),
  DummyCancellationReason(id: 18, reasonName: "Oceania"),
  DummyCancellationReason(id: 19, reasonName: "Antarctica"),
];

