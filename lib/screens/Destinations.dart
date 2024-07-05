import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:travel_directory/DATA/package.dart';
import 'package:travel_directory/screens/Details.dart';
import 'package:travel_directory/screens/Tour_Packages.dart';
import 'package:travel_directory/screens/package_by_region.dart';

class Destinations extends StatefulWidget {
  const Destinations({Key? key}) : super(key: key);

  @override
  State<Destinations> createState() => _Destinations();
}

class _Destinations extends State<Destinations> {
  List<Region> regions = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/packages.json');
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          regions = RegionFromJson(response);
          print(regions);
        }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Are You Ready For Vacation !',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 25, 173, 199)),
                    ),
                  ),
                ],
              )),
              if (regions != null && !regions.isEmpty)
                Container(
                  child: CarouselSlider.builder(
                    itemCount: regions.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return Container(
                        child: InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TourPackagesByRegion(
                                regions[index].regionPackages,
                              ),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(regions[index].img),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height: height * 0.35,
                                width: width * 0.5,
                              ),
                              Container(
                                height: height * 0.35,
                                width: width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.9),
                                      Colors.black.withOpacity(0.2),
                                      Colors.white.withOpacity(0.0),
                                    ],
                                    begin: FractionalOffset.bottomCenter,
                                    end: FractionalOffset.topCenter,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        regions[index].region,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction:
                          0.6, // Show multiple images on one slide
                    ),
                  ),

                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: Data.imgList.length,
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (context, index) {
                  //     return _placeCard(
                  //       height: height,
                  //       width: width,
                  //       index: index,
                  //       context: context,
                  //     );
                  //   },
                  // ),
                ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Most Popular',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Material(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                elevation: 10,
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/shan/inlay.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/mdy/sag0.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/mdy/pag0.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget _placeCard({width, height, index, context}) {
  //   return FadeInRight(
  //     child: Padding(
  //       padding: const EdgeInsets.all(5.0),
  //       child: Hero(
  //         tag: Data.imgList[index],
  //         child: Material(
  //           elevation: 8,
  //           borderRadius: BorderRadius.circular(15),
  //           child: InkWell(
  //             onTap: () => Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => PlaceDetails(
  //                   name: Data.names[index],
  //                   description: Data.details[index],
  //                   img: Data.imgList[index],
  //                   key: ValueKey<String>('Places'),
  //                   images: Data.imgDetailList[index],
  //                   labels: Data.imgDetailLabelList[index],
  //                 ),
  //               ),
  //             ),
  //             child: Stack(
  //               children: [
  //                 Container(
  //                   height: height * 0.35,
  //                   width: width * 0.4,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     image: DecorationImage(
  //                       image: AssetImage(
  //                         Data.imgList[index],
  //                       ),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   height: height * 0.35,
  //                   width: width * 0.4,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15),
  //                     gradient: LinearGradient(
  //                       colors: [
  //                         Colors.black.withOpacity(0.9),
  //                         Colors.black.withOpacity(0.2),
  //                         Colors.white.withOpacity(0.0),
  //                       ],
  //                       begin: FractionalOffset.bottomCenter,
  //                       end: FractionalOffset.topCenter,
  //                     ),
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.all(16),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         Text(
  //                           Data.names[index],
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 17,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   final List<Widget> imageSliders = Data.imgList
//       .map((item) => Container(
//             child: Container(
//               margin: EdgeInsets.all(5.0),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   child: Stack(
//                     children: <Widget>[
//                       Image.network(item, fit: BoxFit.cover, width: 1000.0),
//                       Positioned(
//                         bottom: 0.0,
//                         left: 0.0,
//                         right: 0.0,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color.fromARGB(200, 0, 0, 0),
//                                 Color.fromARGB(0, 0, 0, 0)
//                               ],
//                               begin: Alignment.bottomCenter,
//                               end: Alignment.topCenter,
//                             ),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                               vertical: 10.0, horizontal: 20.0),
//                           child: Text(
//                             'No. ${Data.imgList.indexOf(item)} image',
//                             style: TextStyle(
//                               color: const Color.fromARGB(255, 26, 23, 23),
//                               fontSize: 20.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ),
//           ))
//       .toList();
//
}
