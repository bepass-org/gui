import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:defacto/ui/widgets/form/group.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'configuration.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:defacto/config/theme_provider.dart';

List<Color> colorsList = [
  Colors.white,
  Colors.black,
  Colors.redAccent,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.orange,
];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> settings1 = [];
  List<Map<String, dynamic>> settings2 = [];
  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    String jsonContent1 = await rootBundle.loadString('assets/settings1.json');
    String jsonContent2 = await rootBundle.loadString('assets/settings2.json');

    setState(() {
      settings1 = (json.decode(jsonContent1) as List<dynamic>)
          .cast<Map<String, dynamic>>();
      settings2 = (json.decode(jsonContent2) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (_scaffoldKey.currentState!.isDrawerOpen) {
            _scaffoldKey.currentState!.closeDrawer();
          } else {
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
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text(
              "Settings",
            ),
          ),
          drawer: const MainDrawer(),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: ListView.builder(
            itemCount: settings1.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> setting1 = settings1[index];
              Map<String, dynamic> setting2 = settings2[index];

              return GroupForm(title: 'App Settings', children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: ListView.builder(
                          physics: const PageScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: colorsList.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                final themeNotifer = ref.watch(themeProvider);
                                return GestureDetector(
                                  child: Container(
                                    height: 100,
                                    width: 57,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        color: colorsList[index],
                                        shape: BoxShape.circle),
                                  ),
                                  onTap: () {
                                    themeNotifer.setTheme(index);
                                  },
                                );
                              },
                            );
                          }),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: setting1.entries
                          .where((entry) => entry.value == true)
                          .map((entry) {
                        return buildListTile(entry.key, setting2[entry.key]);
                      }).toList(),
                    ),
                  ],
                )
              ]);
            },
          ),
        ));
  }
}

Widget buildListTile(String title, dynamic value) {
  return ListTile(
    leading: Icon(Icons.edit),
    title: Text(title),
    trailing: Text(value?.toString() ?? 'N/A'),
  );
}
