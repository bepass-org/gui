import 'package:defacto/enums/form_editable_types.dart';
import 'package:defacto/helpers/material_icons.dart';
import 'package:defacto/ui/widgets/form/input_editable.dart';
import 'package:defacto/ui/widgets/form/switch_editable.dart';
import 'package:flutter/material.dart';

Widget buildField(Map<String, dynamic> field) {
  String title = field['name'];
  String defaultValue = field['defaultValue'].toString();
  String description = field['description'].toString();
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
      hint: description,
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
  return MaterialIconHelper.stringToIconData(iconName);
}
