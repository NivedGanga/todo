import 'package:flutter/material.dart';

class TodoModel {
  final String id;
  final String title;
  String? subtitle;
  DateTime? date;
  TimeOfDay? time;

  TodoModel(
      {required this.id,
      required this.title,
      this.date,
      this.subtitle,
      this.time});
}


//'${dateTime!.day.toString()}.${dateTime!.month.toString()}.${dateTime!.year.toString()}'