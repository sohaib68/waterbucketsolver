import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomIntTextField extends StatelessWidget {
  final bool? autoFocus;
  final String? label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  const CustomIntTextField({Key? key, this.autoFocus, this.label, this.controller, this.focusNode, this.nextFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextField(
      key: key,
      autofocus: autoFocus ?? false,
      focusNode: focusNode,
      controller: controller,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.primaryColor, width: 0.7), borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(nextFocus);
      },
    );
  }
}
