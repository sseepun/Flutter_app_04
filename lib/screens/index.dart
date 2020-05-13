import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context, width: 1080, height: 1920, 
      allowFontScaling: true
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: HomeScreen(),
    );
  }
}
