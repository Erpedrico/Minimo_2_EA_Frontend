import 'dart:async';
import 'package:flutter/material.dart';

class TimerService extends ChangeNotifier {
  Timer? _timer;
  int _elapsedMinutes = 0;

  TimerService() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _elapsedMinutes++;
      if (_elapsedMinutes % 1 == 0) {
        _notifyUser();
      }
    });
  }

  void _notifyUser() {
    // Notificar cambios a los listeners
    notifyListeners();
  }

  void resetTimer() {
    _elapsedMinutes = 0;
  }

  int get elapsedMinutes => _elapsedMinutes;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
