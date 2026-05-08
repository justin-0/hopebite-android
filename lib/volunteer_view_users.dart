// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class VolunteerViewUsersPage extends StatefulWidget {
//   const VolunteerViewUsersPage({super.key});
//
//   @override
//   State<VolunteerViewUsersPage> createState() =>
//       _VolunteerViewUsersPageState();
// }
//
// class _VolunteerViewUsersPageState extends State<VolunteerViewUsersPage> {
//
//   List users = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Donor Users")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : users.isEmpty
//           ? const Center(child: Text("No users found"))
//           : ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final u = users[index];
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
//                     u['name'],
//                     style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
//
//                   const SizedBox(height: 6),
//                   Text("Email: ${u['email']}"),
//
//                   const SizedBox(height: 6),
//                   Text("Phone: ${u['phone']}"),
//
//                   const SizedBox(height: 6),
//                   Text("Place: ${u['place']}"),
//
//                   const SizedBox(height: 6),
//                   Text("Address: ${u['address']}"),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // ---------------- LOAD USERS ----------------
//   Future<void> loadUsers() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_view_users/"),
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       users = data['data'];
//       loading = false;
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerViewUsersPage extends StatefulWidget {
  const VolunteerViewUsersPage({super.key});

  @override
  State<VolunteerViewUsersPage> createState() =>
      _VolunteerViewUsersPageState();
}

class _VolunteerViewUsersPageState extends State<VolunteerViewUsersPage> {

  List users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("Donor Users"),
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
            : users.isEmpty
            ? const Center(
          child: Text(
            "No users found",
            style: TextStyle(color: Colors.white),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final u = users[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // NAME
                  Row(
                    children: [
                      const Icon(Icons.person,
                          color: Color(0xFF00796B)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          u['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  infoRow(Icons.email, "Email", u['email']),
                  infoRow(Icons.phone, "Phone", u['phone']),
                  infoRow(Icons.location_city, "Place", u['place']),
                  infoRow(Icons.home, "Address", u['address']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------- INFO ROW ----------
  Widget infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LOAD USERS ----------------
  Future<void> loadUsers() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_view_users/"),
    );

    final data = jsonDecode(response.body);

    setState(() {
      users = data['data'];
      loading = false;
    });
  }
}
