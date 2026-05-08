// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ViewDonationRequestStatusPage extends StatefulWidget {
//   const ViewDonationRequestStatusPage({super.key});
//
//   @override
//   State<ViewDonationRequestStatusPage> createState() =>
//       _ViewDonationRequestStatusPageState();
// }
//
// class _ViewDonationRequestStatusPageState
//     extends State<ViewDonationRequestStatusPage> {
//
//   List data = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStatus();
//   }
//
//   Future<void> fetchStatus() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString("url") ?? "";
//       String lid = sh.getString("lid") ?? "";
//
//       var res = await http.post(
//         Uri.parse("$url/user_view_donation_request_status/"),
//         body: {'lid': lid},
//       );
//
//       var jsonData = jsonDecode(res.body);
//
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           data = jsonData['data'];
//           loading = false;
//         });
//       } else {
//         setState(() => loading = false);
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//       setState(() => loading = false);
//     }
//   }
//
//   Color statusColor(String status) {
//     if (status == 'delivered') return Colors.green;
//     if (status == 'collected') return Colors.blue;
//     if (status == 'accepted') return Colors.green;
//     if (status == 'rejected') return Colors.red;
//     return Colors.orange;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("My Donation Requests"),
//       ),
//
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : data.isEmpty
//           ? const Center(child: Text("No donation requests found"))
//           : ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           final d = data[index];
//
//           return Card(
//             elevation: 6,
//             margin: const EdgeInsets.all(10),
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Text(
//                     d['home_name'],
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   Text("📍 Place: ${d['home_place']}"),
//                   Text("🍱 Food Type: ${d['food_type']}"),
//                   Text("📦 Food Items: ${d['food_items']}"),
//                   Text("🔢 Quantity: ${d['quantity']}"),
//                   Text(
//                     "🕒 Prepared: ${d['prepared_date']} ${d['prepared_time']}",
//                   ),
//                   Text(
//                     "⏰ Expiry: ${d['expiry_time'].isEmpty ? 'N/A' : d['expiry_time']}",
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                     children: [
//
//                       Text(
//                         "Status: ${d['status'].toUpperCase()}",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: statusColor(d['status']),
//                         ),
//                       ),
//
//                       Text(
//                         d['date'],
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
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

class ViewDonationRequestStatusPage extends StatefulWidget {
  const ViewDonationRequestStatusPage({super.key});

  @override
  State<ViewDonationRequestStatusPage> createState() =>
      _ViewDonationRequestStatusPageState();
}

class _ViewDonationRequestStatusPageState
    extends State<ViewDonationRequestStatusPage> {

  List data = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchStatus();
  }

  Future<void> fetchStatus() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString("url") ?? "";
      String lid = sh.getString("lid") ?? "";

      var res = await http.post(
        Uri.parse("$url/user_view_donation_request_status/"),
        body: {'lid': lid},
      );

      var jsonData = jsonDecode(res.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          data = jsonData['data'];
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
      setState(() => loading = false);
    }
  }

  Color statusColor(String status) {
    if (status == 'delivered') return Colors.green;
    if (status == 'collected') return Colors.blue;
    if (status == 'accepted') return Colors.green;
    if (status == 'rejected') return Colors.red;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Donation Requests"),
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
            : data.isEmpty
            ? const Center(
          child: Text(
            "No donation requests found",
            style: TextStyle(color: Colors.white),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(12),
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final d = data[index];

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
                      d['home_name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Expanded(child: Text(d['home_place'])),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.restaurant, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Text("Food Type: ${d['food_type']}"),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.inventory, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Expanded(child: Text("Food Items: ${d['food_items']}")),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.confirmation_number, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Text("Quantity: ${d['quantity']}"),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Prepared: ${d['prepared_date']} ${d['prepared_time']}",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        const Icon(Icons.timer, size: 16, color: Color(0xFF00796B)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "Expiry: ${d['expiry_time'].isEmpty ? 'N/A' : d['expiry_time']}",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor(d['status']).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            d['status'].toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: statusColor(d['status']),
                            ),
                          ),
                        ),

                        Text(
                          d['date'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
}
