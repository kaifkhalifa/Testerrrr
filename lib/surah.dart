class Surah {
  final int number;
  final String name;
  final String englishName;
  final String? englishTranslation; // Made nullable
  final String? revelationType;  // Made nullable
  final int numberOfAyahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    this.englishTranslation, // Nullable
    this.revelationType, // Nullable
    required this.numberOfAyahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishTranslation: json['englishTranslation'] as String?, // Handle null
      revelationType: json['revelationType'] as String?, // Handle null
      numberOfAyahs: json['numberOfAyahs'],
    );
  }
}

