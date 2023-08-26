// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:grobiz_web_landing/config/getx_put_initializer.dart';
// import 'package:grobiz_web_landing/garbadge/countries.dart';
// import 'package:grobiz_web_landing/garbadge/hover.dart';
// import 'package:grobiz_web_landing/page_route/route.dart';
// import 'package:grobiz_web_landing/view/Splash_screen.dart';
// import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_web_landing_screen.dart';
// import 'package:flutter/gestures.dart';
// import 'package:grobiz_web_landing/view/web/web_landing_page/web_landing_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:location/location.dart' as location_permission;
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   getXPutInitializer();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     // getPage();
//     log("in init");
//     // getCountryCode();
//     fetchIpAddress();
//     getUserLocation().then((Position position) {
//       print('Latitude: ${position.latitude}');
//       print('Longitude: ${position.longitude}');
//       getCurrentLocation(position: position);
//     }).catchError((error) {
//       print('Error: $error');
//     });
//     // getCurrentLocation();
//     log("in init end");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Grobiz Landing Page',
//       debugShowCheckedModeBanner: false,
//       scrollBehavior: MyCustomScrollBehavior(),
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//
//       // home:  const Scaffold(),
//       initialRoute: PageRoutes.initialRoute,
//       routes: routesPage,
//     );
//   }
//
//   getPage() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool? isLogin = prefs.getBool('is_login');
//     if (isLogin == true) {
//       // return const EditWebLandingScreen();
//       Get.off(() => const EditWebLandingScreen());
//     } else {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         // Call your button's onPressed function after a certain duration
//         Future.delayed(const Duration(seconds: 0), () {
//           Get.off(() => const WebLandingScreen());
//         });
//       });
//     }
//   }
//
//   Future<Position> getUserLocation() async {
//     LocationPermission permission;
//
//     // Check if location permission is granted
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // Request location permission if not granted
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Handle the scenario when the user denies the location permission
//         return Future.error('Location permission denied');
//       }
//     }
//     // else if(permission == LocationPermission.always || permission == LocationPermission.whileInUse){
//     //   /*Position*/ position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     //
//     //   if(position!=null){
//     //     double latitude=position.latitude;
//     //     double longitude=position.longitude;
//     //
//     //     List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude,localeIdentifier: 'en');
//     //     //print(placemarks.toString());
//     //     if(placemarks!=null){
//     //       String city=placemarks[0].locality.toString();
//     //       if(city=="")
//     //       {
//     //         city=placemarks[0].subAdministrativeArea.toString();
//     //       }
//     //       String state=placemarks[0].administrativeArea.toString();
//     //       String country=placemarks[0].country.toString();
//     //       String countryCode=placemarks[0].isoCountryCode.toString();
//     //
//     //       country_code=countryCode;
//     //
//     //       log("country_code   --- $country_code");
//     //       if(country_code=='IN'){
//     //         phone_code='91';
//     //       }
//     //
//     //       country_name=country;
//     //       stateValue=state;
//     //       cityValue=city;
//     //
//     //       countryList.forEach((element) {
//     //         if(element.name == country_name){
//     //           selectedCountry = element;
//     //         }
//     //       });
//     //
//     //       print(city);
//     //       print(country);
//     //       print(state);
//     //
//     //       if(this.mounted){
//     //         setState(() {
//     //         });
//     //       }
//     //     }
//     //   }
//     // }
//
//     /// Get the current position
//     Position position = await Geolocator.getCurrentPosition();
//     return position;
//   }
//
//   void getUserLocationPosition() async {
//     log("-----1111");
//     LocationPermission permission;
//     log("-----222222");
//
//     // Check if location permission is granted
//     permission = await Geolocator.checkPermission();
//     log("-----33333  $permission");
//     if (permission == LocationPermission.denied) {
//       log("-----444444");
//       // Request location permission if not granted
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         log("-----55555555");
//         // Handle the scenario when the user denies the location permission
//         // Handle the error or perform appropriate actions
//         print('Location permission denied');
//         return;
//       }
//     } else if (permission == LocationPermission.always ||
//         permission == LocationPermission.whileInUse) {
//       log("-----666666666666");
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//
//       if (position != null) {
//         double latitude = position.latitude;
//         double longitude = position.longitude;
//
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//             latitude, longitude,
//             localeIdentifier: 'en');
//
//         if (placemarks != null && placemarks.isNotEmpty) {
//           String city = placemarks[0].locality.toString();
//           if (city == "") {
//             city = placemarks[0].subAdministrativeArea.toString();
//           }
//           String state = placemarks[0].administrativeArea.toString();
//           String country = placemarks[0].country.toString();
//           String countryCode = placemarks[0].isoCountryCode.toString();
//
//           country_code = countryCode;
//           log("country_code   --- $country_code");
//
//           if (country_code == 'IN') {
//             phone_code = '91';
//           }
//
//           country_name = country;
//           stateValue = state;
//           cityValue = city;
//
//           countryList.forEach((element) {
//             if (element.name == country_name) {
//               selectedCountry = element;
//             }
//           });
//
//           print(city);
//           print(country);
//           print(state);
//
//           if (this.mounted) {
//             setState(() {});
//           }
//         }
//       }
//     }
//   }
//
//   String? country_name = 'India';
//   String? stateValue = '';
//   String? cityValue = '';
//   bool locationservicedenied = false;
//   late List<Country> countryList;
//   Country? selectedCountry;
//   // late List<Country> filteredCountries;
//   bool isLocationAllowed = false, isLocationPermissionChecked = false;
//   String country_code = '', phone_code = '', mobile_number = '';
//
//   location_permission.Location location = new location_permission.Location();
//
//   ////meghA sharma
// // getCurrentLocation({Position? position}) async {
// //   // var googleGeocoding = GoogleGeocoding("Your-Key");
// //
// //   log("step    -------     111");
// //   bool serviceEnabled;
// //   LocationPermission permission;
// //   log("step    -------    2222 ");
// //   // Test if location services are enabled.
// //
// //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //   log("step    -------     3333");
// //
// //   if (!serviceEnabled) {
// //     log("step    -------     4444");
// //
// //     serviceEnabled = await location.requestService();
// //     log("step    -------    5555 ");
// //
// //     if (!serviceEnabled) {
// //       log("step    -------    666666 ");
// //       locationservicedenied = true;
// //       isLocationAllowed=false;
// //       isLocationPermissionChecked=true;
// //       return Future.error('Location services are disabled.');
// //     }
// //     log("step    -------    777777 ");
// //
// //   }
// //   log("step    -------     888888888");
// //
// //   permission = await Geolocator.checkPermission();
// //   log("step    -------     999999");
// //
// //   if (permission == LocationPermission.denied) {
// //     log("step    -------    101010010 ");
// //
// //     permission = await Geolocator.requestPermission();
// //     if (permission == LocationPermission.denied) {
// //       if(this.mounted){
// //         isLocationAllowed=false;
// //         isLocationPermissionChecked=true;
// //         setState(() {});
// //       }
// //       return Future.error('Location permissions are denied');
// //     }
// //
// //     else if (permission == LocationPermission.deniedForever) {
// //       if(this.mounted){
// //         isLocationAllowed=false;
// //         isLocationPermissionChecked=true;
// //         setState(() {});
// //       }
// //       return Future.error(
// //           'Location permissions are permanently denied, we cannot request permissions.');
// //     }
// //
// //     else{
// //       isLocationAllowed=true;
// //       isLocationPermissionChecked=true;
// //
// //       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //
// //       if(position!=null){
// //         double latitude=position.latitude;
// //         double longitude=position.longitude;
// //         List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude,localeIdentifier: 'en',);
// //         if(placemarks!=null){
// //           print(placemarks.toString());
// //           String city=placemarks[0].locality.toString();
// //           if(city=="")
// //           {
// //             city=placemarks[0].subAdministrativeArea.toString();
// //           }
// //           String state=placemarks[0].administrativeArea.toString();
// //           String country=placemarks[0].country.toString();
// //           String countrycode=placemarks[0].isoCountryCode.toString();
// //
// //           country_code=countrycode;
// //
// //           print(country_code);
// //           //print('IN');
// //
// //           if(country_code=='IN'){
// //             phone_code='91';
// //           }
// //           country_name=country;
// //           stateValue=state;
// //           cityValue=city;
// //
// //           countryList.forEach((element) {
// //             if(element.name == country_name){
// //               selectedCountry = element;
// //             }
// //           });
// //
// //           print("city is ---- $city");
// //           print("country------ $country");
// //           print("state ----- $state");
// //
// //           if(this.mounted){
// //             setState(() {
// //             });
// //           }
// //         }
// //       }
// //     }
// //   }
// //
// //   else if (permission == LocationPermission.deniedForever) {
// //     log("step    -------     11 11 11 11 11 ");
// //
// //     if(this.mounted){
// //       setState(() {});
// //     }
// //     return Future.error(
// //         'Location permissions are permanently denied, we cannot request permissions.');
// //   }
// //
// //   else{
// //   log("step    -------    12 12 12 12 12  ");
// //   // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //   log("step    -------    131 13 13 13 13 13 ");
// //
// //     if(position!=null){
// //       log("step    -------    14 14 14 14 14 14  ");
// //
// //       double latitude=position.latitude;
// //       double longitude=position.longitude;
// //       log("step    -------    15 15 15 15 15 15 15  ");
// //
// //       List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude,localeIdentifier: 'en');
// //       log("step    -------    16 16 16 16 16 16 16  $placemarks");
// //       //print(placemarks.toString());
// //       if(placemarks!=null){
// //         log("step    -------   17  17 17 17   ${placemarks != null}");
// //         String city=placemarks[0].locality.toString();
// //         if(city=="")
// //         {
// //           log("step    -------    181818181818 ");
// //           city=placemarks[0].subAdministrativeArea.toString();
// //         }
// //         log("step    -------    19191919191919 ");
// //         String state=placemarks[0].administrativeArea.toString();
// //         String country=placemarks[0].country.toString();
// //         String countryCode=placemarks[0].isoCountryCode.toString();
// //         log("step    -------    2202020202020 ");
// //
// //         country_code=countryCode;
// //         log("step    -------    21 21 21 21 212121 ");
// //
// //         log("country_code +++++  --- $country_code");
// //         if(country_code=='IN'){
// //           phone_code='91';
// //         }
// //
// //         country_name=country;
// //         stateValue=state;
// //         cityValue=city;
// //
// //         countryList.forEach((element) {
// //           if(element.name == country_name){
// //             selectedCountry = element;
// //           }
// //         });
// //
// //         print(city);
// //         print(country);
// //         print(state);
// //
// //         if(this.mounted){
// //           setState(() {
// //           });
// //         }
// //       }
// //     }
// //   }
// // }
//
//   Future<void> getCurrentLocation({Position? position}) async {
//     bool isLocationAllowed = true;
//     bool isLocationPermissionChecked = false;
//
//     // Reverse geocoding
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//       position!.latitude,
//       position.longitude,
//       localeIdentifier: 'en',
//     );
//
//     if (placemarks.isNotEmpty) {
//       String city = placemarks[0].locality ?? '';
//       String state = placemarks[0].administrativeArea ?? '';
//       String country = placemarks[0].country ?? '';
//
//       print('City: $city');
//       print('State: $state');
//       print('Country: $country');
//     }
//
//     // Update the UI with location information
//     isLocationPermissionChecked = true;
//     // ...
//   }
//
//   // Future<String> getIPAddress() async {
//   //   final response =
//   //       await http.get(Uri.parse('https://api.ipify.org?format=json'));
//   //   if (response.statusCode == 200) {
//   //     final data = jsonDecode(response.body);
//   //     log("ip is --------- ${data["ip"]}");
//   //     return data['ip'];
//   //   } else {
//   //     throw Exception('Failed to retrieve IP address');
//   //   }
//   // }
//
//   Future<String> fetchCountryCode(String ipAddress) async {
//     log("ip address --- $ipAddress");
//     final apiKey = '33fed398f5472f02d9d252f8ff4e63d6'; // Replace with your actual API key
//     final response = await http.get(Uri.parse('https://api.ipapi.com/$ipAddress?access_key=$apiKey'));
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['country_code'];
//     } else {
//       throw Exception('Failed to fetch country code');
//     }
//   }
//
//   Future<String> fetchIpAddress() async {
//     final response =
//         await http.get(Uri.parse('https://api.ipify.org?format=json'));
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['ip'];
//     } else {
//       throw Exception('Failed to fetch IP address');
//     }
//   }
//
//   /*Future<void>*/ getCountryCode() async {
//     try {
//       final ipAddress = await fetchIpAddress();
//       final countryCode = await fetchCountryCode(ipAddress);
//       print('Country Code: $countryCode');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//
//
// }
//
// class MyCustomScrollBehavior extends MaterialScrollBehavior {
//   // Override behavior methods and getters like dragDevices
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//       };
// }



