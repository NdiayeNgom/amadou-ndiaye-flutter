import 'package:flutter/material.dart';

import '../../models/cours.dart';
import '../screens/cours/cours_detail_screen.dart';

class CoursItem extends StatelessWidget {
  final Cours cours;
  const CoursItem({super.key, required this.cours});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          cours.title.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(cours.title),
      subtitle: Text('durée : ${cours.duration.toString()} H'),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            CoursDetailScreen.routeName,
            arguments: cours.id,
          );
        },
        icon: const Icon(
          Icons.navigate_next_sharp,
          color: Colors.green,
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          CoursDetailScreen.routeName,
          arguments: cours.id,
        );
      },
    );
  }
}
