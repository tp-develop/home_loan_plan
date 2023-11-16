import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HLPTextField extends Container {
  String labelText;
  FormFieldValidator? validator;
  EdgeInsets? margin;
  ValueChanged<String>? onChanged;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatters;
  HLPTextField(
    BuildContext context, {
    required this.labelText,
    this.validator,
    this.margin,
    this.onChanged,
    this.textInputType,
    this.inputFormatters,
  }) : super(
          margin: margin,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelText,
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
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            validator: validator,
          ),
        );
}
