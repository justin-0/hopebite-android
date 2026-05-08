// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserViewBestDonorPage extends StatefulWidget {
//   const UserViewBestDonorPage({super.key});
//
//   @override
//   State<UserViewBestDonorPage> createState() =>
//       _UserViewBestDonorPageState();
// }
//
// class _UserViewBestDonorPageState extends State<UserViewBestDonorPage> {
//
//   bool loading = true;
//   Map<String, dynamic>? donor;
//
//   @override
//   void initState() {
//     super.initState();
//     loadBestDonor();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Best Donor")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : donor == null
//           ? const Center(child: Text("No best donor found"))
//           : Padding(
//         padding: const EdgeInsets.all(16),
//         child: Card(
//           elevation: 4,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   donor!['name'],
//                   style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text("Phone: ${donor!['phone']}"),
//                 Text("Place: ${donor!['place']}"),
//                 const Divider(height: 30),
//                 Text("Total Delivered Donations: ${donor!['total']}"),
//                 Text("Direct Donations: ${donor!['direct']}"),
//                 Text("Post Donations: ${donor!['post']}"),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> loadBestDonor() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_best_donor/"),
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       if (data['status'] == 'ok') donor = data['data'];
//       loading = false;
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewBestDonorPage extends StatefulWidget {
  const UserViewBestDonorPage({super.key});

  @override
  State<UserViewBestDonorPage> createState() =>
      _UserViewBestDonorPageState();
}

class _UserViewBestDonorPageState extends State<UserViewBestDonorPage> {

  bool loading = true;
  Map<String, dynamic>? donor;

  @override
  void initState() {
    super.initState();
    loadBestDonor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Best Donor"),
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
            : donor == null
            ? const Center(
          child: Text(
            "No best donor found",
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

                const CircleAvatar(
                  radius: 45,
                  backgroundColor:
                  Color(0xFF00796B),
                  child: Icon(
                    Icons.emoji_events,
                    size: 45,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  donor!['name'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  donor!['place'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const Divider(height: 30),

                Row(
                  children: [
                    const Icon(Icons.phone,
                        color: Color(0xFF00796B)),
                    const SizedBox(width: 8),
                    Text("Phone: ${donor!['phone']}"),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    _statCard(
                        "Total",
                        donor!['total'].toString(),
                        Colors.green),
                    _statCard(
                        "Direct",
                        donor!['direct'].toString(),
                        Colors.blue),
                    _statCard(
                        "Post",
                        donor!['post'].toString(),
                        Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadBestDonor() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;

    final response = await http.post(
      Uri.parse("$url/user_view_best_donor/"),
    );

    final data = jsonDecode(response.body);

    setState(() {
      if (data['status'] == 'ok') donor = data['data'];
      loading = false;
    });
  }
}
