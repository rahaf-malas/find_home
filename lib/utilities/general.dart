import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class General {
  static final _box = GetStorage();

  static getDataFromStorage(String key) {
    var data;
    if (_box.hasData(key)) {
      data = _box.read(key);
    }
    return data;
  }

  static void saveDataToStorage(String key, data) {
    _box.write(key, data);
  }

  static Set<String> getFav() {
    Set<String> fav = {};
    if (_box.hasData('fav')) {
      var data = json.decode(_box.read('fav'));
      data.forEach((element) {
        fav.add(element);
      });
    }
    return fav;
  }

  static void addToFav(String homeId) {
    Set<String> fav = getFav();
    fav.add(homeId);
    var set = fav.map((e) => e).toList();
    var data = jsonEncode(set);
    _box.write('fav', data);
    print('$homeId added to fav');
  }

  static void removeFromFav(String homeId) async {
    Set<String> favProducts = getFav();
    favProducts.removeWhere((element) => element == homeId);
    var set = favProducts.map((e) => e).toList();
    var data = jsonEncode(set);
    _box.write('fav', data);
    print(' $homeId removed from fav');
  }
}
