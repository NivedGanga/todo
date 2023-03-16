import 'package:flutter/material.dart';

class AddList extends StatelessWidget {
  const AddList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new list'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Done'),
          ),
        ],
      ),
      body: TextFormField(
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
