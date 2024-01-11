import 'dart:convert';

import 'package:defacto/models/profile.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/ui/skeleton/skeleton_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      performStartupOperations();
    });
  }

  void performStartupOperations() async {
    List<Profile> profiles = await loadFakeProfiles();
    ref.read(globalStateProvider.notifier).setAvailableProfiles(profiles);
    // After completing the tasks, navigate to the SkeletonScreen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SkeletonScreen()),
      );
    }
  }

  Future<List<Profile>> loadFakeProfiles() async {
    final String response = await rootBundle.loadString('assets/fake_data/profiles.json');
    final data = await json.decode(response) as List;
    return data.map((profileJson) => Profile.fromJson(profileJson)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show loading indicator
      ),
    );
  }
}