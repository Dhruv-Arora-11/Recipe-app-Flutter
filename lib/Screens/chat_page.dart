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

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {
  final Color customColor = Color(0xFF0B1520);
  final Color secondaryColor = Color(0xFF171D2B);
  final Color accentColor = Colors.white;
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hi! I'm Gemini. How can I help you with recipes today?",
      "isGemini": true
    },
  ];

  late GenerativeModel _geminiModel;
  bool _isTyping = false;

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
      _isTyping = true;
    });

    _getAIResponse(text);
    _messageController.clear();
  }

  void _getAIResponse(String userMessage) async {
    try {
      final chat = _geminiModel.startChat(history: [
        Content.text(userMessage),
      ]);

      var response = await chat.sendMessage(Content.text(userMessage));

      setState(() {
        _isTyping = false;
        _messages.add({"text": response.text, "isGemini": true});
      });
    } catch (e) {
      setState(() {
        _isTyping = false;
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            wordSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return TypingIndicator(); // Add the TypingIndicator widget
                }

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
                  elevation: 0,
                  onPressed: () => _sendMessage(_messageController.text),
                  backgroundColor: secondaryColor,
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

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    )..repeat();

    _animation1 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.33)),
    );
    _animation2 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.33, 0.66)),
    );
    _animation3 = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.66, 1.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Color(0xFF18122E),
          child: Icon(Icons.restaurant, color: Colors.white),
        ),
        SizedBox(width: 8),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              children: [
                Transform.translate(
                  offset: Offset(0, _animation1.value),
                  child: Dot(),
                ),
                SizedBox(width: 4),
                Transform.translate(
                  offset: Offset(0, _animation2.value),
                  child: Dot(),
                ),
                SizedBox(width: 4),
                Transform.translate(
                  offset: Offset(0, _animation3.value),
                  child: Dot(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
