import 'package:defacto/helpers/profile_helper.dart';
import 'package:defacto/models/profile/profile.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/ui/screens/skeleton/skeleton_screen.dart';
import 'package:flutter/material.dart';
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
    List<Profile> profiles = await ProfileHelper.loadFakeProfiles();
    ref.read(globalStateProvider.notifier).setAvailableProfiles(profiles);
    // After completing the tasks, navigate to the SkeletonScreen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  SkeletonScreen()),
      );
    }
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