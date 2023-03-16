import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class IncompleteTasks extends StatelessWidget {
  const IncompleteTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        50,
        (index) => _IncompleteTask(
          id: index,
          title: 'Food',
          dateTime: DateTime.now().add(Duration(days: 1)),
        ),
      ),
    );
  }
}

class _IncompleteTask extends StatelessWidget {
  const _IncompleteTask(
      {required this.id, required this.title, this.details, this.dateTime});
  final int id;
  final String title;
  final String? details;
  final DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: false,
        onChanged: (value) {},
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          details == null ? SizedBox() : Text(details!),
          dateTime == null
              ? SizedBox()
              : Card(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      '${dateTime!.day.toString()}.${dateTime!.month.toString()}.${dateTime!.year.toString()}',
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1,
                          color: dateTime!.millisecondsSinceEpoch <
                                  DateTime.now().millisecondsSinceEpoch
                              ? Colors.red
                              : Colors.deepPurpleAccent),
                      borderRadius: BorderRadius.circular(10)),
                )
        ],
      ),
      onTap: () {
        if (dateTime!.millisecondsSinceEpoch <
            DateTime.now().millisecondsSinceEpoch) {
          log('re');
        }
      },
    );
  }
}
