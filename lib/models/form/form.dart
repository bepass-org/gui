import 'form_group.dart';

class Form {
  final String id;
  final String name;
  final String description;
  final String version;
  final List<FormGroup> groups;

  Form({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.groups,
  });

  factory Form.fromJson(Map<String, dynamic> json) {
    var groupsJson = json['groups'] as List;
    List<FormGroup> groups = groupsJson.map((groupJson) => FormGroup.fromJson(groupJson)).toList();

    return Form(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      groups: groups,
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'version': version,
      'groups': groups.map((group) => group.toJson()).toList(),
    };
  }
}