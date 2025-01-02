import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:recipe_app/Integrating_LLM/constants.dart';
import 'package:recipe_app/components/chat_bubble.dart';


constant c = constant();

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Color customColor = Color(0xFF11151E);
  final Color secondaryColor = Color(0xFF1B2430); // Slightly lighter shade
  final Color accentColor = Color(0xFFEF8354); // Accent color for Gemini messages
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hi! I'm Gemini. How can I help you with recipes today?",
      "isGemini": true
    },
  ];

  late GenerativeModel _geminiModel;

  @override
  void initState() {
    super.initState();
    _geminiModel = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: c.api_key,
      systemInstruction: Content.system(constant.prompt_withUserInfo),
    );
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"text": text, "isGemini": false});
    });

    _getAIResponse(text);
    _messageController.clear();
  }

  void _getAIResponse(String userMessage) async {
    try {
      // Create a new chat session
      final chat = _geminiModel.startChat(history: [
        Content.text(userMessage),
      ]);

      // Fetch Gemini's response
      var response = await chat.sendMessage(Content.text(userMessage));

      setState(() {
        _messages.add({"text": response.text, "isGemini": true});
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "text": "Oops! Something went wrong. Please try again later.",
          "isGemini": true
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text(
          "Chat with Gemini",
          style: TextStyle(color: accentColor),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(
                  text: message["text"],
                  isGemini: message["isGemini"],
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            color: secondaryColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: customColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () => _sendMessage(_messageController.text),
                  backgroundColor: accentColor,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

