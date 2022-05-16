import 'package:faker/faker.dart';

class User{
  final String id;
  final String name;
  final String email;
  final int age;
  Autos autos;

  User({
    required this.id, 
    required this.name, 
    required this.email, 
    required this.age,
    required this.autos,
  });

  static User fakeUser(){
    final String id = DateTime.now().microsecondsSinceEpoch.toString();
    final String name = faker.person.name();
    final String email = faker.internet.email();
    final int age = RandomGenerator().integer(100, min: 18);
    final bool auto = random.boolean();

    return User(
      id: id, 
      name: name, 
      email: email, 
      age: age,
      autos: Autos(
        ferrari: auto, 
        toyota: auto,
      )
    );
  }

  static User fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"], 
      name: json["name"], 
      email: json["email"], 
      age: json["age"],
      autos: Autos.fromJson(json["autos"])
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id"   : id,
      "name" : name,
      "email": email,
      "age"  : age,
      "autos": autos.toJson()
    };
  }

}

class Autos {

  final bool ferrari;
  final bool toyota;

  Autos({
    required this.ferrari,
    required this.toyota,
  });

  static Autos fromJson(Map<String, dynamic> json){
    return Autos(
      ferrari: json["ferrari"],
      toyota: json["toyota"],
    );
  }

  Map<String, dynamic> toJson() => {
      "ferrari": ferrari,
      "toyota": toyota,
  };
}