//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';
//
// class SendDonationRequestPage extends StatefulWidget {
//   final String homeName;
//
//   const SendDonationRequestPage({
//     super.key,
//     required this.homeName,
//   });
//
//   @override
//   State<SendDonationRequestPage> createState() =>
//       _SendDonationRequestPageState();
// }
//
// class _SendDonationRequestPageState extends State<SendDonationRequestPage> {
//
//   final TextEditingController foodTypeController = TextEditingController();
//   final TextEditingController foodItemsController = TextEditingController();
//   final TextEditingController quantityController = TextEditingController();
//
//   DateTime? preparedDate;
//   TimeOfDay? preparedTime;
//   bool loading = false;
//
//   Future<void> pickDate() async {
//     DateTime? date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now().subtract(const Duration(days: 1)),
//       lastDate: DateTime.now().add(const Duration(days: 1)),
//     );
//     if (date != null) setState(() => preparedDate = date);
//   }
//
//   Future<void> pickTime() async {
//     TimeOfDay? time =
//     await showTimePicker(context: context, initialTime: TimeOfDay.now());
//     if (time != null) setState(() => preparedTime = time);
//   }
//
//   Future<void> sendDonationRequest() async {
//
//     String foodType = foodTypeController.text.trim();
//     String foodItems = foodItemsController.text.trim();
//     String quantityText = quantityController.text.trim();
//
//     if (foodType.isEmpty ||
//         foodItems.isEmpty ||
//         quantityText.isEmpty) {
//       Fluttertoast.showToast(msg: "All fields are required");
//       return;
//     }
//
//     if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(foodType)) {
//       Fluttertoast.showToast(msg: "Food type must contain only letters");
//       return;
//     }
//
//     int? qty = int.tryParse(quantityText);
//     if (qty == null) {
//       Fluttertoast.showToast(msg: "Quantity must be a number");
//       return;
//     }
//
//     if (qty < 30) {
//       Fluttertoast.showToast(msg: "Minimum quantity is 30");
//       return;
//     }
//
//     if (preparedDate == null || preparedTime == null) {
//       Fluttertoast.showToast(msg: "Select prepared date and time");
//       return;
//     }
//
//     setState(() => loading = true);
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString("url")!;
//       String lid = sh.getString("lid")!;
//       String homeId = sh.getString("home_id")!;
//
//       String preparedDateStr =
//       preparedDate!.toIso8601String().split("T")[0];
//
//       String preparedTimeStr =
//           "${preparedTime!.hour.toString().padLeft(2, '0')}:${preparedTime!.minute.toString().padLeft(2, '0')}";
//
//       var response = await http.post(
//         Uri.parse("$url/user_send_donation_request/"),
//         body: {
//           "lid": lid,
//           "home_id": homeId,
//           "food_type": foodType,
//           "food_items": foodItems,
//           "quantity": quantityText,
//           "prepared_date": preparedDateStr,
//           "prepared_time": preparedTimeStr,
//         },
//       );
//
//       var jsonData = jsonDecode(response.body);
//
//       if (jsonData["status"] == "ok") {
//         Fluttertoast.showToast(
//           msg: "Request Sent ✅\nExpiry Time: ${jsonData['expiry_time']}",
//           toastLength: Toast.LENGTH_LONG,
//         );
//         Navigator.pop(context);
//       } else {
//         Fluttertoast.showToast(msg: "Failed to send request");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//
//     setState(() => loading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Send Donation Request"),
//         backgroundColor: const Color(0xFF00796B),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF00BFA5), Color(0xFF004D40)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Text(
//                 "To: ${widget.homeName}",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   children: [
//
//                     _box(foodTypeController, "Food Type (Veg / Non-Veg)"),
//                     _box(foodItemsController, "Food Items"),
//                     _box(
//                       quantityController,
//                       "Quantity (Minimum 30)",
//                       isNumber: true,
//                     ),
//
//                     const SizedBox(height: 15),
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00796B),
//                             ),
//                             onPressed: pickDate,
//                             icon: const Icon(Icons.calendar_today, color: Colors.white),
//                             label: Text(
//                               preparedDate == null
//                                   ? "Prepared Date"
//                                   : preparedDate!.toString().split(" ")[0],
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF00796B),
//                             ),
//                             onPressed: pickTime,
//                             icon: const Icon(Icons.access_time, color: Colors.white),
//                             label: Text(
//                               preparedTime == null
//                                   ? "Prepared Time"
//                                   : preparedTime!.format(context),
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   icon: const Icon(Icons.send, color: Color(0xFF00796B)),
//                   label: const Text(
//                     "SEND REQUEST",
//                     style: TextStyle(
//                       color: Color(0xFF00796B),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: sendDonationRequest,
//                 ),
//               ),
//
//               if (loading)
//                 const Padding(
//                   padding: EdgeInsets.only(top: 15),
//                   child: Center(child: CircularProgressIndicator(color: Colors.white)),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _box(
//       TextEditingController c,
//       String label, {
//         bool isNumber = false,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextField(
//         controller: c,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         inputFormatters:
//         isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SendDonationRequestPage extends StatefulWidget {
  final String homeName;

  const SendDonationRequestPage({
    super.key,
    required this.homeName,
  });

  @override
  State<SendDonationRequestPage> createState() =>
      _SendDonationRequestPageState();
}

