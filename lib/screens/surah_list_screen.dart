import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'surah_detail_screen.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  List<dynamic> surahs = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      final response =
          await http.get(Uri.parse('http://api.alquran.cloud/v1/surah'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          surahs = data['data'];
          loading = false;
        });
      } else {
        setState(() {
          error = "Failed to fetch Surahs";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F0), // soft beige
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Quran 🌙",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text("Error: $error"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: surahs.length,
                  itemBuilder: (context, index) {
                    final surah = surahs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SurahDetailScreen(
                              surahNumber: surah['number'],
                              surahName: surah['englishName'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFF8E1),
                              Color(0xFFFFECB3),
                              Color(0xFFFFD54F),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            "${surah['number']}. ${surah['englishName']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          subtitle: Text(
                            surah['englishNameTranslation'],
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.black87),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
