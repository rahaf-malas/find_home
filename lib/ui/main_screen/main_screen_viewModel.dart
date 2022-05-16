import 'package:find_home/ui/favourites/favourites.dart';
import 'package:find_home/ui/map/map.dart';
import 'package:flutter/material.dart';

import '../home/home.dart';

class MainScreenViewModel extends ChangeNotifier {
  int index = 0;
  List<Widget> icons = const [
    Icon(Icons.home),
    Icon(Icons.map),
    Icon(Icons.favorite),
  ];
  List<Widget> screens = const [Home(), Map(), Favourites(),];

  changeIndex(newIndex) {
    index = newIndex;
    notifyListeners();
  }
}
