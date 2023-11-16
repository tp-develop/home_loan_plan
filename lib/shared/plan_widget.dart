import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_loan_plan/models/plan.dart';

class PlanWidget extends StatelessWidget {
  final Plan plan;
  const PlanWidget({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(plan.name),
      ),
    );
  }
}
