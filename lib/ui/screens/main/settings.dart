import 'dart:convert';
import 'dart:io';

import 'package:defacto/ui/screens/other/theme_select.dart';
import 'package:defacto/ui/widgets/builder/build_settings.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../skeleton/skeleton_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

@HiveType(typeId: 0)
class ThemeIndexModel extends HiveObject {
  @HiveField(0)
  late int themeIndex;
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Map<String, dynamic>> settings_template = [];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    String settingsContent =
        await rootBundle.loadString('assets/fake_data/settings_template.json');

    setState(() {
      settings_template = (json.decode(settingsContent) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
        appBar: AppBar(
            automaticallyImplyLeading: Platform.isAndroid,
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Platform.isAndroid
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.background,
            title: Text(
              "Settings",
              style: TextStyle(
                  color: Platform.isAndroid
                      ? Colors.white
                      : Theme.of(context).colorScheme.primary),
            )),
        body: Column(
          children: [
            Container(
              child: themeSelector(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: settings_template.isEmpty
                    ? 0
                    : settings_template[0]['groups'].length,
                itemBuilder: (context, index) {
                  var group = settings_template[0]['groups'][index];
                  return GroupForm(
                    title: group['title'],
                    children: [
                      for (var field in group['fields']) buildSettings(field),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
