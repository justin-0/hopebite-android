// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class VolunteerViewPostsPage extends StatefulWidget {
//   const VolunteerViewPostsPage({super.key});
//
//   @override
//   State<VolunteerViewPostsPage> createState() =>
//       _VolunteerViewPostsPageState();
// }
//
// class _VolunteerViewPostsPageState extends State<VolunteerViewPostsPage> {
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
//       appBar: AppBar(title: const Text("My Volunteer Posts")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : posts.isEmpty
//           ? const Center(child: Text("No posts found"))
//           : ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           final post = posts[index];
//
//           return Card(
//             margin: const EdgeInsets.all(10),
//             child: ListTile(
//               title: Text(post['description']),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 5),
//                   Text("Date: ${post['date']}"),
//                   const SizedBox(height: 5),
//                   Text(
//                     "Status: ${post['status']}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: post['status'] == 'active'
//                           ? Colors.green
//                           : Colors.red,
//                     ),
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
//   // ---------------- API CALL ----------------
//   Future<void> loadPosts() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_view_posts/"),
//       body: {'lid': lid},
//     );
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//
//       if (data['status'] == 'ok') {
//         setState(() {
//           posts = data['data'];
//           loading = false;
//         });
//       } else {
//         Fluttertoast.showToast(msg: data['message']);
//         setState(() => loading = false);
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Server error");
//       setState(() => loading = false);
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VolunteerViewPostsPage extends StatefulWidget {
  const VolunteerViewPostsPage({super.key});

  @override
  State<VolunteerViewPostsPage> createState() =>
      _VolunteerViewPostsPageState();
}

class _VolunteerViewPostsPageState extends State<VolunteerViewPostsPage> {

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

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("My Volunteer Posts"),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
      ),

      // ✅ FULL PAGE GRADIENT (NO WHITE)
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                width: double.infinity,
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
                    : posts.isEmpty
                    ? const Center(
                  child: Text(
                    "No posts found",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : Column(
                  children: List.generate(
                    posts.length,
                        (index) {
                      final post = posts[index];
                      bool isActive =
                          post['status'] == 'active';

                      return Container(
                        width: double.infinity,
                        margin:
                        const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.12),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            // -------- DESCRIPTION --------
                            Text(
                              post['description'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // -------- DATE --------
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  post['date'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            // -------- STATUS BADGE --------
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.green
                                      .withOpacity(0.15)
                                      : Colors.red
                                      .withOpacity(0.15),
                                  borderRadius:
                                  BorderRadius.circular(20),
                                ),
                                child: Text(
                                  isActive
                                      ? "ACTIVE"
                                      : "INACTIVE",
                                  style: TextStyle(
                                    color: isActive
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- API CALL ----------------
  Future<void> loadPosts() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_view_posts/"),
      body: {'lid': lid},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 'ok') {
        setState(() {
          posts = data['data'];
          loading = false;
        });
      } else {
        Fluttertoast.showToast(msg: data['message']);
        setState(() => loading = false);
      }
    } else {
      Fluttertoast.showToast(msg: "Server error");
      setState(() => loading = false);
    }
  }
}
