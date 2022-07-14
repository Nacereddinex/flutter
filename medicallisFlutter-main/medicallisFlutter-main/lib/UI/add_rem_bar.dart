import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medicallis/UI/theme.dart';
import 'package:medicallis/UI/widgets/Input_field.dart';
import 'package:medicallis/UI/widgets/button.dart';
import 'package:medicallis/controllers/reminders_controller.dart';
import 'package:medicallis/models/reminder.dart';
import './../services/notification_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class addTaskPage extends StatefulWidget {
  const addTaskPage({Key? key}) : super(key: key);

  @override
  State<addTaskPage> createState() => _addTaskPageState();
}

class _addTaskPageState extends State<addTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _hour = DateFormat('hh:mm a').format(DateTime.now()).toString();
  final ReminderController _reminderController = Get.put(ReminderController());
  final _titleController = TextEditingController();
  final _typeController = TextEditingController();
  final _noteController = TextEditingController();
  final _dosageController = TextEditingController();

  List<int> remindList = [5, 10, 15, 20];
  int _selectRemind = 5;
  String _selectRepeat = "None";
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Medication Reminder",
                style: HeadingStyle,
              ),
              MyInputField(
                title: 'Medication Name',
                hint: 'Enter the name of your medication',
                controller: _titleController,
              ),
              MyInputField(
                title: 'Medication Type',
                hint: 'Enter the Type of your medication',
                controller: _typeController,
              ),
              MyInputField(
                title: 'Dosage',
                hint: 'Enter the dosage of your medication',
                controller: _dosageController,
              ),
              MyInputField(
                title: 'Note',
                hint: 'Enter a description or a note',
                controller: _noteController,
              ),
              MyInputField(
                title: 'Start Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: MyInputField(
                    title: 'Hour',
                    hint: _hour,
                    widget: IconButton(
                      icon: Icon(Icons.av_timer),
                      onPressed: () {
                        _getTimeFromUser();
                      },
                    ),
                  ))
                ],
              ),
              /*MyInputField(
                title: "Remind",
                hint: "$_selectRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 4,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRemind = int.parse(newValue!);
                    });
                  },
                  items: const [
                    DropdownMenuItem(child: Text("5"), value: "5"),
                    DropdownMenuItem(child: Text("10"), value: "10"),
                    DropdownMenuItem(child: Text("15"), value: "15"),
                    DropdownMenuItem(child: Text("20"), value: "20"),
                  ],
                ),
              ),*/
              MyInputField(
                title: "Repeat",
                hint: "$_selectRepeat ",
                widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  elevation: 4,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRepeat = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(child: Text("None"), value: "None"),
                    DropdownMenuItem(child: Text("Daily"), value: "Daily"),
                    DropdownMenuItem(child: Text("Weekly"), value: "Weekly"),
                    //DropdownMenuItem(child: Text("Monthly"), value: "Monthly"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      child: myButton(
                          Label: "Create Reminder ",
                          onTap: () {
                            _validate();
                          }),
                      height: 40),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _addReminderToDB() async {
    int value = await _reminderController.addReminder(
        rem: reminder(
      name: _titleController.text,
      dosage: _dosageController.text,
      type: _typeController.text,
      note: _noteController.text,
      date: DateFormat.yMd().format(_selectedDate),
      startTime: _hour,
      endTime: _hour,
      remind: _selectRemind,
      repeat: _selectRepeat,
      isCompleted: 0,
    ));
    print("$value  has been inserted");

    /* ;*/
  }

  _validate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addReminderToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("required", "all fields are required ",
          icon: Icon(Icons.warning));
    }
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.blueGrey,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
          size: 20,
        ),
      ),
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print('something went wrong');
    }
  }

  _getTimeFromUser() async {
    String timetemp = 'null';

    var pickedTime = await showTimePicker(
            initialEntryMode: TimePickerEntryMode.input,
            context: context,
            initialTime: TimeOfDay(hour: 9, minute: 10))
        .then((value) => (timetemp =
            "${value?.hour.toString().padLeft(2, '0')}:${value?.minute.toString().padLeft(2, '0')}"));
    setState(() {
      _hour = timetemp;
    });
    //String formattedTime = pickedTime.toString();timetemp

    /* if (pickedTime != null) {
      setState(() {
        _hour = pickedTime;
      });
    } else {
      print('something went wrong');
    }*/
  }

  _showTimepicker() async {
    return;
  }
}
