import 'package:flutter/material.dart';
import '../services/chatbot_service.dart';
import '../widgets/message_bubble.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final ChatbotService _chatbotService = ChatbotService();
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();

    // Memuat intents saat aplikasi dimulai
    _chatbotService.loadIntents();
  }

  // Fungsi untuk mengirim pesan dan mendapatkan respons
  void _sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': text});
      final botResponse = _chatbotService.getResponse(text);
      _messages.add({'sender': 'bot', 'text': botResponse});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatBot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return MessageBubble(
                  message: message['text']!,
                  isUser: isUser,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ketik pesan Anda...',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
