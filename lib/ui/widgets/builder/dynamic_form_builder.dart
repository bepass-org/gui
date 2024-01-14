import 'package:flutter/material.dart';

class DynamicFormBuilder extends StatelessWidget {
  const DynamicFormBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      /*children: template.templateFields.map((field) {
        switch (field.type) {
          case 'string':
            return TextFormField(
              decoration: InputDecoration(labelText: field.name),
              // ... other properties ...
            );
          case 'number':
            return TextFormField(
              decoration: InputDecoration(labelText: field.name),
              keyboardType: TextInputType.number,
              // ... other properties ...
            );
          case 'boolean':
            return SwitchListTile(
              title: Text(field.name),
              // ... other properties ...
            );
          // ... handle other types ...
          default:
            return SizedBox.shrink(); // For unhandled field types
        }
      }).toList(),*/
    );
  }
}
