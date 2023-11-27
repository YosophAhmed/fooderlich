import 'package:flutter/material.dart';
import 'models.dart';

class ProfileManger extends ChangeNotifier {
  var _didSelectUser = false;
  var _tapOnRaywenderlich = false;
  var _darkMode = false;

  bool get didSelectUser => _didSelectUser;
  bool get tapOnRaywendelich => _tapOnRaywenderlich;
  bool get darkMode => _darkMode;
  User get getUser => User(
        firstName: 'Stef',
        lastName: 'Patt',
        role: 'Flutterista',
        profileImageUrl: 'assets/profile_pics/person_stef.jpeg',
        points: 100,
        darkMode: _darkMode,
      );

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  void tapOnRaywenderlich(bool selected) {
    _tapOnRaywenderlich = selected;
    notifyListeners();
  }

  void tapOnProfile(bool selected) {
    _didSelectUser = selected;
    notifyListeners();
  }
}
