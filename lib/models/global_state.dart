import 'package:defacto/enums/app_pages.dart';
import 'package:defacto/models/profile.dart';

class GlobalState {
  const GlobalState({
    required this.isConnectionActive,
    required this.activePage,
    required this.availableProfiles,
    required this.activeProfileId,
  });

  final bool isConnectionActive;
  final AppPage activePage;
  final List<Profile> availableProfiles;
  final String activeProfileId;

  GlobalState copyWith({
    bool? isConnectionActive,
    AppPage? activePage,
    List<Profile>? availableProfiles,
    String? activeProfileId,
  }) {
    return GlobalState(
      isConnectionActive: isConnectionActive ?? this.isConnectionActive,
      activePage: activePage ?? this.activePage,
      availableProfiles: availableProfiles ?? this.availableProfiles,
      activeProfileId: activeProfileId ?? this.activeProfileId,
    );
  }
}
