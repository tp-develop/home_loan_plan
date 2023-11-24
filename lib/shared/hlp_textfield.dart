import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_loan_plan/extensions/number_extension.dart';

class HLPTextField extends StatefulWidget {
  String labelText;
  FormFieldValidator? validator;
  EdgeInsets? margin;
  String? initialValue;
  ValueChanged<String>? onChanged;
  ValueChanged<bool>? onFocusChanged;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatters;

  HLPTextField({
    Key? key,
    required this.labelText,
    this.validator,
    this.margin,
    this.onChanged,
    this.onFocusChanged,
    this.textInputType,
    this.inputFormatters,
    this.initialValue,
  }) : super(key: key);

  @override
  _HlpTextfieldState createState() => _HlpTextfieldState();
}

class _HlpTextfieldState extends State<HLPTextField> {
  FocusNode _focus = FocusNode();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focus.addListener(_onFocusChange);
    _controller.text = widget.initialValue ?? "";
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _onFocusChange() {
    // log("Focus: ${_focus.hasFocus.toString()}");

    if (_focus.hasFocus) {
      _controller.text = _controller.text.replaceAll(",", "");
    } else {
      _controller.text = double.parse(_controller.text).toCurrencyDisplay();
    }

    widget.onFocusChanged?.call(_focus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        controller: _controller,
        focusNode: _focus,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(
            // won't be used if the state-specific arguments are defined
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: OutlineInputBorder(
            //<-- SEE HERE
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        keyboardType: widget.textInputType,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        validator: widget.validator,
      ),
    );
  }
}
