// stateless widget group form
import 'package:flutter/material.dart';

class GroupForm extends StatelessWidget {
  const GroupForm({
    super.key,
    required this.title,
    required this.children,
    this.lastOne = false,
  });

  final String title;
  final List<Widget> children;
  final bool lastOne;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Text(""),
          title: Text(title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
        ),
        ...children,
        !lastOne
            ? const Divider(
                color: Colors.black26,
              )
            : const SizedBox(),
      ],
    );
  }
}
