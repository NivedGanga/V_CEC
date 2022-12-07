

import 'package:flutter/material.dart';



class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 228, 236, 255),
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 0, 115, 133),
        centerTitle: true,
        title:const Text('About'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: Column(
                    children: const[
                      Padding(
                        padding:
                             EdgeInsets.only(left: 18, right: 18, top: 25),
                        child: Text(
                          '''CEC at your fingertips!
        While you are busy with your college academics and other stuffs, don't worry about missing any of the college activities, events, highlights and much more. Getting to know about college things through notice boards has become a thing of past. Which is why PRODDEC CEC is up with V- CEC.
        
This is the official App of CEC to keep you updated with the institution, forums, university notifications, and everything that's happening in every nook and corner of CEC.
        
Features
        
~ Stay updated with latest notifications from the University and college, along with it's corresponding links to browse to the websites.
        
~ Navigate easily to CEC's moodle website.
~ A click on the logo takes you to the official website of CEC.
~ Forums tab:
~ You will have the events and notices put up by our students' forums like PRODDEC, IEEE, FOCES and much more here.
~ Option for admins to add events in forums tab along with a poster, description and the respective links.
~  The app provides syllabus oriented notes and materials, student corner for clearing doubts. This helps the students to get the latest notes easily as per the curriculum.
~ More features will be added in the coming updates.
''',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
