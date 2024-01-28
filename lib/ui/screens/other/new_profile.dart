import 'package:defacto/enums/form_editable_types.dart';
import 'package:defacto/ui/widgets/form/group.dart';
import 'package:defacto/ui/widgets/form/input_editable.dart';
import 'package:defacto/ui/widgets/form/profile_name.dart';
import 'package:defacto/ui/widgets/form/switch_editable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({super.key});

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

  Widget buildField(Map<String, dynamic> field) {
    String title = field['name'];
    String defaultValue = field['defaultValue'].toString();
    IconData icon = _getIcon(field['icon']);

    if (field['type'] == 'boolean') {
      return SwitchEditable(
        icon: icon,
        title: title,
        value: defaultValue.toLowerCase() == 'true',
        onChanged: (v) {},
      );
    } else {
      FormEditableTypes dialogType = _getDialogType(field['type']);
      return InputEditable(
        icon: icon,
        title: title,
        defaultValue: defaultValue,
        dialogType: dialogType,
        onChanged: (v) {},
      );
    }
  }

  FormEditableTypes _getDialogType(String type) {
    switch (type) {
      case 'number':
        return FormEditableTypes.number;
      case 'url':
        return FormEditableTypes.url;

      default:
        return FormEditableTypes.string;
    }
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'security':
        return Icons.security;
      case 'http':
        return Icons.http;

      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Config'),
        actions: const [],
      ),
      body: ListView(
        children: [
          const ProfileName(),
          for (var group in profile_template[0]['groups'])
            GroupForm(
              title: group['name'],
              children: [
                for (var field in group['fields']) buildField(field),
              ],
            ),
        ],
      ),
    );
  }
}