import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:grobiz_web_landing/config/getx_put_initializer.dart';
import 'package:grobiz_web_landing/config/local_storage.dart';
import 'package:grobiz_web_landing/page_route/route.dart';
import 'package:grobiz_web_landing/utils/shared_preference/shared_preference_services.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_controller/pricing_section_controller.dart';
import 'package:grobiz_web_landing/view/web/edit_web_landing_page/edit_web_landing_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:grobiz_web_landing/view/web/web_landing_page/web_landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getXPutInitializer();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final pricingScreenController = Get.find<PricingScreenController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Grobiz Landing Page',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:  MyCarousel(),
      initialRoute: PageRoutes.initialRoute,
      routes: routesPage,
    );
  }
 Future getPage() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    bool? isLogin =prefs.getBool('is_login');
    if(isLogin==true)
    {
      log("going to edit screen");
      // return const EditWebLandingScreen();
      Get.off(()=>const EditWebLandingScreen());
    }
    else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 0), () {
          log("going to regular screen");
          Get.off(()=>const WebLandingScreen());
          // Get.off(()=>const CareersScreen());

        });

      });
    }
  }

  Future<Position> getUserLocation() async {
    log("getUserLocation ----- 1");
    // pricingScreenController.getPlansData(lat: "21.2378888", long: "72.863352");
    LocationPermission permission;
    log("getUserLocation ----- 2");

    // Check if location permission is granted
    permission = await Geolocator.checkPermission();
    log("getUserLocation ----- 3");
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse){

    Position position = await Geolocator.getCurrentPosition();
    setDataToLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.lat,stringData: position.latitude.toString());
    setDataToLocalStorage(dataType: LocalStorage.stringType, prefKey: LocalStorage.long,stringData: position.longitude.toString());
    pricingScreenController.isLocation.value = true;
    log("is from permission always........ ${position.latitude.toString()}");
    pricingScreenController.getPlansData(lat: position.latitude.toString(), long: position.longitude.toString(),);
    }
    else if (permission == LocationPermission.denied) {
      pricingScreenController.isLocation.value = false;
      pricingScreenController.getPlansData(lat: "21.2378888", long: "72.863352");
      log("getUserLocation ----- 4");
      // Request location permission if not granted
      permission = await Geolocator.requestPermission();
      log("getUserLocation ----- 5");

      if (permission == LocationPermission.denied) {
        log("getUserLocation ----- 6");
        pricingScreenController.isLocation.value = false;
        pricingScreenController.getPlansData(lat: "21.2378888", long: "72.863352");
        log("getUserLocation ----- 7");
        // Handle the scenario when the user denies the location permission
        return Future.error('Location permission denied');
      }
    }
    else if (permission == LocationPermission.unableToDetermine){
      pricingScreenController.getPlansData(lat: "21.2378888", long: "72.863352");
      pricingScreenController.isLocation.value = false;
    }
    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    log("getUserLocation ----- 9");
    pricingScreenController.latitude.value = position.latitude.toString();
    log("getUserLocation ----- 10");
    pricingScreenController.longitude.value = position.longitude.toString();
    return position;
  }
}



class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}