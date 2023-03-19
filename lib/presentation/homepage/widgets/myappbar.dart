import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo/core/constants/constants.dart';
import 'package:todo/domain/login/login.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kheight30,
        Row(
          children: [
            kwidth30,
            ScaffoldTitle(),
            Spacer(),
            PopupMenuButton<int>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 0,
                    child: Center(
                      child: Text(
                        'Sign out',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  )
                ];
              },
              onSelected: (value) {
                showDialog(
                  context: context,
                  builder: (context) => SizedBox(
                    width: 200,
                    height: 30,
                    child: AlertDialog(
                      title: Column(
                        children: [
                          Text(
                            'Do you want to sign out?',
                            style: TextStyle(
                                decoration: TextDecoration.none, fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Login.instance.signout(context: context);
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
          ],
        ),
      ],
    );
  }
}

class ScaffoldTitle extends StatelessWidget {
  const ScaffoldTitle({super.key});

  @override
  Widget build(BuildContext context) {
    if (DateTime.now().hour < 12) {
      return const Text(
        'GOOD MORNING',
        style: TextStyle(fontSize: 28),
      );
    } else if (DateTime.now().hour < 18) {
      return const Text(
        'GOOD AFTERNOON',
        style: TextStyle(fontSize: 28),
      );
    } else {
      return const Text(
        'GOOD EVENING',
        style: TextStyle(fontSize: 28),
      );
    }
  }
}
