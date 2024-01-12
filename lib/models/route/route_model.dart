import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'route_model.freezed.dart';
part 'route_model.g.dart';

@unfreezed
class RouteModel with _$RouteModel {


  factory RouteModel({
    String? id,
    String? routeName,
    String? application,
    bool? active,
    String? ip,
    String? port,
    String? sourcePort,
    String? network,
    String? source,
    String? protocol,
    String? outbound,
  }) = _RouteModel;


  factory RouteModel.fromJson(Map<String, Object?> json)
  => _$RouteModelFromJson(json);

}