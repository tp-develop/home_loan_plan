import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_loan_plan/models/plan.dart';
import 'package:home_loan_plan/shared/hlp_button.dart';
import 'package:home_loan_plan/shared/hlp_textfield.dart';
import 'package:uuid/uuid.dart';

class HLPCreatePlanDialog {
  static Future<Plan?> onShow(BuildContext context) {
    String name = '';
    double totalLoanAmount = 0;
    double averageInterest = 0;
    double periodInstallment = 0;
    double averageInstallment = 0;

    return showDialog<Plan>(
      context: context,
      useSafeArea: false,
      builder: (context) {
        return Material(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SafeArea(
              child: Container(
                color: Colors.white,
                height: double.infinity,
                child: Center(
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  'Create Plan'.tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                HLPTextField(
                                  margin: EdgeInsets.only(top: 24),
                                  labelText: 'Name'.tr(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    name = value;
                                  },
                                ),
                                HLPTextField(
                                  margin: EdgeInsets.only(top: 12),
                                  labelText: 'Total loan amount'.tr(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                  onChanged: (value) {
                                    totalLoanAmount = double.parse(value);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                                  ],
                                ),
                                HLPTextField(
                                  margin: EdgeInsets.only(top: 12),
                                  labelText: 'Average interest (%)'.tr(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                                  onChanged: (value) {
                                    averageInterest = double.parse(value);
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                                  ],
                                ),
                                HLPTextField(
                                  margin: EdgeInsets.only(top: 12),
                                  labelText: 'Period installments (total month)'.tr(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  onChanged: (value) {
                                    periodInstallment = double.parse(value);
                                  },
                                ),
                                HLPTextField(
                                  margin: EdgeInsets.only(top: 12),
                                  labelText: 'Average installments'.tr(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textInputType: TextInputType.number,
                                  onChanged: (value) {
                                    averageInstallment = double.parse(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: HlpButton(
                                      topLeftBorder: true,
                                      bottomLeftBorder: true,
                                      label: 'Cancel'.toUpperCase().tr(),
                                      color: Colors.blueGrey.shade200,
                                      onPress: () {
                                        Navigator.pop(
                                          context,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Expanded(
                                    child: HlpButton(
                                      topRightBorder: true,
                                      bottomRightBorder: true,
                                      label: 'CREATE'.tr(),
                                      color: Colors.blueGrey.shade600,
                                      onPress: () => Navigator.pop(
                                        context,
                                        Plan(
                                          id: const Uuid().v4(),
                                          name: name,
                                          averageInterest: averageInterest,
                                          totalPrice: totalLoanAmount,
                                          periodInstallment: periodInstallment,
                                          planYearList: [],
                                          averageInstallment: averageInstallment,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
