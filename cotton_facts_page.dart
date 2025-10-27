import 'package:flutter/material.dart';

class CottonFactsPage extends StatelessWidget {
  const CottonFactsPage({Key? key}) : super(key: key);

  final List<Map<String, String>> cottonFacts = const [
    {
      "icon": "🌱",
      "fact": "Cotton is a natural fiber that grows around the seeds of the cotton plant."
    },
    {
      "icon": "👖",
      "fact": "One bale of cotton can make over 200 pairs of jeans!"
    },
    {
      "icon": "🌍",
      "fact": "Cotton is grown in over 100 countries around the world."
    },
    {
      "icon": "♻️",
      "fact": "Cotton is biodegradable and eco-friendly."
    },
    {
      "icon": "🌞",
      "fact": "It takes about 6 months for a cotton plant to grow from seed to harvest."
    },
    {
      "icon": "🐛",
      "fact": "Pests like bollworms can damage cotton crops, so early disease detection is key."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Cotton Facts",
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🌾 Welcome to Cotton Facts!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Swipe through and discover cool facts about the cotton you wear and use every day!",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: cottonFacts.length,
                itemBuilder: (context, index) {
                  final fact = cottonFacts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Text(
                        fact["icon"]!,
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(
                        fact["fact"]!,
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
                "“Know your cotton, grow your future!” 🌿",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
