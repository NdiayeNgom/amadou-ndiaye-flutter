import 'dart:io';

class Ecole {
  final String id;
  final String nom;
  final String presentation;
  final File image;

  Ecole({
    required this.id,
    required this.nom,
    required this.presentation,
    required this.image,
  });
}
