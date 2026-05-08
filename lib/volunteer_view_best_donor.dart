// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class VolunteerViewBestDonorPage extends StatefulWidget {
//   const VolunteerViewBestDonorPage({super.key});
//
//   @override
//   State<VolunteerViewBestDonorPage> createState() =>
//       _VolunteerViewBestDonorPageState();
// }
//
// class _VolunteerViewBestDonorPageState
//     extends State<VolunteerViewBestDonorPage> {
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
//       Uri.parse("$url/volunteer_view_best_donor/"),
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       if (data['status'] == 'ok') {
//         donor = data['data'];
//       }
//       loading = false;
//     });
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerViewBestDonorPage extends StatefulWidget {
  const VolunteerViewBestDonorPage({super.key});

  @override
  State<VolunteerViewBestDonorPage> createState() =>
      _VolunteerViewBestDonorPageState();
}

class _VolunteerViewBestDonorPageState
    extends State<VolunteerViewBestDonorPage> {

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

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("Best Donor"),
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
                    : donor == null
                    ? const Center(
                  child: Text(
                    "No best donor found",
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

                        // -------- DONOR ICON --------
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00796B)
                                .withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.volunteer_activism,
                            size: 50,
                            color: Color(0xFF00796B),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // -------- NAME --------
                        Text(
                          donor!['name'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // -------- BASIC INFO --------
                        infoRow(
                            Icons.phone, donor!['phone']),
                        infoRow(
                            Icons.location_on,
                            donor!['place']),

                        const Divider(height: 30),

                        // -------- CONTRIBUTION STATS --------
                        statRow(
                          "Total Delivered Donations",
                          donor!['total'].toString(),
                          Icons.local_shipping,
                        ),
                        statRow(
                          "Direct Donations",
                          donor!['direct'].toString(),
                          Icons.handshake,
                        ),
                        statRow(
                          "Post Donations",
                          donor!['post'].toString(),
                          Icons.article,
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

  Widget statRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF00796B)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- API ----------
  Future<void> loadBestDonor() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_view_best_donor/"),
    );

    final data = jsonDecode(response.body);

    setState(() {
      if (data['status'] == 'ok') {
        donor = data['data'];
      }
      loading = false;
    });
  }
}
