import 'package:flutter/material.dart';
import 'surah.dart'; // Make sure to import your Surah model correctly
import 'quran_service.dart'; // Your API fetching service
import 'surah_detail_screen.dart'; // The screen to display the Surah details

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({Key? key}) : super(key: key);

  @override
  _SurahListScreenState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<Surah>> surahListFuture;

  @override
  void initState() {
    super.initState();
    surahListFuture = fetchSurahs(); // Function that fetches the Surah data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      appBar: AppBar(
        title: const Text('Surah List'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Surah>>(
        future: surahListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<Surah> surahs = snapshot.data!;
            return ListView.builder(
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                Surah surah = surahs[index];
                return ListTile(
                  title: Text(surah.englishName, style: Theme.of(context).textTheme.bodyText2),
                  subtitle: Text('${surah.revelationType} - ${surah.numberOfAyahs} verses', style: Theme.of(context).textTheme.bodyText2),
                  onTap: () { // Make sure this is inside the itemBuilder
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahDetailScreen(surahNumber: surah.number),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}