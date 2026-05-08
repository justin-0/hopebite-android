// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'volunteer_view_posts.dart';
//
// class VolunteerCreatePostPage extends StatefulWidget {
//   const VolunteerCreatePostPage({super.key});
//
//   @override
//   State<VolunteerCreatePostPage> createState() =>
//       _VolunteerCreatePostPageState();
// }
//
// class _VolunteerCreatePostPageState extends State<VolunteerCreatePostPage> {
//   final TextEditingController descriptionController = TextEditingController();
//
//   bool loading = false;
//   String? errorText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create Volunteer Post"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.list),
//             tooltip: "View My Posts",
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const VolunteerViewPostsPage(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//
//             // ---------------- DESCRIPTION CARD ----------------
//             Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: TextField(
//                   controller: descriptionController,
//                   maxLines: 5,
//                   onChanged: validateDescription,
//                   decoration: InputDecoration(
//                     labelText: "Post Description",
//                     hintText: "Minimum 10 characters",
//                     errorText: errorText,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 25),
//
//             // ---------------- POST BUTTON ----------------
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed:
//                 (loading || errorText != null) ? null : createPost,
//                 child: loading
//                     ? const SizedBox(
//                   height: 22,
//                   width: 22,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                     strokeWidth: 2,
//                   ),
//                 )
//                     : const Text(
//                   "POST",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 15),
//
//             // ---------------- VIEW POSTS BUTTON ----------------
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton.icon(
//                 icon: const Icon(Icons.visibility),
//                 label: const Text("View My Posts"),
//                 style: OutlinedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const VolunteerViewPostsPage(),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ---------------- VALIDATION ----------------
//   void validateDescription(String value) {
//     if (value.trim().isEmpty) {
//       setState(() => errorText = "Description is required");
//     } else if (value.trim().length < 10) {
//       setState(() => errorText = "Minimum 10 characters required");
//     } else {
//       setState(() => errorText = null);
//     }
//   }
//
//   // ---------------- API CALL ----------------
//   Future<void> createPost() async {
//     String description = descriptionController.text.trim();
//
//     if (description.length < 10) {
//       Fluttertoast.showToast(
//         msg: "Description must be at least 10 characters",
//       );
//       return;
//     }
//
//     setState(() => loading = true);
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_create_post/"),
//       body: {
//         'lid': lid,
//         'description': description,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: data['message']);
//         descriptionController.clear();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const VolunteerViewPostsPage(),
//           ),
//         );
//       } else {
//         Fluttertoast.showToast(msg: data['message']);
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Server error");
//     }
//
//     setState(() => loading = false);
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'volunteer_view_posts.dart';

class VolunteerCreatePostPage extends StatefulWidget {
  const VolunteerCreatePostPage({super.key});

  @override
  State<VolunteerCreatePostPage> createState() =>
      _VolunteerCreatePostPageState();
}

class _VolunteerCreatePostPageState extends State<VolunteerCreatePostPage> {
  final TextEditingController descriptionController = TextEditingController();

  bool loading = false;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("Create Volunteer Post"),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: "View My Posts",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VolunteerViewPostsPage(),
                ),
              );
            },
          ),
        ],
      ),

      // ✅ FULL PAGE GRADIENT (NO WHITE AREA)
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 20),

                    // ---------------- DESCRIPTION CARD ----------------
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 5,
                        onChanged: validateDescription,
                        decoration: InputDecoration(
                          labelText: "Post Description",
                          hintText: "Minimum 10 characters",
                          errorText: errorText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ---------------- POST BUTTON ----------------
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
                        onPressed:
                        (loading || errorText != null) ? null : createPost,
                        child: loading
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Color(0xFF00796B),
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          "POST",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00796B),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ---------------- VIEW POSTS BUTTON ----------------
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "View My Posts",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const VolunteerViewPostsPage(),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- VALIDATION ----------------
  void validateDescription(String value) {
    if (value.trim().isEmpty) {
      setState(() => errorText = "Description is required");
    } else if (value.trim().length < 10) {
      setState(() => errorText = "Minimum 10 characters required");
    } else {
      setState(() => errorText = null);
    }
  }

  // ---------------- API CALL ----------------
  Future<void> createPost() async {
    String description = descriptionController.text.trim();

    if (description.length < 10) {
      Fluttertoast.showToast(
        msg: "Description must be at least 10 characters",
      );
      return;
    }

    setState(() => loading = true);

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_create_post/"),
      body: {
        'lid': lid,
        'description': description,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        Fluttertoast.showToast(msg: data['message']);
        descriptionController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const VolunteerViewPostsPage(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: data['message']);
      }
    } else {
      Fluttertoast.showToast(msg: "Server error");
    }

    setState(() => loading = false);
  }
}
