import 'package:shared_preferences/shared_preferences.dart';
import 'package:chronometer/app/main/interfaces/index.dart';
import 'package:chronometer/app/main/models/index.dart';

class PreferencesRepository implements IPreferencesRepository {
  static const String _themeIndexKey = 'theme';
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  @override
  Future<Theme?> getTheme() async {
    final prefs = await _pref;
    final index = prefs.getInt(_themeIndexKey);

    return index != null ? Theme.values[index] : null;
  }

  @override
  Future<void> setTheme(Theme theme) async {
    final prefs = await _pref;

    await prefs.setInt(_themeIndexKey, theme.index);
  }
}
