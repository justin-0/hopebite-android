// import 'package:flutter/material.dart';
// import 'package:hopebite_android/volunteer_edit_profile.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class ViewProfilePage extends StatefulWidget {
//   const ViewProfilePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewProfilePage> createState() => _ViewProfilePageState();
// }
//
// class _ViewProfilePageState extends State<ViewProfilePage> {
//
//   String name_ = "";
//   String email_ = "";
//   String phone_ = "";
//   String address_ = "";
//   String place_ = "";
//   String latitude_ = "";
//   String longitude_ = "";
//   String image_ = "";
//   String status_ = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//
//               // PROFILE IMAGE
//               CircleAvatar(
//                 radius: 80,
//                 backgroundImage: image_.isNotEmpty
//                     ? NetworkImage(image_)
//                     : const AssetImage('assets/default_avatar.png')
//                 as ImageProvider,
//               ),
//
//               const SizedBox(height: 16),
//
//               // NAME
//               Text(
//                 name_,
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 6),
//
//               // STATUS
//               Text(
//                 status_.toUpperCase(),
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: status_ == 'approved'
//                       ? Colors.green
//                       : status_ == 'pending'
//                       ? Colors.orange
//                       : Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//
//               const SizedBox(height: 16),
//
//               Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       buildDetailRow("Email", email_),
//                       buildDetailRow("Phone", phone_),
//                       buildDetailRow("Address", address_),
//                       buildDetailRow("Place", place_),
//                       buildDetailRow("Latitude", latitude_),
//                       buildDetailRow("Longitude", longitude_),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const VolunteerEditProfilePage(),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.edit),
//                   label: const Text("Edit Profile"),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Text(
//             "$label:",
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ------------------- API CALL -----------------------
//   Future<void> loadProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url").toString();
//     String lid = sh.getString("lid").toString();
//
//     final api = Uri.parse("$url/volunteer_profile/");
//     final response = await http.post(api, body: {"lid": lid});
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//
//       if (data["status"] == "ok") {
//         setState(() {
//           name_ = data["name"];
//           email_ = data["email"];
//           phone_ = data["phone"];
//           address_ = data["address"];
//           place_ = data["place"];
//           latitude_ = data["latitude"];
//           longitude_ = data["longitude"];
//           status_ = data["status_value"];
//
//           String img = data["profile_photo"];
//           image_ = img.isNotEmpty
//               ? (img.startsWith("http") ? img : "$url$img")
//               : "";
//         });
//       } else {
//         Fluttertoast.showToast(msg: "Profile not found");
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Network Error");
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:hopebite_android/volunteer_edit_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {

  String name_ = "";
  String email_ = "";
  String phone_ = "";
  String address_ = "";
  String place_ = "";
  String latitude_ = "";
  String longitude_ = "";
  String image_ = "";
  String status_ = "";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ SAME APPBAR STYLE AS USER
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 20),

              // PROFILE IMAGE
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: image_.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    image_,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Icon(
                  Icons.person,
                  size: 60,
                  color: Color(0xFF00796B),
                ),
              ),

              const SizedBox(height: 15),

              // NAME
              Text(
                name_.isEmpty ? "Loading..." : name_,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),



              const SizedBox(height: 30),

              // DETAILS CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    infoRow(Icons.email, "Email", email_),
                    infoRow(Icons.phone, "Phone", phone_),
                    infoRow(Icons.home, "Address", address_),
                    infoRow(Icons.location_city, "Place", place_),
                    infoRow(Icons.my_location, "Latitude", latitude_),
                    infoRow(Icons.my_location_outlined, "Longitude", longitude_),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // EDIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VolunteerEditProfilePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Color(0xFF00796B)),
                  label: const Text(
                    "EDIT PROFILE",
                    style: TextStyle(
                      color: Color(0xFF00796B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- INFO ROW (MATCH USER PROFILE STYLE) ----------
  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF00796B)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------- API CALL (UNCHANGED) -----------------------
  Future<void> loadProfile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    final api = Uri.parse("$url/volunteer_profile/");
    final response = await http.post(api, body: {"lid": lid});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        setState(() {
          name_ = data["name"];
          email_ = data["email"];
          phone_ = data["phone"];
          address_ = data["address"];
          place_ = data["place"];
          latitude_ = data["latitude"];
          longitude_ = data["longitude"];
          status_ = data["status_value"];

          String img = data["profile_photo"];
          image_ = img.isNotEmpty
              ? (img.startsWith("http") ? img : "$url$img")
              : "";
        });
      } else {
        Fluttertoast.showToast(msg: "Profile not found");
      }
    } else {
      Fluttertoast.showToast(msg: "Network Error");
    }
  }
}
