import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class RoutingScreen extends StatelessWidget {
  const RoutingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Routing And Rules"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_road),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: const Center(
          child: Text("Routing And Rules"),
        ),
      ),
    );
  }
}
