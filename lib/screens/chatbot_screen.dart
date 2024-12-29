import 'package:flutter/material.dart';
import '../services/chatbot_service.dart';
import '../widgets/message_bubble.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
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

    // Menambahkan sapaan dari bot saat aplikasi pertama kali dibuka dengan animasi mengetik
    _addBotMessage('Halo! Ada yang bisa saya bantu?', typingAnimation: true);
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

  // Fungsi untuk menambahkan pesan dari bot dengan animasi mengetik
  void _addBotMessage(String message, {bool typingAnimation = false}) {
    if (typingAnimation) {
      // Menambahkan pesan ketikan bot dengan delay
      setState(() {
        _messages.add({'sender': 'bot', 'text': '...'});
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _messages[_messages.length - 1] = {'sender': 'bot', 'text': message};
        });
      });
    } else {
      setState(() {
        _messages.add({'sender': 'bot', 'text': message});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'ChatBot',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Ketik pesan Anda...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _sendMessage(_controller.text),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
