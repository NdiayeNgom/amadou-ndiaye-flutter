import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/ecole.dart';

class EcoleProvider with ChangeNotifier {
  List<Ecole> _ecoles = [];

  List<Ecole> get ecoles {
    return [..._ecoles];
  }

  void addEcole(
    String ecoleNom,
    String ecolePresentation,
    File imageEcole,
  ) {
    final newEcole = Ecole(
      id: DateTime.now().toString(),
      image: imageEcole,
      nom: ecoleNom,
      presentation: ecolePresentation,
    );
    _ecoles.add(newEcole);
    notifyListeners();
  }
}
