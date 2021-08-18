import 'package:flutter/material.dart';

GestureDetector dropDownList({name, call}) {
  return GestureDetector(child: ListTile(title: Text(name)), onTap: () => call());
}
