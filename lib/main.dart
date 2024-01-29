import 'dart:io';

import 'package:defacto/ui/screens/main/Loading_screen.dart';
import 'package:defacto/ui/screens/main/about.dart';
import 'package:defacto/ui/screens/main/configuration.dart';
import 'package:defacto/ui/screens/main/logs.dart';
import 'package:defacto/ui/screens/main/routing.dart';
import 'package:defacto/ui/screens/main/settings.dart';
import 'package:defacto/ui/screens/skeleton/skeleton_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'config/theme_provider.dart';
import 'config/styles.dart';

/// Try using const constructors as much as possible!

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  final Directory tmpDir = await getTemporaryDirectory();
  await Hive.initFlutter(tmpDir.path);
  await Hive.openBox('prefs');

  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('de'),
        ],
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  Styles styles = Styles();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifer = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Bepass',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      theme: styles.themeData(themeNotifer.themeIndex, context),
      routes: {
        '/loading': (context) => const LoadingScreen(),
        '/': (context) => const SkeletonScreen(),
        '/configuration': (context) => const ConfigurationScreen(),
        '/routingAndRules': (context) => const RoutingScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/logs': (context) => const LogsScreen(),
        '/about': (context) => const AboutScreen(),
      },
      onGenerateRoute: (settings) {
        // todo: rework routing
        // If the route is not found, just get moved to the loading screen
        return MaterialPageRoute(builder: (context) => const LoadingScreen());
      },
    );
  }
}
