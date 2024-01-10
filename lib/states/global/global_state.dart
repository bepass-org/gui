import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/models/global_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalStateNotifier extends StateNotifier<GlobalState> {
  GlobalStateNotifier()
      : super(const GlobalState(
          isConnectionActive: false,
          activePage: AppPage.configuration,
          availableProfiles: [],
          activeProfileId: '',
        ));

  void isConnectionAlive(bool isAlive) {
    state = state.copyWith(isConnectionActive: true);
  }

  void setActivePage(AppPage activePage) {
    state = state.copyWith(activePage: activePage);
  }

  void setActiveProfileId(String activeProfileId) {
    state = state.copyWith(activeProfileId: activeProfileId);
  }
}

final globalStateProvider =
    StateNotifierProvider<GlobalStateNotifier, GlobalState>((ref) {
  return GlobalStateNotifier();
});
