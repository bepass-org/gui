import 'package:defacto/ui/widgets/builder/buildfield.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:defacto/ui/widgets/form/profile_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  List<Map<String, dynamic>> profile_template = [];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    String jsonContent1 =
        await rootBundle.loadString('assets/fake_data/profile_templates.json');

    setState(() {
      profile_template = (json.decode(jsonContent1) as List<dynamic>)
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
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _saveConfiguration,
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveConfiguration,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _saveConfiguration,
          ),
        ],
        title: const Text(
          'Profile Config',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: profile_template.isEmpty
            ? 0
            : profile_template[0]['groups'].length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const ProfileName();
          } else {
            var group = profile_template[0]['groups'][index - 1];
            return GroupForm(
              title: group['name'],
              children: [
                for (var field in group['fields']) buildField(field),
              ],
            );
          }
        },
      ),
    );
  }

  void _saveConfiguration() {
    Navigator.pop(context);
  }
}
