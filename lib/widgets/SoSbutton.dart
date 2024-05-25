// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:hive/hive.dart';
// import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:telephony_sms/telephony_sms.dart';
//
// class SOSButton extends StatefulWidget {
//   @override
//   _SOSButtonState createState() => _SOSButtonState();
// }
//
// class _SOSButtonState extends State<SOSButton> {
//   bool isClicked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onLongPress: () async {
//         setState(() {
//           isClicked = !isClicked;
//         });
//
//         if (isClicked) {
//           try {
//             await _shareLocationWithNearbyDevices();
//             await _shareLocationWithFavorites();
//
//             final snackBar=SnackBar(content: Text("Your location has been Shared"),backgroundColor: Colors.red,);
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           } catch (e) {
//             print("Error sharing location: $e");
//           }
//         }
//       },
//       child: Container(
//         width: 200,
//         height: 200,
//         child: Lottie.asset(
//           'lib/Assets/SOSbutton.json', // Path to your Lottie animation file
//           animate: isClicked,
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> _shareLocationWithFavorites() async {
//   try {
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//     if (!(await Permission.sms.request().isGranted)) {
//       print('Sms Permission not granted');
//       return;
//     }
//
//     final contactsBox = await Hive.openBox('favorites');
//
//     for (var value in contactsBox.values) {
//       if (value is Map<String, dynamic> || value is Map<dynamic, dynamic>) {
//         FavoriteContact contact = FavoriteContact.fromJson(value);
//       }
//     }
//
//     // Discover Bluetooth devices
//     // _startBluetoothScanning(); // Call Bluetooth scanning method
//
//   } catch (e) {
//     print("Error sharing location: $e");
//   }
// }
//
// Future<void> _notifyContact(FavoriteContact contact, double latitude, double longitude) async {
//   String phoneNumber = contact.phoneNumber;
//   final _telephonySMS = TelephonySMS();
//   await _telephonySMS.requestPermission();
//   String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
//   await _telephonySMS.sendSMS(
//       phone: phoneNumber,
//       message: 'Emergency: I need help my location is Latitude: $latitude ,Longitude : $longitude  Track me at : $googleMapsUrl');
// }
//
// class FavoriteContact {
//   String name;
//   String phoneNumber;
//
//   FavoriteContact({
//     required this.name,
//     required this.phoneNumber,
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'phoneNumber': phoneNumber,
//     };
//   }
//
//   factory FavoriteContact.fromJson(Map<String, dynamic> json) {
//     return FavoriteContact(
//       name: json['name'],
//       phoneNumber: json['phoneNumber'],
//     );
//   }
// }
//
// // Bluetooth scanning logic
// // void _startBluetoothScanning() async {
// //   if (await Permission.bluetooth.request().isGranted) {
// //     FlutterBluePlus.adapterState.listen((state) {
// //       if (state == BluetoothAdapterState.on) {
// //         FlutterBluePlus.startScan(timeout: Duration(seconds:45));
// //       }
// //     });
// //
// //     FlutterBluePlus.scanResults.listen((results) {
// //       for (ScanResult r in results) {
// //         // ignore: deprecated_member_use
// //         print('Device ${r.device.remoteId}: "${r.advertisementData.advName}" found!');
// //       }
// //     }, onError: (e) {
// //       print('Error during scanning: $e');
// //     });
// //   } else {
// //     print('Bluetooth permission not granted');
// //   }
// // }
// Future<void> _shareLocationWithNearbyDevices() async {
//   // Request necessary permissions
//   if (await [Permission.bluetooth, Permission.location].request().then((Map<Permission, PermissionStatus> status) => status.values.every((element) => element == PermissionStatus.granted))) {
//     try {
//       // Get current location
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       double latitude = position.latitude;
//       double longitude = position.longitude;
//
//       // Start advertising location data (adjust format as needed)
//       // await FlutterBluePlus.startAdvertising(
//       //   id: "my_location_beacon",
//       //   advertisementData: {
//       //     "latitude": latitude.toString(),
//       //     "longitude": longitude.toString(),
//       //   },
//       // );
//       //
//       // // Listen for errors during advertising
//       // FlutterBluePlus.isAdvertising.listen((isAdvertising) {
//       //   if (!isAdvertising) {
//       //     print("Error: Advertising stopped unexpectedly.");
//       //   }
//       // });
//
//       // Show success snackbar
//       // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
//       //   SnackBar(content: Text("Sharing location with nearby devices..."),
//       //       backgroundColor: Colors.blue),
//       // );
//     } catch (e) {
//       print("Error sharing location: $e");
//     }
//   } else {
//     print("Permissions not granted.");
//
//   }
// }
// // Future<void> _triggerLocationSharing() async {
// //   try {
// //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //
// //     // Store location coordinates for advertising
// //     double latitude = position.latitude;
// //     double longitude = position.longitude;
// //
// //     // Start advertising location data (adjust data format as needed)
// //     FlutterBluePlus.adapterState.startAdvertising(
// //       id: "my_location_beacon", // Use a unique identifier
// //       advertisementData: {
// //         "latitude": "$latitude",
// //         "longitude": "$longitude",
// //       },
// //     );
// //
// //     // ... proceed with Bluetooth scanning and location sharing features
// //
// //   } catch (e) {
// //     print("Error sharing location: $e");
// //   }
// // }
// //
// // import 'dart:async';
// // import 'dart:typed_data';
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:hive/hive.dart';
// // import 'package:lottie/lottie.dart';
// // import 'package:uuid/uuid.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:telephony_sms/telephony_sms.dart';
// // import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// //
// // class SOSButton extends StatefulWidget {
// //   @override
// //   _SOSButtonState createState() => _SOSButtonState();
// // }
// //
// // class _SOSButtonState extends State<SOSButton> {
// //   bool isClicked = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onLongPress: () async {
// //         setState(() {
// //           isClicked = !isClicked;
// //         });
// //
// //         if (isClicked) {
// //           try {
// //             await _shareLocationWithFavorites();
// //             final snackBar =
// //             SnackBar(content: Text("Your location has been Shared"), backgroundColor: Colors.red);
// //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //           } catch (e) {
// //             print("Error sharing location: $e");
// //           }
// //         }
// //       },
// //       child: Container(
// //         width: 200,
// //         height: 200,
// //         child: Lottie.asset(
// //           'lib/Assets/SOSbutton.json', // Path to your Lottie animation file
// //           animate: isClicked,
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // Future<void> _shareLocationWithFavorites() async {
// //   try {
// //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //
// //     if (!(await Permission.sms.request().isGranted)) {
// //       print('Sms Permission not granted');
// //       return;
// //     }
// //
// //     final contactsBox = await Hive.openBox('favorites');
// //
// //     for (var value in contactsBox.values) {
// //       if (value is Map<String, dynamic> || value is Map<dynamic, dynamic>) {
// //         FavoriteContact contact = FavoriteContact.fromJson(value);
// //         await _notifyContact(contact, position.latitude, position.longitude); // Await here
// //       }
// //     }
// //
// //     // Broadcast location via Bluetooth
// //     _broadcastLocation(position.latitude, position.longitude);
// //
// //   } catch (e) {
// //     print("Error sharing location: $e");
// //   }
// // }
// //
// // Future<void> _notifyContact(FavoriteContact contact, double latitude, double longitude) async {
// //   String phoneNumber = contact.phoneNumber;
// //   final _telephonySMS = TelephonySMS();
// //   await _telephonySMS.requestPermission();
// //   String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
// //   await _telephonySMS.sendSMS(
// //       phone: phoneNumber,
// //       message: 'Emergency: I need help my location is Latitude: $latitude ,Longitude : $longitude  Track me at : $googleMapsUrl');
// // }
// //
// // class FavoriteContact {
// //   String name;
// //   String phoneNumber;
// //
// //   FavoriteContact({
// //     required this.name,
// //     required this.phoneNumber,
// //   });
// //
// //   Map<String, dynamic> toJson() {
// //     return {
// //       'name': name,
// //       'phoneNumber': phoneNumber,
// //     };
// //   }
// //
// //   factory FavoriteContact.fromJson(Map<String, dynamic> json) {
// //     return FavoriteContact(
// //       name: json['name'],
// //       phoneNumber: json['phoneNumber'],
// //     );
// //   }
// // }
// //
// // // Bluetooth broadcasting logic
// // Future<void> _broadcastLocation(double latitude, double longitude) async {
// //   // Generate random UUIDs (replace with your own if needed for compatibility)
// //   final serviceUuid = Uuid.parse("0000AA00-0000-1000-8000-00805F9B34FB");
// //   final characteristicUuid = Uuid.parse("0000AA01-0000-1000-8000-00805F9B34FB");
// //
// //   FlutterBluePlus.adapterState.startAdvertsing(
// //     advertisementData: BmScanAdvertisement.fromMap(
// //       serviceUuids: [serviceUuid],
// //       manufacturerData: {
// //         serviceUuid.toString(): _encodeLocationData(latitude, longitude),
// //       },
// //     ),
// //   );
// // }
// //
// // List<int> _encodeLocationData(double latitude, double longitude) {
// //   // Convert latitude and longitude to bytes and encode them
// //   // For simplicity, you can use fixed length for latitude and longitude
// //   // For example, 4 bytes for each (32-bit float)
// //   var latitudeBytes = latitude.toBytes();
// //   var longitudeBytes = longitude.toBytes();
// //
// //   // Combine latitude and longitude bytes into a single list
// //   var locationData = [...latitudeBytes, ...longitudeBytes];
// //
// //   return locationData;
// // }
// //
// // extension DoubleExtensions on double {
// //   List<int> toBytes() {
// //     return Float32List.fromList([this]).buffer.asUint8List();
// //   }
// // }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony_sms/telephony_sms.dart';

class SOSButton extends StatefulWidget {
  @override
  _SOSButtonState createState() => _SOSButtonState();
}
class _SOSButtonState extends State<SOSButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async { // Move async here
        setState(() {
          isClicked = !isClicked;
        });

        if (isClicked) {
          try {
            await _shareLocationWithFavorites(context);
            // print("Successfully shared location with favorites");
            // final snackBar=SnackBar(content: Text("Your location has been Shared"),backgroundColor: Colors.red,);
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } catch (e) {
            print("Error sharing location:$e");
          }
        }
      },
      child: Container(
        // Adjust container size as needed
        width: 200,
        height: 200,
        child: Lottie.asset(
          'lib/Assets/SOSbutton.json', // Path to your Lottie animation file
          animate: isClicked,
        ),
      ),
    );
  }
}
Future<void> _shareLocationWithFavorites(context) async {
  try {
    // Get current location
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if(!(await Permission.sms.request().isGranted)){
      print('Sms Permission not granted');
      return ;
    }

    final contactsBox = await Hive.openBox('favorites');
    // print("Hive box 'favorites' opened successfully.");
    // Iterate through favorite contacts
    // print('Number of values in contactsBox: ${contactsBox.values.length}');
    if (contactsBox.isNotEmpty) {
      final snackBar=SnackBar(content: Text("Your location has been Shared"),backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      for (var value in contactsBox.values) {
        print('fetching ...');
        print('Value is a ${value.runtimeType}: $value');

        print("trying to enter, ${value.runtimeType}");
        if (value is Map<String, dynamic> || value is Map<dynamic, dynamic>) {
          if (value is Map<String, dynamic>) {
            print("IN 1");
            print("I am in <String, dynamic>");
            print('Value is a map: $value');
            if (value.containsKey('name')) {
              print('Value contains key "name": ${value['name']}');
              FavoriteContact contact = FavoriteContact.fromJson(value);
              print('Favorite contact name: ${contact
                  .name}'); // Print contact name
              // Notify contact about shared location
              _notifyContact(contact, position.latitude, position.longitude);
            }
          } else if (value is Map<dynamic, dynamic>) {
            print("I am in <dynamic, dynamic>");
            Map<String, dynamic> typedMap = value.cast<String, dynamic>();
            FavoriteContact contact = FavoriteContact.fromJson(typedMap);
            print('Favorite contact name: ${contact.name}');
            _notifyContact(contact, position.latitude, position.longitude);
          }
          else {
            print("IN 3");
            print('Value does not contain key "name"');
          }
        }
        else {
          print('Value is not a map: $value');
        }
      }
    }else{
      print('Please select at least 1 favorite contact');
      // Display error message to the user
      final snackBar=SnackBar(content: Text("Please select at least 1 favorite contact"),backgroundColor: Colors.red,);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


  } catch (e) {
    print("Error sharing location: $e");
    // Handle error
  }
}

Future<void> _notifyContact(FavoriteContact contact, double latitude, double longitude) async {
  String phoneNumber = contact.phoneNumber;
  final _telephonySMS = TelephonySMS();
  await _telephonySMS.requestPermission();
  String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  String message1 = 'Emergency: I need help my location is Latitude: $latitude ,Longitude : $longitude  Track me at : $googleMapsUrl';
  await _telephonySMS.sendSMS(
      phone: phoneNumber,
      message: message1);
}
class FavoriteContact {
  String name;
  String phoneNumber;

  FavoriteContact({
    required this.name,
    required this.phoneNumber,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
  factory FavoriteContact.fromJson(Map<String, dynamic> json) {
    return FavoriteContact(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }
}