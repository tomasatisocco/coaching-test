// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class UserDataModel {
  const UserDataModel({
    this.id,
    this.createdAt,
    this.name,
    this.email,
    this.birthDate,
    this.nationality,
    this.residence,
    this.certificateDate,
    this.testIds,
    this.status,
    this.subscription,
  });

  final String? name;
  final String? email;
  final String? birthDate;
  final String? nationality;
  final String? residence;
  final String? certificateDate;
  final DateTime? createdAt;
  final String? id;
  final List<String>? testIds;
  final Status? status;
  final Subscription? subscription;

  factory UserDataModel.newUser({
    required String id,
    required DateTime createdAt,
    required String email,
    String? name,
    String? birthDate,
  }) {
    return UserDataModel(
      id: id,
      createdAt: createdAt,
      email: email,
      name: name,
      birthDate: birthDate,
      status: Status.registered,
      subscription: Subscription.none,
    );
  }

  UserDataModel completeUser({
    required String name,
    required String nationality,
    required String residence,
    required String certificateDate,
  }) {
    return copyWith(
      name: name,
      nationality: nationality,
      residence: residence,
      certificateDate: certificateDate,
      status: Status.infoCompleted,
    );
  }

  UserDataModel copyWith({
    String? name,
    String? email,
    String? birthDate,
    String? nationality,
    String? residence,
    String? certificateDate,
    DateTime? createdAt,
    String? id,
    List<String>? testIds,
    Status? status,
    Subscription? subscription,
  }) {
    return UserDataModel(
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      nationality: nationality ?? this.nationality,
      residence: residence ?? this.residence,
      certificateDate: certificateDate ?? this.certificateDate,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      testIds: testIds ?? this.testIds,
      status: status ?? this.status,
      subscription: subscription ?? this.subscription,
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
      'createdAt': createdAt,
      'testIds': testIds,
      'status': status?.index,
      'subscription': subscription?.index,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    if (map['createdAt'] == null) {
      map['createdAt'] = Timestamp.fromDate(DateTime(2023, 7));
    }
    return UserDataModel(
      name: map['name'] as String?,
      email: map['email'] as String?,
      birthDate: map['birthDate'] as String?,
      nationality: map['nationality'] as String?,
      residence: map['residence'] as String?,
      certificateDate: map['certificateDate'] as String?,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      testIds: map['testIds'] as List<String>?,
      status:
          map['status'] == null ? null : Status.values[map['status'] as int],
      subscription: map['subscription'] == null
          ? null
          : Subscription.values[map['subscription'] as int],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '''
      UserDataModel(
        id: $id,
        name: $name,
        email: $email,
        birthDate: $birthDate,
        nationality: $nationality,
        residence: $residence,
        certificateDate: $certificateDate,
        createdAt: $createdAt,
        testIds: $testIds,
        status: $status,
        subscription: $subscription,
      )
    ''';
  }
}

enum Status {
  registered,
  infoCompleted,
  testPaid,
  testStarted,
  testCompleted,
  resultsSending,
  resultsSent,
}

enum Subscription {
  none,
  basic,
  premium,
  mensual,
  anual,
}
