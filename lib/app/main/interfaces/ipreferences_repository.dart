import 'package:chronometer/app/main/models/index.dart';

abstract class IPreferencesRepository {
  Future<void> setTheme(Theme theme);
  Future<Theme> getTheme();
}
