import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String? hintt;
  String? validation;
  TextInputType? keyboardtype;

  int maxleanthh;

  CustomTextField(
      {Key? key,
      this.validation,
      required this.controller,
      this.hintt,
      this.keyboardtype,
      required this.maxleanthh})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardtype,
      maxLength: widget.maxleanthh,
      controller: widget.controller,
      decoration: new InputDecoration(
        border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey)),
        hintText: widget.hintt,
        suffixStyle: const TextStyle(color: Colors.grey),
        counterText: '',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validation;
        }
        return null;
      },
    );
  }
}
