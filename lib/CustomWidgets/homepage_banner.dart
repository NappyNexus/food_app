import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomepageBanner extends StatelessWidget {
  const HomepageBanner({super.key});
  @override
  Widget build(context) {
    return Center(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 160,
                width: 370,
                color: Colors.amber,
                child: Image.asset(
                  "assets/banner bg.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 28, left: 190),
            //color: Colors.amber,
            child: Image.asset(
              "assets/soup.png",
              height: 130,
            ),
          ),
          Container(
            //color: Colors.blueAccent,
            margin: const EdgeInsets.only(top: 26, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get special discount",
                  style: GoogleFonts.montserrat(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "up to 85%",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.white,
                      minimumSize: const Size(0, 40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "Claim voucher",
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}
