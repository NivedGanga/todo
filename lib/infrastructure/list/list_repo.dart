import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/infrastructure/user/model/user_model.dart';

class ListRepo {
  List<ListModel> todoListTitles = [];
  ListRepo._internal();
  static ListRepo instance = ListRepo._internal();

  factory ListRepo() {
    return instance;
  }
  addNewList({required ListModel list}) async {
    await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('List')
        .collection('List')
        .doc(list.id)
        .set({'id': list.id, 'title': list.title});
    await getLists();
  }

  getLists() async {
    final listRespo = await FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('List')
        .collection('List')
        .get();
    final documentList = listRespo.docs;
    List<Map<String, dynamic>> dataList = documentList.map((documentSnapshot) {
      return documentSnapshot.data();
    }).toList();

    todoListTitles.clear();
    todoListTitles = dataList.map((e) {
      return ListModel(id: e['id'], title: e['title']);
    }).toList();
  }

  deletelist({required ListModel list}) async {
    FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('List')
        .collection('List')
        .doc(list.id)
        .delete();
    final collectionRef = FirebaseFirestore.instance
        .collection(UserModel.instance.uid)
        .doc('todos')
        .collection(list.title);

    final batch = FirebaseFirestore.instance.batch();

    await collectionRef.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      return batch.commit();
    });
    await getLists();
  }
}
