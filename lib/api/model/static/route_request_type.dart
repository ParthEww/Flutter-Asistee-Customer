import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteRequestType {
  final int id;
  final String title;
  final bool isSelected;

  const RouteRequestType({required this.id, required this.title, this.isSelected = false});

  // Manual copyWith implementation
  RouteRequestType copyWith({
    int? id,
    String? title,
    bool? isSelected,
  }) {
    return RouteRequestType(
      id: id ?? this.id,
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

final RxList<RouteRequestType> routeRequestTypeList = [
  RouteRequestType(id: 2, title: "Recurring Booking", isSelected: true),
  RouteRequestType(id: 1, title: "One Time Booking", isSelected: false)
].obs;
