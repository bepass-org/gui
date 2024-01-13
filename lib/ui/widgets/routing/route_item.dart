import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/route/route_model.dart';
import '../../../states/route/route_state.dart';
import '../../other_screens/add_route_screen.dart';

class RouteItem extends ConsumerWidget {

  RouteModel? routeModel;

  RouteItem({this.routeModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.onPrimary,

      /// Example: Many items have their own colors inside of the ThemData
      /// You can overwrite them in [config/theme.dart].
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    routeModel!.routeName!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // TODO: Implement edit action
                      /// navigate to [AddRouteScreen] page
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  AddRouteScreen(routeModel: routeModel,)));

                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      // TODO: Replace with actual subtitle(s)
                      'Protocol: TCP\nSource:',
                      style: TextStyle(fontSize: 14, color: Colors.red.shade400),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bypass', // TODO: Replace with dynamic action label
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: routeModel!.active!,
                      //value: rulesActive[rule]!,
                      onChanged: (newValue) {
                        print("Toggle in build $newValue");
                        // setState(() {
                        routeModel!.active = newValue;
                        ref.watch(routeStateProvider.notifier).UpdateItem(routeModel!);

                        //   toggleSwitch(rule );
                        // });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
