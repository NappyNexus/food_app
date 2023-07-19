import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodCard extends StatelessWidget {
  const FoodCard(this.rateText, this.dishName, this.priceTag, this.foodImage,
      {super.key});

  final String rateText;
  final String dishName;
  final String priceTag;
  final String foodImage;

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      "assets/star.png",
                      height: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      rateText,
                      style: GoogleFonts.lora(fontSize: 15),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Image.asset(
                  foodImage,
                  height: 70,
                ),
              ),
              Text(
                dishName,
                style:
                    GoogleFonts.lora(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      priceTag,
                      style: GoogleFonts.lora(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFF2b2e3b), shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
