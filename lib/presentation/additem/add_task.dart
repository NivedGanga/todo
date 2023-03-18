import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/infrastructure/list/list_repo.dart';
import 'package:todo/infrastructure/list/model/list_model.dart';
import 'package:todo/infrastructure/todos/model/todo_model.dart';
import 'package:todo/infrastructure/todos/todos_repo.dart';
import 'package:todo/presentation/common_widgets/date_card.dart';
import 'package:todo/presentation/common_widgets/time_card.dart';

final ValueNotifier<bool> _detailsNotifier = ValueNotifier(false);
final ValueNotifier<bool> _dateNotifier = ValueNotifier(false);
final ValueNotifier<bool> _timeNotifier = ValueNotifier(false);
DateTime? _date;
TimeOfDay? _time;

class AddTask extends StatefulWidget {
  AddTask({super.key, required this.index});
  final int index;
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  late final ListModel list;

  @override
  void initState() {
    list = ListRepo.instance.todoListTitles[widget.index];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'New task',
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _detailsNotifier,
            builder: (context, value, child) => _detailsNotifier.value
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    child: TextFormField(
                      controller: subtitleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add details',
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: _dateNotifier,
                builder: (context, value, child) => _dateNotifier.value
                    ? DateCard(
                        date: _date!,
                      )
                    : SizedBox(),
              ),
              ValueListenableBuilder(
                valueListenable: _timeNotifier,
                builder: (context, value, child) => _timeNotifier.value
                    ? TimeCard(
                        time: _time!,
                      )
                    : SizedBox(),
              )
            ],
          ),
          Row(
            children: [
              kwidth10,
              IconButton(
                onPressed: () {
                  _detailsNotifier.value = !_detailsNotifier.value;
                  _detailsNotifier.notifyListeners();
                },
                icon: Icon(Icons.notes_outlined),
              ),
              kwidth10,
              IconButton(
                onPressed: () async {
                  _date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3000),
                  );
                  if (_date == null) {
                    return;
                  }
                  _dateNotifier.value = true;
                  log(_date.toString());
                },
                icon: Icon(Icons.calendar_today_outlined),
              ),
              kwidth10,
              ValueListenableBuilder(
                  valueListenable: _dateNotifier,
                  builder: (context, val, _) {
                    return AnimatedScale(
                      scale: val ? 1 : 0,
                      duration: Duration(milliseconds: 400),
                      child: IconButton(
                        onPressed: () async {
                          _time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (_time == null) {
                            return;
                          }
                          _timeNotifier.value = true;
                          log(_time!.toString());
                        },
                        icon: Icon(Icons.access_time_rounded),
                      ),
                    );
                  }),
              Spacer(),
              TextButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final todo = TodoModel(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      title: titleController.text,
                      subtitle: subtitleController.text == ''
                          ? null
                          : subtitleController.text,
                      date: _date,
                      time: _time);
                  await TodosRepo.instance
                      .addTodo(todo: todo, listModel: list, context: context);

                  Navigator.pop(context);
                },
                child: Text(
                  'save',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              kwidth10
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _date = null;
    _time = null;
    _timeNotifier.value = false;
    _detailsNotifier.value = false;
    _dateNotifier.value = false;
    _detailsNotifier.value = false;
    super.dispose();
  }
}
