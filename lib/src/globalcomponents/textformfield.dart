import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masterlink/utilities/colors.dart';

class ErrorBuilder {
  String? urlError;
  String? aliasError;
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueSetter<String?>? onChanged;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? labelText;
  final String? errorText;
  final Widget? suffix;
  const CustomTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.maxLength,
    this.inputFormatters,
    this.labelText,
    this.errorText,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.disabled,
        buildCounter: (context,
            {required currentLength, required isFocused, maxLength}) {
          return maxLength != null ? Text("$currentLength/$maxLength") : null;
        },
        style: GoogleFonts.roboto(),
        decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            errorStyle: TextStyle(color: kPrimaryColor),
            labelText: labelText,
            suffixIcon: suffix,
            labelStyle: const TextStyle(),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(3))),
      ),
    );
  }
}
