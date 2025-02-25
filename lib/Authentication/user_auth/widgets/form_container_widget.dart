

import 'package:flutter/material.dart';


class FormContainerWidget extends StatefulWidget {

  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String ? errorText;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  const FormContainerWidget({
    this.errorText,
    this.controller,
    this.isPasswordField,
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType
  });


  @override
  _FormContainerWidgetState createState() => new _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {

  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.black,
              width: 2
            )
          ),
          child: new TextFormField(
            style: TextStyle(color: Colors.black),
            controller: widget.controller,
            keyboardType: widget.inputType,
            key: widget.fieldKey,
            obscureText: widget.isPasswordField == true? _obscureText : false,
            onSaved: widget.onSaved,
            validator: widget.validator,
            onFieldSubmitted: widget.onFieldSubmitted,
            decoration: new InputDecoration(
              filled: true,
              errorText: widget.errorText,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.black45),
              suffixIcon: new GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child:
                widget.isPasswordField==true? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? Colors.blue : Colors.grey,) : Text(""),
              ),
            ),
          ),
      ),
    );
  }
}
