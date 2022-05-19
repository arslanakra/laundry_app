import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_app_ui/utils/constants.dart';

class InputWidget extends StatefulWidget {
  final String? hintText;

  final double height;
  final String topLabel;
  final bool obscureText;
  final TextEditingController? controller;
  TextInputType? type;
  List<TextInputFormatter>? format;
  InputWidget({
    this.hintText,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    this.controller,
    this.type,
    this.format
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.widget.topLabel),
        SizedBox(height: 5.0),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            keyboardType: widget.type,
            inputFormatters: widget.format,
            controller: widget.controller,
            obscureText: this.widget.obscureText,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(74, 77, 84, 0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.primaryColor,
                ),
              ),
              hintText: this.widget.hintText,
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Color.fromRGBO(105, 108, 121, 0.7),
              ),
            ),
          ),
        )
      ],
    );
  }
}
