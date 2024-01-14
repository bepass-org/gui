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

  void UpdateRoute(){
    print("Called");
    //state
    //state?.routeName = "nnnnnnnnnnnnnnn";
     RouteModel route = routeModel!.copyWith();
     route.routeName = "XXXXXXXXX";
    // routeModel = route;
   // RouteModel route = routeModel!.copyWith();
    //state?.routeName = "XXXXXXXXX";
    state = route;
  }
}