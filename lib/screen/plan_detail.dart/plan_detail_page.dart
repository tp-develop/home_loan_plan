import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_loan_plan/extensions/number_extension.dart';
import 'package:home_loan_plan/models/plan.dart';
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.plan.planYearList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.plan.name),
          bottom: widget.plan.planYearList.isEmpty
              ? null
              : TabBar(
                  isScrollable: true,
                  tabs: [
                    ...widget.plan.planYearList
                        .map(
                          (e) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: Text(
                              'ปีที่ ${e.periodNo.toString()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList()
                  ],
                ),
        ),
        body: TabBarView(
          children: [
            ...widget.plan.planYearList.map(
              (e) {
                return HlpScrollableAllDirection(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...List<int>.generate(e.planMonthList.length, (i) => i).map((i) {
                        var planMonth = e.planMonthList.elementAt(i);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              alignment: Alignment.center,
                              child: Text(planMonth.periodNo.toString()),
                            ),
                            Container(
                              width: 120,
                              child: Text(planMonth.totalPrice.toHLPNumber()),
                            ),
                            Container(
                              width: 120,
                              child: HLPTextField(
                                context,
                                labelText: '',
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Text(planMonth.interestPercent.toHLPNumber()),
                            ),
                            Container(
                              width: 120,
                              child: Text(planMonth.interestPrice.toHLPNumber()),
                            ),
                            Container(
                              width: 120,
                              child: Text(planMonth.deductionOfPrincipalPrice.toHLPNumber()),
                            ),
                            Container(
                              width: 120,
                              child: Text(planMonth.outstandingDebtBalance.toHLPNumber()),
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                );
                // return GridView.count(
                //   primary: false,
                //   padding: const EdgeInsets.all(20),
                //   crossAxisSpacing: 10,
                //   scrollDirection: Axis.vertical,
                //   mainAxisSpacing: 10,
                //   crossAxisCount: 7,
                //   children: [

                //   ],
                // );
              },
            ).toList()
          ],
        ),
      ),
    );
  }
}
