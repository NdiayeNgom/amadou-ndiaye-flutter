import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';

class EcoleListScreen extends StatefulWidget {
  static const routeName = "/ecoles";
  const EcoleListScreen({super.key});

  @override
  State<EcoleListScreen> createState() => _EcoleListScreenState();
}

class _EcoleListScreenState extends State<EcoleListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Ecole"),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Text('Affichage liste  des cours '),
      ),
    );
  }
}
