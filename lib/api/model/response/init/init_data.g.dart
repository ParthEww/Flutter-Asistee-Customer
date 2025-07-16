// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitData _$InitDataFromJson(Map<String, dynamic> json) => InitData(
      (json['app_menu_link'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataAppMenuLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['address_type'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataAddressType.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['frequency_list'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataFrequencyList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['days_list'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataDaysList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['month_list'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataMonthList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['year_list'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataYearList.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sorting'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataSorting.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['filtering'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : InitDataFiltering.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['socket_url'] as String?,
      json['update'] as bool?,
      json['force_update'] as bool?,
      json['maintenance'] as bool?,
    );

Map<String, dynamic> _$InitDataToJson(InitData instance) => <String, dynamic>{
      'app_menu_link': instance.appMenuLink,
      'address_type': instance.addressType,
      'frequency_list': instance.frequencyList,
      'days_list': instance.daysList,
      'month_list': instance.monthList,
      'year_list': instance.yearList,
      'sorting': instance.sorting,
      'filtering': instance.filtering,
      'socket_url': instance.socketUrl,
      'update': instance.update,
      'force_update': instance.forceUpdate,
      'maintenance': instance.maintenance,
    };

InitDataAppMenuLink _$InitDataAppMenuLinkFromJson(Map<String, dynamic> json) =>
    InitDataAppMenuLink(
      json['name'] as String?,
      json['show_name'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$InitDataAppMenuLinkToJson(
        InitDataAppMenuLink instance) =>
    <String, dynamic>{
      'name': instance.name,
      'show_name': instance.showName,
      'url': instance.url,
    };

InitDataAddressType _$InitDataAddressTypeFromJson(Map<String, dynamic> json) =>
    InitDataAddressType(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$InitDataAddressTypeToJson(
        InitDataAddressType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };

InitDataFrequencyList _$InitDataFrequencyListFromJson(
        Map<String, dynamic> json) =>
    InitDataFrequencyList(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$InitDataFrequencyListToJson(
        InitDataFrequencyList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };

InitDataDaysList _$InitDataDaysListFromJson(Map<String, dynamic> json) =>
    InitDataDaysList(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$InitDataDaysListToJson(InitDataDaysList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };

InitDataMonthList _$InitDataMonthListFromJson(Map<String, dynamic> json) =>
    InitDataMonthList(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$InitDataMonthListToJson(InitDataMonthList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isSelected': instance.isSelected,
    };

InitDataYearList _$InitDataYearListFromJson(Map<String, dynamic> json) =>
    InitDataYearList(
      (json['id'] as num?)?.toInt(),
      (json['year'] as num?)?.toInt(),
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$InitDataYearListToJson(InitDataYearList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'isSelected': instance.isSelected,
    };

InitDataSorting _$InitDataSortingFromJson(Map<String, dynamic> json) =>
    InitDataSorting(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['value'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$InitDataSortingToJson(InitDataSorting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'isSelected': instance.isSelected,
    };

InitDataFiltering _$InitDataFilteringFromJson(Map<String, dynamic> json) =>
    InitDataFiltering(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['value'] as String?,
      json['isSelected'] as bool?,
    );

Map<String, dynamic> _$InitDataFilteringToJson(InitDataFiltering instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'isSelected': instance.isSelected,
    };
