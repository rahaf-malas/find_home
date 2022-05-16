import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_home/ui/favourites/favourites_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favData = Provider.of<FavouritesViewModel>(context);
    var style = const TextStyle(fontSize: 15, color: Colors.black54);

    return StreamBuilder<QuerySnapshot?>(
      stream: favData.homesCollection,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          favData.addDataToLists(snapshot.data!);
          return Scaffold(
            appBar: AppBar(title: const Text('Favourites')),
            body: favData.homesList.isNotEmpty
                ? ListView.builder(
                    itemCount: favData.homesList.length,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Stack(
                          children: [
                            SizedBox(
                                height: 120,
                                child: Row(children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset('assets/home.jpg')),
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ///price
                                        Text(
                                          favData.homesList[index]['price'],
                                          style: style.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),

                                        ///address
                                        Text(
                                          '${favData.homesList[index]['city']} / ${favData.homesList[index]['address']}',
                                          style: style,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        ///details
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.bed,
                                                  size: 18,
                                                ),
                                                Text(
                                                    '${favData.homesList[index]['rooms']}')
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.shower,
                                                  size: 18,
                                                ),
                                                Text(
                                                    '${favData.homesList[index]['bathrooms']}')
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.numbers,
                                                  size: 18,
                                                ),
                                                Text(
                                                    '${favData.homesList[index]['area']}')
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ])),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(10))),
                                child: Text(
                                  favData.homesList[index]['type']!,
                                  style: style,
                                  textAlign: TextAlign.center,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                    onPressed: () {
                                      favData.removeFromFav(
                                          favData.homesList[index].id);
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )))
                          ],
                        ),
                      );
                    })
                : Center(
                    child: Container(
                        height: 400,
                        child: Lottie.asset(
                          'assets/empty_fav.json',
                          repeat: false,
                          alignment: Alignment.center,
                          width: 200,
                        )),
                  ),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
      },
    );
  }
}
