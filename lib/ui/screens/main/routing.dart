import 'dart:io';

import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/states/route/route_state.dart';
import 'package:defacto/ui/screens/other/add_route_screen.dart';
import 'package:defacto/ui/widgets/routing/route_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../skeleton/skeleton_screen.dart';
import 'configuration.dart';

class RoutingScreen extends ConsumerStatefulWidget {
  const RoutingScreen({super.key});

  @override
  ConsumerState<RoutingScreen> createState() => _RoutingScreenState();
}

class _RoutingScreenState extends ConsumerState<RoutingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, bool> rulesActive = {
    'Rule 7': true,
    'Block QUIC': false,
    'Block Ads': true,
    // Add more rules as necessary
  };

  // void toggleSwitch(String key) {
  //   print("Toggle clicked");
  //   setState(() {
  //
  //     rulesActive[key] = !rulesActive[key]!;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('${rulesActive[key]! ? "Enabled" : "Disabled"} $key'),
  //         duration: const Duration(seconds: 1),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final globalState = ref.watch(routeStateProvider);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState!.closeDrawer();
        } else {
          ref.read(globalStateProvider.notifier).setActivePage(AppPage.configuration);
        }
      },
      child: BasePage(
        scaffoldKey: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: Platform.isAndroid,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Platform.isAndroid
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
          title: Text(
            "Routing And Rules",
            style: TextStyle(
                color: Platform.isAndroid
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddRouteScreen()));
              },
              icon: const Icon(Icons.add_road),
            ),
            IconButton(
              onPressed: () {
                // ref.watch(routeStateProvider.notifier).ChangeItem();
                // ref.watch(routeStateProvider.notifier).AddNew();
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        //  drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Material(
          color: Theme.of(context).colorScheme.background,
          child: ListView.builder(
            padding: const EdgeInsets.all(4),
            physics: const BouncingScrollPhysics(),
            itemCount: globalState.length,
            itemBuilder: (context, index) => RouteItem(
              routeModel: globalState[index],
              index: index,
            ),
            // children: rulesActive.keys.map((rule) {
            //   return RouteItem();
            // }).toList(),
          ),
        ),
      ),
    );
  }
}
