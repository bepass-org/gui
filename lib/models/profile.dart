class Profile {
  String id;
  String type;
  Map<String, dynamic> fields;

  Profile({
    required this.id,
    required this.type,
    required this.fields,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      type: json['type'],
      fields: json['fields'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'fields': fields,
    };
  }
}