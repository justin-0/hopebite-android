// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class VolunteerViewReviewsPage extends StatefulWidget {
//   const VolunteerViewReviewsPage({super.key});
//
//   @override
//   State<VolunteerViewReviewsPage> createState() =>
//       _VolunteerViewReviewsPageState();
// }
//
// class _VolunteerViewReviewsPageState
//     extends State<VolunteerViewReviewsPage> {
//
//   bool loading = true;
//   List reviews = [];
//
//   @override
//   void initState() {
//     super.initState();
//     loadReviews();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Reviews")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : reviews.isEmpty
//           ? const Center(child: Text("No reviews found"))
//           : ListView.builder(
//         itemCount: reviews.length,
//         itemBuilder: (context, index) {
//           final r = reviews[index];
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Row(
//                     children: List.generate(
//                       r['rating'],
//                           (i) => const Icon(Icons.star, color: Colors.amber, size: 20),
//                     ),
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   Text(
//                     r['review'],
//                     style: const TextStyle(fontSize: 16),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Text(
//                     "By: ${r['by']} (${r['by_type']})",
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//
//                   const SizedBox(height: 4),
//                   Text(
//                     r['date'],
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> loadReviews() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_view_reviews/"),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       if (data['status'] == 'ok') {
//         reviews = data['data'];
//       }
//       loading = false;
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerViewReviewsPage extends StatefulWidget {
  const VolunteerViewReviewsPage({super.key});

  @override
  State<VolunteerViewReviewsPage> createState() =>
      _VolunteerViewReviewsPageState();
}

class _VolunteerViewReviewsPageState
    extends State<VolunteerViewReviewsPage> {

  bool loading = true;
  List reviews = [];

  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("My Reviews"),
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
                padding: const EdgeInsets.all(16),
                child: loading
                    ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                    : reviews.isEmpty
                    ? const Center(
                  child: Text(
                    "No reviews found",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : Column(
                  children: List.generate(reviews.length, (index) {
                    final r = reviews[index];

                    return Container(
                      margin:
                      const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          // -------- STAR RATING --------
                          Row(
                            children: List.generate(
                              r['rating'],
                                  (i) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // -------- REVIEW TEXT --------
                          Text(
                            r['review'],
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 14),

                          const Divider(),

                          // -------- REVIEWER INFO --------
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 18,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "By: ${r['by']} (${r['by_type']})",
                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                r['date'],
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- API CALL ----------------
  Future<void> loadReviews() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_view_reviews/"),
      body: {'lid': lid},
    );

    final data = jsonDecode(response.body);

    setState(() {
      if (data['status'] == 'ok') {
        reviews = data['data'];
      }
      loading = false;
    });
  }
}
