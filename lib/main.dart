import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_app_ui/ui/dashboard.dart';
import 'package:laundry_app_ui/utils/constants.dart';

import 'ui/home.dart';
import 'ui/login.dart';
import 'ui/navigationScreen.dart';
import 'ui/register.dart';
import 'ui/single_order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Laundry App",
        theme: ThemeData(
          scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),

      home: Home(),
      );
  }
}

