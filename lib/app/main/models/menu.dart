import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chronometer/app/main/counter/counter_screen.dart';

typedef PushScreen = void Function(Widget widget);

class Menu {
  int _id = 0;
  String _name = '';
  List<MenuOption> _options = List<MenuOption>.empty();

  Menu(this._id, this._name, this._options);

  //Data Encapsulation
  int get id => _id;
  String get name => _name;
  List<MenuOption> get options => _options;

  set name(String name) =>
      (_name = name.length >= 30 ? name.substring(0, 30) : name);
  set options(List<MenuOption> options) => _options = options;

  // Create iterator map from model
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = _name;
    map['options'] = _options;

    if (_id != 0) map['_id'] = _id;

    return map;
  }

  /// Funtion that transform dynamic obj to MenuOption
  Menu.fromObject(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _options = obj['options'];
  }

  /// Function that render screen by menu option
  void renderScreen(MenuOption option, PushScreen pushScreen) {
    if (_name == 'Counter') {
      pushScreen((option.name == 'Global')
          ? CouterScreenWithGlobalState()
          : CouterScreenWithLocalState());
    }
  }

  Widget? buildBlocGlobal(
      MenuOption option, Bloc? bloc, BlocWidgetBuilder builder) {
    final Widget? widget;

    if (option.isGlobal) {
      switch (_name) {
        case 'Counter':
          widget = BlocBuilder(bloc: bloc, builder: builder);
          break;
        default:
          widget = null;
          break;
      }
    } else {
      widget = null;
    }

    return widget;
  }
}

class MenuOption {
  int _id = 0;
  String _name = '';
  bool _isGlobal = false;

  MenuOption(this._id, this._name, [this._isGlobal = false]);

  //Data Encapsulation
  int get id => _id;
  String get name => _name;
  bool get isGlobal => _isGlobal;

  set name(String name) =>
      (_name = name.length >= 30 ? name.substring(0, 30) : name);
  set isGlobal(bool isGlobal) => _isGlobal = isGlobal;

  // Create iterator map from model
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = _name;
    map['isGlobal'] = _isGlobal;

    if (_id != 0) map['_id'] = _id;

    return map;
  }

  /// Funtion that transform dynamic obj to MenuOption
  MenuOption.fromObject(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _isGlobal = obj['isGlobal'];
  }
}
