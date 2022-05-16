import 'package:find_home/components/home_card/home_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeCardData = Provider.of<HomeCardViewModel>(context, listen: false);
    var style = const TextStyle(fontSize: 15, color: Colors.black54);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///price
                      Text(
                        homeCardData.home['price'],
                        style: style.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      ///address
                      Text(
                        '${homeCardData.home['city']} / ${homeCardData.home['address']}',
                        style: style,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ///details
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.bed,
                                size: 18,
                              ),
                              Text('${homeCardData.home['rooms']}')
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
                              Text('${homeCardData.home['bathrooms']}')
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
                              Text('${homeCardData.home['area']}')
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
                homeCardData.home['type']!,
                style: style,
                textAlign: TextAlign.center,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child:
                  Consumer<HomeCardViewModel>(builder: (context, viewModel, _) {
                return IconButton(
                    onPressed: () {
                      viewModel.isFav?viewModel.removeFromFav():
                      viewModel.addToFav();
                    },
                    icon: Icon(
                      viewModel.isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ));
              }))
        ],
      ),
    );
  }
}
