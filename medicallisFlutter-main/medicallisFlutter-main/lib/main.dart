import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medicallis/UI/home_page.dart';
import 'package:medicallis/db/db.dart';
import './UI/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await db.initDB();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.light,
        themeMode: ThemeMode.dark,
        home: HomePage());
  }
}
