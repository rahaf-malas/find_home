import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:find_home/ui/main_screen/main_screen_viewModel.dart';
import 'package:find_home/ui/home/home_view_model.dart';
import 'package:find_home/ui/map/map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../favourites/favourites_view_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mainScreenData = Provider.of<MainScreenViewModel>(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          items: mainScreenData.icons,
          height: 60,
          color: Colors.grey[300]!,
          buttonBackgroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 500),
          index: mainScreenData.index,
          onTap: (newIndex) {
            mainScreenData.changeIndex(newIndex);
          },
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => HomeViewModel()),
            ChangeNotifierProvider(create: (context) => MapViewModel()),
            ChangeNotifierProvider(create: (context) => FavouritesViewModel()),
          ],
          child: mainScreenData.screens[mainScreenData.index],
        ),
      ),
    );
  }
}
