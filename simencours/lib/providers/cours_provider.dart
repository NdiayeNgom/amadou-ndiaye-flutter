import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cours.dart';
import '../services/api.dart';

class CoursProvider with ChangeNotifier {
  String authToken = '';
  String userId = '';
  List<Cours> coursList = [];

  CoursProvider(this.authToken, this.userId, this.coursList);

  List<Cours> get cours => [...coursList];

  Future<void> getAllCours() async {
    final url = Uri.https(API.baseURL, '/cours.json', {'auth': authToken});
    print(url);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      final List<Cours> coursLoaded = [];
      print(extractedData);
      extractedData.forEach((coursId, coursData) {
        coursLoaded.add(Cours(
          id: coursId,
          title: coursData['title'],
          description: coursData['description'],
          duration: coursData['duration'],
        ));
      });
      coursList = coursLoaded;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addCourse(Cours cours) async {
    final url = Uri.https(API.baseURL, '/cours.json', {'auth': authToken});

    try {
      final response = await http.post(url, body: cours.toJson());
      final coursAdded = Cours(
          id: json.decode(response.body)['name'],
          title: cours.title,
          description: cours.description,
          duration: cours.duration);
      coursList.add(coursAdded);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
