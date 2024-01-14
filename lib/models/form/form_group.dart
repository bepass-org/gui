import 'form_field.dart';

class FormGroup {
  final String id;
  final String name;
  final String description;
  final bool showTitle;
  final bool showBottomDivider;
  final List<FormField> fields;

  FormGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.showTitle,
    required this.showBottomDivider,
    required this.fields,
  });

  factory FormGroup.fromJson(Map<String, dynamic> json) {
    var fieldsJson = json['fields'] as List;
    List<FormField> fields = fieldsJson.map((fieldJson) => FormField.fromJson(fieldJson)).toList();

    return FormGroup(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      showTitle: json['showTitle'],
      showBottomDivider: json['showBottomDivider'],
      fields: fields,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'fields': fields.map((field) => field.toJson()).toList(),
    };
  }
}