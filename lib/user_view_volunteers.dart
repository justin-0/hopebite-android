// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ViewVolunteers extends StatefulWidget {
//   const ViewVolunteers({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewVolunteers> createState() => _ViewVolunteersState();
// }
//
// class _ViewVolunteersState extends State<ViewVolunteers> {
//
//   List volunteers = [];
//   Map<int, List> reviewsMap = {};
//   Set<int> loadingIds = {};
//   String baseUrl = "";
//
//   @override
//   void initState() {
//     super.initState();
//     loadBaseUrl();
//     loadVolunteers();
//   }
//
//   // ---------------- LOAD BASE URL ----------------
//   Future<void> loadBaseUrl() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     setState(() {
//       baseUrl = sh.getString('url') ?? "";
//     });
//   }
//
//   // ---------------- LOAD VOLUNTEERS ----------------
//   Future<void> loadVolunteers() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? "";
//
//       var res = await http.post(Uri.parse('$url/user_view_volunteers/'));
//       var jsonData = jsonDecode(res.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           volunteers = jsonData['data'];
//         });
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error loading volunteers");
//     }
//   }
//
//   // ---------------- LOAD REVIEWS (INLINE) ----------------
//   Future<void> loadReviews(int volunteerId) async {
//
//     if (reviewsMap.containsKey(volunteerId)) return;
//
//     setState(() {
//       loadingIds.add(volunteerId);
//     });
//
//     try {
//       var res = await http.post(
//         Uri.parse('$baseUrl/view_volunteer_ratings/'),
//         body: {'volunteer_id': volunteerId.toString()},
//       );
//
//       var jsonData = jsonDecode(res.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           reviewsMap[volunteerId] = jsonData['data'];
//           loadingIds.remove(volunteerId);
//         });
//       }
//     } catch (e) {
//       loadingIds.remove(volunteerId);
//       Fluttertoast.showToast(msg: "Error loading reviews");
//     }
//   }
//
//   // ---------------- UI ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: Text(widget.title),
//       ),
//
//       body: volunteers.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: volunteers.length,
//         itemBuilder: (context, index) {
//
//           final v = volunteers[index];
//           final int vid = v['volunteer_id'];
//           final List reviews = reviewsMap[vid] ?? [];
//
//           String imageUrl = "";
//           if (v['photo'] != "") {
//             imageUrl = v['photo'].startsWith("http")
//                 ? v['photo']
//                 : baseUrl + v['photo'];
//           }
//
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               // ================= VOLUNTEER CARD =================
//               Card(
//                 elevation: 8,
//                 margin: const EdgeInsets.all(10),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Row(
//                         children: [
//                           imageUrl.isNotEmpty
//                               ? CircleAvatar(
//                             radius: 30,
//                             backgroundImage: NetworkImage(imageUrl),
//                           )
//                               : const CircleAvatar(
//                             radius: 30,
//                             child: Icon(Icons.person),
//                           ),
//
//                           const SizedBox(width: 10),
//
//                           Expanded(
//                             child: Text(
//                               v['name'],
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       const SizedBox(height: 8),
//                       Text("📍 Place: ${v['place']}"),
//                       Text("📞 Phone: ${v['phone']}"),
//                       Text("⭐ Avg Rating: ${v['avg_rating']} / 5"),
//                       Text("📝 Reviews: ${v['total_reviews']}"),
//
//                       const SizedBox(height: 10),
//
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: ElevatedButton(
//                           onPressed: () => loadReviews(vid),
//                           child: const Text("View Reviews"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // ================= REVIEWS BELOW CARD =================
//               if (loadingIds.contains(vid))
//                 const Padding(
//                   padding: EdgeInsets.all(15),
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//
//               ...reviews.map((r) => Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "⭐ Rating: ${r['rating']}",
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(r['review']),
//                       const SizedBox(height: 4),
//                       Text(
//                         r['date'],
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewVolunteers extends StatefulWidget {
  const ViewVolunteers({super.key, required this.title});
  final String title;

  @override
  State<ViewVolunteers> createState() => _ViewVolunteersState();
}

class _ViewVolunteersState extends State<ViewVolunteers> {

  List volunteers = [];
  Map<int, List> reviewsMap = {};
  Set<int> loadingIds = {};
  Set<int> openedReviewIds = {};
  String baseUrl = "";

  @override
  void initState() {
    super.initState();
    loadBaseUrl();
    loadVolunteers();
  }

  Future<void> loadBaseUrl() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    baseUrl = sh.getString('url') ?? "";
  }

  Future<void> loadVolunteers() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url') ?? "";

      var res = await http.post(Uri.parse('$url/user_view_volunteers/'));
      var jsonData = jsonDecode(res.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          volunteers = jsonData['data'];
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error loading volunteers");
    }
  }

  Future<void> toggleReviews(int volunteerId) async {

    if (openedReviewIds.contains(volunteerId)) {
      setState(() {
        openedReviewIds.remove(volunteerId);
      });
      return;
    }

    setState(() {
      openedReviewIds.add(volunteerId);
    });

    if (reviewsMap.containsKey(volunteerId)) return;

    setState(() {
      loadingIds.add(volunteerId);
    });

    try {
      var res = await http.post(
        Uri.parse('$baseUrl/view_volunteer_ratings/'),
        body: {'volunteer_id': volunteerId.toString()},
      );

      var jsonData = jsonDecode(res.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          reviewsMap[volunteerId] = jsonData['data'];
          loadingIds.remove(volunteerId);
        });
      }
    } catch (e) {
      loadingIds.remove(volunteerId);
      Fluttertoast.showToast(msg: "Error loading reviews");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
        child: volunteers.isEmpty
            ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
            : ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: volunteers.length,
          itemBuilder: (context, index) {

            final v = volunteers[index];
            final int vid = v['volunteer_id'];
            final bool isOpen = openedReviewIds.contains(vid);
            final List reviews = reviewsMap[vid] ?? [];

            String imageUrl = "";
            if (v['photo'] != "") {
              imageUrl = v['photo'].startsWith("http")
                  ? v['photo']
                  : baseUrl + v['photo'];
            }

            return Column(
              children: [

                // ================= VOLUNTEER CARD =================
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          imageUrl.isNotEmpty
                              ? CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(imageUrl),
                          )
                              : const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              v['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text("📍 Place: ${v['place']}"),
                      Text("📞 Phone: ${v['phone']}"),
                      Text("⭐ Avg Rating: ${v['avg_rating']} / 5"),
                      Text("📝 Reviews: ${v['total_reviews']}"),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00796B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => toggleReviews(vid),
                          child: Text(
                            isOpen ? "Close Reviews" : "View Reviews",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ================= LOADING =================
                if (loadingIds.contains(vid))
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(),
                  ),

                // ================= FULL WIDTH REVIEWS =================
                if (isOpen)
                  ...reviews.map((r) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 6, 16, 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFF00796B).withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "⭐ Rating: ${r['rating']} / 5",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          r['review'],
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          r['date'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
              ],
            );
          },
        ),
      ),
    );
  }
}
