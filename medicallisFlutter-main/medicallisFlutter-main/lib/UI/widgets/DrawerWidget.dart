import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:medicallis/UI/Educational.dart';
import 'package:medicallis/UI/TrackersPage.dart';
import 'package:medicallis/UI/add_rem_bar.dart';

import '../home_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildheader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildheader(BuildContext context) => Container(
        color: Colors.blueGrey,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            CircleAvatar(
              radius: 52,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Caretaker Sarah',
              style: TextStyle(fontSize: 28, color: Colors.white),
            )
          ],
        ),
      );
  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.map_outlined),
            title: const Text('Search for Pharmacies'),
            onTap: () {
              //Get.to();
            },
          ),
          ListTile(
            leading: const Icon(Icons.track_changes_sharp),
            title: const Text('Weight Tracker'),
            onTap: () {
              Get.to(TrackerPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_outlined),
            title: const Text('Prescription Scanning'),
            onTap: () {
              Get.to(EducationalContent());
            },
          ),
        ],
      );
}
