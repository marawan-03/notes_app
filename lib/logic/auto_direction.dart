import 'package:flutter/material.dart';

bool isArabic(String text) {
  final match = RegExp(r'[A-Za-z\u0600-\u06FF]').firstMatch(text);
  if (match == null) return false;
  return RegExp(r'[\u0600-\u06FF]').hasMatch(match.group(0)!);
}

TextDirection directionOf(String text) =>
    isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
