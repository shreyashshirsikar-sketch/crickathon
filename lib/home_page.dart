import 'package:flutter/material.dart';
// Make sure to import your other files here:
// import 'predict_page.dart';
// import 'trivia_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Navigation Section
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildNavButton(
                    context,
                    "Predict",
                    Icons.analytics,
                    const Color(0xFFD8E2FF),
                    () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => const PredictPage()));
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNavButton(
                    context,
                    "Trivia",
                    Icons.quiz,
                    const Color(0xFF86F898),
                    () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => const TriviaPage()));
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 2. Live Match Card
            _buildLiveMatchCard(),

            const SizedBox(height: 24),

            // 3. Stats Section
            const Text(
              "Match Stats",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard("Run Rate", "10.1", Icons.bolt, true),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    "Target",
                    "320",
                    Icons.trending_up,
                    false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 4. Poll Section
            _buildPollSection(),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---

  Widget _buildNavButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF0058BD), size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveMatchCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "LIVE NOW",
                style: TextStyle(
                  color: Color(0xFF0058BD),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              Icon(Icons.circle, color: Colors.red, size: 12),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "INDIA: 184/3",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "PAK: Yet to bat",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    bool isPrimary,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFFD8E2FF) : const Color(0xFFECEDF7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0058BD)),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            label.toUpperCase(),
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPollSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Live Match Poll",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...["Bumrah (42%)", "Shami (28%)"].map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(e),
            ),
          ),
        ],
      ),
    );
  }
}
