import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _obscureLoginPass = true, _obscureRegisterPass = true, _obscureConfirmPass = true;
  bool _isLoginProcess = false, _isRegisterProcess = false;

  bool get obscureLoginPass => _obscureLoginPass;
  bool get isLoginProcess => _isLoginProcess;
  bool get obscureRegisterPass => _obscureRegisterPass;
  bool get obscureConfirmPass => _obscureConfirmPass;
  bool get isRegisterProcess => _isRegisterProcess;

  set obscureLoginPass(bool val) {
    _obscureLoginPass = val;
    notifyListeners();
  }

  set isLoginProcess(bool val) {
    _isLoginProcess = val;
    notifyListeners();
  }

  set obscureRegisterPass(bool val) {
    _obscureRegisterPass = val;
    notifyListeners();
  }

  set obscureConfirmPass(bool val) {
    _obscureConfirmPass = val;
    notifyListeners();
  }

  set isRegisterProcess(bool val) {
    _isRegisterProcess = val;
    notifyListeners();
  }
}