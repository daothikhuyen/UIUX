import 'package:flutter/material.dart';

class GroupEventsPage extends StatelessWidget {
  const GroupEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Group Events",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [Icon(Icons.add, size: 30), SizedBox(width: 12)],
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _title("Events in progress"),
          _eventItem(),

          const SizedBox(height: 8),
          _title("Upcoming Events"),

          _eventItem(),
          _eventItem(),
          _eventItem(),

          const SizedBox(height: 8),
          _title("Past events"),

          _eventItem(),
          _eventItem(),
        ],
      ),
    );
  }
}

Widget _title(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
    ),
  );
}

Widget _eventItem() {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/images/d1.jpg",
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "March 8 • Online",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(height: 5),
              Text(
                "Propaganda events, encouraging hearts",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "393 people interested • 1 participated",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
