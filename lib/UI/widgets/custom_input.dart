// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({
    Key? key,
    required this.title,
    required this.controller,
    required this.inputType,
    this.isRequired = false,
    this.isActive = true,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final TextInputType inputType;
  bool? isActive;
  bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        enabled: isActive,
        // onChanged: onChange,
        keyboardType: inputType,
        validator: isRequired!
            ? (_) {
                if (_!.isEmpty) {
                  return "Por favor ingrese este campo";
                }
                if (title == "Documento") {
                  if (_.length < 7 || _.length > 11) {
                    return "Por favor ingrese un número valido";
                  }
                }

                if (title == "Número telefónico") {
                  if (_.length < 10) {
                    return "Por favor ingrese un número valido";
                  }
                }
              }
            : null,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: title),
      ),
    ));
  }
}
