import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telephony_sms/telephony_sms.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class BloodNeeded extends StatefulWidget {
  const BloodNeeded({Key? key}) : super(key: key);
  @override
  State<BloodNeeded> createState() => _BloodNeededState();
}

class _BloodNeededState extends State<BloodNeeded> {
  String? _selectedBloodGroup;
  final List<String> _bloodGroups = ['A', 'B+', 'O', 'O-', 'AB-'];
  final TextEditingController _hospitalController = TextEditingController();
  final places = GoogleMapsPlaces(
      apiKey: "<AIzaSyCsZGNzMyj0jyeH7Wtfw8gVOFFWlj7nlZ4>");
  final _telephonySms = TelephonySMS();

  @override
  void initState() {
    super.initState();
    _getNearbyHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Need', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 135, 4, 4),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "lib/Assets/187-1879841_iphone-7-plus-iphone-7-skyblue.jpg",
            ),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Color(0xFF710000),
              BlendMode.modulate,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'I need a blood group of : ',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedBloodGroup,
                hint: Text(
                  'Select a blood group',
                  style: TextStyle(color: Colors.white),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _selectedBloodGroup = newValue;
                  });
                },
                items: _bloodGroups.map<DropdownMenuItem<String>>((
                    String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors
                        .blueAccent)),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text(
                'At Hospital ',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 90),
                child: TextField(
                  cursorColor: Colors.white,
                  controller: _hospitalController,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  _getNearbyHospitals();
                  if (_selectedBloodGroup == null ||
                      _hospitalController.text.isEmpty) {
                    return;
                  }
                  var status = await Permission.sms.request();
                  if (status.isGranted) {
                    print('Presed ME ');
                    final contacts = await FlutterContacts.getContacts(
                      withProperties: true,);
                    _getNearbyHospitals();
                    List<String> phoneNumbers = [];
                    int c = 0;
                    // for (var contact in contacts) {
                    //   print(c);
                    //   for (var item in contact.phones!) {
                    //     phoneNumbers.add(item.number!);
                    //     print(item.number! + '   $c');
                    //     c++ ;
                    //   }
                    // }
                    // Send SMS to all phone numbers
                    // for (var phoneNumber in phoneNumbers) {
                    //   _telephonySms.sendSMS(phone: phoneNumber, message: message);
                    // }
                  }
                },
                child: Text('Send Now', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getNearbyHospitals() async {
    // Check for location permission (optional)
    var locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus.isGranted) {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Define a realistic search radius (e.g., 5 kilometers)
      final radius = 5000;

      try {
        // Use the correct method with valid location and radius
        PlacesSearchResponse response = await places.searchNearbyWithRadius(
            Location(lat: position.latitude, lng: position.longitude),
            radius,
            type: 'hospital');

        // Process the results and print hospital names to console
        if (response.status == 'OK') {
          for (var hospital in response.results) {
            print(hospital.name);
          }
        } else {
          print("Error fetching hospitals: ${response.errorMessage}");
        }
      } catch (error) {
        print("Error during search: $error");
      }
    } else {
      print("Location permission is not granted");
    }
  }
}
