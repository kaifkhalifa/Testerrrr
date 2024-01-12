class Verse {
  final int number;
  final String text;
  final String translation;

  Verse({
    required this.number,
    required this.text,
    required this.translation,
  });

  // Assuming the JSON contains all the fields needed to create a Verse object
  factory Verse.fromJson(Map<String, dynamic> json) {
    // Check if any of the values are null and handle them appropriately
    if (json['number'] == null || json['text'] == null || json['translation'] == null) {
      throw Exception('Missing data for Verse.fromJson');
    }
    return Verse(
      number: json['number'] as int,
      text: json['text'] as String,
      translation: json['translation'] as String,
    );
  }
}

