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
    on<LoadPreferences>(_onLoadPreferences);
    on<UpdateTheme>(_onUpdateTheme);
  }

  Future<void> _onLoadPreferences(
      LoadPreferences event, Emitter<PreferencesState> emit) async {
    final theme = await _preferencesRepository.getTheme();

    if (theme == null) {
      emit(const PreferencesLoaded(theme: Theme.dart));
    } else {
      add(UpdateTheme(theme));
    }
  }

  Future<void> _onUpdateTheme(
      UpdateTheme event, Emitter<PreferencesState> emit) async {
    await _preferencesRepository.setTheme(event.theme);

    emit(PreferencesLoaded(theme: event.theme));
  }
}
