// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class VolunteerFeedbackPage extends StatefulWidget {
//   const VolunteerFeedbackPage({super.key});
//
//   @override
//   State<VolunteerFeedbackPage> createState() => _VolunteerFeedbackPageState();
// }
//
// class _VolunteerFeedbackPageState extends State<VolunteerFeedbackPage> {
//
//   TextEditingController titleController = TextEditingController();
//   TextEditingController feedbackController = TextEditingController();
//
//   List feedbacks = [];
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     loadFeedback();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Feedback")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             const Text(
//               "Send Feedback",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 10),
//
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 labelText: "Title",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             TextField(
//               controller: feedbackController,
//               maxLines: 4,
//               decoration: const InputDecoration(
//                 labelText: "Feedback",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: sendFeedback,
//                 child: const Text("Submit"),
//               ),
//             ),
//
//             const Divider(height: 30),
//
//             const Text(
//               "My Feedback",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//
//             const SizedBox(height: 10),
//
//             loading
//                 ? const Center(child: CircularProgressIndicator())
//                 : feedbacks.isEmpty
//                 ? const Text("No feedback found")
//                 : ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: feedbacks.length,
//               itemBuilder: (context, index) {
//                 final f = feedbacks[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(vertical: 6),
//                   child: ListTile(
//                     title: Text(f['title']),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 4),
//                         Text(f['feedback']),
//                         const SizedBox(height: 4),
//                         Text(
//                           f['date'].toString(),
//                           style: const TextStyle(
//                               color: Colors.grey, fontSize: 12),
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
//   Future<void> sendFeedback() async {
//     if (titleController.text.isEmpty || feedbackController.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Fill all fields");
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_send_feedback/"),
//       body: {
//         'lid': lid,
//         'title': titleController.text,
//         'feedback': feedbackController.text,
//       },
//     );
//
//     final data = jsonDecode(response.body);
//
//     Fluttertoast.showToast(msg: data['message']);
//
//     if (data['status'] == 'ok') {
//       titleController.clear();
//       feedbackController.clear();
//       loadFeedback();
//     }
//   }
//
//   Future<void> loadFeedback() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url")!;
//     String lid = sh.getString("lid")!;
//
//     final response = await http.post(
//       Uri.parse("$url/volunteer_view_feedback/"),
//       body: {'lid': lid},
//     );
//
//     final data = jsonDecode(response.body);
//
//     setState(() {
//       if (data['status'] == 'ok') {
//         feedbacks = data['data'];
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

class VolunteerFeedbackPage extends StatefulWidget {
  const VolunteerFeedbackPage({super.key});

  @override
  State<VolunteerFeedbackPage> createState() => _VolunteerFeedbackPageState();
}

class _VolunteerFeedbackPageState extends State<VolunteerFeedbackPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  List feedbacks = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadFeedback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ✅ HOPBITE APPBAR
      appBar: AppBar(
        title: const Text("Feedback"),
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
                width: double.infinity, // ✅ FORCE FULL WIDTH
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ================= SEND FEEDBACK =================
                    const Text(
                      "Send Feedback",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity, // ✅ FULL WIDTH
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [

                          TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              labelText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          TextField(
                            controller: feedbackController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: "Feedback",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

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
                              onPressed: sendFeedback,
                              child: const Text(
                                "SUBMIT",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ================= MY FEEDBACK =================
                    const Text(
                      "My Feedback",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    loading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : feedbacks.isEmpty
                        ? const Text(
                      "No feedback found",
                      style: TextStyle(color: Colors.white),
                    )
                        : Column(
                      children: List.generate(
                        feedbacks.length,
                            (index) {
                          final f = feedbacks[index];

                          return Container(
                            width: double.infinity, // ✅ FULL WIDTH
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.1),
                                  blurRadius: 6,
                                  offset:
                                  const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                Text(
                                  f['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  f['feedback'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    f['date'].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- SEND FEEDBACK ----------------
  Future<void> sendFeedback() async {
    if (titleController.text.isEmpty ||
        feedbackController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fill all fields");
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_send_feedback/"),
      body: {
        'lid': lid,
        'title': titleController.text,
        'feedback': feedbackController.text,
      },
    );

    final data = jsonDecode(response.body);
    Fluttertoast.showToast(msg: data['message']);

    if (data['status'] == 'ok') {
      titleController.clear();
      feedbackController.clear();
      loadFeedback();
    }
  }

  // ---------------- LOAD FEEDBACK ----------------
  Future<void> loadFeedback() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/volunteer_view_feedback/"),
      body: {'lid': lid},
    );

    final data = jsonDecode(response.body);

    setState(() {
      if (data['status'] == 'ok') {
        feedbacks = data['data'];
      }
      loading = false;
    });
  }
}
