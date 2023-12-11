import 'package:flutter/material.dart';
import 'package:projeto/_comum/minhas_cores.dart';

InputDecoration getAuthenticationInputDecoration(String Label) {
  return InputDecoration(
    hintText: Label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(64),
      borderSide: BorderSide(
        color: MinhasCores.roxoescuro,
        width: 4,
      ),
    ),
  );
}
