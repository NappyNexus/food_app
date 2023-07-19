import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});
  @override
  Widget build(context) {
    return Container(
      height: 60,
      width: 370,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color.fromARGB(255, 238, 238, 238),
        border: Border.all(
          color: Color(0xFFc4c4c4),
        ),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            size: 25,
            color: Color(0xFF2b2e3b),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your food...',
                border: InputBorder.none,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Color(0xFFc4c4c4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
