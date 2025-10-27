import 'package:flutter/material.dart';

class FarmingTipsPage extends StatelessWidget {
  const FarmingTipsPage({Key? key}) : super(key: key);

  final List<Map<String, String>> cottonTips = const [
    {
      "icon": "📅",
      "tip": "January - February: Prepare the soil by plowing and adding organic compost or manure."
    },
    {
      "icon": "🌱",
      "tip": "March: Choose high-quality cotton seeds and treat them to prevent early pest issues."
    },
    {
      "icon": "🌦️",
      "tip": "April: Start sowing the seeds with appropriate spacing and depth after the last frost."
    },
    {
      "icon": "💧",
      "tip": "May - June: Ensure consistent irrigation. Cotton needs moisture during germination and early growth."
    },
    {
      "icon": "🧪",
      "tip": "June - July: Apply fertilizers rich in nitrogen and potassium for healthy plant development."
    },
    {
      "icon": "🦟",
      "tip": "July - August: Monitor for pests like bollworms and aphids; apply natural or chemical control as needed."
    },
    {
      "icon": "🌸",
      "tip": "August - September: Flowering begins. Maintain even moisture and remove weeds manually or chemically."
    },
    {
      "icon": "🧺",
      "tip": "October: Harvest begins as cotton bolls mature. Pick cotton during dry weather to avoid rotting."
    },
    {
      "icon": "🔁",
      "tip": "November - December: After harvest, clear the field and rotate crops to restore soil health."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cotton Growing Tips',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🧑‍🌾 How to Grow Cotton (Year-Round Guide)",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Follow these monthly tips to grow healthy cotton and maximize your yield:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: cottonTips.length,
                itemBuilder: (context, index) {
                  final tip = cottonTips[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Text(
                        tip["icon"]!,
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(
                        tip["tip"]!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "“With care and patience, your cotton will bloom!” 🌾",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
