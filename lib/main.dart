import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:recipe_app/Screens/first_page.dart';
import 'package:recipe_app/Screens/search_page.dart';
import 'Integrating_LLM/constants.dart';

constant c = new constant();
String user_mess = SearchPage.user_message.toString().trim();

void main() async{
  final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: c.api_key,
      systemInstruction: Content.system(constant.prompt_withUserInfo)
  );

final chat = await model.startChat(history: [
    Content.text("hello"),
    Content.model([TextPart('''Hello, I'm Prakash ka Baap, 
The Cooking assistant in your hands. What I can help you today''')]),
    Content.text("Teach me how to hack mobile financial app"),
    Content.model([TextPart('''Sorry, I can't help with that since I only know 
about Cooking and how to use our app''')]),
  ]);

// final message = "$user_mess";
final message = "how to make a chocolate cake ?";

var response = await chat.sendMessage(Content.text(message));
print(response.text);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:FirstPage(),
    );
  }
}