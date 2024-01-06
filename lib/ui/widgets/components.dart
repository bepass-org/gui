import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomSwitchListTile({super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomSwitchListTileState createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      value: widget.value,
      onChanged: widget.onChanged,
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final ThemeData themeData;

  const CustomTextField({super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    controller.text = hint;
    Color hintColor = themeData.colorScheme.onSurface.withOpacity(0.6);
    Color inputColor =
        themeData.colorScheme.onSurface; // Adjust this color as needed

    return Container(
      color: themeData.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(fontWeightDelta: 3, fontSizeDelta: 2),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: controller,
                style: Theme.of(context).textTheme.titleSmall!.apply(
                      fontWeightDelta: 2,
                      color: inputColor,
                    ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: hint,
                  hintStyle: TextStyle(color: hintColor), // Set hint text color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.colorScheme.onSurface,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeData.colorScheme.primary,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomIntegerField extends StatefulWidget {
  final String title;
  final int defaultInput;
  final TextEditingController controller;
  final ThemeData themeData;

  const CustomIntegerField({super.key,
    required this.title,
    required this.defaultInput,
    required this.controller,
    required this.themeData,
  });

  @override
  _CustomIntegerFieldState createState() => _CustomIntegerFieldState();
}

class _CustomIntegerFieldState extends State<CustomIntegerField> {
  @override
  Widget build(BuildContext context) {
    widget.controller.text = widget.defaultInput.toString();

    return Container(
      color: widget.themeData.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextField(
          controller: widget.controller,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .apply(fontWeightDelta: 2, fontSizeDelta: 2),
          decoration: InputDecoration(
            labelText: widget.title,
            labelStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .apply(fontWeightDelta: 3, fontSizeDelta: 2),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.themeData.colorScheme.onSurface, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.themeData.colorScheme.primary, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              widget.controller.text = int.parse(value).toString();
            });
          },
        ),
      ),
    );
  }
}

class CustomMultilineField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final ThemeData themeData;

  const CustomMultilineField({super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeData.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextField(
          decoration: InputDecoration(
            labelText: title,
            hintText: hint,
            hintStyle: TextStyle(
              color: themeData.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          controller: controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ),
    );
  }
}



class CustomCheckboxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckboxListTile({super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
