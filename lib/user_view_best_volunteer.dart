// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewBestVolunteerPage extends StatefulWidget {
//   const UserViewBestVolunteerPage({super.key});
//
//   @override
//   State<UserViewBestVolunteerPage> createState() =>
//       _UserViewBestVolunteerPageState();
// }
//
// class _UserViewBestVolunteerPageState
//     extends State<UserViewBestVolunteerPage> {
//
//   bool loading = true;
//   Map<String, dynamic>? v;
//
//   @override
//   void initState() {
//     super.initState();
//     loadBestVolunteer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Best Volunteer")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : v == null
//           ? const Center(child: Text("No best volunteer found"))
//           : Padding(
//         padding: const EdgeInsets.all(16),
//         child: Card(
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 Center(
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: v!['profile_photo'] != ''
//                         ? NetworkImage(v!['profile_photo'])
//                         : null,
//                     child: v!['profile_photo'] == ''
//                         ? const Icon(Icons.person, size: 50)
//                         : null,
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 Text(
//                   v!['name'],
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//
//                 const SizedBox(height: 8),
//                 Text("Phone: ${v!['phone']}"),
//                 Text("Place: ${v!['place']}"),
//
//                 const Divider(height: 30),
//
//                 Text("Average Rating: ${v!['avg_rating']}"),
//                 Text("Sentiment Score: ${v!['avg_sentiment']}"),
//                 Text("Total Reviews: ${v!['total_reviews']}"),
//                 Text("Delivered Orders: ${v!['delivered_orders']}"),
//
//                 const SizedBox(height: 10),
//
//                 Text(
//                   "ML Score: ${v!['score']}",
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> loadBestVolunteer() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_best_volunteer/"),
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       if (data['status'] == 'ok') {
//         v = data['data'];
//       }
//       loading = false;
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewBestVolunteerPage extends StatefulWidget {
  const UserViewBestVolunteerPage({super.key});

  @override
  State<UserViewBestVolunteerPage> createState() =>
      _UserViewBestVolunteerPageState();
}

class _UserViewBestVolunteerPageState
    extends State<UserViewBestVolunteerPage> {

  bool loading = true;
  Map<String, dynamic>? v;

  @override
  void initState() {
    super.initState();
    loadBestVolunteer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Best Volunteer"),
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
        child: loading
            ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
            : v == null
            ? const Center(
          child: Text(
            "No best volunteer found",
            style: TextStyle(color: Colors.white),
          ),
        )
            : Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [

                CircleAvatar(
                  radius: 55,
                  backgroundColor:
                  const Color(0xFF00796B),
                  backgroundImage: v!['profile_photo'] != ''
                      ? NetworkImage(v!['profile_photo'])
                      : null,
                  child: v!['profile_photo'] == ''
                      ? const Icon(
                    Icons.person,
                    size: 55,
                    color: Colors.white,
                  )
                      : null,
                ),

                const SizedBox(height: 15),

                Text(
                  v!['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  v!['place'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const Divider(height: 30),

                _infoRow(
                    Icons.phone, "Phone", v!['phone']),
                _infoRow(
                    Icons.star, "Average Rating", v!['avg_rating']),
                _infoRow(
                    Icons.analytics,
                    "Sentiment Score",
                    v!['avg_sentiment']),
                _infoRow(
                    Icons.reviews,
                    "Total Reviews",
                    v!['total_reviews']),
                _infoRow(
                    Icons.local_shipping,
                    "Delivered Orders",
                    v!['delivered_orders']),

                const SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius:
                    BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "ML SCORE",
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.5,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        v!['score'].toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF00796B)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadBestVolunteer() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;

    final response = await http.post(
      Uri.parse("$url/user_view_best_volunteer/"),
    );

    final data = jsonDecode(response.body);

    setState(() {
      if (data['status'] == 'ok') {
        v = data['data'];
      }
      loading = false;
    });
  }
}
