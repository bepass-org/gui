import 'package:flutter/material.dart';

class DefaultListItem extends StatefulWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String? title;
  final String? body;

  const DefaultListItem({super.key, this.padding, this.margin, this.prefixWidget, this.suffixWidget, this.title, this.body});

  @override
  State<DefaultListItem> createState() => _DefaultListItemState();
}

class _DefaultListItemState extends State<DefaultListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding??const EdgeInsets.symmetric(horizontal: 8),
      margin: widget.margin,
      child: Row(
        children: [
          widget.prefixWidget ?? const SizedBox.shrink(),
          if (widget.prefixWidget != null) const SizedBox(width: 22),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.title != null)
                  Text(
                    widget.title!,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                  ),
                if (widget.body != null)
                  Text(
                    widget.body!,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(color: const Color(0xff605b5b)),
                  ),
              ],
            ),
          ),
          widget.suffixWidget ?? const SizedBox(width: 22),
          widget.suffixWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
