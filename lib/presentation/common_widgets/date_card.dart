import 'package:flutter/material.dart';

import 'package:todo/core/colors/colors.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: primaryColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${weekName(week: date.weekday)},${monthName(month: date.month)} ${date.day}",
        ),
      ),
    );
  }

  String weekName({required int week}) {
    switch (week) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
    }
    return '';
  }

  String monthName({required int month}) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return '';
  }
}
