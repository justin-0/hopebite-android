// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'user_edit_profile.dart';
//
// class UserProfilePage extends StatefulWidget {
//   const UserProfilePage({super.key});
//
//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }
//
// class _UserProfilePageState extends State<UserProfilePage> {
//
//   String name_ = "";
//   String email_ = "";
//   String phone_ = "";
//   String place_ = "";
//   String address_ = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }
//
//   Future<void> loadProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     var res = await http.post(
//       Uri.parse("$url/user_profile/"),
//       body: {"lid": lid},
//     );
//
//     if (res.statusCode == 200) {
//       var data = jsonDecode(res.body);
//       if (data["status"] == "ok") {
//         setState(() {
//           name_ = data["name"];
//           email_ = data["email"];
//           phone_ = data["phone"];
//           place_ = data["place"];
//           address_ = data["address"];
//         });
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Network error");
//     }
//   }
//
//   Widget row(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Text("$label: ",
//               style: const TextStyle(fontWeight: FontWeight.bold)),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             row("Name", name_),
//             row("Email", email_),
//             row("Phone", phone_),
//             row("Place", place_),
//             row("Address", address_),
//
//             const SizedBox(height: 20),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => const UserEditProfilePage()),
//                   );
//                 },
//                 child: const Text("Edit Profile"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_edit_profile.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  String name_ = "";
  String email_ = "";
  String phone_ = "";
  String place_ = "";
  String address_ = "";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    var res = await http.post(
      Uri.parse("$url/user_profile/"),
      body: {"lid": lid},
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"] == "ok") {
        setState(() {
          name_ = data["name"];
          email_ = data["email"];
          phone_ = data["phone"];
          place_ = data["place"];
          address_ = data["address"];
        });
      }
    } else {
      Fluttertoast.showToast(msg: "Network error");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
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

              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(55),
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Color(0xFF00796B),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                name_.isEmpty ? "Loading..." : name_,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    infoRow(Icons.person, "Name", name_),
                    infoRow(Icons.email, "Email", email_),
                    infoRow(Icons.phone, "Phone", phone_),
                    infoRow(Icons.location_city, "Place", place_),
                    infoRow(Icons.home, "Address", address_),
                  ],
                ),
              ),

              const SizedBox(height: 25),

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
                        builder: (_) => const UserEditProfilePage(),
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
}
