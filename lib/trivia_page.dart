import 'package:flutter/material.dart';

// --- Data Model ---
class TriviaQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String hint;

  TriviaQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.hint,
  });
}

// --- Main Trivia Page ---
class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  State<TriviaPage> createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;
  late AnimationController _fadeController;

  final List<TriviaQuestion> _questions = [
    TriviaQuestion(
      question: "Who holds the record for most Test centuries?",
      options: ['Sachin Tendulkar', 'Virat Kohli', 'Ricky Ponting', 'Kumar Sangakkara'],
      correctIndex: 0,
      hint: "Often called the 'Little Master'.",
    ),
    TriviaQuestion(
      question: "Which country has won the most ODI World Cups?",
      options: ['India', 'West Indies', 'Australia', 'England'],
      correctIndex: 2,
      hint: "They have 6 titles.",
    ),
    TriviaQuestion(
      question: "Who is known as 'Captain Cool'?",
      options: ['Ricky Ponting', 'MS Dhoni', 'Kane Williamson', 'Steve Smith'],
      correctIndex: 1,
      hint: "Known for his calm demeanor.",
    ),
    TriviaQuestion(
      question: "What is the highest individual score in an ODI?",
      options: ['264', '237', '219', '200'],
      correctIndex: 0,
      hint: "Scored by Rohit Sharma.",
    ),
    TriviaQuestion(
      question: "Which stadium is known as the 'Home of Cricket'?",
      options: ['MCG', 'Eden Gardens', 'Lord\'s', 'Wankhede'],
      correctIndex: 2,
      hint: "Located in London.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _handleOptionSelected(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _questions[_currentIndex].correctIndex) {
        _score += 50;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _fadeController.reset();
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
      _fadeController.forward();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultsPage(score: _score)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_currentIndex];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.quiz_rounded, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              "Trivia Challenge",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.stars_rounded, size: 20, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 6),
                Text(
                  "$_score",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeController,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Progress Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question ${_currentIndex + 1} of ${_questions.length}",
                    style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
                  ),
                  Text(
                    "${((_currentIndex + 1) / _questions.length * 100).toInt()}%",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _questions.length,
                  minHeight: 8,
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 32),

              // Question Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "MASTERY LEVEL",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      currentQ.question,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Options List
              ...currentQ.options.asMap().entries.map((entry) => _buildOptionTile(context, entry.key, entry.value)),

              // Hint Box
              if (_answered)
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.lightbulb_rounded, color: Colors.blue.shade600, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          currentQ.hint,
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 80), // Padding for FAB
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _answered
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 56,
              child: FloatingActionButton.extended(
                onPressed: _nextQuestion,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                label: const Text("Next Question", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                icon: const Icon(Icons.arrow_forward_rounded),
              ),
            )
          : null,
    );
  }

  Widget _buildOptionTile(BuildContext context, int index, String text) {
    bool isSelected = _selectedOption == index;
    bool isCorrect = index == _questions[_currentIndex].correctIndex;
    
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.transparent;
    Color textColor = Colors.black87;
    IconData? trailingIcon;
    Color iconColor = Colors.transparent;

    if (_answered) {
      if (isCorrect) {
        backgroundColor = Colors.green.shade50;
        borderColor = Colors.green;
        textColor = Colors.green.shade800;
        trailingIcon = Icons.check_circle_rounded;
        iconColor = Colors.green;
      } else if (isSelected) {
        backgroundColor = Colors.red.shade50;
        borderColor = Colors.red.shade300;
        textColor = Colors.red.shade800;
        trailingIcon = Icons.cancel_rounded;
        iconColor = Colors.red;
      }
    } else if (isSelected) {
      backgroundColor = Theme.of(context).colorScheme.primary.withOpacity(0.05);
      borderColor = Theme.of(context).colorScheme.primary;
      textColor = Theme.of(context).colorScheme.primary;
    }

    return GestureDetector(
      onTap: () => _handleOptionSelected(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: [
            if (!_answered)
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _answered ? backgroundColor : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _answered ? Colors.transparent : Colors.grey.shade200,
                ),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: _answered ? textColor : Colors.grey.shade500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: textColor,
                ),
              ),
            ),
            if (trailingIcon != null) Icon(trailingIcon, color: iconColor),
          ],
        ),
      ),
    );
  }
}

// --- Results Page ---
class ResultsPage extends StatelessWidget {
  final int score;
  const ResultsPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.emoji_events_rounded, size: 100, color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(height: 32),
              const Text(
                "Quiz Complete!",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              Text(
                "Your Final Score",
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                "$score",
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Back to Home", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
