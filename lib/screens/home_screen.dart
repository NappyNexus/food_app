import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:food_app/CustomWidgets/food_card.dart';
import 'package:food_app/CustomWidgets/homepage_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _currentAddress;
  Position? _currentPosition;

  //This override will get the location automatically
  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.subAdministrativeArea}';
        // '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  //⬇️⬇️⬇️UI Design⬇️⬇️⬇️
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        toolbarHeight: 60,
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
                Text(
                  "${_currentAddress ?? ""}",
                  style: GoogleFonts.inconsolata(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w900)),
                ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Top Card
            HomepageBanner(),
            //Search Bar
            Container(
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
            ),
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
                  SizedBox(
                    width: 130,
                  ),
                  TextButton(
                      child: Text(
                        "View all",
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF7f7f7f)),
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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: const Text("Location Page")),
  //     body: SafeArea(
  //       child: Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text('LAT: ${_currentPosition?.latitude ?? ""}'),
  //             Text('LNG: ${_currentPosition?.longitude ?? ""}'),
  //             Text('ADDRESS: ${_currentAddress ?? ""}'),
  //             const SizedBox(height: 32),
  //             ElevatedButton(
  //               onPressed: _getCurrentPosition,
  //               child: const Text("Get Current Location"),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
