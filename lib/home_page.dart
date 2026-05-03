import 'package:flutter/material.dart';
// Make sure to import your other files here:
// import 'predict_page.dart';
// import 'trivia_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.sports_cricket_rounded, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              "CricPulse",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Live Match Card (Premium Gradient)
            _buildLiveMatchCard(context),

            const SizedBox(height: 32),

            // 2. Navigation Section
            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w800, 
                color: Theme.of(context).colorScheme.primary
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildNavButton(
                    context,
                    "Predict",
                    "Win Points",
                    Icons.online_prediction_rounded,
                    Theme.of(context).colorScheme.primary,
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
                    "Test Knowledge",
                    Icons.quiz_rounded,
                    Theme.of(context).colorScheme.secondary,
                    () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => const TriviaPage()));
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 3. Stats Section
            Text(
              "Match Stats",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w800, 
                color: Theme.of(context).colorScheme.primary
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard(context, "Run Rate", "10.1", Icons.bolt_rounded, true)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, "Target", "320", Icons.trending_up_rounded, false)),
              ],
            ),

            const SizedBox(height: 32),

            // 4. Poll Section
            _buildPollSection(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // --- Helpers ---

  Widget _buildNavButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveMatchCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            const Color(0xFF283593), // Slightly lighter indigo
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    FadeTransition(
                      opacity: _pulseController,
                      child: const Icon(Icons.circle, color: Colors.redAccent, size: 10),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.cast_rounded, color: Colors.white70, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("INDIA", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  const Text(
                    "184/3",
                    style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800, height: 1),
                  ),
                  const SizedBox(height: 4),
                  Text("Overs: 18.2", style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("PAK", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  const Text(
                    "Yet to bat",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, height: 1),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: isPrimary ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: isPrimary ? Theme.of(context).colorScheme.primary : Colors.grey.shade600, size: 24),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 28, 
              fontWeight: FontWeight.w800,
              color: isPrimary ? Theme.of(context).colorScheme.primary : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 11, 
              fontWeight: FontWeight.w700, 
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.how_to_vote_rounded, color: Theme.of(context).colorScheme.secondary, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                "Live Match Poll",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Who will be the top wicket taker?",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          _buildPollOption(context, "Jasprit Bumrah", 0.65, true),
          const SizedBox(height: 12),
          _buildPollOption(context, "Mohammed Shami", 0.35, false),
        ],
      ),
    );
  }

  Widget _buildPollOption(BuildContext context, String name, double percentage, bool isWinning) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text("${(percentage * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 12,
            backgroundColor: Colors.grey.shade100,
            valueColor: AlwaysStoppedAnimation<Color>(
              isWinning ? Theme.of(context).colorScheme.secondary : Colors.grey.shade300,
            ),
          ),
        ),
      ],
    );
  }
}
