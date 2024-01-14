// profile_name.dart name widget
import 'package:defacto/enums/form_editable_types.dart';
import 'package:defacto/ui/widgets/form/input_editable.dart';
import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({super.key, this.value});

  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputEditable(
          icon: Icons.person,
          title: 'Profile Name',
          value: value,
          defaultValue: '',
          hint: 'Enter Profile Name',
          dialogType: FormEditableTypes.string,
          onChanged: (value) {},
        ),
        const Divider(
          color: Colors.black26,
        ),
      ],
    );
  }
}