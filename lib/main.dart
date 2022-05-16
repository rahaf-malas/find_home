import 'package:find_home/ui/splash_screen/splash_screen.dart';
import 'package:find_home/ui/splash_screen/splash_screen_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFE0E0E0),
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 16)),
        brightness: Brightness.light,
        primaryColor: const Color(0xffFF9900),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: ChangeNotifierProvider(
        create: (context) => SplashScreenViewModel(context),
        child: const SplashScreen(),
      ),
    );
  }
}
