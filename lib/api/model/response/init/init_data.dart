import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enum/app_status.dart';

part 'init_data.g.dart';

@JsonSerializable()
class InitData {
  @JsonKey(name: 'app_menu_link')
  List<InitDataAppMenuLink?>? appMenuLink;
  @JsonKey(name: 'address_type')
  List<InitDataAddressType?>? addressType;
  @JsonKey(name: 'frequency_list')
  List<InitDataFrequencyList?>? frequencyList;
  @JsonKey(name: 'days_list')
  List<InitDataDaysList?>? daysList;
  @JsonKey(name: 'month_list')
  List<InitDataMonthList?>? monthList;
  @JsonKey(name: 'year_list')
  List<InitDataYearList?>? yearList;
  List<InitDataSorting?>? sorting;
  List<InitDataFiltering?>? filtering;
  @JsonKey(name: 'socket_url')
  String? socketUrl;
  bool? update;
  @JsonKey(name: 'force_update')
  bool? forceUpdate;
  bool? maintenance;

  InitData(
      this.appMenuLink,
      this.addressType,
      this.frequencyList,
      this.daysList,
      this.monthList,
      this.yearList,
      this.sorting,
      this.filtering,
      this.socketUrl,
      this.update,
      this.forceUpdate,
      this.maintenance);

  factory InitData.fromJson(Map<String, dynamic> json) =>
      _$InitDataFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataToJson(this);

  AppStatus get appStatus {
    if (maintenance ?? false) {
      return AppStatus.maintenance;
    } else if (forceUpdate ?? false) {
      return AppStatus.forceUpdate;
    } else if (update ?? false) {
      return AppStatus.optionalUpdate;
    } else {
      return AppStatus.normal;
    }
  }
}

@JsonSerializable()
class InitDataAppMenuLink {
  String? name;
  @JsonKey(name: 'show_name')
  String? showName;
  String? url;

  InitDataAppMenuLink(this.name, this.showName, this.url);

  factory InitDataAppMenuLink.fromJson(Map<String, dynamic> json) =>
      _$InitDataAppMenuLinkFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataAppMenuLinkToJson(this);
}

@JsonSerializable()
class InitDataAddressType {
  int? id;
  String? name;
  bool? isSelected;

  InitDataAddressType(this.id, this.name, this.isSelected);

  factory InitDataAddressType.fromJson(Map<String, dynamic> json) =>
      _$InitDataAddressTypeFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataAddressTypeToJson(this);
}

@JsonSerializable()
class InitDataFrequencyList {
  int? id;
  String? name;
  bool? isSelected;

  InitDataFrequencyList(this.id, this.name, this.isSelected);

  factory InitDataFrequencyList.fromJson(Map<String, dynamic> json) =>
      _$InitDataFrequencyListFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataFrequencyListToJson(this);
}

@JsonSerializable()
class InitDataDaysList {
  int? id;
  String? name;
  bool? isSelected;

  InitDataDaysList(this.id, this.name, this.isSelected);

  factory InitDataDaysList.fromJson(Map<String, dynamic> json) =>
      _$InitDataDaysListFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataDaysListToJson(this);
}

@JsonSerializable()
class InitDataMonthList {
  int? id;
  String? name;
  bool? isSelected;

  InitDataMonthList(this.id, this.name, this.isSelected);

  factory InitDataMonthList.fromJson(Map<String, dynamic> json) =>
      _$InitDataMonthListFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataMonthListToJson(this);
}

@JsonSerializable()
class InitDataYearList {
  int? id;
  int? year;
  bool? isSelected;

  InitDataYearList(this.id, this.year, this.isSelected);

  factory InitDataYearList.fromJson(Map<String, dynamic> json) =>
      _$InitDataYearListFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataYearListToJson(this);
}

@JsonSerializable()
class InitDataSorting {
  int? id;
  String? name;
  String? value;
  bool? isSelected;

  InitDataSorting(this.id, this.name, this.value, this.isSelected);

  factory InitDataSorting.fromJson(Map<String, dynamic> json) =>
      _$InitDataSortingFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataSortingToJson(this);
}

@JsonSerializable()
class InitDataFiltering {
  int? id;
  String? name;
  String? value;
  bool? isSelected;

  InitDataFiltering(this.id, this.name, this.value, this.isSelected);

  factory InitDataFiltering.fromJson(Map<String, dynamic> json) =>
      _$InitDataFilteringFromJson(json);

  Map<String, dynamic> toJson() => _$InitDataFilteringToJson(this);
}
