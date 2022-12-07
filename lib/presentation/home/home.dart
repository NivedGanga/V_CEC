import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_cec_firebse1/domain/emain_check/email_check.dart';
import 'package:v_cec_firebse1/presentation/home/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/Login_Functions.dart';
import 'package:v_cec_firebse1/presentation/login/Login_Page/loginscreen.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notices_screen/Notices.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/departments.dart';
import 'package:v_cec_firebse1/presentation/main_screens/events_screen/events.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/profilepic.dart';
import '../../domain/uploadUserImage.dart';
import 'package:v_cec_firebse1/presentation/main_screens/mainmenu_screen/mainmenu.dart';
import 'package:v_cec_firebse1/presentation/main_screens/notes_screen/notes.dart';
import 'package:bottom_bar_page_transition/bottom_bar_page_transition.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/about.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/help.dart';
import 'package:v_cec_firebse1/presentation/screens/account_screen/widgets/location.dart';

late ProfilePicture dp;
late ValueNotifier<String> profilepiclink;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

EventService eventService = EventService();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    dp = ProfilePicture(
      name: username.substring(0, 3),
      radius: 20,
      fontsize: 20,
    );

    super.initState();
  }

  final pages = [
    const Mainmenu(),
    const events(),
    Notices(),
    const departments(),
    const Notes(),
  ];
  final int _temp = email.length;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          (email.substring(_temp - 13, _temp) == "ceconline.edu")
              ? BottomNavigationBar(
                  unselectedItemColor: const Color.fromARGB(255, 63, 63, 63),
                  selectedItemColor: const Color.fromARGB(255, 58, 67, 142),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: selected,
                  onTap: (value) {
                    setState(() {
                      selected = value;
                    });
                  },
                  items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                            size: 30,
                          ),
                          label: 'HOME'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.event,
                            size: 30,
                          ),
                          label: 'EVENTS'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.notifications,
                            size: 30,
                          ),
                          label: 'NOTICES'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.people,
                            size: 30,
                          ),
                          label: 'BRANCHES'),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.folder),
                        label: 'FILES',
                      )
                    ])
              : BottomNavigationBar(
                  unselectedItemColor: const Color.fromARGB(255, 63, 63, 63),
                  selectedItemColor: const Color.fromARGB(255, 58, 67, 142),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: selected,
                  onTap: (value) {
                    setState(() {
                      selected = value;
                    });
                  },
                  items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                            size: 30,
                          ),
                          label: 'HOME'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.event,
                            size: 30,
                          ),
                          label: 'EVENTS'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.notifications,
                            size: 30,
                          ),
                          label: 'NOTICES'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.people,
                            size: 30,
                          ),
                          label: 'BRANCHES'),
                    ]),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 115, 133),
        leading: ifcec(selected, context),
        title: const Text(
          'V-CEC',
          style: TextStyle(
            fontFamily: 'crimson',
            fontSize: 33,
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: ValueListenableBuilder(
                  valueListenable: profilepiclink,
                  builder: (context, String value, chil) {
                    return TextButton(
                      onPressed: () {
                        bottom_sheet(context);
                      },
                      child: profilepiclink.value == ''
                          ? dp
                          : ProfilePicture(
                              name: username.substring(0, 3),
                              radius: 20,
                              fontsize: 21,
                              img: value,
                            ),
                    );
                  }),
            ),
          )
        ],
      ),
      body: BottomBarPageTransition(
        builder: (_, index) => pages[index],
        currentIndex: selected,
        totalLength: pages.length,
        transitionType: TransitionType.fade,
        transitionDuration: const Duration(milliseconds: 400),
        transitionCurve: Curves.ease,
      ),
    );
  }
}
