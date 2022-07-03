import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medicallis/UI/theme.dart';
import 'package:medicallis/UI/widgets/button.dart';

class NotificationPage extends StatelessWidget {
  final String? label;
  const NotificationPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            )),
        title: Text(
          this.label.toString().split('#')[0],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 300,
              width: 330,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Text(
                    ' name : ' + this.label.toString().split('#')[0],
                    style: subHeadingStyle,
                  ),
                  Spacer(),
                  Text(
                    ' Medication dosage : ' +
                        this.label.toString().split('#')[1],
                    style: subHeadingStyle,
                  ),
                  Spacer(),
                  Text(
                    ' Medication note : ' + this.label.toString().split('#')[2],
                    style: subHeadingStyle,
                  ),
                  Spacer(),
                  Text(
                    'Timing : ' + this.label.toString().split('#')[3],
                    style: subHeadingStyle,
                  ),
                ],
              ),
            ),
            Spacer(),
            myButton(Label: 'CLose Notification', onTap: () => Get.back())
          ],
        ),
      ),
    );
  }
}
