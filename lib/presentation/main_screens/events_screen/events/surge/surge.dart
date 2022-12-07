import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/detailed.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events/surge/addeventsurge.dart';
import 'package:v_cec_firebse1/core/constants/constants.dart';
//import 'package:size_config/size_config.dart';

class Surge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:const Color.fromARGB(255, 0, 115, 133),
          //Colors.white, //
          toolbarHeight: MediaQuery.of(context).size.height * .09,
          shadowColor: Colors.grey,
          iconTheme:const IconThemeData(color: Color.fromARGB(255, 0, 0, 0)),
          title: SizedBox(
            //height: MediaQuery.of(context).size.height * .07,
            child: SizedBox(
              //color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .165,
                  ),
                  CircleAvatar(
                      backgroundColor:const Color.fromARGB(255, 255, 255, 255),
                      radius: 25,
                      backgroundImage: AssetImage(forumlogos[10])),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .02,
                  ),
                  Text("SURGE",
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w700,
                        color:const Color.fromARGB(228, 255, 255, 255),
                        fontSize: MediaQuery.of(context).size.height * .04,
                      ))
                ],
              ),
            ),
          ),
          actions: [
            (email == 'proddecapp@gmail.com' || email == 'surge@ceconline.edu')
                ? Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((ctx) =>const addeventsurge())));
                            },
                            icon:const Icon(Icons.library_add_outlined))),
                  )
                : Container()
          ]),
      backgroundColor:const Color.fromARGB(255, 0, 86, 99),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('eSurge')
              .orderBy('no', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      DocumentSnapshot _event = snapshot.data!.docs[index];
                      return Container(
                        decoration: BoxDecoration(
                            gradient:const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 106, 213, 199),
                                  Color.fromARGB(255, 187, 227, 220)
                                ],
                                end: Alignment.bottomRight,
                                begin: Alignment.topLeft),
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return detailed(event: _event);
                              }));
                            },
                            title: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2, bottom: 2, right: 2, left: 0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.34,
                                    height: MediaQuery.of(context).size.width *
                                        0.34,
                                    child: CachedNetworkImage(
                                      imageUrl: _event['image'],
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _event['name'],
                                        textAlign: TextAlign.center,
                                        style:const TextStyle(
                                          fontSize: 17,
                                          // fontFamily: ,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                      ),
                                      _event['date'].length > 0 &&
                                              _event['date'].length < 12 == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                 const Icon(Icons
                                                      .calendar_today_rounded),
                                                  Text(
                                                    _event['date'],
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .0200,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: snapshot.data!.docs.length),
              );
            }
          },
        ),
      ),
    );
  }
}
