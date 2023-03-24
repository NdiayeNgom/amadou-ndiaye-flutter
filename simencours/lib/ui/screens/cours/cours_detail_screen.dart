import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cours_provider.dart';
import '../../../models/cours.dart';
import '../../widgets/app_drawer.dart';

class CoursDetailScreen extends StatelessWidget {
  static const routeName = '/detail-cours';

  const CoursDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Cours> coursList =
        Provider.of<CoursProvider>(context, listen: false).cours;
    final idCours = ModalRoute.of(context)!.settings.arguments as String;

    Cours cours = coursList.firstWhere((cours) => cours.id == idCours);

    return Scaffold(
      appBar: AppBar(
        title: Text(cours.title),
      ),
      drawer: const AppDrawer(),
      body: Container(),
    );
  }
}
