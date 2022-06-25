import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medicallis/UI/theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String? hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField(
      {Key? key, required this.title, this.hint, this.controller, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: titleStyle,
        ),
        Container(
          height: 42,
          color: Colors.grey,
          width: 300,
          child: Row(children: [
            Expanded(
              child: TextFormField(
                readOnly: widget == null ? false : true,
                controller: controller,
                autofocus: false,
                decoration:
                    InputDecoration(hintText: hint, hintStyle: subTitleStyle),
              ),
            ),
            widget == null
                ? Container()
                : Container(
                    child: widget,
                  )
          ]),
        ),
      ]),
    );
  }
}
