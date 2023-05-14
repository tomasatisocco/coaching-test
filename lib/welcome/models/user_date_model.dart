// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDataModel {
  const UserDataModel({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.nationality,
    required this.residence,
    required this.certificateDate,
  });

  final String name;
  final String email;
  final String birthDate;
  final String nationality;
  final String residence;
  final String certificateDate;

  UserDataModel copyWith({
    String? name,
    String? email,
    String? birthDate,
    String? nationality,
    String? residence,
    String? certificateDate,
  }) {
    return UserDataModel(
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      nationality: nationality ?? this.nationality,
      residence: residence ?? this.residence,
      certificateDate: certificateDate ?? this.certificateDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'nationality': nationality,
      'residence': residence,
      'certificateDate': certificateDate,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      name: map['name'] as String,
      email: map['email'] as String,
      birthDate: map['birthDate'] as String,
      nationality: map['nationality'] as String,
      residence: map['residence'] as String,
      certificateDate: map['certificateDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '''
      UserDataModel(
        name: $name,
        email: $email,
        birthDate: $birthDate,
        nationality: $nationality,
        residence: $residence,
        certificateDate: $certificateDate,
      )
    ''';
  }
}
