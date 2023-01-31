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

  void printMenuAndOption(MenuOption option) {
    print("Menu: ${this._name}, option: ${option.name}");
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
