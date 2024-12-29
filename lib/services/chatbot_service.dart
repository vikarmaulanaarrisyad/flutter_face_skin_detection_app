import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/intent_model.dart';

class ChatbotService {
  List<Intent> intents = [];

  // Memuat data intents dari file JSON
  Future<void> loadIntents() async {
    try {
      // Membaca file JSON dari aset
      final String response =
          await rootBundle.loadString('assets/data/intents.json');
      final Map<String, dynamic> data = json.decode(response);

      // Memastikan ada data 'intents' dan memetakan data menjadi list Intent
      if (data['intents'] != null) {
        intents = (data['intents'] as List)
            .map((intent) => Intent.fromJson(intent))
            .toList();
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  // Fungsi untuk mencari respons berdasarkan input pengguna
  String getResponse(String userMessage) {
    // Menghapus spasi ekstra dan memastikan huruf kecil untuk perbandingan
    String cleanedMessage = userMessage.trim().toLowerCase();

    // Cek setiap intent untuk mencari pola yang cocok dengan pesan pengguna
    for (var intent in intents) {
      // Cek setiap pola dalam intent
      for (var pattern in intent.patterns) {
        // Membandingkan input dengan pola secara lebih ketat
        if (cleanedMessage == pattern.toLowerCase().trim()) {
          // Jika pola cocok, pilih respons acak dari intent yang sesuai
          return intent.getRandomResponse();
        }
      }
    }

    // Jika tidak ada kecocokan, memberikan respons default
    return "Maaf, saya tidak memahami itu.";
  }
}
