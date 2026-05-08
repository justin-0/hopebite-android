// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'user_profile.dart';
//
// class UserEditProfilePage extends StatefulWidget {
//   const UserEditProfilePage({super.key});
//
//   @override
//   State<UserEditProfilePage> createState() => _UserEditProfilePageState();
// }
//
// class _UserEditProfilePageState extends State<UserEditProfilePage> {
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
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
//           nameController.text = data["name"];
//           emailController.text = data["email"];
//           phoneController.text = data["phone"];
//           placeController.text = data["place"];
//           addressController.text = data["address"];
//         });
//       }
//     }
//   }
//
//   void updateProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     var res = await http.post(
//       Uri.parse("$url/user_editprofile/"),
//       body: {
//         "lid": lid,
//         "name": nameController.text,
//         "email": emailController.text,
//         "phone": phoneController.text,
//         "place": placeController.text,
//         "address": addressController.text,
//       },
//     );
//
//     if (res.statusCode == 200) {
//       var data = jsonDecode(res.body);
//       if (data["status"] == "ok") {
//         Fluttertoast.showToast(msg: "Profile Updated");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const UserProfilePage()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: "Update failed");
//       }
//     }
//   }
//
//   Widget box(TextEditingController c, String label) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: TextField(
//         controller: c,
//         decoration: InputDecoration(
//           border: const OutlineInputBorder(),
//           labelText: label,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Edit Profile")),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//
//             box(nameController, "Name"),
//             box(emailController, "Email"),
//             box(phoneController, "Phone"),
//             box(placeController, "Place"),
//             box(addressController, "Address"),
//
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: updateProfile,
//               child: const Text("Update"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_profile.dart';

class UserEditProfilePage extends StatefulWidget {
  const UserEditProfilePage({super.key});

  @override
  State<UserEditProfilePage> createState() => _UserEditProfilePageState();
}

class _UserEditProfilePageState extends State<UserEditProfilePage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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
          nameController.text = data["name"];
          emailController.text = data["email"];
          phoneController.text = data["phone"];
          placeController.text = data["place"];
          addressController.text = data["address"];
        });
      }
    }
  }

  void updateProfile() async {

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        placeController.text.isEmpty ||
        addressController.text.isEmpty) {
      Fluttertoast.showToast(msg: "All fields are required");
      return;
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(nameController.text)) {
      Fluttertoast.showToast(msg: "Name must contain only alphabets");
      return;
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text)) {
      Fluttertoast.showToast(msg: "Phone number must be 10 digits");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      Fluttertoast.showToast(msg: "Enter a valid email");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    var res = await http.post(
      Uri.parse("$url/user_editprofile/"),
      body: {
        "lid": lid,
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "place": placeController.text,
        "address": addressController.text,
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data["status"] == "ok") {
        Fluttertoast.showToast(msg: "Profile Updated");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserProfilePage()),
        );
      } else {
        Fluttertoast.showToast(msg: "Update failed");
      }
    } else {
      Fluttertoast.showToast(msg: "Network error");
    }
  }

  Widget inputField(
      TextEditingController controller,
      String hint,
      IconData icon,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
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

              const Icon(Icons.edit, size: 70, color: Colors.white),

              const SizedBox(height: 15),

              const Text(
                "Update Your Details",
                style: TextStyle(
                  fontSize: 24,
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
                    inputField(nameController, "Name", Icons.person),
                    inputField(emailController, "Email", Icons.email),
                    inputField(phoneController, "Phone", Icons.phone),
                    inputField(placeController, "Place", Icons.location_city),
                    inputField(addressController, "Address", Icons.home),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: updateProfile,
                  child: const Text(
                    "UPDATE PROFILE",
                    style: TextStyle(
                      color: Color(0xFF00796B),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
