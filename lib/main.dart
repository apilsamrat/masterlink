import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masterlink/utilities/colors.dart';

import 'src/layouts/home/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Master Link",
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: kPrimaryColor,
        colorScheme: ColorScheme.light(primary: kPrimaryColor),
        fontFamily: GoogleFonts.roboto(fontWeight: FontWeight.w600).fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: kPrimaryColor,
          titleTextStyle: GoogleFonts.vt323(fontSize: 32),
        ),
      ),
      builder: EasyLoading.init(),
      home: const HomePage(),
    );
  }
}
