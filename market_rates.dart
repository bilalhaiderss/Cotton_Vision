import 'package:flutter/material.dart';

class MarketRatesPage extends StatelessWidget {
  const MarketRatesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> marketRates = const [
    {
      "icon": "📦",
      "type": "Phutti (Raw Cotton)",
      "rate": "Rs. 8,500 - Rs. 9,300 per 40 kg"
    },
    {
      "icon": "🧺",
      "type": "Lint Cotton (Processed)",
      "rate": "Rs. 17,000 - Rs. 18,500 per maund"
    },
    {
      "icon": "🏭",
      "type": "Kapas (Seed Cotton)",
      "rate": "Rs. 8,800 - Rs. 9,500 per 40 kg"
    },
    {
      "icon": "🌾",
      "type": "Sindh Cotton",
      "rate": "Rs. 8,600 - Rs. 9,200 per 40 kg"
    },
    {
      "icon": "🌿",
      "type": "Punjab Cotton",
      "rate": "Rs. 8,900 - Rs. 9,600 per 40 kg"
    },
    {
      "icon": "🧵",
      "type": "Cotton Yarn (30s)",
      "rate": "Rs. 3,100 - Rs. 3,300 per 10 lbs"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Market Rates',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📊 Cotton Market Rates (Pakistan)",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Here are the latest market prices for various types of cotton in Pakistan. Prices may vary by region and demand:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: marketRates.length,
                itemBuilder: (context, index) {
                  final item = marketRates[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Text(
                        item["icon"]!,
                        style: const TextStyle(fontSize: 28),
                      ),
                      title: Text(
                        item["type"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item["rate"]!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "“Stay informed. Make better trade decisions!” 🧑‍🌾",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
