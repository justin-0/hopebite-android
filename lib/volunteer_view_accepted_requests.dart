// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class VolunteerViewAcceptedRequestsPage extends StatefulWidget {
//   const VolunteerViewAcceptedRequestsPage({super.key});
//
//   @override
//   State<VolunteerViewAcceptedRequestsPage> createState() =>
//       _VolunteerViewAcceptedRequestsPageState();
// }
//
// class _VolunteerViewAcceptedRequestsPageState
//     extends State<VolunteerViewAcceptedRequestsPage> {
//
//   List requests = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadRequests();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Accepted Requests")),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : requests.isEmpty
//           ? const Center(child: Text("No accepted requests"))
//           : ListView.builder(
//         itemCount: requests.length,
//         itemBuilder: (context, index) {
//           final r = requests[index];
//           String status = r['status'];
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
//                     r['description'],
//                     style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
//
//                   const SizedBox(height: 6),
//                   Text("Donor: ${r['donor_name']}"),
//                   const SizedBox(height: 6),
//                   Text("Phone: ${r['donor_phone']}"),
//                   const SizedBox(height: 6),
//                   Text("Date: ${r['date']}"),
//                   const SizedBox(height: 6),
//
//                   Text(
//                     "Status: $status",
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
//                   if (status == 'accepted')
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () =>
//                             markCollected(r['request_id'].toString()),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange),
//                         child: const Text("Collected"),
//                       ),
//                     ),
//
//                   if (status == 'collected')
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () =>
//                             markDelivered(r['request_id'].toString()),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green),
//                         child: const Text("Delivered"),
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
//   Future<void> loadRequests() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_view_accepted_requests/"),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       requests = data['data'];
//       loading = false;
//     });
//   }
//
//   Future<void> markCollected(String requestId) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_mark_collected_users/"),
//       body: {
//         'request_id': requestId,
//         'lid': lid,
//       },
//     );
//
//     final data = jsonDecode(response.body);
//     Fluttertoast.showToast(msg: data['message']);
//     loadRequests();
//   }
//
//
//   Future<void> markDelivered(String requestId) async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_mark_delivered_users/"),
//       body: {
//         'request_id': requestId,
//         'lid': lid,
//       },
//     );
//
//     final data = jsonDecode(response.body);
//     Fluttertoast.showToast(msg: data['message']);
//     loadRequests();
//   }
//
// }
//
//
//



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VolunteerViewAcceptedRequestsPage extends StatefulWidget {
  const VolunteerViewAcceptedRequestsPage({super.key});

  @override
  State<VolunteerViewAcceptedRequestsPage> createState() =>
      _VolunteerViewAcceptedRequestsPageState();
}

class _VolunteerViewAcceptedRequestsPageState
    extends State<VolunteerViewAcceptedRequestsPage> {

  List requests = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("Accepted Requests"),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
      ),

      // ✅ FULL PAGE GRADIENT (NO WHITE AREA)
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
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
                    : requests.isEmpty
                    ? const Center(
                  child: Text(
                    "No accepted requests",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : Column(
                  children: List.generate(requests.length, (index) {
                    final r = requests[index];
                    String status = r['status'];

                    Color statusColor = status == 'delivered'
                        ? Colors.green
                        : status == 'collected'
                        ? Colors.orange
                        : Colors.blue;

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

                          // DESCRIPTION
                          Text(
                            r['description'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          infoRow("Donor", r['donor_name']),
                          infoRow("Phone", r['donor_phone']),
                          infoRow("Date", r['date']),

                          const SizedBox(height: 8),

                          Text(
                            "Status: ${status.toUpperCase()}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),

                          const SizedBox(height: 15),

                          if (status == 'accepted')
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () =>
                                    markCollected(r['request_id'].toString()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "COLLECTED",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                          if (status == 'collected')
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () =>
                                    markDelivered(r['request_id'].toString()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "DELIVERED",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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

  // ---------- INFO ROW ----------
  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LOAD REQUESTS ----------------
  Future<void> loadRequests() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_view_accepted_requests/"),
      body: {'lid': lid},
    );

    final data = jsonDecode(response.body);

    setState(() {
      requests = data['data'];
      loading = false;
    });
  }

  // ---------------- MARK COLLECTED ----------------
  Future<void> markCollected(String requestId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_mark_collected_users/"),
      body: {
        'request_id': requestId,
        'lid': lid,
      },
    );

    final data = jsonDecode(response.body);
    Fluttertoast.showToast(msg: data['message']);
    loadRequests();
  }

  // ---------------- MARK DELIVERED ----------------
  Future<void> markDelivered(String requestId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_mark_delivered_users/"),
      body: {
        'request_id': requestId,
        'lid': lid,
      },
    );

    final data = jsonDecode(response.body);
    Fluttertoast.showToast(msg: data['message']);
    loadRequests();
  }
}
