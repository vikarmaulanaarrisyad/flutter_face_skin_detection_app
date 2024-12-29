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
      _addBotMessage(botResponse,
          typingAnimation: true); // Menambahkan animasi pada balasan bot
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
    // Mendapatkan ukuran layar untuk responsivitas
    final screenWidth = MediaQuery.of(context).size.width;

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
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: screenWidth * 0.04), // Responsif padding
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
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02), // Responsif padding
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04), // Responsif padding
                      child: TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (text) => _sendMessage(text),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16.0),
                          hintText: 'Ketik pesan Anda...',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            color: Colors.blueAccent,
                            onPressed: () => _sendMessage(_controller.text),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
