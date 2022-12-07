import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

import '../../../core/constants/constants.dart';

class Mainmenu extends StatefulWidget {
  const Mainmenu({Key? key}) : super(key: key);

  @override
  State<Mainmenu> createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  @override
  void initState() {
    super.initState();
  }

  int activepage = 0;
  late int imglength;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 228, 236, 255),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 0,
                ),

                //image corousel

                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 9 / 16,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('HomeScreen')
                            .snapshots(),
                        builder: (BuildContext context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return CarouselSlider.builder(
                              unlimitedMode: true,
                              autoSliderTransitionTime:
                                  const Duration(milliseconds: 500),
                              enableAutoSlider: true,
                              slideIndicator: CircularSlideIndicator(
                                indicatorBorderWidth: 0,
                                currentIndicatorColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                indicatorRadius: 4.5,
                                itemSpacing: 14,
                                indicatorBackgroundColor:
                                    const Color.fromARGB(189, 106, 106, 106),
                                padding: const EdgeInsets.only(bottom: 10),
                              ),
                              slideBuilder: (index) {
                                DocumentSnapshot homepics =
                                    snapshot.data!.docs[index];

                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        homepics['Img'],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                          }
                        })),

                //buttonlist
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                      const CircleBorder()),
                                ),
                                child:
                                    Image(image: AssetImage(forumlogos[index])),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) {
                                    return forum_pages[index];
                                  })));
                                }),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, index) {
                        return const SizedBox(
                          width: 5,
                        );
                      },
                      itemCount: forumlogos.length - 1),
                ),

                //other

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('record')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      DocumentSnapshot record = snapshot.data!.docs.first;
                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      record['placement'],
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 45, 151, 131),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'PLACEMENTS',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      record['offers'],
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 45, 151, 131),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'JOB OFFERS',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18)
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18),
                              Column(
                                children: [
                                  Text(
                                    record['companies'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 45, 151, 131),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'COMPANIES',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(),
                              Column(
                                children: [
                                  Text(
                                    record['package'],
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 45, 151, 131),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'HIGHEST PACKAGE',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.13),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),

                //quote
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          '''“I am sure that the students of College of Engineering Chengannur shall be empowered to achieve their life’s dreams through the knowledge gained here”''',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 19,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 5),
                        child: Text(
                          '~ Dr.Smitha Dharan',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
