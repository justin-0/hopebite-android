// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewAcceptedPostsPage extends StatefulWidget {
//   const UserViewAcceptedPostsPage({super.key});
//
//   @override
//   State<UserViewAcceptedPostsPage> createState() =>
//       _UserViewAcceptedPostsPageState();
// }
//
// class _UserViewAcceptedPostsPageState
//     extends State<UserViewAcceptedPostsPage> {
//
//   List posts = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadAcceptedPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Accepted Posts")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : posts.isEmpty
//           ? const Center(child: Text("No accepted posts"))
//           : ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           final post = posts[index];
//
//           String status = post['status']
//               .toString()
//               .trim()
//               .toLowerCase();
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Text(
//                     post['description'],
//                     style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
//
//                   const SizedBox(height: 6),
//                   Text("Volunteer: ${post['volunteer_name']}"),
//
//                   const SizedBox(height: 6),
//                   Text("Date: ${post['date']}"),
//
//                   const SizedBox(height: 6),
//                   Text(
//                     "Status: ${post['status']}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: status == 'delivered'
//                           ? Colors.green
//                           : status == 'collected'
//                           ? Colors.orange
//                           : Colors.blue,
//                     ),
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   // ⭐ SHOW ONLY WHEN DELIVERED
//                   if (status == 'delivered')
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue),
//                         onPressed: () =>
//                             showRatingOverlay(post),
//                         child: const Text("Add Rating"),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ---------------- LOAD ACCEPTED POSTS ----------------
//   Future<void> loadAcceptedPosts() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_accepted_posts/"),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       posts = data['data'];
//       loading = false;
//     });
//   }
//
//   // ---------------- TOP OVERLAY RATING (NO BOTTOM, NO NEW PAGE) ----------------
//   void showRatingOverlay(dynamic post) {
//     int rating = 0;
//     TextEditingController reviewController = TextEditingController();
//
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: "Rating",
//       transitionDuration: const Duration(milliseconds: 300),
//       pageBuilder: (context, animation, secondaryAnimation) {
//         return SafeArea(
//           child: Material(
//             color: Colors.black.withOpacity(0.4),
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 margin: const EdgeInsets.only(top: 60),
//                 padding: const EdgeInsets.all(20),
//                 height: MediaQuery.of(context).size.height * 0.7,
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(20),
//                   ),
//                 ),
//                 child: StatefulBuilder(
//                   builder: (context, setDialogState) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Rate Volunteer",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: () =>
//                                   Navigator.pop(context),
//                             )
//                           ],
//                         ),
//
//                         const SizedBox(height: 10),
//                         Text(
//                           post['volunteer_name'],
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold),
//                         ),
//
//                         const SizedBox(height: 20),
//
//                         const Text("Your Rating"),
//
//                         const SizedBox(height: 10),
//
//                         // ⭐ REAL STAR UI
//                         Row(
//                           children: List.generate(5, (index) {
//                             return IconButton(
//                               icon: Icon(
//                                 index < rating
//                                     ? Icons.star
//                                     : Icons.star_border,
//                                 color: Colors.amber,
//                                 size: 32,
//                               ),
//                               onPressed: () {
//                                 setDialogState(() {
//                                   rating = index + 1;
//                                 });
//                               },
//                             );
//                           }),
//                         ),
//
//                         const SizedBox(height: 20),
//
//                         const Text("Review"),
//                         const SizedBox(height: 6),
//
//                         TextField(
//                           controller: reviewController,
//                           maxLines: 4,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: "Write your review",
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         SizedBox(
//                           width: double.infinity,
//                           height: 45,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               if (rating == 0) {
//                                 Fluttertoast.showToast(
//                                     msg: "Please select rating");
//                                 return;
//                               }
//
//                               submitRating(
//                                 post['volunteer_id'].toString(),
//                                 rating.toString(),
//                                 reviewController.text,
//                               );
//
//                               Navigator.pop(context);
//                             },
//                             child: const Text("Submit Rating"),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, anim1, anim2, child) {
//         return SlideTransition(
//           position: Tween(
//             begin: const Offset(0, -1),
//             end: Offset.zero,
//           ).animate(anim1),
//           child: child,
//         );
//       },
//     );
//   }
//
//   // ---------------- SUBMIT RATING ----------------
//   Future<void> submitRating(
//       String volunteerId,
//       String rating,
//       String review,
//       ) async {
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_send_rating/"),
//       body: {
//         'lid': lid,
//         'volunteer_id': volunteerId,
//         'rating': rating,
//         'review': review,
//       },
//     );
//
//     final data = jsonDecode(response.body);
//
//     Fluttertoast.showToast(msg: data['message']);
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewAcceptedPostsPage extends StatefulWidget {
  const UserViewAcceptedPostsPage({super.key});

  @override
  State<UserViewAcceptedPostsPage> createState() =>
      _UserViewAcceptedPostsPageState();
}

class _UserViewAcceptedPostsPageState
    extends State<UserViewAcceptedPostsPage> {

  List posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadAcceptedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Accepted Posts"),
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
            : posts.isEmpty
            ? const Center(
          child: Text(
            "No accepted posts",
            style: TextStyle(color: Colors.white),
          ),
        )
            : ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            String status =
            post['status'].toString().trim().toLowerCase();

            Color statusColor;
            if (status == 'delivered') {
              statusColor = Colors.green;
            } else if (status == 'collected') {
              statusColor = Colors.orange;
            } else {
              statusColor = Colors.blue;
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      post['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const Icon(Icons.person,
                            size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            post['volunteer_name'],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Text(
                          post['date'],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                            statusColor.withOpacity(0.15),
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    if (status == 'delivered')
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF00796B),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () =>
                              showRatingOverlay(post),
                          icon: const Icon(Icons.star,
                              color: Colors.white),
                          label: const Text(
                            "ADD RATING",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> loadAcceptedPosts() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/user_view_accepted_posts/"),
      body: {'lid': lid},
    );

    final data = jsonDecode(response.body);

    setState(() {
      posts = data['data'];
      loading = false;
    });
  }

  void showRatingOverlay(dynamic post) {
    int rating = 0;
    TextEditingController reviewController = TextEditingController();

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Rating",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Material(
            color: Colors.black.withOpacity(0.4),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 60),
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                child: StatefulBuilder(
                  builder: (context, setDialogState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Rate Volunteer",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () =>
                                  Navigator.pop(context),
                            )
                          ],
                        ),

                        const SizedBox(height: 10),
                        Text(
                          post['volunteer_name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 20),
                        const Text("Your Rating"),

                        const SizedBox(height: 10),

                        Row(
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 32,
                              ),
                              onPressed: () {
                                setDialogState(() {
                                  rating = index + 1;
                                });
                              },
                            );
                          }),
                        ),

                        const SizedBox(height: 20),
                        const Text("Review"),
                        const SizedBox(height: 6),

                        TextField(
                          controller: reviewController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            hintText: "Write your review",
                          ),
                        ),

                        const Spacer(),

                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xFF00796B),
                            ),
                            onPressed: () {
                              if (rating == 0) {
                                Fluttertoast.showToast(
                                    msg: "Please select rating");
                                return;
                              }

                              submitRating(
                                post['volunteer_id'].toString(),
                                rating.toString(),
                                reviewController.text,
                              );

                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Submit Rating",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Future<void> submitRating(
      String volunteerId,
      String rating,
      String review,
      ) async {

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/user_send_rating/"),
      body: {
        'lid': lid,
        'volunteer_id': volunteerId,
        'rating': rating,
        'review': review,
      },
    );

    final data = jsonDecode(response.body);

    Fluttertoast.showToast(msg: data['message']);
  }
}
