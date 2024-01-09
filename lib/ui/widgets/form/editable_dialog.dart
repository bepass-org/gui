import 'package:flutter/material.dart';
import 'package:defacto/enums/editable_dialog_types.dart';
import 'package:flutter/services.dart';

class EditableDialog extends StatefulWidget {
  final String? title;
  final EditableDialogType type;
  final String? currentValue;
  final String placeholder;
  final Function(String) onSuccess;

  const EditableDialog({
    super.key,
    this.title,
    required this.type,
    this.currentValue,
    required this.placeholder,
    required this.onSuccess,
  });

  @override
  State<StatefulWidget> createState() => _EditableDialogState();
}

class _EditableDialogState extends State<EditableDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? 'Edit Value'),
      content: _buildDialogContent(),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            widget.onSuccess(_controller.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _buildDialogContent() {
    switch (widget.type) {
      case EditableDialogType.string:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
        );
      case EditableDialogType.number:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        );
      case EditableDialogType.multiline:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        );
      case EditableDialogType.numberRange:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,-]'))],
        );
      case EditableDialogType.ip:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.text,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'([0-9a-fA-F:.])'))],
        );
      case EditableDialogType.port:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        );
      case EditableDialogType.domain:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.url,
        );
      case EditableDialogType.url:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.url,
        );
      default:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
        );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}