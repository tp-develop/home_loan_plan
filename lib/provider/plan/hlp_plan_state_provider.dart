import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_loan_plan/models/plan.dart';

class HLPPlanStateProvider extends StateNotifier<List<Plan>> {
  // We initialize the list of todos to an empty list

  HLPPlanStateProvider() : super([]);

  // Let's allow the UI to add todos.
  void addPlan(Plan todo) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, todo];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  void addPlanList(List<Plan> planList) {
    state = [...planList];
  }

  // Let's allow removing todos
  void removePlan(String todoId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }
}
