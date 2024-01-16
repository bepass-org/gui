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
    String? domain,
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

  // RouteModel updateProperty(String propertyName, String newValue) {
  //   return RouteModel(
  //     id: id,
  //     routeName: routeName,
  //     application: application,
  //     domain: propertyName == 'domain' ? newValue : domain,
  //     active: active,
  //     ip: propertyName == 'ip' ? newValue : ip,
  //     port: propertyName == 'port' ? newValue : port,
  //     sourcePort: sourcePort,
  //     network: network,
  //     source: source,
  //     protocol: protocol,
  //     outbound: outbound,
  //   );
  // }



}