import 'dart:convert';

import 'package:defacto/models/route/route_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final SinglerouteStateProvider =
StateProvider((ref) => SingleRouteStateNotifier());

class SingleRouteStateNotifier extends StateNotifier<RouteModel?>{

  RouteModel? routeModel;
  SingleRouteStateNotifier( {this.routeModel}):super(routeModel);

  // update fields of routemodel
  void UpdateRoute({required String propertyName,required dynamic newValue}){


    // set new value for copy object based on propertyName
    RouteModel? copiedModel = state?.copyWith(
      domain: propertyName == 'domain' ? newValue : state?.domain,
      routeName: propertyName == 'routeName' ? newValue : state?.routeName,
      outbound: propertyName == 'outbound' ? newValue : state?.outbound,
      protocol: propertyName == 'protocol' ? newValue : state?.protocol,
      source: propertyName == 'source' ? newValue : state?.source,
      network: propertyName == 'network' ? newValue : state?.network,
      sourcePort: propertyName == 'sourcePort' ? newValue : state?.sourcePort,
      port: propertyName == 'port' ? newValue : state?.port,
      application: propertyName == 'application' ? newValue : state?.application,
      active: propertyName == 'active' ? newValue : state?.active,
      ip: propertyName == 'ip' ? newValue : state?.ip,

    );
    state = copiedModel;

  }
}