import 'dart:convert';
import 'package:defacto/helpers/material_icons.dart';
import 'package:defacto/ui/widgets/card/default_card.dart';
import 'package:defacto/ui/widgets/card/default_list_item.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<Map<String, dynamic>> about_template = [];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    String aboutContent =
        await rootBundle.loadString('assets/fake_data/about_template.json');

    setState(() {
      about_template = (json.decode(aboutContent) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount:
            about_template.isEmpty ? 0 : about_template[0]['groups'].length,
        itemBuilder: (context, index) {
          var group = about_template[0]['groups'][index];
          return GroupForm(
            title: group['name'],
            children: [
              Column(
                children: [
                  DefaultCard(child: _appInfoWidget(context, group)),
                  for (var field in group['fields'])
                    DefaultCard(child: _fieldInfoWidget(context, field)),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

Widget _appInfoWidget(BuildContext context, Map<String, dynamic> group) {
  String capitalizedTitle = group['id'].toUpperCase();

  return Column(children: [
    DefaultListItem(
      title: capitalizedTitle,
      addDivider: true,
      additionalInput: group['label'],
      body: (group['descType'] != 'hidden') ? group['description'] : null,
      prefixWidget: Icon(Icons.history),
    ),
  ]);
}

Widget _fieldInfoWidget(BuildContext context, Map<String, dynamic> field) {
  String capitalizedTitle = field['id'].toUpperCase();
  return Column(children: [
    DefaultListItem(
        title: capitalizedTitle,
        addDivider: false,
        additionalInput: field['label'],
        body: (field['descType'] != 'hidden') ? field['description'] : null,
        prefixWidget: Icon(MaterialIconHelper.stringToIconData(field['icon']))),
  ]);
}
