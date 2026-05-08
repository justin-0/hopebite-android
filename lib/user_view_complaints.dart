// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class UserComplaintPage extends StatefulWidget {
//   const UserComplaintPage({super.key});
//
//   @override
//   State<UserComplaintPage> createState() => _UserComplaintPageState();
// }
//
// class _UserComplaintPageState extends State<UserComplaintPage> {
//
//   TextEditingController complaintController = TextEditingController();
//   List complaints = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadComplaints();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Complaints")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             const Text(
//               "Send Complaint",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 10),
//
//             TextField(
//               controller: complaintController,
//               maxLines: 4,
//               decoration: const InputDecoration(
//                 labelText: "Complaint",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: sendComplaint,
//                 child: const Text("Submit"),
//               ),
//             ),
//
//             const Divider(height: 30),
//
//             const Text(
//               "My Complaints",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 10),
//
//             loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : complaints.isEmpty
//                 ? const Text("No complaints found")
//                 : ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: complaints.length,
//               itemBuilder: (context, index) {
//                 final c = complaints[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         Text(
//                           c['complaint'],
//                           style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                         ),
//
//                         const SizedBox(height: 6),
//
//                         Text(
//                           "Date: ${c['date']}",
//                           style: const TextStyle(
//                               color: Colors.grey, fontSize: 12),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         c['reply'] != ''
//                             ? Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.green.shade50,
//                             borderRadius: BorderRadius.circular(6),
//                           ),
//                           child: Text(
//                             "Reply: ${c['reply']}",
//                             style: const TextStyle(
//                                 color: Colors.green,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         )
//                             : const Text(
//                           "Reply: Pending",
//                           style: TextStyle(
//                               color: Colors.orange,
//                               fontStyle: FontStyle.italic),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> sendComplaint() async {
//     if (complaintController.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Enter complaint");
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_send_complaint/"),
//       body: {
//         'lid': lid,
//         'complaint': complaintController.text,
//       },
//     );
//
//     final data = jsonDecode(response.body);
//     Fluttertoast.showToast(msg: data['message']);
//
//     if (data['status'] == 'ok') {
//       complaintController.clear();
//       loadComplaints();
//     }
//   }
//
//   Future<void> loadComplaints() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/user_view_complaints/"),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       if (data['status'] == 'ok') {
//         complaints = data['data'];
//       }
//       loading = false;
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserComplaintPage extends StatefulWidget {
  const UserComplaintPage({super.key});

  @override
  State<UserComplaintPage> createState() => _UserComplaintPageState();
}

class _UserComplaintPageState extends State<UserComplaintPage> {

  TextEditingController complaintController = TextEditingController();
  List complaints = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaints"),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Send Complaint",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [

                    TextField(
                      controller: complaintController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Complaint",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00796B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: sendComplaint,
                        child: const Text(
                          "SUBMIT",
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

              const SizedBox(height: 30),

              const Text(
                "My Complaints",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              loading
                  ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
                  : complaints.isEmpty
                  ? const Text(
                "No complaints found",
                style: TextStyle(color: Colors.white),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  final c = complaints[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          c['complaint'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Date: ${c['date']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 10),

                        c['reply'] != ''
                            ? Container(
                          padding:
                          const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green
                                .withOpacity(0.1),
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Reply: ${c['reply']}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                            : const Text(
                          "Reply: Pending",
                          style: TextStyle(
                            color: Colors.orange,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendComplaint() async {
    if (complaintController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter complaint");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/user_send_complaint/"),
      body: {
        'lid': lid,
        'complaint': complaintController.text,
      },
    );

    final data = jsonDecode(response.body);
    Fluttertoast.showToast(msg: data['message']);

    if (data['status'] == 'ok') {
      complaintController.clear();
      loadComplaints();
    }
  }

  Future<void> loadComplaints() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/user_view_complaints/"),
      body: {'lid': lid},
    );

    final data = jsonDecode(response.body);

    setState(() {
      if (data['status'] == 'ok') {
        complaints = data['data'];
      }
      loading = false;
    });
  }
}
