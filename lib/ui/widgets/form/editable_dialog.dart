import 'package:flutter/material.dart';
import 'package:defacto/enums/form_editable_types.dart';
import 'package:flutter/services.dart';

class EditableDialog extends StatefulWidget {
  final String? title;
  final FormEditableTypes type;
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      buttonPadding: EdgeInsets.zero,
      actionsPadding: const EdgeInsets.all(0),
    );
  }

  Widget _buildDialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.title != null) const SizedBox(height: 20),
        if (widget.title != null) Text(widget.title!, style: Theme.of(context).textTheme.bodyLarge),
        _buildDialogForm(),
      ],
    );
  }

  Widget _buildDialogForm() {
    switch (widget.type) {
      case FormEditableTypes.string:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
        );
      case FormEditableTypes.number:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
          ],
        );
      case FormEditableTypes.multiline:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        );
      case FormEditableTypes.numberRange:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9,-]'))
          ],
        );
      case FormEditableTypes.ip:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'([0-9a-fA-F:.])'))
          ],
        );
      case FormEditableTypes.port:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        );
      case FormEditableTypes.domain:
        return TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: widget.placeholder),
          keyboardType: TextInputType.url,
        );
      case FormEditableTypes.url:
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
