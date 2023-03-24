import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/cours.dart';
import './cours_item.dart';
import '../../providers/cours_provider.dart';

class CoursList extends StatelessWidget {
  const CoursList({super.key});

  @override
  Widget build(BuildContext context) {
    final coursData = Provider.of<CoursProvider>(context);

    List<Cours> coursList = coursData.cours;

    Future<void> _refreshCours(BuildContext context) async {
      await Provider.of<CoursProvider>(context, listen: false).getAllCours();
    }

    return RefreshIndicator(
      onRefresh: () => _refreshCours(context),
      child: ListView.builder(
        itemCount: coursList.length,
        itemBuilder: (context, index) => Container(
          child: CoursItem(
            cours: coursList[index],
          ),
        ),
      ),
    );
  }
}
