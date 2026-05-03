import 'package:flutter/material.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  String? _selectedPrediction;
  bool _isSubmitted = false;

  // Data for Prediction Buttons
  final List<Map<String, dynamic>> _predictions = [
    {
      "label": "Dot",
      "icon": Icons.block,
      "bg": Colors.yellow.shade100,
      "color": Colors.yellow.shade700,
    },
    {
      "label": "Single",
      "icon": Icons.exposure_plus_1,
      "bg": Colors.blue.shade100,
      "color": Colors.blue.shade700,
    },
    {
      "label": "Boundary",
      "icon": Icons.bolt,
      "bg": const Color(0xFF89FA9B),
      "color": const Color(0xFF006E2C),
    },
    {
      "label": "Wicket",
      "icon": Icons.close,
      "bg": const Color(0xFFFFDAD6),
      "color": const Color(0xFFBA1A1A),
    },
  ];

  void _submitPrediction() {
    if (_selectedPrediction != null) {
      setState(() {
        _isSubmitted = true;
      });
      // Here you would add logic to send the prediction to your backend
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Icon(Icons.sports_cricket, color: Color(0xFF0058BD)),
            SizedBox(width: 8),
            Text(
              "IND 184/3 (18.2)",
              style: TextStyle(
                color: Color(0xFF0058BD),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accuracy Header
            _buildAccuracyHeader(),
            const SizedBox(height: 24),

            // Key Matchup Section (Mentioning two players)
            const Text(
              "Key Matchup",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildKeyMatchup(
              "Virat Kohli",
              "72* (45 balls)",
              "Pat Cummins",
              "3.2-0-28-1",
            ),
            const SizedBox(height: 24),

            // Prediction Section
            const Text(
              "Predict the Next Ball",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: _predictions
                  .map((p) => _buildPredictButton(p))
                  .toList(),
            ),

            const SizedBox(height: 24),

            // Submit Button / Feedback
            _isSubmitted
                ? _buildSuccessCard()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedPrediction == null
                          ? null
                          : _submitPrediction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0058BD),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Confirm Prediction",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccuracyHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3FD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC2C6D5)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, color: Color(0xFF0058BD)),
          SizedBox(width: 12),
          Text(
            "ACCURACY: 84%",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0058BD),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMatchup(
    String p1Name,
    String p1Stat,
    String p2Name,
    String p2Stat,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(p1Name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(p1Stat, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const Text(
            "VS",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Column(
            children: [
              Text(p2Name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(p2Stat, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPredictButton(Map<String, dynamic> data) {
    bool isSelected = _selectedPrediction == data['label'];
    return GestureDetector(
      onTap: _isSubmitted
          ? null
          : () => setState(() => _selectedPrediction = data['label']),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF0058BD) : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: data['bg'],
                shape: BoxShape.circle,
              ),
              child: Icon(data['icon'], color: data['color'], size: 32),
            ),
            const SizedBox(height: 8),
            Text(
              data['label'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 8),
          Text(
            "Prediction '$_selectedPrediction' Submitted!",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
