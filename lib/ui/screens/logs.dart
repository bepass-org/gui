import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_sweep),
          ),
        ],
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
