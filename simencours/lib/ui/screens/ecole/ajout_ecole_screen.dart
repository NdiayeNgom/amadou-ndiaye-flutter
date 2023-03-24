import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/ecole_provider.dart';
import '../../widgets/image_picker_field.dart';

class AjoutEcoleScreen extends StatefulWidget {
  static const routeName = '/ajout-ecole';

  @override
  _AjoutEcoleScreenState createState() => _AjoutEcoleScreenState();
}

class _AjoutEcoleScreenState extends State<AjoutEcoleScreen> {
  final _nomController = TextEditingController();
  final _presentationController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveEcole() {
    if (_nomController.text.isEmpty ||
        _presentationController.text.isEmpty ||
        _pickedImage == null) {
      return;
    }

    Provider.of<EcoleProvider>(context, listen: false).addEcole(
        _nomController.text, _presentationController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter Une nouvelle ecole'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Nom Ecole'),
                    controller: _nomController,
                  ),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Présentation Ecole'),
                    controller: _presentationController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImagePickerField(_selectImage),
                ],
              ),
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.save_alt),
              label: Text('Enregister l\'école'),
              onPressed: _saveEcole,
            ),
          ),
        ],
      ),
    );
  }
}
