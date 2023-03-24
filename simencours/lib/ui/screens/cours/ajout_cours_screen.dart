import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/cours.dart';
import '../../widgets/app_drawer.dart';
import '../../../providers/cours_provider.dart';
import 'cours_list_screen.dart';

class AjoutCoursScreen extends StatefulWidget {
  static const routeName = '/ajout-cours';
  AjoutCoursScreen({super.key});

  @override
  _AjoutCoursScreenState createState() => _AjoutCoursScreenState();
}

class _AjoutCoursScreenState extends State<AjoutCoursScreen> {
  final _descriptionFocusNode = FocusNode();
  final _durationFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _ajoutCours = Cours(
    title: '',
    duration: 0,
    description: '',
  );

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _durationFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      await Provider.of<CoursProvider>(context, listen: false)
          .addCourse(_ajoutCours);
    } catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Une erreur s\'est produite !'),
          content: const Text('L\'enregistrement a echoué.'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    } finally {
      Navigator.of(context).pushReplacementNamed(CoursListScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter Un Cours'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Titre cours'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ajoutCours = Cours(
                    title: value!,
                    duration: 0,
                    description: '',
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Durée Cours'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _durationFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Donner la durée du cours.';
                  }

                  if (double.tryParse(value!) == null) {
                    return 'la durée doit être un nombre.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Merci de donner une durée supérieur à 0.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ajoutCours = Cours(
                    title: _ajoutCours.title,
                    duration: double.parse(value!),
                    description: '',
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Merci de donner une description.';
                  }
                  if (value!.length < 15) {
                    return 'La description doit avoir plus de 15 lettres.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ajoutCours = Cours(
                    title: _ajoutCours.title,
                    duration: _ajoutCours.duration,
                    description: value!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
