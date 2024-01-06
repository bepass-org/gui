import 'package:defacto/ui/widgets/bottom_nav_bar.dart';
import 'package:defacto/ui/widgets/configuration_tile.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:defacto/ui/screens/new_configuration.dart';

class SkeletonScreen extends ConsumerWidget {
  const SkeletonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bepass"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewConfigurationPage()),
              );
            },
            icon: const Icon(Icons.note_add),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        child: const Icon(Ionicons.paper_plane_outline),
        onPressed: () {},
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Material(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          padding: const EdgeInsets.all(4),
          physics: const BouncingScrollPhysics(),
          children: const [
            ConfigurationTile(
              title: "MCI",
              subTitle: "Cloudflare worker",
              isSelected: true,
            ),
            ConfigurationTile(
              title: "Irancell",
              subTitle: "Standalone server",
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }
}
