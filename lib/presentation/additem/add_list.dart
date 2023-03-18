import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo/infrastructure/list/list_repo.dart';
import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:todo/presentation/homepage/homepage.dart';

class AddList extends StatelessWidget {
  AddList({super.key});
  final listTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new list'),
        actions: [
          TextButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              if (listTitleController.text == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('list title cannot be empty')));
                return;
              }
              final list = ListModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: listTitleController.text.trim());
              await ListRepo.instance.addNewList(list: list);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                  (route) => false);
              log(list.toString());
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: TextFormField(
        controller: listTitleController,
        decoration: InputDecoration(
          hintText: 'Enter list title',
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 10,
              color: Color.fromARGB(255, 255, 0, 0),
            ),
          ),
        ),
      ),
    );
  }
}
