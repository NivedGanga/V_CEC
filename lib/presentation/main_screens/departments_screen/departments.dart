import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/core/constants/constants.dart';
import 'package:v_cec_firebse1/presentation/main_screens/departments_screen/widgets/branchtile.dart';

class departments extends StatelessWidget {
 const departments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration:const BoxDecoration(color: Color.fromARGB(255, 228, 236, 255)),
        child: ListView.separated(
          itemBuilder: (BuildContext context, index) {
            return BranchTile(
              context: context,
              branch: branches[index],
              hod: hods[index],
              index: index,
            );
          },
          separatorBuilder: (BuildContext context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: branches.length,
        ),
      )),
    );
  }
}
