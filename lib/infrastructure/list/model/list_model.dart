import 'package:flutter/material.dart';
import 'package:todo/infrastructure/todos/model/todo_model.dart';

class ListModel {
  final String id;
  final String title;
  final ValueNotifier<List<TodoModel>> todoList = ValueNotifier([]);
  final ValueNotifier<List<TodoModel>> completedList = ValueNotifier([]);
  ListModel({required this.id, required this.title});
  @override
  String toString() {
    return 'id:$id title:$title';
  }
}
