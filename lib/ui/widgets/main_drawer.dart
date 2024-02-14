import 'dart:io';

import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/widgets/connection_timer_state.dart';
import 'bottom_nav_bar.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  Widget DesktopFooter(String timer_value) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 25,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          // timer text
          Text(
            timer_value,
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalState = ref.watch(timer_state_notifier);
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Platform.isWindows || Platform.isLinux
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context)
                          .primaryColor, // Customize the header color
                ),
                child: Platform.isWindows || Platform.isLinux
                    ? BottomNavBar()
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Bepass",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        )),
              ),
              Expanded(
                  child: Container(
                child: Column(
                  children: [
                    buildDrawerItem(context, ref, AppPage.configuration,
                        Icons.sticky_note_2, 'Configuration'),
                    buildDrawerItem(context, ref, AppPage.routingAndRules,
                        Icons.turn_right_outlined, 'Routing and rules'),
                    buildDrawerItem(context, ref, AppPage.settings,
                        Icons.settings, 'Settings'),
                    buildDrawerItem(
                        context, ref, AppPage.logs, Icons.bug_report, 'Logs'),
                    buildDrawerItem(context, ref, AppPage.about,
                        Icons.info_rounded, 'About'),
                  ],
                ),
              )),
              if (Platform.isWindows) DesktopFooter(globalState)
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildDrawerItem(BuildContext context, WidgetRef ref, AppPage page,
      IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        ref.read(globalStateProvider.notifier).setActivePage(page);
      },
    );
  }
}
