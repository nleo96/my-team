import 'dart:convert';

import '../core/core.dart';
import 'values/email.dart';
import 'values/id.dart';
import 'values/name.dart';

class Person with Serialization {
  Id<Person> id;

  Name name;

  DateTime birthDate;

  int get age => Age.from(birthDate);

  EmailAddress email;

  String? _nickname;

  String? get nickname => _nickname;

  set nickname(String? value) {
    if (value != null && value.isEmpty) {
      throw ArgumentError.value(
        value,
        'value',
        'The nickname should be null or a not empty string',
      );
    }
    _nickname = value;
  }

  Person({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.email,
    String? nickname,
  }) {
    this.nickname = nickname;
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: Id<Person>(map['id']),
      name: Name(
        first: map['firstName'],
        middle: map['middleName'] ?? '',
        last: map['lastName'],
      ),
      birthDate: DateTime.parse(map['birthDate']),
      email: EmailAddress(map['email']),
      nickname: map['nickname'],
    );
  }

  factory Person.fromJSON(String source) => Person.fromMap(json.decode(source));

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id.toInt(),
      'firstName': name.first,
      'middleName': name.middle,
      'lastName': name.last,
      'fullName': name.full,
      'birthDate': birthDate.toIso8601String(),
      'age': age,
      'email': email.toString(),
      'nickname': _nickname,
    };
  }
}
