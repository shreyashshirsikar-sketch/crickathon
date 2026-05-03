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

class _TriviaPageState extends State<TriviaPage> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;

  final List<TriviaQuestion> _questions = [
    TriviaQuestion(
      question: "Who holds the record for most Test centuries?",
      options: [
        'Sachin Tendulkar',
        'Virat Kohli',
        'Ricky Ponting',
        'Kumar Sangakkara',
      ],
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
    TriviaQuestion(
      question: "Who has the most wickets in Test cricket history?",
      options: [
        'Shane Warne',
        'Anil Kumble',
        'James Anderson',
        'Muttiah Muralitharan',
      ],
      correctIndex: 3,
      hint: "Spin wizard from Sri Lanka.",
    ),
    TriviaQuestion(
      question: "Which team won the inaugural T20 World Cup?",
      options: ['Pakistan', 'India', 'Australia', 'South Africa'],
      correctIndex: 1,
      hint: "Won in 2007 under Dhoni.",
    ),
    TriviaQuestion(
      question: "Who scored the fastest century in ODIs?",
      options: [
        'Chris Gayle',
        'AB de Villiers',
        'Shahid Afridi',
        'Corey Anderson',
      ],
      correctIndex: 1,
      hint: "He achieved it in just 31 balls.",
    ),
    TriviaQuestion(
      question: "What is 'The Wall' a nickname for?",
      options: [
        'Rahul Dravid',
        'Jacques Kallis',
        'Steve Waugh',
        'Alastair Cook',
      ],
      correctIndex: 0,
      hint: "Known for his rock-solid defense.",
    ),
    TriviaQuestion(
      question: "How many players are there on a cricket field per team?",
      options: ['10', '11', '12', '9'],
      correctIndex: 1,
      hint: "The standard number for both sides.",
    ),
  ];

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
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
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
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF86F898),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.stars, size: 18),
                Text(" Score: $_score"),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Question ${_currentIndex + 1} of ${_questions.length}"),
                Text(
                  "${((_currentIndex + 1) / _questions.length * 100).toInt()}%",
                  style: const TextStyle(
                    color: Color(0xFF0058BD),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
              color: const Color(0xFF006E2C),
              backgroundColor: const Color(0xFFE7E7F1),
            ),
            const SizedBox(height: 24),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MASTERY LEVEL",
                      style: TextStyle(
                        color: Color(0xFF0058BD),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentQ.question,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...currentQ.options.asMap().entries.map(
              (entry) => _buildOptionTile(entry.key, entry.value),
            ),
            if (_answered)
              Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, color: Colors.blue),
                    const SizedBox(width: 12),
                    Expanded(child: Text(currentQ.hint)),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _answered ? _nextQuestion : null,
        backgroundColor: _answered ? const Color(0xFF0058BD) : Colors.grey,
        child: const Icon(Icons.skip_next, color: Colors.white),
      ),
    );
  }

  Widget _buildOptionTile(int index, String text) {
    bool isSelected = _selectedOption == index;
    bool isCorrect = index == _questions[_currentIndex].correctIndex;
    Color borderColor = _answered
        ? (isCorrect
              ? Colors.green
              : (isSelected ? Colors.red : Colors.grey.shade300))
        : Colors.grey.shade300;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () => _handleOptionSelected(index),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFE7E7F1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              String.fromCharCode(65 + index),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(text),
        trailing: _answered && isCorrect
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null,
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
      backgroundColor: const Color(0xFFF9F9FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events, size: 100, color: Color(0xFF0058BD)),
            const SizedBox(height: 24),
            const Text(
              "Quiz Complete!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Your Final Score: $score",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0058BD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
