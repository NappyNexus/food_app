import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/colors.dart';
import 'location_feature.dart';

class TopBarAppBar extends StatelessWidget {
  const TopBarAppBar({super.key});

  @override
  Widget build(context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      toolbarHeight: 60,
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: IconButton(
          icon: Image.asset(
            "assets/menu (1).png",
            width: 25,
          ),
          onPressed: () {},
        ),
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            "Location",
            style: GoogleFonts.inconsolata(
                textStyle: TextStyle(fontSize: 18, color: Color(0xFFc4c4c4))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/placeholder.png",
                width: 20,
              ),
              const LocationFeature(),
            ],
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: IconButton(
            icon: Image.asset(
              "assets/active.png",
              width: 25,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
