import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_loan_plan/models/dto/staff.dto.dart';
import 'package:home_loan_plan/models/plan.dart';

class AuthNotifier extends StateNotifier<Staff?> {
  AuthNotifier() : super(null);

  setCurrentStaff(Staff staff) {
    state = staff;
  }

  logout() {
    state = null;
  }
}
