import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_home/utilities/general.dart';
import 'package:flutter/material.dart';

class FavouritesViewModel extends ChangeNotifier {
  FavouritesViewModel() {
    print('favIds $favIds');
  }
  final Stream<QuerySnapshot?> homesCollection =
      FirebaseFirestore.instance.collection('homes').snapshots();
  List<QueryDocumentSnapshot<Object?>> homesList = [];

  List<String> favIds = [];

  addDataToLists(QuerySnapshot<Object?> data) {
    favIds = General.getFav().toList();
    homesList.clear();
    for (var element in data.docs) {
      if (favIds.contains(element.id)) {
        homesList.add(element);
      }
    }
    print('final homeList length: ${homesList.length}');
  }

  removeFromFav(id) {
    General.removeFromFav(id);
    homesList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
