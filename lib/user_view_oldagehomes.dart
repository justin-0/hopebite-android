// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hopebite_android/user_send_donation_request.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:location/location.dart' as loc;
//
// class ViewOldAgeHomes extends StatefulWidget {
//   const ViewOldAgeHomes({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewOldAgeHomes> createState() => _ViewOldAgeHomesState();
// }
//
// class _ViewOldAgeHomesState extends State<ViewOldAgeHomes> {
//
//   final loc.Location location = loc.Location();
//   loc.LocationData? currentPosition;
//
//   List<String> id_ = [];
//   List<String> name_ = [];
//   List<String> phone_ = [];
//   List<String> place_ = [];
//   List<String> address_ = [];
//   List<String> distance_ = [];
//   List<String> requestStatus_ = []; // ✅ NEW
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//     viewOldAgeHomes();
//   }
//
//   // ------------------ GET CURRENT LOCATION ------------------
//   Future<void> getCurrentLocation() async {
//     try {
//       bool enabled = await location.serviceEnabled();
//       if (!enabled) {
//         enabled = await location.requestService();
//         if (!enabled) return;
//       }
//
//       var permission = await location.hasPermission();
//       if (permission == loc.PermissionStatus.denied) {
//         permission = await location.requestPermission();
//         if (permission != loc.PermissionStatus.granted) return;
//       }
//
//       currentPosition = await location.getLocation();
//       viewOldAgeHomes();
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Location error: $e");
//     }
//   }
//
//   // ------------------ FETCH OLD AGE HOMES ------------------
//   Future<void> viewOldAgeHomes() async {
//
//     if (currentPosition == null) return;
//
//     List<String> id = [];
//     List<String> name = [];
//     List<String> phone = [];
//     List<String> place = [];
//     List<String> address = [];
//     List<String> distance = [];
//     List<String> requestStatus = [];
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String baseUrl = sh.getString('url') ?? "";
//       String lid = sh.getString('lid') ?? ""; // ✅ USER ID
//
//       var res = await http.post(
//         Uri.parse('$baseUrl/user_view_nearest_oldagehomes/'),
//         body: {
//           'latitude': currentPosition!.latitude.toString(),
//           'longitude': currentPosition!.longitude.toString(),
//           'lid': lid,
//         },
//       );
//
//       var jsonData = jsonDecode(res.body);
//
//       if (jsonData['status'] == 'ok') {
//         var arr = jsonData['data'];
//
//         for (int i = 0; i < arr.length; i++) {
//           id.add(arr[i]['id'].toString());
//           name.add(arr[i]['name']);
//           phone.add(arr[i]['phone']);
//           place.add(arr[i]['place']);
//           address.add(arr[i]['address']);
//           distance.add(arr[i]['distance_km'].toString());
//           requestStatus.add(arr[i]['request_status']); // ✅
//         }
//
//         setState(() {
//           id_ = id;
//           name_ = name;
//           phone_ = phone;
//           place_ = place;
//           address_ = address;
//           distance_ = distance;
//           requestStatus_ = requestStatus;
//         });
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   // ------------------ UI ------------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: Text(widget.title),
//       ),
//
//       body: id_.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 8,
//             margin: const EdgeInsets.all(10),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Text(
//                     name_[index],
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   Text("📍 Place: ${place_[index]}"),
//                   Text("🏠 Address: ${address_[index]}"),
//                   Text("📞 Phone: ${phone_[index]}"),
//                   Text("📏 Distance: ${distance_[index]} km"),
//
//                   const SizedBox(height: 12),
//
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: requestStatus_[index] == "pending"
//                         ? const Text(
//                       "⏳ Request Pending",
//                       style: TextStyle(
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                         : ElevatedButton.icon(
//                       icon: const Icon(Icons.send),
//                       label: const Text("Request"),
//                       onPressed: () async {
//                         SharedPreferences sh =
//                         await SharedPreferences.getInstance();
//                         sh.setString("home_id", id_[index]);
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) =>
//                                 SendDonationRequestPage(
//                                   homeName: name_[index],
//                                 ),
//                           ),
//
//                         );
//                         viewOldAgeHomes();
//
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopebite_android/user_send_donation_request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;

class ViewOldAgeHomes extends StatefulWidget {
  const ViewOldAgeHomes({super.key, required this.title});
  final String title;

  @override
  State<ViewOldAgeHomes> createState() => _ViewOldAgeHomesState();
}

class _ViewOldAgeHomesState extends State<ViewOldAgeHomes> {

  final loc.Location location = loc.Location();
  loc.LocationData? currentPosition;

  List<String> id_ = [];
  List<String> name_ = [];
  List<String> phone_ = [];
  List<String> place_ = [];
  List<String> address_ = [];
  List<String> distance_ = [];
  List<String> requestStatus_ = [];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    viewOldAgeHomes();
  }

  Future<void> getCurrentLocation() async {
    try {
      bool enabled = await location.serviceEnabled();
      if (!enabled) {
        enabled = await location.requestService();
        if (!enabled) return;
      }

      var permission = await location.hasPermission();
      if (permission == loc.PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != loc.PermissionStatus.granted) return;
      }

      currentPosition = await location.getLocation();
      viewOldAgeHomes();
    } catch (e) {
      Fluttertoast.showToast(msg: "Location error: $e");
    }
  }

  Future<void> viewOldAgeHomes() async {

    if (currentPosition == null) return;

    List<String> id = [];
    List<String> name = [];
    List<String> phone = [];
    List<String> place = [];
    List<String> address = [];
    List<String> distance = [];
    List<String> requestStatus = [];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String baseUrl = sh.getString('url') ?? "";
      String lid = sh.getString('lid') ?? "";

      var res = await http.post(
        Uri.parse('$baseUrl/user_view_nearest_oldagehomes/'),
        body: {
          'latitude': currentPosition!.latitude.toString(),
          'longitude': currentPosition!.longitude.toString(),
          'lid': lid,
        },
      );

      var jsonData = jsonDecode(res.body);

      if (jsonData['status'] == 'ok') {
        var arr = jsonData['data'];

        for (int i = 0; i < arr.length; i++) {
          id.add(arr[i]['id'].toString());
          name.add(arr[i]['name']);
          phone.add(arr[i]['phone']);
          place.add(arr[i]['place']);
          address.add(arr[i]['address']);
          distance.add(arr[i]['distance_km'].toString());
          requestStatus.add(arr[i]['request_status']);
        }

        setState(() {
          id_ = id;
          name_ = name;
          phone_ = phone;
          place_ = place;
          address_ = address;
          distance_ = distance;
          requestStatus_ = requestStatus;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00796B),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: id_.isEmpty
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : ListView.builder(
          padding: const EdgeInsets.all(12),
          physics: const BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      name_[index],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Expanded(child: Text(place_[index])),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.home, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Expanded(child: Text(address_[index])),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Text(phone_[index]),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.route, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Text("${distance_[index]} km away"),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerRight,
                      child: requestStatus_[index] == "pending"
                          ? const Text(
                        "Request Pending",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                          : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00796B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.send),
                        label: const Text("Send Request",
                          style: TextStyle(color: Colors.white), ),
                        onPressed: () async {
                          SharedPreferences sh =
                          await SharedPreferences.getInstance();
                          sh.setString("home_id", id_[index]);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SendDonationRequestPage(
                                homeName: name_[index],
                              ),
                            ),
                          );

                          viewOldAgeHomes();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
