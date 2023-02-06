import 'package:flutter/material.dart';
import 'package:chronometer/app/main/shared/screen/index.dart';
import 'package:chronometer/app/main/extensions/bloc_building.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var blocBuilding = BlocBuilding.initialize();

  blocBuilding.useDelegates();
  blocBuilding.runWithPrefereces(App());
}
