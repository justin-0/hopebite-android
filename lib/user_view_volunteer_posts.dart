// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewVolunteerPostsPage extends StatefulWidget {
//   const UserViewVolunteerPostsPage({super.key});
//
//   @override
//   State<UserViewVolunteerPostsPage> createState() =>
//       _UserViewVolunteerPostsPageState();
// }
//
// class _UserViewVolunteerPostsPageState extends State<UserViewVolunteerPostsPage> {
//
//   List posts = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Volunteer Posts")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           final post = posts[index];
//           bool closed = post['status'] == 'closed';
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     post['description'],
//                     style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 6),
//                   Text("Volunteer: ${post['volunteer_name']}"),
//                   const SizedBox(height: 6),
//                   Text("Date: ${post['date']}"),
//                   const SizedBox(height: 6),
//                   Text(
//                     "Status: ${post['status']}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: closed ? Colors.red : Colors.green,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   if (!closed)
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () =>
//                             acceptPost(post['post_id'].toString()),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green),
//                         child: const Text("Accept"),
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
//   Future<void> loadPosts() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_volunteer_posts/"),
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
//   Future<void> acceptPost(String postId) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_accept_volunteer_post/"),
//       body: {'post_id': postId, 'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     Fluttertoast.showToast(msg: data['message']);
//     loadPosts();
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewVolunteerPostsPage extends StatefulWidget {
  const UserViewVolunteerPostsPage({super.key});

  @override
  State<UserViewVolunteerPostsPage> createState() =>
      _UserViewVolunteerPostsPageState();
}

class _UserViewVolunteerPostsPageState extends State<UserViewVolunteerPostsPage> {

  List posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volunteer Posts"),
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
            "No volunteer posts available",
            style: TextStyle(color: Colors.white),
          ),
        )
            : ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            bool closed = post['status'] == 'closed';

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

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: closed
                                ? Colors.red.withOpacity(0.15)
                                : Colors.green.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            post['status'].toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                              closed ? Colors.red : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    if (!closed)
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF00796B),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () =>
                              acceptPost(post['post_id'].toString()),
                          child: const Text(
                            "ACCEPT",
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

  Future<void> loadPosts() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/user_view_volunteer_posts/"),
      body: {'lid': lid},
    );

    final data = jsonDecode(response.body);

    setState(() {
      posts = data['data'];
      loading = false;
    });
  }

  Future<void> acceptPost(String postId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/user_accept_volunteer_post/"),
      body: {'post_id': postId, 'lid': lid},
    );

    final data = jsonDecode(response.body);

    Fluttertoast.showToast(msg: data['message']);
    loadPosts();
  }
}
