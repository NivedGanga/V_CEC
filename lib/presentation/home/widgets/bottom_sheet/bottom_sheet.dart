import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:v_cec_firebse1/domain/uploadUserImage.dart';
import 'package:v_cec_firebse1/presentation/home/home.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/loginscreen.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/about.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/help.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/location.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/profilepic.dart';

bottom_sheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: const Color.fromARGB(0, 192, 144, 0),
    context: context,
    builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.065,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Color.fromARGB(255, 10, 115, 94),
                    image: DecorationImage(
                      opacity: 0.3,
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/pic1-01-scaled.jpeg',
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Text(
                            username,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ktuid,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const Location();
                                        }));
                                      },
                                      child: const Icon(
                                        Icons.location_on,
                                        size: 35,
                                        color: Colors.white,
                                      )),
                                  const Text(
                                    'Location',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.0,
                              ),
                              Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return About();
                                        }));
                                      },
                                      child: const Icon(
                                        Icons.info,
                                        size: 35,
                                        color: Colors.white,
                                      )),
                                  const Text(
                                    'About',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox(),
                              Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const Help();
                                        }));
                                      },
                                      child: const Icon(
                                        Icons.help,
                                        size: 35,
                                        color: Colors.white,
                                      )),
                                  const Text(
                                    '     Help    ',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const SizedBox()
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                            ),
                            onPressed: () async {
                              logout(context);
                              await FirebaseAuth.instance.signOut();

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              ' Logout ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            child: ValueListenableBuilder(
                valueListenable: profilepiclink,
                builder: (context, String value, child) {
                  return CircleAvatar(
                    backgroundColor: const Color.fromARGB(0, 255, 193, 7),
                    radius: 50,
                    child: profilepiclink.value == ''
                        ? ProfilePicture(
                            name: username.substring(0, 3),
                            radius: 50,
                            fontsize: 30,
                          )
                        : ProfilePicture(
                            name: username.substring(0, 3),
                            radius: 50,
                            fontsize: 30,
                            img: profilepiclink.value,
                          ),
                  );
                }),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const ProfilePic();
                },
              ));
            },
          ),
        ],
      );
    },
  );
}
