import 'package:defacto/enums/form_editable_types.dart';
import 'package:flutter/material.dart';

class SelectEditable extends StatefulWidget {
  const SelectEditable({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.defaultValue = '',
    this.hint,
    required this.dialogType,
    required this.onChanged,
    required this.options,
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
  final List? options;

  @override
  _SelectEditableState createState() => _SelectEditableState();
}

class _SelectEditableState extends State<SelectEditable> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value ?? widget.defaultValue;
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
      trailing: DropdownButton(
        value: _selectedValue,
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (String? newValue) {
          setState(() {
            _selectedValue = newValue!;
          });
          widget.onChanged(newValue!);
        },
        items: widget.options?.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
