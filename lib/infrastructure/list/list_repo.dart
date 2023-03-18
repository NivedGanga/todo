import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListRepo {
  ListRepo._internal();
  static ListRepo instance = ListRepo._internal();
  factory ListRepo() {
    return instance;
  }
  addNewList({required ListModel list}) async {
    FirebaseFirestore.instance
        .collection('collectionPath')
        .doc('List')
        .collection('List')
        .doc(list.id)
        .set({'title': list.title});
  }
}
