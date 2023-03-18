import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:todo/infrastructure/todos/model/todo_model.dart';
import 'package:todo/infrastructure/user/model/user_model.dart';

class TodosRepo {
  TodosRepo._internal();
  static TodosRepo instance = TodosRepo._internal();

  factory TodosRepo() {
    return instance;
  }

  addTodo(
      {required TodoModel todo,
      required ListModel listModel,
      required context}) async {
    await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('todos')
        .collection(listModel.title)
        .doc(todo.id)
        .set({
      'id': todo.id,
      'title': todo.title,
      'subtitle': todo.subtitle,
      'date': todo.date.toString(),
      'time':
          todo.time == null ? null : '${todo.time!.hour}:${todo.time!.minute}',
    });
    final tempList = listModel.todoList.value.reversed.toList();
    tempList.add(todo);
    listModel.todoList.value = tempList.reversed.toList();
    listModel.todoList.notifyListeners();
  }

  getTodos({required ListModel listModel}) async {
    final listRespo = await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('todos')
        .collection(listModel.title)
        .get();
    getCompletedTodos(listModel: listModel);
    final documentList = listRespo.docs;
    List<Map<String, dynamic>> dataList = documentList.map((documentSnapshot) {
      return documentSnapshot.data();
    }).toList();
    listModel.todoList.value.clear();
    listModel.todoList.notifyListeners();
    final _datalist = dataList.map((e) {
      return TodoModel(
        id: e['id'],
        title: e['title'],
        subtitle: e['subtitle'],
        date: e['date'] != null && e['date'] != 'null'
            ? DateTime.parse(e['date'])
            : null,
        time: e['time'] == null
            ? null
            : TimeOfDay(
                hour: int.parse(e['time'].split(":")[0]),
                minute: int.parse(e['time'].split(":")[1])),
      );
    }).toList();
    listModel.todoList.value = _datalist.reversed.toList();
    listModel.todoList.notifyListeners();
  }

  completedATask({required TodoModel todo, required ListModel list}) async {
    FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('todos')
        .collection(list.title)
        .doc(todo.id)
        .delete();
    await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('completedTodo')
        .collection(list.title)
        .doc(todo.id)
        .set({
      'id': todo.id,
      'title': todo.title,
      'subtitle': todo.subtitle,
      'date': todo.date.toString(),
      'time':
          todo.time == null ? null : '${todo.time!.hour}:${todo.time!.minute}',
    });
    getTodos(listModel: list);
  }

  undoCompleteTask({required TodoModel todo, required ListModel list}) async {
    FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('completedTodo')
        .collection(list.title)
        .doc(todo.id)
        .delete();
    await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('todos')
        .collection(list.title)
        .doc(todo.id)
        .set({
      'id': todo.id,
      'title': todo.title,
      'subtitle': todo.subtitle,
      'date': todo.date.toString(),
      'time':
          todo.time == null ? null : '${todo.time!.hour}:${todo.time!.minute}',
    });
    getTodos(listModel: list);
  }

  getCompletedTodos({required ListModel listModel}) async {
    final listRespo = await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('completedTodo')
        .collection(listModel.title)
        .get();
    final documentList = listRespo.docs;
    List<Map<String, dynamic>> dataList = documentList.map((documentSnapshot) {
      return documentSnapshot.data();
    }).toList();
    listModel.completedList.value.clear();
    listModel.completedList.notifyListeners();
    final _datalist = dataList.map((e) {
      return TodoModel(
        id: e['id'],
        title: e['title'],
        subtitle: e['subtitle'],
        date: e['date'] != 'null' && e['date'] != null
            ? DateTime.parse(e['date'])
            : null,
        time: e['time'] == null
            ? null
            : TimeOfDay(
                hour: int.parse(e['time'].split(":")[0]),
                minute: int.parse(e['time'].split(":")[1])),
      );
    }).toList();
    listModel.completedList.value = _datalist.reversed.toList();
    listModel.completedList.notifyListeners();
  }

  deleteTodo({required TodoModel todo, required ListModel list}) async {
    await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('todos')
        .collection(list.title)
        .doc(todo.id)
        .delete();
    getTodos(listModel: list);
  }
}
