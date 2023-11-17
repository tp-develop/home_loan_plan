// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Customer extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String personalId;

  @HiveField(4)
  String phoneNumber;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.personalId,
    required this.phoneNumber,
  });
}
