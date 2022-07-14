import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medicallis/models/reminder.dart';
import '../controllers/reminders_controller.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({Key? key}) : super(key: key);

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  @override
  final _trackerController = Get.put(TrackerController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          /**/
          Center(
            child: ElevatedButton(
              child: Text('click to add'),
              onPressed: () {
                _addTrackerToDB();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //_ShowTrackers(),
        ],
      ),
    );
  }

  _addTrackerToDB() async {
    int value = await _trackerController.addTracker(
        trc: tracker(
            BloodPressure: 'test',
            BloodSugar: 'test',
            Time: 'today',
            Weight: '200kg'));
    print("$value  has been inserted");

    /* ;*/
  }

  _ShowTrackers() async {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _trackerController.trackerList.length,
            itemBuilder: (_, index) {
              tracker trc = _trackerController.trackerList[index];
              //print(DateFormat.yMd()                   .parse(DateFormat.yMd().format(_selectDate).toString())                   .weekday);

              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: 100,
                  height: 100,
                  color: Colors.black,
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    _trackerController.trackerList[index].obs.toString(),
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              );
            });
      }),
    );

    /* ;*/
  }
}
