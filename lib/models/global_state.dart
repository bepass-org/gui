import 'package:defacto/enums/app_pages.dart';

class GlobalState {
  const GlobalState({
    required this.isConnectionActive,
    required this.activePage,
  });

  final bool isConnectionActive;
  final AppPage activePage;
}
