// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hopebite_android/volunteer_profile.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:location/location.dart' as loc;
//
// class VolunteerEditProfilePage extends StatefulWidget {
//   const VolunteerEditProfilePage({super.key});
//
//   @override
//   State<VolunteerEditProfilePage> createState() =>
//       _VolunteerEditProfilePageState();
// }
//
// class _VolunteerEditProfilePageState extends State<VolunteerEditProfilePage> {
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//
//   File? _selectedImage;
//   String existingImage = "";
//
//   final loc.Location location = loc.Location();
//   loc.LocationData? currentPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//     getCurrentLocation();
//   }
//
//   // ---------------- LOCATION ----------------
//   Future<void> getCurrentLocation() async {
//     bool enabled = await location.serviceEnabled();
//     if (!enabled) {
//       enabled = await location.requestService();
//       if (!enabled) return;
//     }
//
//     var permission = await location.hasPermission();
//     if (permission == loc.PermissionStatus.denied) {
//       permission = await location.requestPermission();
//       if (permission != loc.PermissionStatus.granted) return;
//     }
//
//     currentPosition = await location.getLocation();
//     setState(() {});
//   }
//
//   // ---------------- LOAD PROFILE ----------------
//   Future<void> loadProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     var res = await http.post(
//       Uri.parse("$url/volunteer_profile/"),
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
//
//           // ✅ FIXED IMAGE URL
//           String img = data["profile_photo"];
//           existingImage = img.isNotEmpty
//               ? (img.startsWith("http") ? img : "$url$img")
//               : "";
//         });
//       }
//     }
//   }
//
//   // ---------------- IMAGE PICKER ----------------
//   Future<void> pickImage() async {
//     if (await Permission.mediaLibrary.request().isGranted) {
//       final picker = ImagePicker();
//       final image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         setState(() {
//           _selectedImage = File(image.path);
//         });
//       }
//     }
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
//             const SizedBox(height: 20),
//
//             InkWell(
//               onTap: pickImage,
//               child: _selectedImage != null
//                   ? Image.file(_selectedImage!, height: 150, width: 150)
//                   : existingImage.isNotEmpty
//                   ? Image.network(existingImage, height: 150, width: 150)
//                   : const Icon(Icons.image, size: 100),
//             ),
//
//             _box(nameController, "Name"),
//             _box(emailController, "Email"),
//             _box(phoneController, "Phone"),
//             _box(placeController, "Place"),
//             _box(addressController, "Address"),
//
//             const SizedBox(height: 10),
//
//             Text(
//               currentPosition == null
//                   ? "Fetching GPS..."
//                   : "Lat: ${currentPosition!.latitude}, Long: ${currentPosition!.longitude}",
//             ),
//
//             const SizedBox(height: 20),
//
//             ElevatedButton(
//               onPressed: updateProfile,
//               child: const Text("Update Profile"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _box(TextEditingController c, String label) {
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
//   // ---------------- UPDATE PROFILE ----------------
//   void updateProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     var request = http.MultipartRequest(
//       "POST",
//       Uri.parse("$url/volunteer_editprofile/"),
//     );
//
//     request.fields["lid"] = lid;
//     request.fields["name"] = nameController.text;
//     request.fields["email"] = emailController.text;
//     request.fields["phone"] = phoneController.text;
//     request.fields["place"] = placeController.text;
//     request.fields["address"] = addressController.text;
//     request.fields["latitude"] = currentPosition!.latitude.toString();
//     request.fields["longitude"] = currentPosition!.longitude.toString();
//
//     if (_selectedImage != null) {
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           "profile_photo",
//           _selectedImage!.path,
//         ),
//       );
//     }
//
//     var response = await request.send();
//
//     if (response.statusCode == 200) {
//       Fluttertoast.showToast(msg: "Profile Updated");
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const ViewProfilePage(title: "Profile"),
//         ),
//       );
//     } else {
//       Fluttertoast.showToast(msg: "Update Failed");
//     }
//   }
// }


import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopebite_android/volunteer_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';

class VolunteerEditProfilePage extends StatefulWidget {
  const VolunteerEditProfilePage({super.key});

  @override
  State<VolunteerEditProfilePage> createState() =>
      _VolunteerEditProfilePageState();
}

class _VolunteerEditProfilePageState extends State<VolunteerEditProfilePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  File? _selectedImage;
  String existingImage = "";

  final loc.Location location = loc.Location();
  loc.LocationData? currentPosition;

  @override
  void initState() {
    super.initState();
    loadProfile();
    getCurrentLocation();
  }

  // ---------------- LOCATION ----------------
  Future<void> getCurrentLocation() async {
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
    setState(() {});
  }

  // ---------------- LOAD PROFILE ----------------
  Future<void> loadProfile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    var res = await http.post(
      Uri.parse("$url/volunteer_profile/"),
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

          String img = data["profile_photo"];
          existingImage = img.isNotEmpty
              ? (img.startsWith("http") ? img : "$url$img")
              : "";
        });
      }
    }
  }

  // ---------------- IMAGE PICKER ----------------
  Future<void> pickImage() async {
    if (await Permission.mediaLibrary.request().isGranted) {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    }
  }

  // ---------------- VALIDATION ----------------
  bool validateForm() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String place = placeController.text.trim();
    String address = addressController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        place.isEmpty ||
        address.isEmpty) {
      Fluttertoast.showToast(msg: "All fields are required");
      return false;
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(name)) {
      Fluttertoast.showToast(msg: "Name must contain only alphabets");
      return false;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(email)) {
      Fluttertoast.showToast(msg: "Enter a valid email");
      return false;
    }

    if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      Fluttertoast.showToast(msg: "Phone must contain 10 digits");
      return false;
    }

    if (currentPosition == null) {
      Fluttertoast.showToast(msg: "Location not detected");
      return false;
    }

    return true;
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

              InkWell(
                onTap: pickImage,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  )
                      : existingImage.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      existingImage,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Color(0xFF00796B),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _box(nameController, "Name"),
                    _box(emailController, "Email"),
                    _box(phoneController, "Phone", isNumber: true),
                    _box(placeController, "Place"),
                    _box(addressController, "Address"),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Text(
                currentPosition == null
                    ? "Fetching GPS location..."
                    : "Lat: ${currentPosition!.latitude}, Long: ${currentPosition!.longitude}",
                style: const TextStyle(color: Colors.white70),
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

  Widget _box(TextEditingController c, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters:
        isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ---------------- UPDATE PROFILE ----------------
  void updateProfile() async {
    if (!validateForm()) return;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$url/volunteer_editprofile/"),
    );

    request.fields["lid"] = lid;
    request.fields["name"] = nameController.text.trim();
    request.fields["email"] = emailController.text.trim();
    request.fields["phone"] = phoneController.text.trim();
    request.fields["place"] = placeController.text.trim();
    request.fields["address"] = addressController.text.trim();
    request.fields["latitude"] = currentPosition!.latitude.toString();
    request.fields["longitude"] = currentPosition!.longitude.toString();

    if (_selectedImage != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "profile_photo",
          _selectedImage!.path,
        ),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Profile Updated");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ViewProfilePage(title: "Profile"),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "Update Failed");
    }
  }
}
