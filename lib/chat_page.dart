import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // Initialize Gemini
  // IMPORTANT: For production, do not hardcode the key.
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: 'AIzaSyCayvgj5HjS0sYXL7GX8cOB5o_ou52aZ9Q',
  );

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final userMessage = _controller.text;

    // Add User Message
    setState(() {
      _messages.add({'role': 'user', 'text': userMessage});
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      final response = await model.generateContent([Content.text(userMessage)]);

      setState(() {
        _messages.add({
          'role': 'ai',
          'text': response.text ?? "I'm sorry, I couldn't generate a response.",
        });
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({'role': 'ai', 'text': 'Error: $e'});
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
      ),
      body: Column(
        children: [
          // Chat Scroll Area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                if (msg['role'] == 'user') {
                  return _buildUserMessage(msg['text']!);
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildAiMessage(msg['text']!),
                  );
                }
              },
            ),
          ),

          // Loading Indicator
          if (_isLoading)
            const LinearProgressIndicator(color: Color(0xFF0058BD)),

          // Input Area (Using your styled layout)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3FD),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Ask about rules, stats...",
                        border: InputBorder.none,
                        icon: Icon(Icons.mood, color: Colors.grey),
                        suffixIcon: Icon(Icons.attach_file, color: Colors.grey),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _isLoading ? null : _sendMessage,
                  child: const CircleAvatar(
                    backgroundColor: Color(0xFF0058BD),
                    child: Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Your Original Styling Helpers ---

  Widget _buildAiMessage(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFF2771DF),
          radius: 16,
          child: Icon(Icons.smart_toy, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 8),
        Container(
          constraints: const BoxConstraints(maxWidth: 280),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(text),
        ),
      ],
    );
  }

  Widget _buildUserMessage(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 280),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFF0058BD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
