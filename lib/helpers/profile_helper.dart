import 'dart:convert';

import 'package:defacto/models/profile/profile.dart';
import 'package:flutter/services.dart';

class ProfileHelper {
  static Future<List<Profile>> loadFakeProfiles() async {
    final String response = await rootBundle.loadString('assets/fake_data/profiles.json');
    final data = await json.decode(response) as List;
    return data.map((profileJson) => Profile.fromJson(profileJson)).toList();
  }
}