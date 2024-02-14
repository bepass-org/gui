import 'package:defacto/enums/form_editable_types.dart';
import 'package:flutter/material.dart';

import 'editable_dialog.dart';

class InputEditable extends StatefulWidget {
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

  @override
  _InputEditableState createState() => _InputEditableState();
}

class _InputEditableState extends State<InputEditable> {
  late String _internalValue;

  @override
  void initState() {
    super.initState();
    _internalValue = widget.value ?? widget.defaultValue;
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditableDialog(
          title: widget.showTitleOnDialog ? 'Edit ${widget.title}' : null,
          type: widget.dialogType,
          currentValue: _internalValue,
          placeholder: widget.hint ?? 'Enter ${widget.title}',
          onSuccess: (newValue) {
            setState(() {
              _internalValue = newValue;
            });
            widget.onChanged(newValue);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayText = widget.defaultValue;
    if (widget.value != null && widget.value!.isNotEmpty) {
      displayText = widget.value!;
    } else if (widget.hint != null &&
        widget.hint!.isNotEmpty &&
        widget.defaultValue.isEmpty) {
      displayText = widget.hint!;
    }

    return ListTile(
      leading: Icon(widget.icon),
      title: Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(displayText),
      onTap: () => _showEditDialog(context),
    );
  }
}
