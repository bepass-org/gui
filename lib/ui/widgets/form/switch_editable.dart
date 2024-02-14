import 'package:flutter/material.dart';

class SwitchEditable extends StatefulWidget {
  const SwitchEditable({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final bool value;
  final Function(bool) onChanged;

  @override
  _SwitchEditableState createState() => _SwitchEditableState();
}

class _SwitchEditableState extends State<SwitchEditable> {
  late bool _internalValue;

  @override
  void initState() {
    super.initState();
    _internalValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon),
      title: Text(widget.title),
      trailing: Switch(
        value: _internalValue,
        onChanged: (bool newValue) {
          setState(() {
            _internalValue = newValue;
          });
          widget.onChanged(newValue);
        },
      ),
    );
  }
}
