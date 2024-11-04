import 'package:flutter/material.dart';
import 'package:food_app/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:food_app/CustomWidgets/food_card.dart';
import 'package:food_app/CustomWidgets/homepage_banner.dart';
import 'package:food_app/CustomWidgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      //appBar: TopBarAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Top Card
            const HomepageBanner(),
            //Search Bar
            const SearchBarWidget(),
            //Food Display
            Container(
              //margin: EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Popular Food",
                    style: GoogleFonts.montserrat(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 130,
                  ),
                  TextButton(
                      child: Text(
                        "View all",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF7f7f7f)),
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            //Food Cards
            const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FoodCard("4.8", "Super Burrito", "\$24.00",
                        "assets/burrito.png"),
                    FoodCard("4.8", "Musicoburger", "\$26.30",
                        "assets/hamburger.png"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FoodCard("4.8", "Family S. Pizza", "\$30.00",
                        "assets/pizza.png"),
                    FoodCard("4.8", "Egg Sandwich", "\$25.10",
                        "assets/sandwich.png"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
