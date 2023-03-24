import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cours {
  final String? id;
  final String title;
  final String description;
  final double duration;

  Cours({
    this.id,
    required this.title,
    required this.description,
    required this.duration,
  });

  Cours copyWith({
    String? id,
    String? title,
    String? description,
    double? duration,
    bool? isValided,
  }) {
    return Cours(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
    };
  }

  String toJson() => json.encode(toMap());
}
