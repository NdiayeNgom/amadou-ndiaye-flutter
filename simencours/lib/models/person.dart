class Person {
  final String email;
  final String password;
  //final String? imageURL;
  Person({
    required this.email,
    required this.password,
    //this.imageURL,
  });

  Person copyWith({
    String? email,
    String? password,
    //String? imageURL,
  }) {
    return Person(
      email: email ?? this.email,
      password: password ?? this.password,
      //imageURL: imageURL ?? this.imageURL,
    );
  }

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      email: map['email'],
      password: map['password'],
      //imageURL: map['profile_path'],
    );
  }
}
