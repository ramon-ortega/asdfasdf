import 'package:flutter/material.dart';
import 'package:sembast_app/db/app_theme.dart';
import 'package:sembast_app/db/db.dart';
import 'package:sembast_app/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  await MyAppTheme.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MyAppTheme.instance,
      child: Consumer<MyAppTheme>(
        builder: (_, myAppTheme, child ){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: MyAppTheme.instance.darkEnabled?ThemeData.dark():ThemeData.light(),
            home: HomePage()
          );
        },
      ),
    );
  }
}

