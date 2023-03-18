import 'package:flutter/material.dart';
import 'package:todo/core/constants/constants.dart';

final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier(true);

class IconAndField extends StatelessWidget {
  IconAndField({
    super.key,
    required this.size,
    required this.controller,
    this.isPass = false,
    required this.text,
    required this.iconData,
  });
  final String text;
  final IconData iconData;

  final Size size;
  final TextEditingController controller;
  final bool isPass;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData),
        kwidth20,
        SizedBox(
          width: size.width * 0.7,
          child: ValueListenableBuilder(
              valueListenable: _obscureTextNotifier,
              builder: (context, newValue, _) {
                return TextFormField(
                  controller: controller,
                  obscureText: isPass ? newValue : false,
                  decoration: InputDecoration(
                    hintText: text,
                    suffix: isPass
                        ? GestureDetector(
                            onTap: () {
                              _obscureTextNotifier.value =
                                  !_obscureTextNotifier.value;
                            },
                            child: Icon(
                              newValue
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          )
                        : SizedBox(),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
