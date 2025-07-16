
import 'package:flutter_yay_rider_driver/api/model/response/route_stop.dart';

class RouteData {
  final String? adminStatus;
  final String? approxDistance;
  final String? approxDuration;
  final String? boardingPoint;
  final String? dropOffPoint;
  final String? endDate;
  final String? endTime;
  final String? frequency;
  final int? id;
  final String? repeatAfter;
  final String? repeatType;
  final String? requestType;
  final String? routeName;
  final String? routeNumber;
  final List<RouteStop>? routeStops;
  final int? routeableId;
  final String? routeableType;
  final String? startDate;
  final String? startTime;
  final int? year;
  final String? type;
  final bool? isOnboard;

  RouteData({
    this.adminStatus,
    this.approxDistance,
    this.approxDuration,
    this.boardingPoint,
    this.dropOffPoint,
    this.endDate,
    this.endTime,
    this.frequency,
    this.id,
    this.repeatAfter,
    this.repeatType,
    this.requestType,
    this.routeName,
    this.routeNumber,
    this.routeStops,
    this.routeableId,
    this.routeableType,
    this.startDate,
    this.startTime,
    this.year,
    this.type,
    this.isOnboard = false,
  });
}
