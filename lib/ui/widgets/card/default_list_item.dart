import 'package:flutter/material.dart';

class DefaultListItem extends StatefulWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onClick;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String? title;
  // Retain the existing 'body' property for backward compatibility
  final String? body;
  // Introduce a new property for Widget body
  final Widget? bodyWidget;
  final String? additionalInput;
  final bool addDivider;

  const DefaultListItem({
    super.key,
    this.padding,
    this.margin,
    this.onClick,
    this.prefixWidget,
    this.suffixWidget,
    this.title,
    this.body,
    this.bodyWidget,
    this.additionalInput,
    this.addDivider = false,
  });

  @override
  State<DefaultListItem> createState() => _DefaultListItemState();
}

class _DefaultListItemState extends State<DefaultListItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 8),
        margin: widget.margin,
        child: Row(
          children: [
            widget.prefixWidget ?? const SizedBox.shrink(),
            if (widget.prefixWidget != null) const SizedBox(width: 26),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.title != null)
                    Center(
                      child: Text(
                        widget.title!,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  if (widget.addDivider) const SizedBox(height: 4),
                  if (widget.addDivider)
                    Divider(color: Theme.of(context).colorScheme.secondary),
                  if (widget.additionalInput != null)
                    Text(
                      widget.additionalInput!,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                    ),
                  // Conditionally display either the String body or the Widget body
                  if (widget.body != null)
                    Text(
                      widget.body!,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: const Color(0xff605b5b)),
                    ),
                  // Render the widget body if it is provided
                  if (widget.bodyWidget != null)
                    widget.bodyWidget!,
                ],
              ),
            ),
            widget.suffixWidget ?? const SizedBox(width: 26),
            widget.suffixWidget ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
