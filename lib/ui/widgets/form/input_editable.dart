import 'package:defacto/enums/form_editable_types.dart';
import 'package:flutter/material.dart';

import 'editable_dialog.dart';

class InputEditable extends StatelessWidget {
  const InputEditable({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.defaultValue = '',
    this.hint,
    required this.dialogType,
    required this.onChanged,
    this.showTitleOnDialog = false,
  });

  final IconData icon;
  final String title;
  final String? value;
  final String defaultValue;
  final String? hint;
  final FormEditableTypes dialogType;
  final Function(String) onChanged;
  final bool showTitleOnDialog;

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditableDialog(
          title: showTitleOnDialog ? 'Edit $title' : null,
          type: dialogType,
          currentValue: value ?? defaultValue,
          placeholder: hint ?? 'Enter $title',
          onSuccess: onChanged,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayText = defaultValue;
    if (value != null && value!.isNotEmpty) {
      displayText = value!;
    } else if (hint != null && hint!.isNotEmpty && defaultValue.isEmpty) {
      displayText = hint!;
    }

    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(displayText),
      onTap: () => _showEditDialog(context),
    );
  }
}