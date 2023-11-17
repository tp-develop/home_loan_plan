import 'package:home_loan_plan/models/dto/staff.dto.dart';
import 'package:home_loan_plan/models/dto/customer.dart';
import 'package:home_loan_plan/models/request/load_staff_account_request.dart';
import 'package:home_loan_plan/models/request/login_request.dart';
import 'package:home_loan_plan/models/request/logout_request.dart';

abstract class ABAuthRepository {
  Future<Staff?> login(LoginRequest request);

  Future<bool> logout(LogoutRequest request);

  Future<List<Staff>?> loadStaff(LoadStaffAccountRequest request);
}
