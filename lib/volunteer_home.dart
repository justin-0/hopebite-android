//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hopebite_android/user_view_best_volunteer.dart';
// import 'package:hopebite_android/volunteer_complaints.dart';
// import 'package:hopebite_android/volunteer_feedback.dart';
// import 'package:hopebite_android/volunteer_view_best_donor.dart';
// import 'package:hopebite_android/volunteer_view_best_volunteer.dart';
// import 'package:hopebite_android/volunteer_view_reviews.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'login.dart';
// import 'volunteer_profile.dart';
// import 'volunteer_create_post.dart';
// import 'volunteer_view_users.dart';
// import 'volunteer_view_accepted_requests.dart';
// import 'volunteer_view_request_from_oldagehome.dart';
//
// class VolunteerHomePage extends StatefulWidget {
//   const VolunteerHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<VolunteerHomePage> createState() => _VolunteerHomePageState();
// }
//
// class _VolunteerHomePageState extends State<VolunteerHomePage> {
//   String username_ = "";
//   String photo_ = "";
//
//   @override
//   void initState() {
//     super.initState();
//     viewprofile();
//   }
//
//   // ---------------- LOAD PROFILE ----------------
//   void viewprofile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? "";
//     String lid = sh.getString('lid') ?? "";
//
//     try {
//       final response = await http.post(
//         Uri.parse('$url/volunteer_profile/'),
//         body: {'lid': lid},
//       );
//
//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         if (data['status'] == 'ok') {
//           setState(() {
//             username_ = data['name'];
//             String img = data['profile_photo'] ?? "";
//             photo_ = img.isNotEmpty
//                 ? (img.startsWith("http") ? img : url + img)
//                 : "";
//           });
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   // ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 18, 82, 98),
//         title: const Text(
//           "HOPEBITE",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//         ),
//         centerTitle: true,
//       ),
//
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 18, 82, 98),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//
//                   const Text(
//                     "HOPEBITE",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   CircleAvatar(
//                     radius: 28,
//                     backgroundImage: photo_.isNotEmpty
//                         ? NetworkImage(photo_)
//                         : const AssetImage("assets/default_avatar.png")
//                     as ImageProvider,
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   Text(
//                     username_,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text("Home"),
//               onTap: () => Navigator.pop(context),
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text("View Profile"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const ViewProfilePage(title: 'Profile'),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.people),
//               title: const Text("View Users"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerViewUsersPage(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.add_box),
//               title: const Text("Create Post"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerCreatePostPage(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.check_circle),
//               title: const Text("Accepted Requests"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerViewAcceptedRequestsPage(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.apartment),
//               title: const Text("Requests from Old Age Home"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerViewAcceptedRequestsPage_od(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.apartment),
//               title: const Text("Best Volunteer"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerViewBestVolunteerPage(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.apartment),
//               title: const Text("Reviews "),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerViewReviewsPage(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.apartment),
//               title: const Text("Best Donor "),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerViewBestDonorPage(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.apartment),
//               title: const Text("Feedback "),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerFeedbackPage(),
//                   ),
//                 );
//               },
//             ),
//
//             ListTile(
//               leading: const Icon(Icons.apartment),
//               title: const Text("Complaints "),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) =>
//                     const VolunteerComplaintPage(),
//                   ),
//                 );
//               },
//             ),
//
//
//             ListTile(
//               leading: const Icon(Icons.logout, color: Colors.red),
//               title: const Text("Logout"),
//               onTap: () async {
//                 SharedPreferences prefs =
//                 await SharedPreferences.getInstance();
//                 await prefs.clear();
//
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const LoginPage(),
//                   ),
//                       (route) => false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hopebite_android/user_view_best_volunteer.dart';
import 'package:hopebite_android/volunteer_complaints.dart';
import 'package:hopebite_android/volunteer_feedback.dart';
import 'package:hopebite_android/volunteer_view_best_donor.dart';
import 'package:hopebite_android/volunteer_view_best_volunteer.dart';
import 'package:hopebite_android/volunteer_view_reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'volunteer_profile.dart';
import 'volunteer_create_post.dart';
import 'volunteer_view_users.dart';
import 'volunteer_view_accepted_requests.dart';
import 'volunteer_view_request_from_oldagehome.dart';

class VolunteerHomePage extends StatefulWidget {
  const VolunteerHomePage({super.key, required this.title});
  final String title;

  @override
  State<VolunteerHomePage> createState() => _VolunteerHomePageState();
}

class _VolunteerHomePageState extends State<VolunteerHomePage> {
  String username_ = "";
  String photo_ = "";

  @override
  void initState() {
    super.initState();
    viewprofile();
  }

  // ---------------- LOAD PROFILE ----------------
  void viewprofile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? "";
    String lid = sh.getString('lid') ?? "";

    try {
      final response = await http.post(
        Uri.parse('$url/volunteer_profile/'),
        body: {'lid': lid},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          setState(() {
            username_ = data['name'];
            String img = data['profile_photo'] ?? "";
            photo_ = img.isNotEmpty
                ? (img.startsWith("http") ? img : url + img)
                : "";
          });
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HopBite Volunteer"),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
      ),

      drawer: Drawer(
        backgroundColor: const Color(0xFF0F3D2E),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00BFA5), Color(0xFF00796B)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    backgroundImage:
                    photo_.isNotEmpty ? NetworkImage(photo_) : null,
                    child: photo_.isEmpty
                        ? const Icon(Icons.person,
                        size: 40, color: Color(0xFF00796B))
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username_.isEmpty ? "Loading..." : username_,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            _drawerItem(Icons.person, "Profile", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ViewProfilePage(title: 'Profile')));
            }),

            _drawerItem(Icons.people, "View Users", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerViewUsersPage()));
            }),

            _drawerItem(Icons.add_circle, "Create Post", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerCreatePostPage()));
            }),

            _drawerItem(Icons.check_circle, "Accepted Requests", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerViewAcceptedRequestsPage()));
            }),

            _drawerItem(Icons.home_work, "Old Age Home Requests", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerViewAcceptedRequestsPage_od()));
            }),

            _drawerItem(Icons.star, "Best Volunteers", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerViewBestVolunteerPage()));
            }),

            _drawerItem(Icons.rate_review, "Reviews", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerViewReviewsPage()));
            }),

            _drawerItem(Icons.emoji_events, "Best Donors", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerViewBestDonorPage()));
            }),

            _drawerItem(Icons.feedback, "Feedback", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerFeedbackPage()));
            }),

            _drawerItem(Icons.report_problem, "Complaints", () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const VolunteerComplaintPage()));
            }),

            const Divider(color: Colors.white24),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.white)),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
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

              const Text(
                "Welcome Volunteer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Deliver food. Spread hope.",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              _buildActionCard(
                "View Donation Requests",
                "Check new food donation requests",
                Icons.notifications_active,
                Colors.orange,
                "https://images.unsplash.com/photo-1593113598332-cd288d649433?q=80&w=400",
                    () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VolunteerViewUsersPage())),
              ),

              _buildActionCard(
                "Accepted Requests",
                "Manage your accepted deliveries",
                Icons.check_circle,
                Colors.green,
                "https://images.unsplash.com/photo-1509099836639-18ba1795216d?q=80&w=400",
                    () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VolunteerViewAcceptedRequestsPage())),
              ),

              _buildActionCard(
                "Old Age Home Requests",
                "Deliver food to old age homes",
                Icons.home_work,
                Colors.blue,
                "https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?q=80&w=400",
                    () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VolunteerViewAcceptedRequestsPage_od())),
              ),

              _buildActionCard(
                "Create Post",
                "Share updates about your activities",
                Icons.add_circle,
                Colors.purple,
                "https://images.unsplash.com/photo-1559027615-cd4628902d4a?q=80&w=400",
                    () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VolunteerCreatePostPage())),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- SAME FUNCTIONS KEPT ----------

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _buildStatCard(String number, String label, IconData icon) {
    return Container();
  }

  Widget _buildActionCard(
      String title,
      String subtitle,
      IconData icon,
      Color color,
      String imageUrl,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: const Color(0xFF00796B)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecognitionCard(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return Container();
  }
}
