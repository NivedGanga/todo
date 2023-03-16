import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors.dart';

class CompleteTasks extends StatelessWidget {
  const CompleteTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => _CompleteTask(),
      ),
    );
  }
}

class _CompleteTask extends StatelessWidget {
  const _CompleteTask();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.done_outlined,
        color: primaryColor,
      ),
      title: Text(
        'Food',
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          decorationStyle: TextDecorationStyle.solid,
          decorationColor: primaryColor,
          decorationThickness: 2,
        ),
      ),
    );
  }
}
