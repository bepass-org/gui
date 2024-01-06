import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const MainDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: const Center(
          child: Text("Settings"),
        ),
      ),
    );
  }
}
