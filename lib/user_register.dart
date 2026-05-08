//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:location/location.dart' as loc;
//
// import 'login.dart';
//
// class UserRegister extends StatefulWidget {
//   const UserRegister({super.key});
//
//   @override
//   State<UserRegister> createState() => _UserRegisterState();
// }
//
// class _UserRegisterState extends State<UserRegister> {
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//
//   final loc.Location location = loc.Location();
//   loc.LocationData? currentPosition;
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation();
//   }
//
//   Future<void> getCurrentLocation() async {
//     bool enabled = await location.serviceEnabled();
//     if (!enabled) enabled = await location.requestService();
//     if (!enabled) return;
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//
//                 const SizedBox(height: 20),
//
//                 const Icon(Icons.person_add, size: 70, color: Colors.white),
//
//                 const SizedBox(height: 15),
//
//                 const Text(
//                   "User Registration",
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 _input(nameController, "Full Name", Icons.person),
//                 _input(usernameController, "Username", Icons.account_circle),
//                 _input(passwordController, "Password", Icons.lock, hide: true),
//                 _input(emailController, "Email", Icons.email),
//                 _input(phoneController, "Phone", Icons.phone, keyboard: TextInputType.number),
//                 _input(placeController, "Place", Icons.location_city),
//                 _input(addressController, "Address", Icons.home),
//
//                 const SizedBox(height: 15),
//
//                 Text(
//                   currentPosition == null
//                       ? "Fetching location..."
//                       : "Lat: ${currentPosition!.latitude}, Long: ${currentPosition!.longitude}",
//                   style: const TextStyle(color: Colors.white70),
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: registerUser,
//                     child: const Text(
//                       "REGISTER",
//                       style: TextStyle(
//                         color: Color(0xFF00796B),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (_) => const LoginPage()),
//                     );
//                   },
//                   child: const Text(
//                     "Already have an account? Login",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _input(
//       TextEditingController controller,
//       String hint,
//       IconData icon, {
//         bool hide = false,
//         TextInputType keyboard = TextInputType.text,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: TextField(
//         controller: controller,
//         obscureText: hide,
//         keyboardType: keyboard,
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon),
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void registerUser() async {
//
//     if (nameController.text.isEmpty ||
//         usernameController.text.isEmpty ||
//         passwordController.text.isEmpty ||
//         emailController.text.isEmpty ||
//         phoneController.text.isEmpty ||
//         placeController.text.isEmpty ||
//         addressController.text.isEmpty) {
//       Fluttertoast.showToast(msg: "All fields are required");
//       return;
//     }
//
//     if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(nameController.text)) {
//       Fluttertoast.showToast(msg: "Name must contain only alphabets");
//       return;
//     }
//
//     if (!RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text)) {
//       Fluttertoast.showToast(msg: "Phone number must be 10 digits");
//       return;
//     }
//
//     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//         .hasMatch(emailController.text)) {
//       Fluttertoast.showToast(msg: "Enter a valid email");
//       return;
//     }
//
//     if (passwordController.text.length < 6) {
//       Fluttertoast.showToast(msg: "Password must be at least 6 characters");
//       return;
//     }
//
//     if (currentPosition == null) {
//       Fluttertoast.showToast(msg: "Location not available");
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url").toString();
//
//     var request = http.MultipartRequest(
//       "POST",
//       Uri.parse("$url/user_register/"),
//     );
//
//     request.fields["username"] = usernameController.text;
//     request.fields["password"] = passwordController.text;
//     request.fields["name"] = nameController.text;
//     request.fields["email"] = emailController.text;
//     request.fields["phone"] = phoneController.text;
//     request.fields["place"] = placeController.text;
//     request.fields["address"] = addressController.text;
//     request.fields["latitude"] = currentPosition!.latitude.toString();
//     request.fields["longitude"] = currentPosition!.longitude.toString();
//
//     var response = await request.send();
//     var responseData = await http.Response.fromStream(response);
//
//     if (responseData.statusCode == 200) {
//       var data = jsonDecode(responseData.body);
//       if (data["status"] == "ok") {
//         Fluttertoast.showToast(msg: "Registration Successful");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const LoginPage()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: data["message"]);
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Network Error");
//     }
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;

import 'login.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Error messages
  String? nameError;
  String? usernameError;
  String? passwordError;
  String? emailError;
  String? phoneError;
  String? placeError;
  String? addressError;

  final loc.Location location = loc.Location();
  loc.LocationData? currentPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();

    nameController.addListener(() {
      setState(() {
        nameError = _validateName(nameController.text);
      });
    });

    usernameController.addListener(() {
      setState(() {
        usernameError = _validateRequired(usernameController.text, "Username");
      });
    });

    passwordController.addListener(() {
      setState(() {
        passwordError = _validatePassword(passwordController.text);
      });
    });

    emailController.addListener(() {
      setState(() {
        emailError = _validateEmail(emailController.text);
      });
    });

    phoneController.addListener(() {
      setState(() {
        phoneError = _validatePhone(phoneController.text);
      });
    });

    placeController.addListener(() {
      setState(() {
        placeError = _validateRequired(placeController.text, "Place");
      });
    });

    addressController.addListener(() {
      setState(() {
        addressError = _validateRequired(addressController.text, "Address");
      });
    });
  }

  String? _validateName(String value) {
    if (value.isEmpty) return "Full Name is required";
    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) return "Name must contain only alphabets";
    return null;
  }

  String? _validateRequired(String value, String field) {
    if (value.isEmpty) return "$field is required";
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return "Enter a valid email";
    return null;
  }

  String? _validatePhone(String value) {
    if (value.isEmpty) return "Phone is required";
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return "Phone number must be 10 digits";
    return null;
  }

  Future<void> getCurrentLocation() async {
    bool enabled = await location.serviceEnabled();
    if (!enabled) enabled = await location.requestService();
    if (!enabled) return;

    var permission = await location.hasPermission();
    if (permission == loc.PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != loc.PermissionStatus.granted) return;
    }

    currentPosition = await location.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                const SizedBox(height: 20),

                const Icon(Icons.person_add, size: 70, color: Colors.white),

                const SizedBox(height: 15),

                const Text(
                  "User Registration",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                _input(nameController, "Full Name", Icons.person, errorText: nameError),
                _input(usernameController, "Username", Icons.account_circle, errorText: usernameError),
                _input(passwordController, "Password", Icons.lock, hide: true, errorText: passwordError),
                _input(emailController, "Email", Icons.email, errorText: emailError),
                _input(phoneController, "Phone", Icons.phone, keyboard: TextInputType.number, errorText: phoneError),
                _input(placeController, "Place", Icons.location_city, errorText: placeError),
                _input(addressController, "Address", Icons.home, errorText: addressError),

                const SizedBox(height: 15),

                Text(
                  currentPosition == null
                      ? "Fetching location..."
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
                    onPressed: registerUser,
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Color(0xFF00796B),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(
      TextEditingController controller,
      String hint,
      IconData icon, {
        bool hide = false,
        TextInputType keyboard = TextInputType.text,
        String? errorText,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            obscureText: hide,
            keyboardType: keyboard,
            decoration: InputDecoration(
              prefixIcon: Icon(icon),
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: errorText != null
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                )
                    : BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: errorText != null
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                )
                    : BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: errorText != null
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                )
                    : BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          if (errorText != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: const BoxDecoration(
                color: Color(0xFFFFEBEE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    errorText,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void registerUser() async {

    // Trigger all validations on submit
    setState(() {
      nameError = _validateName(nameController.text);
      usernameError = _validateRequired(usernameController.text, "Username");
      passwordError = _validatePassword(passwordController.text);
      emailError = _validateEmail(emailController.text);
      phoneError = _validatePhone(phoneController.text);
      placeError = _validateRequired(placeController.text, "Place");
      addressError = _validateRequired(addressController.text, "Address");
    });

    if (nameError != null ||
        usernameError != null ||
        passwordError != null ||
        emailError != null ||
        phoneError != null ||
        placeError != null ||
        addressError != null) {
      return;
    }

    if (currentPosition == null) {
      Fluttertoast.showToast(msg: "Location not available");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();

    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$url/user_register/"),
    );

    request.fields["username"] = usernameController.text;
    request.fields["password"] = passwordController.text;
    request.fields["name"] = nameController.text;
    request.fields["email"] = emailController.text;
    request.fields["phone"] = phoneController.text;
    request.fields["place"] = placeController.text;
    request.fields["address"] = addressController.text;
    request.fields["latitude"] = currentPosition!.latitude.toString();
    request.fields["longitude"] = currentPosition!.longitude.toString();

    var response = await request.send();
    var responseData = await http.Response.fromStream(response);

    if (responseData.statusCode == 200) {
      var data = jsonDecode(responseData.body);
      if (data["status"] == "ok") {
        Fluttertoast.showToast(msg: "Registration Successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      } else {
        Fluttertoast.showToast(msg: data["message"]);
      }
    } else {
      Fluttertoast.showToast(msg: "Network Error");
    }
  }
}