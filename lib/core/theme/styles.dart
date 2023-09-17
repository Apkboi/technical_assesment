import 'package:flutter/material.dart';
import 'package:technical_assesment/core/constants/app_colors.dart';

InputDecoration outlinedTextFieldDecoration = InputDecoration(
  filled: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),

  border: OutlineInputBorder(
      gapPadding: 2,

      borderSide: const BorderSide(color: grey1),
      borderRadius: BorderRadius.circular(10)),
);

final errorBorder = OutlineInputBorder(
    gapPadding: 2,
    borderSide: const BorderSide(
      color: Colors.red,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(10));
