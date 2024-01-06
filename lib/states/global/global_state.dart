import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/models/global_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalStateNotifier extends StateNotifier<GlobalState> {
  GlobalStateNotifier()
      : super(const GlobalState(
          isConnectionActive: false,
          activePage: AppPage.configuration,
        ));

  void isConnectionAlive(bool isAlive) {
    state = GlobalState(isConnectionActive: isAlive, activePage: state.activePage);
  }

  void changeActivePage(AppPage activePage) {
    state = GlobalState(isConnectionActive: state.isConnectionActive, activePage: activePage);
  }
}

final globalStateProvider =
    StateNotifierProvider<GlobalStateNotifier, GlobalState>((ref) {
  return GlobalStateNotifier();
});
