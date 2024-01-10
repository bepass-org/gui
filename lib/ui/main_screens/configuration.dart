import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/ui/widgets/bottom_nav_bar.dart';
import 'package:defacto/ui/widgets/profile/add_profile.dart';
import 'package:defacto/ui/widgets/profile/more_options.dart';
import 'package:defacto/ui/widgets/configuration_tile.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class ConfigurationScreen extends ConsumerStatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  ConsumerState<ConfigurationScreen> createState() {
    return _ConfigurationScreen();
  }
}

class _ConfigurationScreen extends ConsumerState<ConfigurationScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalState = ref.watch(globalStateProvider);

    // Start the animation
    globalState.isConnectionActive
        ? _controller.forward()
        : _controller.reverse();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(_scaffoldKey.currentState!.isDrawerOpen){
          _scaffoldKey.currentState!.closeDrawer();
        }
        else{
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text("Bepass", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Ionicons.search, color: Colors.white),
            ),
            const AddProfile(),
            const MoreOptions(),
          ],
        ),
        drawer: const MainDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(
              bottom: globalState.isConnectionActive ? 0.0 : 10.0),
          // Adjust the value based on the height of your BottomNavigationBar
          child: FloatingActionButton(
            shape: const CircleBorder(),
            child: const Icon(Ionicons.paper_plane_outline),
            onPressed: () {
              ref
                  .read(globalStateProvider.notifier)
                  .isConnectionAlive(!globalState.isConnectionActive);
            },
          ),
        ),
        bottomNavigationBar: SizeTransition(
          sizeFactor: _animation,
          axisAlignment: -1.0,
          child: const BottomNavBar(),
        ),
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
      ),
    );
  }
}
