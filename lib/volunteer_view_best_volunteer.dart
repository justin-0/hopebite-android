// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class VolunteerViewBestVolunteerPage extends StatefulWidget {
//   const VolunteerViewBestVolunteerPage({super.key});
//
//   @override
//   State<VolunteerViewBestVolunteerPage> createState() =>
//       _VolunteerViewBestVolunteerPageState();
// }
//
// class _VolunteerViewBestVolunteerPageState
//     extends State<VolunteerViewBestVolunteerPage> {
//
//   bool loading = true;
//   Map<String, dynamic>? volunteer;
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
//           : volunteer == null
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
//                     backgroundImage: volunteer!['profile_photo'] != ''
//                         ? NetworkImage(volunteer!['profile_photo'])
//                         : null,
//                     child: volunteer!['profile_photo'] == ''
//                         ? const Icon(Icons.person, size: 50)
//                         : null,
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 Text(
//                   volunteer!['name'],
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//
//                 const SizedBox(height: 8),
//                 Text("Phone: ${volunteer!['phone']}"),
//                 Text("Place: ${volunteer!['place']}"),
//
//                 const Divider(height: 30),
//
//                 Text("Average Rating: ${volunteer!['avg_rating']}"),
//                 Text("Sentiment Score: ${volunteer!['avg_sentiment']}"),
//                 Text("Total Reviews: ${volunteer!['total_reviews']}"),
//                 Text("Delivered Orders: ${volunteer!['delivered_orders']}"),
//
//                 const SizedBox(height: 10),
//
//                 Text(
//                   "ML Score: ${volunteer!['score']}",
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
//       Uri.parse("$url/volunteer_view_best_volunteer/"),
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       if (data['status'] == 'ok') {
//         volunteer = data['data'];
//       }
//       loading = false;
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerViewBestVolunteerPage extends StatefulWidget {
  const VolunteerViewBestVolunteerPage({super.key});

  @override
  State<VolunteerViewBestVolunteerPage> createState() =>
      _VolunteerViewBestVolunteerPageState();
}

class _VolunteerViewBestVolunteerPageState
    extends State<VolunteerViewBestVolunteerPage> {

  bool loading = true;
  Map<String, dynamic>? volunteer;

  @override
  void initState() {
    super.initState();
    loadBestVolunteer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("Best Volunteer"),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
      ),

      // ✅ FULL PAGE GRADIENT
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: loading
                    ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                    : volunteer == null
                    ? const Center(
                  child: Text(
                    "No best volunteer found",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [

                        // -------- PROFILE IMAGE --------
                        CircleAvatar(
                          radius: 55,
                          backgroundColor:
                          const Color(0xFF00796B),
                          backgroundImage:
                          volunteer!['profile_photo'] != ''
                              ? NetworkImage(
                              volunteer!['profile_photo'])
                              : null,
                          child:
                          volunteer!['profile_photo'] == ''
                              ? const Icon(
                            Icons.person,
                            size: 55,
                            color: Colors.white,
                          )
                              : null,
                        ),

                        const SizedBox(height: 16),

                        // -------- NAME --------
                        Text(
                          volunteer!['name'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // -------- BASIC INFO --------
                        infoRow(
                            Icons.phone, volunteer!['phone']),
                        infoRow(
                            Icons.location_on,
                            volunteer!['place']),

                        const Divider(height: 30),

                        // -------- STATS --------
                        statRow("Average Rating",
                            volunteer!['avg_rating'].toString()),
                        statRow("Sentiment Score",
                            volunteer!['avg_sentiment'].toString()),
                        statRow("Total Reviews",
                            volunteer!['total_reviews'].toString()),
                        statRow("Delivered Orders",
                            volunteer!['delivered_orders']
                                .toString()),

                        const SizedBox(height: 16),

                        // -------- ML SCORE --------
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: Text(
                            "ML SCORE: ${volunteer!['score']}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------- UI HELPERS ----------
  Widget infoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 6),
          Text(value),
        ],
      ),
    );
  }

  Widget statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style:
              const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  // ---------- API ----------
  Future<void> loadBestVolunteer() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_view_best_volunteer/"),
    );

    final data = jsonDecode(response.body);

    setState(() {
      if (data['status'] == 'ok') {
        volunteer = data['data'];
      }
      loading = false;
    });
  }
}
