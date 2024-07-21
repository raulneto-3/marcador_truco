import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrucoProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Map pontos = {
    'Nós': 0,
    'Eles': 0,
  };

  void addPontos(String team, int value) {
    pontos[team] += value;
    notifyListeners();
  }

  void resetPontos() {
    pontos['Nós'] = 0;
    pontos['Eles'] = 0;
    notifyListeners();
  }

  bool _truco = false;

  bool get truco => _truco;

  void toggleTruco() {
    _truco = !_truco;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('truco', truco));
  }
}
