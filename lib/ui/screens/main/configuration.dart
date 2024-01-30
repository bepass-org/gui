import 'package:defacto/states/global/global_state.dart';
import 'package:defacto/ui/widgets/bottom_nav_bar.dart';
import 'package:defacto/ui/widgets/main_drawer.dart';
import 'package:defacto/ui/widgets/profile/add_profile.dart';
import 'package:defacto/ui/widgets/profile/more_options.dart';
import 'package:defacto/ui/widgets/profile/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../skeleton/skeleton_screen.dart';

class ConfigurationScreen extends ConsumerStatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  ConsumerState<ConfigurationScreen> createState() {
    return _ConfigurationScreen();
  }


  // var conf_app = AppBar(
  //   iconTheme: const IconThemeData(color: Colors.white),
  //   backgroundColor: Theme.of(context).colorScheme.primary,
  //   title: _isSearching
  //       ? TextField(
  //     controller: _searchController,
  //     decoration: const InputDecoration(
  //       hintText: 'Search...',
  //       hintStyle: TextStyle(color: Colors.white70),
  //       border: InputBorder.none,
  //     ),
  //     style: const TextStyle(color: Colors.white),
  //     onChanged: (value) {
  //       // Implement your search logic here
  //     },
  //   )
  //       : const Text("Bepass", style: TextStyle(color: Colors.white)),
  //   actions: [
  //     IconButton(
  //       onPressed: () {
  //         setState(() {
  //           _isSearching = !_isSearching;
  //         });
  //       },
  //       icon: Icon(
  //         _isSearching ? Icons.close : Ionicons.search,
  //         color: Colors.white,
  //       ),
  //     ),
  //     const AddProfile(),
  //     const MoreOptions(),
  //   ],
  // );
}

class _ConfigurationScreen extends ConsumerState<ConfigurationScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
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

  void _deleteProfile(String id) {
    final globalState = ref.watch(globalStateProvider);
    final profiles = globalState.availableProfiles;
    final index = profiles.indexWhere((profile) => profile.id == id);
    if (index >= 0) {
      final removedItem = profiles.removeAt(index);
      ref
          .read(globalStateProvider.notifier)
          .deleteProfileWithId(removedItem.id);
      _listKey.currentState!.removeItem(
        index,
        (context, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: Opacity(
              opacity: 0,
              child: ProfileWidget(
                profile: removedItem,
                activeProfileId: globalState.activeProfileId,
                onTap: () => ref
                    .read(globalStateProvider.notifier)
                    .setActiveProfileId(removedItem.id),
                onEdit: (){},
                onDelete: () => _deleteProfile(removedItem.id),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalState = ref.watch(globalStateProvider);

    // Start the animation
    globalState.isConnectionActive
        ? _controller.forward()
        : _controller.reverse();

    return PopScope(
      // WARNING: DO NOT USE WILLPOPSCOPE ITS DEPRECATED
      canPop: false,
      onPopInvoked: (didPop) {
        if (_scaffoldKey.currentState!.isDrawerOpen) {
          _scaffoldKey.currentState!.closeDrawer();
        } else if (_isSearching) {
          _cancelSearch();
        } else {
          SystemNavigator.pop();
        }
      },
      child: BasePage(
        scaffoldKey: _scaffoldKey,
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

        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.only(
            bottom: globalState.isConnectionActive ? 0.0 : 10.0,
          ),
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
          child: AnimatedList(
            key: _listKey,
            padding: const EdgeInsets.all(4),
            physics: const BouncingScrollPhysics(),
            initialItemCount: globalState.availableProfiles.length,
            itemBuilder: (context, index, animation) {
              final profile = globalState.availableProfiles[index];
              return ProfileWidget(
                profile: profile,
                activeProfileId: globalState.activeProfileId,
                onTap: () => ref
                    .read(globalStateProvider.notifier)
                    .setActiveProfileId(profile.id),
                onEdit: (){},
                onDelete: () => _deleteProfile(profile.id),
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

AppBar conf_app(BuildContext context,{required bool isSearching,var searchController}){
  return  AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: Theme.of(context).colorScheme.primary,
    title: isSearching
        ? TextField(
      controller: searchController,
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
          // setState(() {
          //   isSearching = !isSearching;
          // });
        },
        icon: Icon(
          isSearching ? Icons.close : Ionicons.search,
          color: Colors.white,
        ),
      ),
      const AddProfile(),
      const MoreOptions(),
    ],
  );
}