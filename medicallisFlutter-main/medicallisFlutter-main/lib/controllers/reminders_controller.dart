import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/reminder.dart';
import '../db/db.dart';

class ReminderController extends GetxController {
  @override
  void onReady() {
    getReminders();
    super.onReady();
  }

  var reminderList = <reminder>[].obs;

  Future<int> addReminder({reminder? rem}) async {
    return await db.insert(rem);
  }

  void getReminders() async {
    List<Map<String, dynamic>> reminders = await db.query();

    reminderList.assignAll(
        reminders.map((data) => new reminder.fromJson(data)).toList());
  }

  void delete(reminder rem) {
    db.delete(rem);
  }

  void markcompleted(int id) async {
    await db.update(id);
    print('marked as completed');
  }
}

class TrackerController extends GetxController {
  @override
  void onReady() {
    getTrackers();
    super.onReady();
  }

  var trackerList = <tracker>[].obs;

  Future<int> addTracker({tracker? trc}) async {
    return await db.inserttrc(trc);
  }

  void getTrackers() async {
    /*List<Map<String, dynamic>> trc = await db.querytrc();

    trackerList
        .assignAll(trc.map((data)  =>  tracker.fromJson(data)).toList());*/
  }

  void delete(reminder rem) {
    db.delete(rem);
  }

  void markcompleted(int id) async {
    await db.update(id);
    print('marked as completed');
  }
}
