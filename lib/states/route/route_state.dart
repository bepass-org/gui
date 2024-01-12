import 'dart:convert';

import 'package:defacto/models/route/route_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final routeStateProvider =
StateNotifierProvider<RouteStateNotifier, List<RouteModel>>((ref) {
  return RouteStateNotifier();
});

class RouteStateNotifier extends StateNotifier<List<RouteModel>>{

  RouteStateNotifier() : super([]) {
    init();
  }

  /*
  populate list with fake sample data
   */
  init()async{

    List<RouteModel> route = await loadFakeProfiles();


    state = route;
  }
  Future<List<RouteModel>> loadFakeProfiles() async {
    final String response = await rootBundle.loadString('assets/fake_data/route.json');
    final data = await json.decode(response) as List;
    return data.map((profileJson) => RouteModel.fromJson(profileJson)).toList();
  }


  /*
  test method for add new Route to the state
   */
  void AddNew(){
    var temp = RouteModel(id: '22',routeName: 'my route2',application: 'beepas app',active: true);
    state = [ ...state,temp];
  }

  /*
  update item
   */
  void UpdateItem(RouteModel newroute){
    List<RouteModel> newState = [...state];
    // find the index of item
    int index = newState.indexWhere((route) => route.id == newroute.id);
    // update the item with new object
    newState[index] = newroute;
    state = newState;
  }


}