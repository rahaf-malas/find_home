import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_home/components/home_card/home_card.dart';
import 'package:find_home/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../components/home_card/home_card_view_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeData = Provider.of<HomeViewModel>(context, listen: false);
    var tabStyle = const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black45);
    var activeTabStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).primaryColor);

    return StreamBuilder<QuerySnapshot?>(
        stream: homeData.homesCollection,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            homeData.addDataToLists(snapshot.data);
            homeData.getFilterCachedValues();
            return Consumer<HomeViewModel>(builder: (context, viewModel, _) {
              return Scaffold(
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(180),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            height: 50,
                          ),
                          Row(
                            children: [
                              DropdownButton<String?>(
                                  hint: const Text('filter by city'),
                                  // underline: Container(),
                                  value: viewModel.selectedCity,
                                  borderRadius: BorderRadius.circular(10),
                                  items: viewModel.citiesList
                                      .map<DropdownMenuItem<String>>((e) =>
                                          DropdownMenuItem<String>(
                                              child: Text(e), value: e))
                                      .toList(),
                                  onChanged: (data) {
                                    viewModel.changeCitySelection(
                                        data, snapshot.data!.docs);
                                  }),
                              viewModel.filter
                                  ? TextButton.icon(
                                      onPressed: () {
                                        viewModel.clearCitySelection();
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        size: 18,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      label: Text(
                                        'clear selection',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ))
                                  : Container()
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    "All",
                                    style: viewModel.all
                                        ? activeTabStyle
                                        : tabStyle,
                                  ),
                                  onTap: () {
                                    viewModel.changeActiveTab(0);
                                  },
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Rent",
                                    style: viewModel.rent
                                        ? activeTabStyle
                                        : tabStyle,
                                  ),
                                  onTap: () {
                                    viewModel.changeActiveTab(1);
                                  },
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  child: Text(
                                    "Buy",
                                    style: viewModel.sale
                                        ? activeTabStyle
                                        : tabStyle,
                                  ),
                                  onTap: () {
                                    viewModel.changeActiveTab(2);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        viewModel.all
                            ? viewModel.homesList.isNotEmpty
                                ? Scrollbar(
                                    child: ListView.builder(
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      itemCount: viewModel.homesList.length,
                                      itemBuilder: (context, index) {
                                        return ChangeNotifierProvider(
                                          create: (context) =>
                                              HomeCardViewModel(
                                                  home: viewModel
                                                      .homesList[index]),
                                          child: const HomeCard(),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                  child: Container(
                                      height: 400,
                                      child: Lottie.asset(
                                        'assets/no_homes.json',
                                        repeat: false,
                                        alignment: Alignment.center,
                                        width: 200,
                                      ),
                                    ),
                                )
                            : Container(),

                        ///show rent
                        viewModel.rent
                            ? viewModel.onlyRent.isNotEmpty
                                ? Scrollbar(
                                  child: ListView.builder(
                                                                          physics: const ScrollPhysics(),

                                      shrinkWrap: true,
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 5),
                                      itemCount: viewModel.onlyRent.length,
                                      itemBuilder: (context, index) {
                                        return ChangeNotifierProvider(
                                          create: (context) => HomeCardViewModel(
                                              home: viewModel.onlyRent[index]),
                                          child: const HomeCard(),
                                        );
                                      },
                                    ),
                                )
                                : Center(
                                  child: Container(
                                      height: 400,
                                      child: Lottie.asset(
                                        'assets/no_homes.json',
                                        repeat: false,
                                        alignment: Alignment.center,
                                        width: 200,
                                      ),
                                    ),
                                )
                            : Container(),
                        viewModel.sale
                            ? viewModel.onlySale.isNotEmpty
                                ? Scrollbar(
                                  child: ListView.builder(
                                                                          physics: const ScrollPhysics(),

                                      shrinkWrap: true,
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 5),
                                      itemCount: viewModel.onlySale.length,
                                      itemBuilder: (context, index) {
                                        return ChangeNotifierProvider(
                                          create: (context) => HomeCardViewModel(
                                              home: viewModel.onlySale[index]),
                                          child: const HomeCard(),
                                        );
                                      },
                                    ),
                                )
                                : Center(
                                  child: Container(
                                      height: 400,
                                      child: Lottie.asset(
                                        'assets/no_homes.json',
                                        repeat: false,
                                        alignment: Alignment.center,
                                        width: 200,
                                      ),
                                    ),
                                )
                            : Container(),
                      ],
                    ),
                  ));
            });
          } else {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
        });
  }
}
