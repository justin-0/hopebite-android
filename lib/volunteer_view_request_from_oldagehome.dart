

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteerViewAcceptedRequestsPage_od extends StatefulWidget {
  const VolunteerViewAcceptedRequestsPage_od({super.key});

  @override
  State<VolunteerViewAcceptedRequestsPage_od> createState() =>
      _VolunteerViewAcceptedRequestsPageState();
}

class _VolunteerViewAcceptedRequestsPageState
    extends State<VolunteerViewAcceptedRequestsPage_od> {

  List requests = [];
  bool loading = true;
  String myId = "";

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    myId = sh.getString("lid")!;
    loadRequests();
  }

  Color _getUrgencyColor(String urgency) {
    if (urgency == 'high') return Colors.red;
    if (urgency == 'medium') return Colors.orange;
    return Colors.green;
  }

  String _getUrgencyLabel(String urgency) {
    if (urgency == 'high') return '🔴 High Urgency';
    if (urgency == 'medium') return '🟡 Medium Urgency';
    return '🟢 Low Urgency';
  }

  Future<void> _openMap(String lat, String lon, String label) async {
    final uri = Uri.parse(
      'https://maps.google.com/maps?daddr=$lat,$lon',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Requests from Old Age Homes"),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
      ),

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
                padding: const EdgeInsets.all(16),
                child: loading
                    ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                    : requests.isEmpty
                    ? const Center(
                  child: Text(
                    "No requests available",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : Column(
                  children: List.generate(requests.length, (index) {
                    final r = requests[index];
                    String status = r['status'];
                    String urgency = r['urgency'] ?? 'low';
                    bool isMine = r['volunteer_id'].toString() == myId;
                    bool takenByOther = status != 'open' && !isMine;

                    Color urgencyColor = _getUrgencyColor(urgency);
                    String urgencyLabel = _getUrgencyLabel(urgency);

                    Color statusColor = status == 'delivered'
                        ? Colors.green
                        : status == 'collected'
                        ? Colors.orange
                        : status == 'accepted'
                        ? Colors.blue
                        : Colors.grey;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // ========= FOOD SECTION =========
                          sectionTitle(Icons.restaurant, "Food Details"),
                          infoRow("Items", r['food_items']),
                          infoRow("Quantity", r['quantity'].toString()),

                          // ── Expiry with urgency color ──
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: urgencyColor.withOpacity(0.1),
                                border: Border.all(
                                    color: urgencyColor, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    urgencyLabel,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: urgencyColor,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Icon(Icons.timer,
                                          size: 14, color: urgencyColor),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Expiry: ${r['expiry_time']}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: urgencyColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const Divider(height: 24),

                          // ========= DONOR SECTION =========
                          sectionTitleWithMap(
                            Icons.person,
                            "Donor Details",
                            r['donor_latitude'].toString(),
                            r['donor_longitude'].toString(),
                            r['donor_name'],
                          ),
                          infoRow("Name", r['donor_name']),
                          infoRow("Phone", r['donor_phone']),
                          infoRow("Distance",
                              "${r['distance_to_donor_km']} km"),

                          const Divider(height: 24),

                          // ========= OLD AGE HOME =========
                          sectionTitleWithMap(
                            Icons.home,
                            "Old Age Home / Orphanage",
                            r['home_latitude'].toString(),
                            r['home_longitude'].toString(),
                            r['home_name'],
                          ),
                          infoRow("Name", r['home_name']),
                          infoRow("Place", r['home_place']),
                          infoRow("Phone", r['home_phone']),
                          infoRow("Distance",
                              "${r['distance_to_home_km']} km"),

                          const Divider(height: 24),

                          // ========= STATUS =========
                          Row(
                            children: [
                              const Icon(Icons.info, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                takenByOther
                                    ? "Taken by another volunteer"
                                    : "Status: ${status.toUpperCase()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: takenByOther
                                      ? Colors.red
                                      : statusColor,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          // ========= ACTION BUTTONS =========
                          if (status == 'open')
                            actionButton(
                              "ACCEPT ORDER",
                              Colors.blue,
                                  () => acceptOrder(
                                  r['order_id'].toString()),
                            ),

                          if (status == 'accepted' && isMine)
                            actionButton(
                              "COLLECTED",
                              Colors.orange,
                                  () => markCollected(
                                  r['order_id'].toString()),
                            ),

                          if (status == 'collected' && isMine)
                            actionButton(
                              "DELIVERED",
                              Colors.green,
                                  () => markDelivered(
                                  r['order_id'].toString()),
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

  // ================= UI HELPERS =================

  Widget sectionTitle(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF00796B)),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ── Section title with map icon on the right ──
  Widget sectionTitleWithMap(
      IconData icon,
      String text,
      String lat,
      String lon,
      String label,
      ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF00796B)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _openMap(lat, lon, label),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF00796B).withOpacity(0.1),
              border: Border.all(color: const Color(0xFF00796B), width: 1.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on,
                    size: 15, color: Color(0xFF00796B)),
                SizedBox(width: 3),
                Text(
                  "Map",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF00796B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget actionButton(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ================= API CALLS =================

  Future<void> loadRequests() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;

    final res = await http.post(
      Uri.parse("$url/volunteer_view_request_from_oldagehome/"),
      body: {'lid': lid},
    );

    final data = jsonDecode(res.body);
    setState(() {
      requests = data['data'];
      loading = false;
    });
  }

  Future<void> acceptOrder(String id) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;
    await http.post(Uri.parse("$url/volunteer_accept_order/"),
        body: {'order_id': id, 'lid': lid});
    loadRequests();
  }

  Future<void> markCollected(String id) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;
    await http.post(Uri.parse("$url/volunteer_mark_collected/"),
        body: {'order_id': id, 'lid': lid});
    loadRequests();
  }

  Future<void> markDelivered(String id) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url")!;
    String lid = sh.getString("lid")!;
    await http.post(Uri.parse("$url/volunteer_mark_delivered/"),
        body: {'order_id': id, 'lid': lid});
    loadRequests();
  }
}