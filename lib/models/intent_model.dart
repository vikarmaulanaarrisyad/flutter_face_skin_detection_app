class Intent {
  String tag;
  List<String> patterns;
  List<String> responses;
  List<String> context;

  Intent({
    required this.tag,
    required this.patterns,
    required this.responses,
    required this.context,
  });

  // Fungsi untuk mengonversi JSON menjadi objek Intent
  factory Intent.fromJson(Map<String, dynamic> json) {
    return Intent(
      tag: json['tag'],
      patterns: List<String>.from(json['patterns']),
      responses: List<String>.from(json['responses']),
      context: List<String>.from(json['context']),
    );
  }

  // Mendapatkan respons acak
  String getRandomResponse() {
    if (responses.isNotEmpty) {
      var randomResponse = List.from(responses)..shuffle();
      return randomResponse.first;
    }
    return "Tidak ada respons yang tersedia.";
  }

  @override
  String toString() {
    return 'Intent(tag: $tag, patterns: $patterns, responses: $responses, context: $context)';
  }
}
