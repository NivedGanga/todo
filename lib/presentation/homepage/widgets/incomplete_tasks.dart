import 'dart:developer';
import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:todo/infrastructure/list/list_repo.dart';
import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:todo/infrastructure/todos/model/todo_model.dart';
import 'package:todo/infrastructure/todos/todos_repo.dart';
import 'package:todo/presentation/common_widgets/date_card.dart';

class IncompleteTasks extends StatefulWidget {
  IncompleteTasks({super.key, required this.index});
  final int index;

  @override
  State<IncompleteTasks> createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
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
      valueListenable: list.todoList,
      builder: (context, newList, _) {
        return SingleChildScrollView(
          child: AnimationList(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            duration: 800,
            reBounceDepth: 10.0,
            children: List.generate(
              newList.length,
              (i) => _IncompleteTask(
                todo: newList[i],
                list: list,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IncompleteTask extends StatelessWidget {
  _IncompleteTask({required this.todo, required this.list});
  final TodoModel todo;
  final ListModel list;
  final ValueNotifier<bool> checkboNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: checkboNotifier,
        builder: (context, val, _) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: val ? 0 : 1,
            child: ListTile(
              leading: Checkbox(
                value: val,
                onChanged: (value) {
                  checkboNotifier.value = !checkboNotifier.value;
                  TodosRepo.instance.completedATask(todo: todo, list: list);
                },
              ),
              title: Text(todo.title),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  todo.subtitle == null ? SizedBox() : Text(todo.subtitle!),
                  Row(
                    children: [
                      todo.date == null
                          ? SizedBox()
                          : DateCard(date: todo.date!),
                      todo.time == null
                          ? SizedBox()
                          : Card(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  todo.time!.format(context),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: todo.date!.compareTo(
                                                    DateTime.now()) <=
                                                0 &&
                                            todo.time!.hour * 60 * 60 +
                                                    todo.time!.minute * 60 >
                                                TimeOfDay.now().hour * 60 * 60 +
                                                    TimeOfDay.now().minute * 60
                                        ? Colors.red
                                        : Colors.deepPurpleAccent,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                            )
                    ],
                  )
                ],
              ),
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => SizedBox(
                    width: 200,
                    height: 30,
                    child: AlertDialog(
                      title: Column(
                        children: [
                          Text(
                            'Do you want delete this task?',
                            style: TextStyle(
                                decoration: TextDecoration.none, fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  await TodosRepo.instance
                                      .deleteTodo(todo: todo, list: list);
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
