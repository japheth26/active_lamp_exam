import 'package:active_lamp_exam/core/constant/route_const.dart';
import 'package:active_lamp_exam/features/presentation/page/home.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: RouteConst.HOME_ROUTE,
      // routes: {
      //   RouteConst.HOME_ROUTE: (context) => HomePage(),
      // },
      home: HomePage(),
    );
  }
}
