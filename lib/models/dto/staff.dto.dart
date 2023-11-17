// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'staff.dto.g.dart';

@HiveType(typeId: 1)
class Staff extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String branchId;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String personalId;

  @HiveField(5)
  String password;

  @HiveField(6)
  String username;

  Staff({
    required this.id,
    required this.branchId,
    required this.firstName,
    required this.lastName,
    required this.personalId,
    required this.password,
    required this.username,
  });

  @override
  String toString() {
    return 'Staff(id: $id, branchId: $branchId, firstName: $firstName, lastName: $lastName, personalId: $personalId, password: $password, username: $username)';
  }
}
