import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
                  Theme.of(context).colorScheme.onBackground
                ],
                radius: 1,
                center: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Text(
                'Bepass',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sticky_note_2),
            title: const Text('Configuration'),
            onTap: () {
              ref.read(globalStateProvider.notifier).changeActivePage(AppPage.configuration);
            },
          ),
          ListTile(
            leading: const Icon(Icons.turn_right_outlined),
            title: const Text('Routing and rules'),
            onTap: () {
              ref.read(globalStateProvider.notifier).changeActivePage(AppPage.routingAndRules);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              ref.read(globalStateProvider.notifier).changeActivePage(AppPage.settings);
            },
          ),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Logs'),
            onTap: () {
              ref.read(globalStateProvider.notifier).changeActivePage(AppPage.logs);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_rounded),
            title: const Text('About'),
            onTap: () {
              ref.read(globalStateProvider.notifier).changeActivePage(AppPage.about);
            },
          ),
        ],
      ),
    );
  }
}