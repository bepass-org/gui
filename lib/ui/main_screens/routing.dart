import 'package:defacto/ui/other_screens/add_route_screen.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/route/route_state.dart';
import '../widgets/routing/route_item.dart';
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

  void toggleSwitch(String key) {
    print("Toggle clicked");
    setState(() {

      rulesActive[key] = !rulesActive[key]!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${rulesActive[key]! ? "Enabled" : "Disabled"} $key'),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalState = ref.watch(routeStateProvider);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(_scaffoldKey.currentState!.isDrawerOpen){
          _scaffoldKey.currentState!.closeDrawer();
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConfigurationScreen(),
            ),
          );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Routing And Rules", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  AddRouteScreen()));
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
        drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Material(
          color: Theme.of(context).colorScheme.background,
          child: ListView.builder(
            padding: const EdgeInsets.all(4),
            physics: const BouncingScrollPhysics(),
            itemCount: globalState.length,
            itemBuilder: (context, index) => RouteItem(routeModel: globalState[index],index: index,),
            // children: rulesActive.keys.map((rule) {
            //   return RouteItem();
            // }).toList(),
          ),
        ),
      ),
    );
  }
}
