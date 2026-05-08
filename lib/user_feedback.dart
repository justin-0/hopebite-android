// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class UserFeedbackPage extends StatefulWidget {
//   const UserFeedbackPage({super.key});
//
//   @override
//   State<UserFeedbackPage> createState() => _UserFeedbackPageState();
// }
//
// class _UserFeedbackPageState extends State<UserFeedbackPage> {
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
//                           style: const TextStyle(color: Colors.grey, fontSize: 12),
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
//       Uri.parse("$url/user_send_feedback/"),
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
//       Uri.parse("$url/user_view_feedback/"),
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

class UserFeedbackPage extends StatefulWidget {
  const UserFeedbackPage({super.key});

  @override
  State<UserFeedbackPage> createState() => _UserFeedbackPageState();
}

class _UserFeedbackPageState extends State<UserFeedbackPage> {

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
      appBar: AppBar(
        title: const Text("Feedback"),
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
                "Send Feedback",
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
                        onPressed: sendFeedback,
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
                child: CircularProgressIndicator(color: Colors.white),
              )
                  : feedbacks.isEmpty
                  ? const Text(
                "No feedback found",
                style: TextStyle(color: Colors.white),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: feedbacks.length,
                itemBuilder: (context, index) {
                  final f = feedbacks[index];

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
                          f['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          f['feedback'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          f['date'].toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
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
      Uri.parse("$url/user_send_feedback/"),
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

  Future<void> loadFeedback() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final response = await http.post(
      Uri.parse("$url/user_view_feedback/"),
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
