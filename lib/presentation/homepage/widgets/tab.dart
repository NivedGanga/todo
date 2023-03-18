import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/infrastructure/list/list_repo.dart';
import 'package:todo/infrastructure/todos/model/todo_model.dart';
import 'package:todo/infrastructure/todos/todos_repo.dart';
import 'package:todo/presentation/homepage/widgets/completed_tasks.dart';
import 'package:todo/presentation/homepage/widgets/incomplete_tasks.dart';

final ValueNotifier _loadingNotifier = ValueNotifier(false);

class TabWidget extends StatelessWidget {
  const TabWidget({super.key, required this.index});
  final int index;
  @override
  StatelessElement createElement() {
    TodosRepo.instance
        .getTodos(listModel: ListRepo.instance.todoListTitles[index]);
    // TODO: implement createElement
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              IncompleteTasks(
                index: index,
              ),
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  iconColor: Colors.white,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Center(
                  child: Text(
                    'Completed Tasks',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                collapsed: SizedBox(),
                expanded: CompleteTasks(index: index),
              ),
              kheight30,
              kheight30
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _loadingNotifier,
          builder: (context, value, child) {
            if (value) {
              return Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}
