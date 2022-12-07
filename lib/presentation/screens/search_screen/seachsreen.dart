import 'package:flutter/material.dart';
import 'package:v_cec_firebse1/presentation/screens/search_screen/widgets/searchbar/searchbar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.023,
            ),
            const SearchBarWidget(),
          ],
        ),
      ),
    );
  }
}
