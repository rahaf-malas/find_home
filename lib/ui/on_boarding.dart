import 'package:find_home/ui/main_screen/main_screen_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';
import 'package:provider/provider.dart';

import 'main_screen/main_screen.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<OnbordingData> list = [
      OnbordingData(
        imagePath: "assets/on_boarding_1.png",
        title: "Lorem ipsum",
        desc:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
      ),
      OnbordingData(
        imagePath: "assets/on_boarding_2.png",
        title: "Lorem ipsum",
        desc:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
      ),
      OnbordingData(
        imagePath: "assets/on_boarding_3.png",
        title: "Lorem ipsum",
        desc:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
      ),
    ];
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: IntroScreen(
                list,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (context) => MainScreenViewModel(),
                        child: const MainScreen()))))
      ]),
    );
  }
}
