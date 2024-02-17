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
    return TextField(
      autofocus: autoFocus ?? false,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
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
          suffixIcon:
              IconButton(icon: const Icon(Icons.close_outlined), iconSize: 20, onPressed: () => controller?.clear())),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
      onSubmitted: (_) {
        FocusScope.of(context).requestFocus(nextFocus);
      },
    );
  }
}
