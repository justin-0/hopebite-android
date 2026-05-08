// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hopebite_android/user_feedback.dart';
// import 'package:hopebite_android/user_view_best_donor.dart';
// import 'package:hopebite_android/user_view_best_volunteer.dart';
// import 'package:hopebite_android/user_view_complaints.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'login.dart';
// import 'user_profile.dart';
// import 'user_view_oldagehomes.dart';
// import 'user_view_donation_request_status.dart';
// import 'user_view_volunteers.dart';
// import 'user_view_volunteer_posts.dart';
// import 'user_view_accepted_posts.dart';
//
// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage> {
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
//         Uri.parse('$url/user_profile/'),
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
//       backgroundColor: const Color(0xFF0A0A0A),
//
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1A1A1A),
//         elevation: 0,
//         title: ShaderMask(
//           shaderCallback: (bounds) => const LinearGradient(
//             colors: [Color(0xFFFFD700), Color(0xFFDAA520)],
//           ).createShader(bounds),
//           child: const Text(
//             "HOPEBITE",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               letterSpacing: 2.0,
//               fontSize: 22,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Color(0xFFDAA520)),
//       ),
//
//       drawer: Drawer(
//         backgroundColor: const Color(0xFF1A1A1A),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     const Color(0xFFDAA520).withOpacity(0.3),
//                     const Color(0xFFB8860B).withOpacity(0.3),
//                   ],
//                 ),
//                 border: const Border(
//                   bottom: BorderSide(color: Color(0xFFDAA520), width: 2),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "HOPEBITE DONOR",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFFFFD700),
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//
//                   const SizedBox(height: 10),
//                   Text(
//                     username_.isEmpty ? "Loading..." : username_,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             _buildDrawerItem(Icons.home, "Home", () => Navigator.pop(context)),
//
//             _buildDrawerItem(Icons.person, "View Profile", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const UserProfilePage()),
//               );
//             }),
//
//             _buildDrawerItem(Icons.house, "Old Age Homes", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const ViewOldAgeHomes(title: 'Old Age Homes')),
//               );
//             }),
//
//             _buildDrawerItem(Icons.history, "Donation Status", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const ViewDonationRequestStatusPage()),
//               );
//             }),
//
//             _buildDrawerItem(Icons.group, "View Volunteers", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const ViewVolunteers(title: 'Volunteers')),
//               );
//             }),
//
//             _buildDrawerItem(Icons.post_add, "Volunteer Posts", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const UserViewVolunteerPostsPage()),
//               );
//             }),
//
//             _buildDrawerItem(Icons.check_circle, "Accepted Posts", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const UserViewAcceptedPostsPage()),
//               );
//             }),
//
//             _buildDrawerItem(Icons.star, "Best Volunteers", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const UserViewBestVolunteerPage()),
//               );
//             }),
//
//             _buildDrawerItem(Icons.emoji_events, "Best Donors", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const UserViewBestDonorPage()),
//               );
//             }),
//
//             _buildDrawerItem(Icons.feedback, "Feedback", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const UserFeedbackPage()),
//               );
//             }),
//
//             _buildDrawerItem(Icons.report_problem, "Complaints", () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const UserComplaintPage()),
//               );
//             }),
//
//             const Divider(color: Color(0xFFDAA520), thickness: 1, height: 30),
//
//             ListTile(
//               leading: const Icon(Icons.logout, color: Colors.red),
//               title: const Text(
//                 "Logout",
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//               ),
//               onTap: () async {
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 await prefs.clear();
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (_) => const LoginPage()),
//                       (route) => false,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Hero Section
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     const Color(0xFFDAA520).withOpacity(0.2),
//                     const Color(0xFF0A0A0A),
//                   ],
//                 ),
//               ),
//               padding: const EdgeInsets.all(30),
//               child: Column(
//                 children: [
//                   const Icon(
//                     Icons.volunteer_activism,
//                     size: 80,
//                     color: Color(0xFFDAA520),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Welcome, Donor!",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFFFFD700),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Share your surplus food and\nmake a difference in someone's life",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Colors.white70,
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // Stats Cards
//
//
//             const SizedBox(height: 30),
//
//             // Donation Actions Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Donation Actions",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFFFFD700),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   _buildActionCard(
//                     "Find Old Age Homes",
//                     "Browse verified old age homes",
//                     Icons.home_work,
//                     Colors.blue,
//                     "https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?q=80&w=400",
//                         () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const ViewOldAgeHomes(title: 'Old Age Homes')),
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   _buildActionCard(
//                     "Donation Status",
//                     "Track your donation requests",
//                     Icons.history,
//                     Colors.orange,
//                     "https://images.unsplash.com/photo-1593113598332-cd288d649433?q=80&w=400",
//                         () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const ViewDonationRequestStatusPage()),
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   _buildActionCard(
//                     "Find Volunteers",
//                     "Connect with active volunteers",
//                     Icons.people,
//                     Colors.green,
//                     "https://images.unsplash.com/photo-1509099836639-18ba1795216d?q=80&w=400",
//                         () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const ViewVolunteers(title: 'Volunteers')),
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   _buildActionCard(
//                     "Volunteer Posts",
//                     "See volunteer activities & updates",
//                     Icons.article,
//                     Colors.purple,
//                     "https://images.unsplash.com/photo-1559027615-cd4628902d4a?q=80&w=400",
//                         () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const UserViewVolunteerPostsPage()),
//                       );
//                     },
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   _buildActionCard(
//                     "Accepted Posts",
//                     "View your accepted donations",
//                     Icons.check_circle,
//                     const Color(0xFF10B981),
//                     "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?q=80&w=400",
//                         () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const UserViewAcceptedPostsPage()),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 30),
//
//             // Recognition Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Community & Recognition",
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFFFFD700),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildRecognitionCard(
//                           "Best Volunteers",
//                           Icons.star,
//                           Colors.amber,
//                               () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => const UserViewBestVolunteerPage()),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       Expanded(
//                         child: _buildRecognitionCard(
//                           "Best Donors",
//                           Icons.emoji_events,
//                           Colors.orange,
//                               () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => const UserViewBestDonorPage()),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 15),
//
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _buildRecognitionCard(
//                           "Send Feedback",
//                           Icons.feedback,
//                           Colors.blue,
//                               () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => const UserFeedbackPage()),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 15),
//                       Expanded(
//                         child: _buildRecognitionCard(
//                           "Report Issue",
//                           Icons.report_problem,
//                           Colors.red,
//                               () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (_) => const UserComplaintPage()),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper widget for drawer items
//   Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFFDAA520)),
//       title: Text(
//         title,
//         style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
//       ),
//       onTap: onTap,
//       hoverColor: const Color(0xFFDAA520).withOpacity(0.1),
//     );
//   }
//
//   // Stat card widget
//   Widget _buildStatCard(String number, String label, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             const Color(0xFFDAA520).withOpacity(0.2),
//             const Color(0xFFB8860B).withOpacity(0.1),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFDAA520).withOpacity(0.3)),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, size: 35, color: const Color(0xFFFFD700)),
//           const SizedBox(height: 12),
//           Text(
//             number,
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFFFFD700),
//             ),
//           ),
//           const SizedBox(height: 5),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 13,
//               color: Colors.white.withOpacity(0.7),
//               height: 1.3,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Action card widget with image - FIXED
//   Widget _buildActionCard(
//       String title,
//       String subtitle,
//       IconData icon,
//       Color color,
//       String imageUrl,
//       VoidCallback onTap,
//       ) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 110,
//         decoration: BoxDecoration(
//           color: const Color(0xFF1A1A1A),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: const Color(0xFFDAA520).withOpacity(0.3)),
//         ),
//         child: Row(
//           children: [
//             // Image section
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 bottomLeft: Radius.circular(16),
//               ),
//               child: Image.network(
//                 imageUrl,
//                 width: 110,
//                 height: 110,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     width: 110,
//                     height: 110,
//                     color: color.withOpacity(0.2),
//                     child: Icon(icon, size: 45, color: color),
//                   );
//                 },
//               ),
//             ),
//
//             // Content section
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(icon, color: color, size: 20),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             title,
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.white.withOpacity(0.6),
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Arrow icon
//             Padding(
//               padding: const EdgeInsets.only(right: 12),
//               child: Icon(
//                 Icons.arrow_forward_ios,
//                 color: const Color(0xFFDAA520).withOpacity(0.5),
//                 size: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Recognition card widget
//   Widget _buildRecognitionCard(
//       String title,
//       IconData icon,
//       Color color,
//       VoidCallback onTap,
//       ) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: const Color(0xFF1A1A1A),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: const Color(0xFFDAA520).withOpacity(0.3)),
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.2),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, size: 35, color: color),
//             ),
//             const SizedBox(height: 15),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
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
import 'package:hopebite_android/user_feedback.dart';
import 'package:hopebite_android/user_view_best_donor.dart';
import 'package:hopebite_android/user_view_best_volunteer.dart';
import 'package:hopebite_android/user_view_complaints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'user_profile.dart';
import 'user_view_oldagehomes.dart';
import 'user_view_donation_request_status.dart';
import 'user_view_volunteers.dart';
import 'user_view_volunteer_posts.dart';
import 'user_view_accepted_posts.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key, required this.title});
  final String title;

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String username_ = "";
  String photo_ = "";

  @override
  void initState() {
    super.initState();
    viewprofile();
  }

  void viewprofile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? "";
    String lid = sh.getString('lid') ?? "";

    try {
      final response = await http.post(
        Uri.parse('$url/user_profile/'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Icon(Icons.volunteer_activism, size: 50, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    username_.isEmpty ? "Loading..." : username_,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            _drawerItem(Icons.person, "Profile", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserProfilePage()));
            }),

            _drawerItem(Icons.home_work, "Old Age Homes", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewOldAgeHomes(title: 'Old Age Homes')));
            }),

            _drawerItem(Icons.history, "Donation Status", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewDonationRequestStatusPage()));
            }),

            _drawerItem(Icons.people, "Volunteers", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewVolunteers(title: 'Volunteers')));
            }),

            _drawerItem(Icons.article, "Volunteer Posts", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserViewVolunteerPostsPage()));
            }),

            _drawerItem(Icons.check_circle, "Accepted Posts", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserViewAcceptedPostsPage()));
            }),

            _drawerItem(Icons.star, "Best Volunteers", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserViewBestVolunteerPage()));
            }),

            _drawerItem(Icons.emoji_events, "Best Donors", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserViewBestDonorPage()));
            }),

            _drawerItem(Icons.feedback, "Feedback", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserFeedbackPage()));
            }),

            _drawerItem(Icons.report_problem, "Complaints", () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const UserComplaintPage()));
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

      appBar: AppBar(
        backgroundColor: const Color(0xFF00796B),
        title: const Text("HopBite"),
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

              const Text(
                "Welcome to HopBite",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Share food. Spread hope.",
                style: TextStyle(color: Colors.white70),
              ),

              const SizedBox(height: 30),

              _actionCard(
                "Find Old Age Homes",
                "Browse verified homes",
                Icons.home_work,
                "https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?q=80&w=400",
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewOldAgeHomes(title: 'Old Age Homes'))),
              ),

              _actionCard(
                "Donation Status",
                "Track your requests",
                Icons.history,
                "https://images.unsplash.com/photo-1593113598332-cd288d649433?q=80&w=400",
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewDonationRequestStatusPage())),
              ),

              _actionCard(
                "Find Volunteers",
                "Connect with volunteers",
                Icons.people,
                "https://images.unsplash.com/photo-1509099836639-18ba1795216d?q=80&w=400",
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewVolunteers(title: 'Volunteers'))),
              ),

              _actionCard(
                "Volunteer Posts",
                "View activities",
                Icons.article,
                "https://images.unsplash.com/photo-1559027615-cd4628902d4a?q=80&w=400",
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserViewVolunteerPostsPage())),
              ),

              _actionCard(
                "Accepted Posts",
                "View accepted donations",
                Icons.check_circle,
                "https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?q=80&w=400",
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserViewAcceptedPostsPage())),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _actionCard(
      String title,
      String subtitle,
      IconData icon,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
}
