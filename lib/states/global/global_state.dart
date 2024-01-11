import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/models/global_state.dart';
import 'package:defacto/models/profile.dart';
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
    state = state.copyWith(isConnectionActive: isAlive);
  }

  void setActivePage(AppPage activePage) {
    state = state.copyWith(activePage: activePage);
  }

  void setActiveProfileId(String activeProfileId) {
    state = state.copyWith(activeProfileId: activeProfileId);
  }

  void setAvailableProfiles(List<Profile> availableProfiles) {
    state = state.copyWith(availableProfiles: availableProfiles);
  }

  void updateProfileTraffic(String profileId, double upload, double download) {
    var updatedProfiles = state.availableProfiles.map((profile) {
      if (profile.id == profileId) {
        return profile.copyWith(uploadTraffic: upload, downloadTraffic: download);
      }
      return profile;
    }).toList();
    state = state.copyWith(availableProfiles: updatedProfiles);
  }

  void startFakeTrafficGenerator() {
    // Implement logic to periodically update traffic for the active profile
  }
}

final globalStateProvider =
    StateNotifierProvider<GlobalStateNotifier, GlobalState>((ref) {
  return GlobalStateNotifier();
});
