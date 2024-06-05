// Model class for eg4.dart
class Person {
  String name;
  int age;
  String email;
  Map<String,dynamic> address;

  Person({
    required this.name,
    required this.age,
    required this.email,
    required this.address,
  });

  // know how to load ourself from a JSON object
  factory Person.fromJson(Map<String,dynamic> json) {
    return Person(
      name: json['name'] as String,
      age: json['age'] as int,
      email: json['email'] as String,
      address: json['address'] as Map<String,dynamic>,
    );
  }

  // know how to serialize ourself to JSON
  Map<String,dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'email': email,
      'address': address,
    };
  }
}
