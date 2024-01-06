import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      drawer: const MainDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: const Center(
          child: Text("About"),
        ),
      ),
    );
  }
}
