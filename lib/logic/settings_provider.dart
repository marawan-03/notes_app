import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsProvider with ChangeNotifier {
  final Box _box = Hive.box('settings');
  late bool _isGrid;

  SettingsProvider() {
    _isGrid = _box.get('isGrid', defaultValue: true);
  }

  bool get isGrid => _isGrid;

  void toggleView() {
    _isGrid = !_isGrid;
    notifyListeners();
    _box.put('isGrid', _isGrid);
  }
}