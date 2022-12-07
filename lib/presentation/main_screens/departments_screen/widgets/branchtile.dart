import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:v_cec_firebse1/core/constants/constants.dart';

class BranchTile extends StatelessWidget {
  BuildContext context;
  String branch;
  String hod;
  int index;
  BranchTile({super.key, 
    required this.context,
    required this.branch,
    required this.hod,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.174,
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
            ),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: size.width * 0.059,
                    )),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 2, 148, 157),
                                width: 1.9,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                              ),
                            )),
                            overlayColor: MaterialStateProperty.all(null),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 255, 255, 255))),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return facultipages[index];
                          }));
                        },
                        child: Text(branch,
                            style: TextStyle(
                                fontSize: size.height * 0.025,
                                color: const Color.fromARGB(255, 2, 148, 157),
                                fontFamily: 'kdam',
                                fontWeight: FontWeight.w500))),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            height: double.infinity,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.5,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20)),
                                    )),
                                    elevation: MaterialStateProperty.all(5),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255))),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return facultipages[index];
                                  }));
                                },
                                child: Text(
                                  hod,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                )),
                          ),
                        )
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
