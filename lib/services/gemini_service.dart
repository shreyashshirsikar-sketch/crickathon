import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService with ChangeNotifier {
  // IMPORTANT: For production, do not hardcode the key.
  static const _apiKey = 'AIzaSyCayvgj5HjS0sYXL7GX8cOB5o_ou52aZ9Q';
  
  late final GenerativeModel _model;
  
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  List<Map<String, String>> get messages => _messages;
  bool get isLoading => _isLoading;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
    );
    // Add a welcome message
    _messages.add({
      'role': 'ai',
      'text': "Hi! I'm your CricPulse AI Expert. Ask me about cricket rules, stats, or match history!"
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add({'role': 'user', 'text': text});
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _model.generateContent([Content.text(text)]);
      _messages.add({
        'role': 'ai',
        'text': response.text ?? "I'm sorry, I couldn't generate a response.",
      });
    } catch (e) {
      _messages.add({'role': 'ai', 'text': 'Error: $e'});
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
