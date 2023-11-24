import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:home_loan_plan/extensions/number_extension.dart';
import 'package:home_loan_plan/models/plan.dart';
import 'package:home_loan_plan/provider/plan/plan_extension.dart';
import 'package:home_loan_plan/shared/hlp_scrollable_all_direction.dart';
import 'package:home_loan_plan/shared/hlp_textfield.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlanDetailPage extends StatefulHookConsumerWidget {
  final Plan plan;
  const PlanDetailPage({
    super.key,
    required this.plan,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends ConsumerState<PlanDetailPage> {
  late Plan _planEditor;

  late PageController _controller;
  int currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    _planEditor = widget.plan.copyWith();

    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    log('widget.plan.planYearList ${widget.plan.planYearList.length}');
    return Scaffold(
      appBar: AppBar(
        title: Text(_planEditor.name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(ref.calculatePlan(_planEditor));
            },
            icon: const Icon(
              Icons.done,
            ),
          )
        ],
        bottom: _planEditor.planYearList.isEmpty
            ? null
            : PreferredSize(
                preferredSize: const Size(double.infinity, 60),
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...widget.plan.planYearList
                          .asMap()
                          .map(
                            (i, e) => MapEntry(
                              i,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.animateToPage(i,
                                        duration: Duration(milliseconds: 300), curve: Curves.linear);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(
                                    'ปีที่ ${e.periodNo.toString()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: currentPage == i ? FontWeight.bold : FontWeight.normal,
                                      fontSize: currentPage == i ? 18 : 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .values
                          .toList()
                    ],
                  ),
                ),
              ),
      ),
      body: PageView.builder(
        itemCount: _planEditor.planYearList.length,
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final _plan = _planEditor.planYearList[index];
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                HlpScrollableAllDirection(
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List<int>.generate(_plan.planMonthList.length, (i) => i).map((i) {
                          var planMonth = _plan.planMonthList[i];
                          return Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  alignment: Alignment.center,
                                  child: Text(planMonth.periodNo.toString()),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 120,
                                  child: Text(planMonth.totalPrice.toCurrencyDisplay()),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 120,
                                  child: HLPTextField(
                                    labelText: '',
                                    initialValue: planMonth.installmentPrice.toCurrencyDisplay(),
                                    onChanged: (val) {
                                      _plan.planMonthList[i].installmentPrice = double.parse(val);
                                    },
                                    onFocusChanged: (val) {
                                      setState(() {
                                        _planEditor = ref.reCalculatePlan(_planEditor);
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Container(
                                  width: 120,
                                  child: Text(planMonth.interestPercent.toHLPNumber()),
                                ),
                                Container(
                                  width: 120,
                                  child: Text(planMonth.interestPrice.toCurrencyDisplay()),
                                ),
                                Container(
                                  width: 120,
                                  child: Text(planMonth.deductionOfPrincipalPrice.toCurrencyDisplay()),
                                ),
                                Container(
                                  width: 120,
                                  child: Text(planMonth.outstandingDebtBalance.toCurrencyDisplay()),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
