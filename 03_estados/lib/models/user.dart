class User {
  final String name;
  final int age;
  final List<String> professions;

  User({this.name, this.age, this.professions});

  User copyWith({String name, int age, List<String> professions}){
    // método que retorna una copia de este usuario, pero cambiando
    // los parámetros(opcionales) que se le pasen.
    return new User(
      name: name ?? this.name,
      age: age ?? this.age,
      professions: professions ?? this.professions
    );
  }

}