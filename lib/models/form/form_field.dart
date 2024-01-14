import 'package:defacto/enums/form_editable_types.dart';
import 'package:defacto/helpers/material_icons.dart';
import 'package:flutter/material.dart';

class FormField {
  final String id;
  final String name;
  final FormEditableTypes type;
  final IconData icon;
  final String description;
  final String defaultValue;

  FormField({
    required this.id,
    required this.name,
    required this.type,
    required this.icon,
    required this.description,
    required this.defaultValue,
  });

  static FormEditableTypes stringToFieldType(String str) {
    for (FormEditableTypes type in FormEditableTypes.values) {
      if (type.toString().split('.').last == str) {
        return type;
      }
    }
    return FormEditableTypes.string; // or throw an exception, based on how you want to handle unknown values
  }

  factory FormField.fromJson(Map<String, dynamic> json) {
    return FormField(
      id: json['id'],
      name: json['name'],
      type: stringToFieldType(json['type']),
      icon: MaterialIconHelper.stringToIconData(json['icon']),
      description: json['description'],
      defaultValue: json['defaultValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'icon': icon,
      'description': description,
      'defaultValue': defaultValue,
    };
  }
}