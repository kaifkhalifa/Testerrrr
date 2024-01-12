import 'package:http/http.dart' as http;
import 'dart:convert';
import 'surah.dart';  // Import the Surah class
import 'surah_detail.dart'; // Import the SurahDetail class

// Function to fetch the list of Surahs
Future<List<Surah>> fetchSurahs() async {
  const String url = 'http://api.alquran.cloud/v1/surah';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> surahsJson = json.decode(response.body)['data'];
    return surahsJson.map<Surah>((json) => Surah.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Surahs');
  }
}

// Function to fetch the details of a specific Surah
Future<SurahDetail> fetchSurahDetail(int number) async {
  final response = await http.get(Uri.parse('http://api.alquran.cloud/v1/surah/$number'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> surahDetailJson = json.decode(response.body)['data'];
    // Assuming you have a fromJson constructor in SurahDetail class
    return SurahDetail.fromJson(surahDetailJson);
  } else {
    throw Exception('Failed to load Surah detail');
  }
}
