import 'package:find_home/utilities/general.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel extends ChangeNotifier {
  bool all = true, rent = false, sale = false;
  bool filter = false;
  String? selectedCity;

  final Stream<QuerySnapshot?> homesCollection =
      FirebaseFirestore.instance.collection('homes').snapshots();
  List<QueryDocumentSnapshot<Object?>> homesList = [];
  List<QueryDocumentSnapshot<Object?>> copyOfHomesList = [];
  List<QueryDocumentSnapshot<Object?>> onlyRent = [];
  List<QueryDocumentSnapshot<Object?>> onlySale = [];
  Set<String> citiesList = {};

  getFilterCachedValues() async {
    var _filterValue = General.getDataFromStorage('filter');
    filter = _filterValue == null || _filterValue == false ? false : true;
    selectedCity = General.getDataFromStorage('selectedCity');
    print('cached filter value: $filter / cached selected city value: $selectedCity ');
    if (filter) {
      copyOfHomesList.clear();
      for (var element in homesList) {
        copyOfHomesList.add(element);
      }
      filterByCity();
    }
  }

  void addDataToLists(QuerySnapshot<Object?>? data) {
    homesList.clear();
    citiesList.clear();
    for (var element in data!.docs) {
      homesList.add(element);
      citiesList.add(element['city']);
    }
  }

  changeActiveTab(index) {
    switch (index) {
      case 0:
        {
          all = true;
          rent = false;
          sale = false;
          changeSource();
          notifyListeners();
          break;
        }
      case 1:
        {
          all = false;
          rent = true;
          sale = false;
          onlyRent.clear();
          changeSource();
          notifyListeners();
          break;
        }
      case 2:
        {
          all = false;
          rent = false;
          sale = true;
          onlySale.clear();
          changeSource();
          notifyListeners();
          break;
        }
    }
  }

  changeSource() {
    if (all) {
      if (filter) {
        filterByCity();
      }
    } else if (rent) {
      if (filter) {
        filterByCity();
      } else {
        onlyRent = homesList
            .where((element) => element['type'].toString().contains('rent'))
            .toList();
      }
    } else if (sale) {
      if (filter) {
        filterByCity();
      } else {
        onlySale = homesList
            .where((element) => element['type'].toString().contains('sale'))
            .toList();
      }
    }
  }

  changeCitySelection(String? city, List<QueryDocumentSnapshot<Object?>> data) {
    filter = true;
    selectedCity = city;
    General.saveDataToStorage('filter', filter);
    General.saveDataToStorage('selectedCity', selectedCity!);

    ///take a copy of the main homes list to return it back after clear selection
    copyOfHomesList.clear();
    for (var element in data) {
      copyOfHomesList.add(element);
    }
    filterByCity();
    notifyListeners();
  }

  clearCitySelection() {
    filter = false;
    selectedCity = null;
    General.saveDataToStorage('filter', filter);
    General.saveDataToStorage('selectedCity', selectedCity);

    ///return the homes list to the it's original version (all homes)
    homesList.clear();
    for (var element in copyOfHomesList) {
      homesList.add(element);
    }
    changeSource();
    notifyListeners();
  }

  filterByCity() {
    if (all) {
      homesList = copyOfHomesList
          .where(
              (element) => element['city'].toString().contains('$selectedCity'))
          .toList();
    }
    if (rent) {
      onlyRent = homesList
          .where((element) =>
              element['city'].toString().contains('$selectedCity') &&
              element['type'].toString().contains('rent'))
          .toList();
    }
    if (sale) {
      onlySale = homesList
          .where((element) =>
              element['city'].toString().contains('$selectedCity') &&
              element['type'].toString().contains('sale'))
          .toList();
    }
  }
}
