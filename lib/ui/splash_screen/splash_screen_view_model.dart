import 'package:find_home/ui/main_screen/main_screen_viewModel.dart';
import 'package:find_home/ui/on_boarding.dart';
import 'package:find_home/utilities/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../main_screen/main_screen.dart';


class SplashScreenViewModel extends ChangeNotifier {
  final BuildContext context;
  SplashScreenViewModel(this.context) {
    checkIfFirstTimeToLaunch();
  }

  checkIfFirstTimeToLaunch() async {
    var firstTime = await General.getDataFromStorage("firstTime");
    print('firstTime:$firstTime');
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (firstTime == null || firstTime == true) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => const OnBoarding()),
              (route) => false);
          General.saveDataToStorage("firstTime", false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => ChangeNotifierProvider(create: (context)=>MainScreenViewModel(),
               child: const MainScreen(),
              )),
              (route) => false);
        }
      },
    );
  }
}
