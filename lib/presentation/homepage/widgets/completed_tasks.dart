import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors.dart';
import 'package:todo/infrastructure/list/list_repo.dart';
import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:todo/infrastructure/todos/model/todo_model.dart';
import 'package:todo/infrastructure/todos/todos_repo.dart';

class CompleteTasks extends StatefulWidget {
  const CompleteTasks({super.key, required this.index});
  final int index;
  @override
  State<CompleteTasks> createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  late final ListModel list;
  @override
  void initState() {
    list = ListRepo.instance.todoListTitles[widget.index];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: list.completedList,
        builder: (context, newList, _) {
          return Column(
            children: List.generate(
              newList.length,
              (i) => _CompleteTask(
                list: list,
                todo: newList[i],
              ),
            ),
          );
        });
  }
}

class _CompleteTask extends StatelessWidget {
  _CompleteTask({required this.todo, required this.list});
  final TodoModel todo;
  final ListModel list;
  final ValueNotifier<bool> checkboNotifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: checkboNotifier,
        builder: (context, val, _) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: val ? 1 : 0,
            child: ListTile(
              leading: Checkbox(
                value: val,
                onChanged: (value) {
                  checkboNotifier.value = !checkboNotifier.value;
                  TodosRepo.instance.undoCompleteTask(todo: todo, list: list);
                },
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: primaryColor,
                  decorationThickness: 2,
                ),
              ),
            ),
          );
        });
  }
}