class _SendDonationRequestPageState extends State<SendDonationRequestPage> {

  final TextEditingController foodTypeController = TextEditingController();
  final TextEditingController foodItemsController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  DateTime? preparedDate;
  TimeOfDay? preparedTime;
  bool loading = false;

  String? expiryTime;
  String? urgencyMessage;
  Color? urgencyColor;

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date != null) setState(() => preparedDate = date);
  }

  Future<void> pickTime() async {
    TimeOfDay? time =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) setState(() => preparedTime = time);
  }

  Color _getUrgencyColor(String urgency) {
    if (urgency.contains("🔴")) return Colors.red;
    if (urgency.contains("🟡")) return Colors.orange;
    return Colors.green;
  }

  Future<void> sendDonationRequest() async {

    String foodType = foodTypeController.text.trim();
    String foodItems = foodItemsController.text.trim();
    String quantityText = quantityController.text.trim();

    if (foodType.isEmpty || foodItems.isEmpty || quantityText.isEmpty) {
      Fluttertoast.showToast(msg: "All fields are required");
      return;
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(foodType)) {
      Fluttertoast.showToast(msg: "Food type must contain only letters");
      return;
    }

    int? qty = int.tryParse(quantityText);
    if (qty == null) {
      Fluttertoast.showToast(msg: "Quantity must be a number");
      return;
    }

    if (qty < 30) {
      Fluttertoast.showToast(msg: "Minimum quantity is 30");
      return;
    }

    if (preparedDate == null || preparedTime == null) {
      Fluttertoast.showToast(msg: "Select prepared date and time");
      return;
    }

    setState(() => loading = true);

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString("url")!;
      String lid = sh.getString("lid")!;
      String homeId = sh.getString("home_id")!;

      String preparedDateStr = preparedDate!.toIso8601String().split("T")[0];
      String preparedTimeStr =
          "${preparedTime!.hour.toString().padLeft(2, '0')}:${preparedTime!.minute.toString().padLeft(2, '0')}";

      var response = await http.post(
        Uri.parse("$url/user_send_donation_request/"),
        body: {
          "lid": lid,
          "home_id": homeId,
          "food_type": foodType,
          "food_items": foodItems,
          "quantity": quantityText,
          "prepared_date": preparedDateStr,
          "prepared_time": preparedTimeStr,
        },
      );

      var jsonData = jsonDecode(response.body);

      if (jsonData["status"] == "ok") {
        setState(() {
          expiryTime = jsonData['expiry_time'];
          urgencyMessage = jsonData['urgency'];
          urgencyColor = _getUrgencyColor(jsonData['urgency']);
        });

        Fluttertoast.showToast(
          msg: "Request Sent ✅",
          toastLength: Toast.LENGTH_LONG,
        );
      } else {
        Fluttertoast.showToast(msg: "Failed to send request");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Donation Request"),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "To: ${widget.homeName}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    _box(foodTypeController, "Food Type (Veg / Non-Veg)"),
                    _box(foodItemsController, "Food Items"),
                    _box(
                      quantityController,
                      "Quantity (Minimum 30)",
                      isNumber: true,
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00796B),
                            ),
                            onPressed: pickDate,
                            icon: const Icon(Icons.calendar_today, color: Colors.white),
                            label: Text(
                              preparedDate == null
                                  ? "Prepared Date"
                                  : preparedDate!.toString().split(" ")[0],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00796B),
                            ),
                            onPressed: pickTime,
                            icon: const Icon(Icons.access_time, color: Colors.white),
                            label: Text(
                              preparedTime == null
                                  ? "Prepared Time"
                                  : preparedTime!.format(context),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.send, color: Color(0xFF00796B)),
                  label: const Text(
                    "SEND REQUEST",
                    style: TextStyle(
                      color: Color(0xFF00796B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: sendDonationRequest,
                ),
              ),

              if (loading)
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(child: CircularProgressIndicator(color: Colors.white)),
                ),

              // ── Color-based expiry urgency card ──
              if (expiryTime != null && urgencyMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: urgencyColor!.withOpacity(0.15),
                      border: Border.all(color: urgencyColor!, width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer, color: urgencyColor, size: 22),
                            const SizedBox(width: 8),
                            Text(
                              "Expiry Info",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: urgencyColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "⏰ Expiry Time: $expiryTime",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          urgencyMessage!,
                          style: TextStyle(
                            fontSize: 14,
                            color: urgencyColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _box(
      TextEditingController c,
      String label, {
        bool isNumber = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters:
        isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}