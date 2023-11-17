// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:home_loan_plan/models/dto/staff.dto.dart';
import 'package:home_loan_plan/models/request/load_staff_account_request.dart';
import 'package:home_loan_plan/models/request/login_request.dart';
import 'package:home_loan_plan/models/request/logout_request.dart';
import 'package:home_loan_plan/provider/auth/ab_auth_repository.dart';

final Provider<ABAuthRepository> authRepositoryProvider = Provider<HiveDBAuthRepository>(
  (ref) {
    throw UnimplementedError();
  },
);

class HiveDBAuthRepository extends ABAuthRepository {
  List<Box> boxCollection;

  HiveDBAuthRepository({
    required this.boxCollection,
  });

  @override
  Future<Staff?> login(LoginRequest request) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<List<Staff>?> loadStaff(LoadStaffAccountRequest request) {
    // TODO: implement loadStaff
    throw UnimplementedError();
  }

  @override
  Future<bool> logout(LogoutRequest request) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
