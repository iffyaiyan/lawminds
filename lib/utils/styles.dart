import 'package:flutter/material.dart';

class Styles {
  static InputDecoration outlineTextField({String? label, String? hint, String? error, Widget? suffixIcon, Color? fillColor, Widget? prefixIcon}) => InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.indigo, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 0.5),
      borderRadius: BorderRadius.circular(4),
    ),
    labelText: label,
    hintText: hint,
    errorText: error,
    suffixIcon: suffixIcon,
    fillColor: fillColor,
    filled: fillColor != null,
    prefixIcon: prefixIcon,
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );

  static ButtonStyle primaryElevatedButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    disabledBackgroundColor: Colors.indigo.shade400,
    disabledForegroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 15,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}