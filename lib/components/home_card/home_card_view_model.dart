import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

import '../../utilities/general.dart';

class HomeCardViewModel extends ChangeNotifier {
  final QueryDocumentSnapshot<Object?> home;
  HomeCardViewModel({required this.home}) {
    // final _box=GetStorage();
    // _box.remove('fav');
    checkIfIsFav();
  }
  bool isFav = false;

  checkIfIsFav() {
    Set<String> fav = General.getFav();
    for (var element in fav) {
      if (element == home.id) {
        isFav = true;
      }
        notifyListeners();
    }
  }

  addToFav() {
    isFav = !isFav;
    General.addToFav(home.id);
    HapticFeedback.vibrate();
    notifyListeners();
  }

  removeFromFav() {
    isFav = !isFav;
    General.removeFromFav(home.id);
    // HapticFeedback.vibrate();
    notifyListeners();
  }
}
