
import 'package:fitfolio/view/sub_screens_wtd/other_sub/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utility/utilitycolor.dart';


class SplaceScreen extends StatefulWidget {
  const SplaceScreen({Key? key}) : super(key: key);

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {

  @override
  void initState() {
    super.initState();
    toLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: screenHeight * 0.9,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.4,
                child: Image.asset(
                  'assets/images/fitfolio-logo (1).png',
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                'LetStart..',
                style:
                    GoogleFonts.acme(fontSize: 25, fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
      ),
    );
  }
}
