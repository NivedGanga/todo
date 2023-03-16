import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/presentation/homepage/widgets/completed_tasks.dart';
import 'package:todo/presentation/homepage/widgets/incomplete_tasks.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          IncompleteTasks(),
          Text('data'),
          CompleteTasks(),
        ],
      ),
    );
  }
}
