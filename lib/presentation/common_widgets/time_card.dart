import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/core/colors/colors.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({super.key, required this.time});
  final TimeOfDay time;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: primaryColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${time.format(context)}",
        ),
      ),
    );
  }
}
