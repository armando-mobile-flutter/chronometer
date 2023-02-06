import 'package:chronometer/app/main/interfaces/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/models/index.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_event.dart';
import 'package:chronometer/app/main/blocs/preferences/preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final IPreferencesRepository _preferencesRepository;

  PreferencesBloc(
      {required IPreferencesRepository preferencesRepository,
      PreferencesState? initialState})
      : _preferencesRepository = preferencesRepository,
        super(initialState ?? PreferencesNotLoaded()) {
    on<LoadPreferences>((event, emit) async {
      final theme = await _preferencesRepository.getTheme();

      return (theme == null)
          ? emit(const PreferencesLoaded(theme: Theme.dart))
          : add(UpdateTheme(theme));
    });

    on<UpdateTheme>((event, emit) async {
      await _preferencesRepository.setTheme(event.theme);

      return emit(PreferencesLoaded(theme: event.theme));
    });
  }
}
