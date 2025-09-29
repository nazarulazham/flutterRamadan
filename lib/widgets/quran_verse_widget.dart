import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuranVerseWidget extends StatefulWidget {
  const QuranVerseWidget({super.key});

  @override
  State<QuranVerseWidget> createState() => _QuranVerseWidgetState();
}

class _QuranVerseWidgetState extends State<QuranVerseWidget> {
  String? verseText;
  String? surahInfo;
  bool loading = true;

  Future<void> fetchRandomVerse() async {
    setState(() => loading = true);

    try {
      final response =
          await http.get(Uri.parse("https://api.alquran.cloud/v1/ayah/random"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final ayah = data['data'];
        setState(() {
          verseText = ayah['text'];
          surahInfo =
              "${ayah['surah']['englishName']} (${ayah['surah']['englishNameTranslation']}) - Ayah ${ayah['numberInSurah']}";
        });
      }
    } catch (e) {
      setState(() {
        verseText = "Failed to load verse";
        surahInfo = "";
      });
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomVerse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFFFD700), // golden border
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  verseText ?? "",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Amiri', // optional Arabic font
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  surahInfo ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
    );
  }
}
