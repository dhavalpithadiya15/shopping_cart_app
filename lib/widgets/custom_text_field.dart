import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType textInputType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.validator,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        border:  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        contentPadding: const EdgeInsets.only(left: 20),
        label: Text(label),
      ),
    );
  }
}
