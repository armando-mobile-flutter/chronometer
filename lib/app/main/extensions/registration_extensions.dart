import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/extensions/bloc_building.dart';
import 'package:chronometer/app/main/blocs/index.dart';
import 'package:chronometer/app/main/interfaces/index.dart';

class RepositoryRegistration extends StatelessWidget {
  const RepositoryRegistration(
      {super.key, required this.blocBuilding, required this.child});
  final BlocBuilding blocBuilding;
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(providers: [
        RepositoryProvider<IPreferencesRepository>.value(
            value: blocBuilding.preferencesRepository!)
      ], child: child);
}

class BlocRegitration extends StatelessWidget {
  const BlocRegitration(
      {super.key, required this.blocBuilding, required this.child});
  final BlocBuilding blocBuilding;
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider<PreferencesBloc>.value(
            value: blocBuilding.preferencesBloc!),
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        BlocProvider<StopwatchBloc>(create: (context) => StopwatchBloc())
      ], child: child);
}
