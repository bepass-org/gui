import 'package:defacto/ui/other_screens/add_route_screen.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import 'configuration.dart';

class RoutingScreen extends StatefulWidget {
  const RoutingScreen({super.key});

  @override
  State<RoutingScreen> createState() => _RoutingScreenState();
}

class _RoutingScreenState extends State<RoutingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, bool> rulesActive = {
    'Rule 7': true,
    'Block QUIC': false,
    'Block Ads': true,
    // Add more rules as necessary
  };

  void toggleSwitch(String key) {
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
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddRouteScreen()));
              },
              icon: const Icon(Icons.add_road),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Material(
          color: Theme.of(context).colorScheme.background,
          child: ListView(
            padding: const EdgeInsets.all(4),
            physics: const BouncingScrollPhysics(),
            children: rulesActive.keys.map((rule) {
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
                              rule,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // TODO: Implement edit action
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
                                value: rulesActive[rule]!,
                                onChanged: (newValue) {
                                  setState(() {
                                    rulesActive[rule] = newValue;
                                  });
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
            }).toList(),
          ),
        ),
      ),
    );
  }
}
