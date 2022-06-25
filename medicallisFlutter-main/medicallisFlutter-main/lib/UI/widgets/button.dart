import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medicallis/UI/theme.dart';

class myButton extends StatelessWidget {
  final String Label;
  final Function()? onTap;

  const myButton({Key? key, required this.Label, required this.onTap})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: primaryClr,
          ),
          child: Text(
            Label,
            style: TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          )),
    );
  }
}
