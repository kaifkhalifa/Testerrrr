import 'package:flutter/material.dart';
import 'quran_service.dart'; // Your API fetching service
import 'surah_detail.dart'; // Your SurahDetail model
import 'package:quran_app/verse.dart';


// A simple widget that might represent a verse of the Surah
class VerseWidget extends StatelessWidget {
  final Verse verse; // Your Verse model

  const VerseWidget({Key? key, required this.verse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(verse.number.toString()),
          ),
          title: Text(verse.text), // The original text of the verse
          subtitle: Text(verse.translation), // Translation of the verse
        ),
      ),
    );
  }
}

class SurahDetailScreen extends StatelessWidget {
  final int surahNumber;

  const SurahDetailScreen({Key? key, required this.surahNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Surah Details"),
      ),
      body: FutureBuilder<SurahDetail>(
        future: fetchSurahDetail(surahNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            SurahDetail surahDetail = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Here you'd include your header with the Surah title
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      surahDetail.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  // List of Verses
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(), // to disable ListView's scrolling
                    shrinkWrap: true, // Use this to fit the list into the available space
                    itemCount: surahDetail.verses.length,
                    itemBuilder: (context, index) {
                      return VerseWidget(verse: surahDetail.verses[index]);
                    },
                  ),
                  // Include any other details or widgets you need
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}