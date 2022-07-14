import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medicallis/UI/add_rem_bar.dart';
import 'package:medicallis/UI/theme.dart';
import 'package:medicallis/UI/widgets/button.dart';
import 'package:medicallis/controllers/reminders_controller.dart';
import 'package:medicallis/models/reminder.dart';
import 'package:medicallis/services/notification_services.dart';
import 'widgets/DrawerWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectDate = DateTime.now();
  final _reminderController = Get.put(ReminderController());

  // ignore: prefer_typing_uninitialized_variables
  var notifHelper;
  @override
  void initState() {
    super.initState();
    notifHelper = notifyHelper();
    notifHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Medicallis App '),
      ),
      body: Column(
        children: [
          /**/
          _addTaskBar(),
          _addDateBar(),
          SizedBox(
            height: 10,
          ),
          _showReminders(),
        ],
      ),
    );
  }

  _showReminders() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _reminderController.reminderList.length,
            itemBuilder: (_, index) {
              reminder r = _reminderController.reminderList[index];
              //print(DateFormat.yMd()                   .parse(DateFormat.yMd().format(_selectDate).toString())                   .weekday);
              //print(r.toJson());
              print('weekday from date: ' +
                  DateFormat.yMd().parse(r.date!).weekday.toString());
              print('weekday from selected :' +
                  DateFormat.yMd()
                      .parse(DateFormat.yMd().format(_selectDate).toString())
                      .weekday
                      .toString());

              if (r.repeat == 'Daily') {
                notifHelper.scheduledNotification(
                    int.parse(r.startTime.toString().split(':')[0]),
                    int.parse(r.startTime.toString().split(':')[1]),
                    r);
                return GestureDetector(
                  onTap: () {
                    _showBottomPopUp(
                        context, _reminderController.reminderList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(10),
                    color:
                        _reminderController.reminderList[index].isCompleted == 1
                            ? Colors.grey
                            : Color.fromARGB(255, 68, 79, 238),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              _reminderController.reminderList[index].name
                                  .toString(),
                              style: ReminderStyle,
                            ),
                            Spacer(),
                            Text(
                                _reminderController
                                    .reminderList[index].startTime
                                    .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Dosage :' +
                                    _reminderController
                                        .reminderList[index].dosage
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Type :' +
                                    _reminderController.reminderList[index].type
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Note :' +
                                    _reminderController.reminderList[index].note
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (r.repeat == 'Weekly' &&
                  DateFormat.yMd().parse(r.date!).weekday ==
                      DateFormat.yMd()
                          .parse(
                              DateFormat.yMd().format(_selectDate).toString())
                          .weekday) {
                notifHelper.scheduledNotification(
                    int.parse(r.startTime.toString().split(':')[0]),
                    int.parse(r.startTime.toString().split(':')[1]),
                    r);
                return GestureDetector(
                  onTap: () {
                    _showBottomPopUp(
                        context, _reminderController.reminderList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(10),
                    color:
                        _reminderController.reminderList[index].isCompleted == 1
                            ? Colors.grey
                            : Color.fromARGB(255, 68, 79, 238),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              _reminderController.reminderList[index].name
                                  .toString(),
                              style: ReminderStyle,
                            ),
                            Spacer(),
                            Text(
                                _reminderController
                                    .reminderList[index].startTime
                                    .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Dosage :' +
                                    _reminderController
                                        .reminderList[index].dosage
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Type :' +
                                    _reminderController.reminderList[index].type
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Note :' +
                                    _reminderController.reminderList[index].note
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (r.date == DateFormat.yMd().format(_selectDate)) {
                return GestureDetector(
                  onTap: () {
                    _showBottomPopUp(
                        context, _reminderController.reminderList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(10),
                    color:
                        _reminderController.reminderList[index].isCompleted == 1
                            ? Colors.grey
                            : Color.fromARGB(255, 68, 79, 238),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              _reminderController.reminderList[index].name
                                  .toString(),
                              style: ReminderStyle,
                            ),
                            Spacer(),
                            Text(
                                _reminderController
                                    .reminderList[index].startTime
                                    .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Dosage :' +
                                    _reminderController
                                        .reminderList[index].dosage
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Type :' +
                                    _reminderController.reminderList[index].type
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                'Note :' +
                                    _reminderController.reminderList[index].note
                                        .toString(),
                                style: ReminderStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _showBottomPopUp(BuildContext context, reminder rem) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(top: 4),
      height: MediaQuery.of(context).size.height * 0.29,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.blue),
          ),
          SizedBox(height: 10),
          /*_btnSheet(
              Label: "Mark as Completed ",
              context: context,
              onTap: () {
                Get.back();
                _reminderController.markcompleted(rem.id!);
                _reminderController.getReminders();
              },
              clr: Colors.blue),*/
          _btnSheet(
              Label: "Delete",
              context: context,
              onTap: () {
                _reminderController.delete(rem);
                _reminderController.getReminders();
                Get.back();
              },
              clr: Colors.red),
          SizedBox(height: 20),
          _btnSheet(
              Label: "Close ",
              context: context,
              onTap: () {
                Get.back();
              },
              clr: Colors.white),
          SizedBox(height: 20),
        ],
      ),
    ));
  }

  _btnSheet({
    required String Label,
    required Function()? onTap,
    required Color clr,
    required BuildContext context,
    bool isclosed = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(20),
          color: clr,
        ),
        child: Center(
            child: Text(
          Label,
          style: titleStyle,
        )),
      ),
    );
  }

  _addDateBar() {
    return Container(
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        onDateChange: (date) {
          setState(() {
            _selectDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  'Today',
                  style: HeadingStyle,
                ),
              ],
            ),
          ),
          myButton(
              Label: '+ add medication reminder',
              onTap: () async {
                await Get.to(() => addTaskPage());
                _reminderController.getReminders();
              })
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: () {
          //notifHelper.displayNotification(title: 'test', body: 'changed');
          //notifHelper.scheduledNotification();
        },
        child: Icon(
          Icons.medical_information,
          size: 20,
        ),
      ),
      title: Text('Medicallis App '),
      /*actions: [
        Icon(
          Icons.person,
          size: 20,
        ),
        SizedBox(
          width: 20,
        )
      ],*/
    );
  }
}



/* */
