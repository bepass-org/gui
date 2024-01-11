import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/ui/widgets/bottom_nav_bar.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:defacto/ui/widgets/profile/add_profile.dart';
import 'package:defacto/ui/widgets/profile/more_options.dart';
import 'package:defacto/ui/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class ConfigurationScreen extends ConsumerStatefulWidget {
  const ConfigurationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConfigurationScreen> createState() {
    return _ConfigurationScreen();
  }
}

class _ConfigurationScreen extends ConsumerState<ConfigurationScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalState = ref.watch(globalStateProvider);

    // Start the animation
    globalState.isConnectionActive
        ? _controller.forward()
        : _controller.reverse();

    return WillPopScope(
      onWillPop: () async {
        if (_isSearching) {
          _cancelSearch();
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    // Implement your search logic here
                  },
                )
              : const Text("Bepass", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              },
              icon: Icon(
                _isSearching ? Icons.close : Ionicons.search,
                color: Colors.white,
              ),
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
          child: ListView.builder(
            padding: const EdgeInsets.all(4),
            physics: const BouncingScrollPhysics(),
            itemCount: globalState.availableProfiles.length,
            itemBuilder: (context, index) {
              final profile = globalState.availableProfiles[index];
              return Profile(
                title: profile.name,
                type: profile.type,
                isSelected: profile.id == globalState.activeProfileId,
                totalUploadTraffic: profile.totalUploadTraffic,
                uploadMeasureUnit: profile.uploadMeasureUnit,
                totalDownloadTraffic: profile.totalDownloadTraffic,
                downloadMeasureUnit: profile.downloadMeasureUnit,
                onTap: (String activeProfileId) {
                  ref
                      .read(globalStateProvider.notifier)
                      .setActiveProfileId(activeProfileId);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _cancelSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }
}
