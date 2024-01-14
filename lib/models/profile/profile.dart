class Profile {
  String id;
  String type;
  String name;
  Map<String, dynamic> fields;
  double totalUploadTraffic;
  final String uploadMeasureUnit;
  double totalDownloadTraffic;
  final String downloadMeasureUnit;

  Profile({
    required this.id,
    required this.type,
    required this.name,
    required this.fields,
    required this.uploadMeasureUnit,
    required this.downloadMeasureUnit,
    this.totalUploadTraffic = 0,
    this.totalDownloadTraffic = 0,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      fields: json['fields'],
      totalUploadTraffic: json['uploadTraffic'],
      uploadMeasureUnit: json['uploadMeasureUnit'],
      totalDownloadTraffic: json['downloadTraffic'],
      downloadMeasureUnit: json['downloadMeasureUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'fields': fields,
      'uploadTraffic': totalUploadTraffic,
      'uploadMeasureUnit': uploadMeasureUnit,
      'downloadTraffic': totalDownloadTraffic,
      'downloadMeasureUnit': downloadMeasureUnit,
    };
  }

  Profile copyWith({
    double? uploadTraffic,
    double? downloadTraffic,
    String? uploadMeasureUnit,
    String? downloadMeasureUnit,
    String? name,
    Map<String, dynamic>? fields,
  }) {
    return Profile(
      id: id,
      type: type,
      name: name ?? this.name,
      fields: fields ?? this.fields,
      totalUploadTraffic: uploadTraffic ?? totalUploadTraffic,
      totalDownloadTraffic: downloadTraffic ?? totalDownloadTraffic,
      uploadMeasureUnit: uploadMeasureUnit ?? this.uploadMeasureUnit,
      downloadMeasureUnit: downloadMeasureUnit ?? this.downloadMeasureUnit,
    );
  }
}
