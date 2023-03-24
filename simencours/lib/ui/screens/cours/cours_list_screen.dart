import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_drawer.dart';
import '../../widgets/cours_list.dart';
import '../../../providers/cours_provider.dart';

class CoursListScreen extends StatefulWidget {
  static const routeName = "/cours";
  const CoursListScreen({super.key});

  @override
  State<CoursListScreen> createState() => _CoursListScreenState();
}

class _CoursListScreenState extends State<CoursListScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CoursProvider>(context).getAllCours().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Cours"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : CoursList(),
    );
  }
}
