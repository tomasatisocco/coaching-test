// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  const UserDataModel({
    this.isPaid = false,
    this.isRead = false,
    this.id,
    this.authId,
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

  final String? id;
  final String? name;
  final String? email;
  final String? birthDate;
  final String? nationality;
  final String? residence;
  final String? certificateDate;
  final DateTime? createdAt;
  final String? authId;
  final List<String>? testIds;
  final Status? status;
  final String? subscription;
  final bool isPaid;
  final bool isRead;

  factory UserDataModel.newUser({
    required String authId,
    required DateTime createdAt,
    required String email,
    String? name,
    String? birthDate,
  }) {
    return UserDataModel(
      authId: authId,
      createdAt: createdAt,
      email: email,
      name: name,
      birthDate: birthDate,
      status: Status.registered,
    );
  }

  UserDataModel completeUser({
    required String name,
    required String nationality,
    required String residence,
    required String certificateDate,
    required String birthDate,
  }) {
    return copyWith(
      name: name,
      nationality: nationality,
      residence: residence,
      certificateDate: certificateDate,
      status: Status.infoCompleted,
      birthDate: birthDate,
    );
  }

  UserDataModel copyWith({
    String? id,
    String? name,
    String? email,
    String? birthDate,
    String? nationality,
    String? residence,
    String? certificateDate,
    DateTime? createdAt,
    String? authId,
    List<String>? testIds,
    Status? status,
    String? subscription,
    bool? isPaid,
    bool? isRead,
  }) {
    return UserDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      nationality: nationality ?? this.nationality,
      residence: residence ?? this.residence,
      certificateDate: certificateDate ?? this.certificateDate,
      authId: authId ?? this.authId,
      createdAt: createdAt ?? this.createdAt,
      testIds: testIds ?? this.testIds,
      status: status ?? this.status,
      subscription: subscription ?? this.subscription,
      isPaid: isPaid ?? this.isPaid,
      isRead: isRead ?? this.isRead,
    );
  }

  // id is not included in toMap() because it is the document id
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'authId': authId,
      'name': name,
      'email': email,
      'birthDate': birthDate,
      'nationality': nationality,
      'residence': residence,
      'certificateDate': certificateDate,
      'createdAt': createdAt.toString(),
      'testIds': testIds,
      'status': status?.index,
      'subscription': subscription,
      'isPaid': isPaid,
      'isRead': isRead,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    if (map['createdAt'] == null) {
      map['createdAt'] = Timestamp.fromDate(DateTime(2023, 7));
    }
    return UserDataModel(
      id: map['id'] as String?,
      authId: map['authId'] as String?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      birthDate: map['birthDate'] as String?,
      nationality: map['nationality'] as String?,
      residence: map['residence'] as String?,
      certificateDate: map['certificateDate'] as String?,
      createdAt: map['createdAt'] is String
          ? DateTime.tryParse(map['createdAt'] as String)
          : (map['createdAt'] as Timestamp).toDate(),
      testIds:
          (map['testIds'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      status:
          map['status'] == null ? null : Status.values[map['status'] as int],
      subscription: map['subscription'] as String?,
      isPaid: map['isPaid'] as bool? ?? false,
      isRead: map['isRead'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '''
      UserDataModel(
        authId: $authId,
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
        isRead: $isRead,
      )
    ''';
  }

  @override
  List<Object?> get props => [
        id,
        authId,
        email,
        name,
        birthDate,
        nationality,
        residence,
        certificateDate,
        createdAt,
        testIds,
        status,
        subscription,
        isPaid,
        isRead,
      ];
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
