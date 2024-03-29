import 'dart:io';

import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/ui/screens/main/about.dart';
import 'package:defacto/ui/screens/main/configuration.dart';
import 'package:defacto/ui/screens/main/logs.dart';
import 'package:defacto/ui/screens/main/routing.dart';
import 'package:defacto/ui/screens/main/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../widgets/main_drawer.dart';


class SkeletonScreen extends ConsumerWidget {
  const SkeletonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppPage currentPage = ref.watch(globalStateProvider).activePage;

    Widget getPageWidget(AppPage page) {
      switch (page) {
        case AppPage.configuration:
          return const ConfigurationScreen();
        case AppPage.routingAndRules:
          return const RoutingScreen();
        case AppPage.settings:
          return const SettingsScreen();
        case AppPage.logs:
          return const LogsScreen();
        case AppPage.about:
          return const AboutScreen();
        // Add more cases for additional pages
        default:
          return const ConfigurationScreen();
      }
    }

    return getPageWidget(currentPage);

  }
}
class BasePage extends StatelessWidget {
   AppBar? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Key? scaffoldKey;
  final List<Widget>? actions;

  BasePage({required this.appBar,required this.body,this.backgroundColor,this.scaffoldKey,
  this.floatingActionButtonLocation,this.floatingActionButton,this.bottomNavigationBar,
  this.actions});

  Widget WindowsUI(BuildContext context){
    return Row(
      children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0,2),
                  spreadRadius: 2,
                  blurRadius: 3
                ),
              ]
            ),
            child: MainDrawer(),),

        Expanded(child: Column(
          children: [
            appBar!,
            Expanded(child: body!)
          ],
        ))
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: Platform.isAndroid==true? appBar:null,
      drawer:Platform.isAndroid==true? const MainDrawer():null,
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,


      body:Platform.isAndroid? body: WindowsUI(context),
    );
  }
}
