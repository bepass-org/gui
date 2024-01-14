import 'dart:convert';

import 'package:defacto/models/form/form.dart';
import 'package:flutter/services.dart';

class ProfileTemplateHelper {
  static Future<List<Form>> loadFakeProfileTemplates() async {
    final String response = await rootBundle.loadString('assets/fake_data/profile_template.json');
    final data = await json.decode(response) as List;
    return data.map((profileJson) => Form.fromJson(profileJson)).toList();
  }
}