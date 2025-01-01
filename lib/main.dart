// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'screens/home_screen.dart';
//
//
//
// void main() {
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       getPages: [
//         GetPage(name: "/", page: () => HomeScreen()),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quoteapp/screens/SplashScreen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/home", page: () => HomeScreen()),
      ],
    );
  }
}
