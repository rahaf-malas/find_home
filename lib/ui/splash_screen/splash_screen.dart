import 'package:find_home/ui/splash_screen/splash_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashScreenViewModel>(context);
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/logo.png',
            height: 170,
            width: 170,
          )),
          const SizedBox(
            height: 30,
          ),
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
