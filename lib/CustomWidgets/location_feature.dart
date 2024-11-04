import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationFeature extends StatefulWidget {
  const LocationFeature({super.key});

  @override
  State<LocationFeature> createState() => _LocationFeatureState();
}

class _LocationFeatureState extends State<LocationFeature> {
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
    return Text(
      _currentAddress ?? "",
      style: GoogleFonts.inconsolata(
          textStyle: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900)),
    );
  }
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