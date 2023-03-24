import 'package:flutter/material.dart';

import '../screens/cours/ajout_cours_screen.dart';
import '../screens/ecole/ajout_ecole_screen.dart';
import '../screens/cours/cours_list_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'Gestion Ecoles / Cours',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTiBu7ih5yWa86YUkM9REAaeM0ACHWDz9VeA&usqp=CAU"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: const Text('Liste des cours'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CoursListScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: const Text('Ajouter un cours'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AjoutCoursScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: const Text('Ajouter une école'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AjoutEcoleScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
