import 'package:defacto/models/global_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalStateNotifier extends StateNotifier<GlobalState> {
  GlobalStateNotifier() : super(const GlobalState(isConnectionActive: false));

  void isConnectionAlive(bool isAlive) {
    state = GlobalState(isConnectionActive: isAlive);
  }
}

final globalStateProvider =
    StateNotifierProvider<GlobalStateNotifier, GlobalState>((ref) {
  return GlobalStateNotifier();
});