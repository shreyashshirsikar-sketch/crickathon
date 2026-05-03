import 'package:flutter/material.dart';

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> with SingleTickerProviderStateMixin {
  String? _selectedPrediction;
  bool _isSubmitted = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Data for Prediction Buttons
  final List<Map<String, dynamic>> _predictions = [
    {
      "label": "Dot",
      "icon": Icons.block_rounded,
      "bg": const Color(0xFFFFF9C4),
      "color": const Color(0xFFF57F17),
    },
    {
      "label": "Single",
      "icon": Icons.exposure_plus_1_rounded,
      "bg": const Color(0xFFE3F2FD),
      "color": const Color(0xFF1565C0),
    },
    {
      "label": "Boundary",
      "icon": Icons.bolt_rounded,
      "bg": const Color(0xFFE8F5E9),
      "color": const Color(0xFF2E7D32),
    },
    {
      "label": "Wicket",
      "icon": Icons.close_rounded,
      "bg": const Color(0xFFFFEBEE),
      "color": const Color(0xFFC62828),
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _submitPrediction() {
    if (_selectedPrediction != null) {
      setState(() {
        _isSubmitted = true;
      });
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.online_prediction_rounded, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              "Predict & Win",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accuracy Header
            _buildAccuracyHeader(context),
            const SizedBox(height: 32),

            // Key Matchup Section
            Text(
              "Key Matchup",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            _buildKeyMatchup(
              context,
              "Virat Kohli",
              "72* (45)",
              "Pat Cummins",
              "3.2-0-28-1",
            ),
            const SizedBox(height: 32),

            // Prediction Section
            Text(
              "Predict the Next Ball",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: _predictions.map((p) => _buildPredictButton(context, p)).toList(),
            ),

            const SizedBox(height: 32),

            // Submit Button / Feedback
            _isSubmitted
                ? _buildSuccessCard(context)
                : SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _selectedPrediction == null ? null : _submitPrediction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                        elevation: _selectedPrediction == null ? 0 : 8,
                        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Lock Prediction",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      ),
                    ),
                  ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAccuracyHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_graph_rounded, color: Theme.of(context).colorScheme.primary, size: 28),
          const SizedBox(width: 12),
          Text(
            "YOUR ACCURACY: ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ),
          ),
          Text(
            "84%",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMatchup(
    BuildContext context,
    String p1Name,
    String p1Stat,
    String p2Name,
    String p2Stat,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p1Name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 4),
                Text(p1Stat, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: const Text(
              "VS",
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black54),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(p2Name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 4),
                Text(p2Stat, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictButton(BuildContext context, Map<String, dynamic> data) {
    bool isSelected = _selectedPrediction == data['label'];
    return GestureDetector(
      onTap: _isSubmitted ? null : () => setState(() => _selectedPrediction = data['label']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? data['bg'] : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: data['color'].withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
          border: Border.all(
            color: isSelected ? data['color'] : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.5) : data['bg'],
                shape: BoxShape.circle,
              ),
              child: Icon(data['icon'], color: data['color'], size: 36),
            ),
            const SizedBox(height: 12),
            Text(
              data['label'],
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: isSelected ? data['color'] : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessCard(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            const Icon(Icons.check_circle_rounded, color: Color(0xFF4CAF50), size: 48),
            const SizedBox(height: 12),
            const Text(
              "Prediction Locked!",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "You picked '$_selectedPrediction'. Good luck!",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF388E3C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
