import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:home_loan_plan/models/plan.dart';
import 'package:home_loan_plan/provider/plan/plan_extension.dart';
import 'package:home_loan_plan/screen/plan_detail.dart/plan_detail_page.dart';
import 'package:home_loan_plan/shared/dialog/hlp_create_plan.dart';
import 'package:home_loan_plan/shared/hlp_button.dart';
import 'package:home_loan_plan/shared/plan_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.fetchPlanList();
    });
  }

  @override
  Widget build(BuildContext context) {
    log('plans ${ref.planList}', name: this.runtimeType.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "appName".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ref.planList.isEmpty
            ? GestureDetector(onTap: onCreatePlan, child: Image.asset('assets/images/empty-box.png'))
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: <Widget>[
                  ...ref.planList
                      .map(
                        (e) => InkWell(
                          onTap: () => onNavigateToPlanDetail(e),
                          child: Slidable(
                            child: PlanWidget(plan: e),
                            endActionPane: ActionPane(
                              extentRatio: 0.6,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  flex: 1,
                                  borderRadius: BorderRadius.circular(12),
                                  onPressed: (context) async {
                                    await ref.removePlanById(e.id);
                                  },
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  icon: CupertinoIcons.pencil,
                                  label: 'Edit'.tr(),
                                ),
                                SlidableAction(
                                  flex: 1,
                                  borderRadius: BorderRadius.circular(12),
                                  onPressed: (context) async {
                                    await ref.removePlanById(e.id);
                                  },
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  icon: CupertinoIcons.delete_solid,
                                  label: 'Delete'.tr(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: HlpButton(
            topLeftBorder: true,
            bottomLeftBorder: true,
            bottomRightBorder: true,
            topRightBorder: true,
            label: "createPlanBtn".tr(),
            color: Colors.blueGrey.shade600,
            onPress: onCreatePlan,
          ),
        ),
      ),
    );
  }

  onCreatePlan() async {
    final resultInfo = await HLPCreatePlanDialog.onShow(context);

    log(resultInfo.toString());
    if (resultInfo != null) {
      final resultPlanCreate = await ref.createPlan(resultInfo, 20000);

      if (resultPlanCreate != null) {
        onNavigateToPlanDetail(resultPlanCreate);
      }
    }
  }

  void onNavigateToPlanDetail(Plan plan) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanDetailPage(
          plan: plan,
        ),
      ),
    );
  }
}
