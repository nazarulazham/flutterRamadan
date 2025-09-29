import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const SurahDetailScreen(
      {super.key, required this.surahNumber, required this.surahName});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  List<dynamic> ayat = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchAyat();
  }

  Future<void> fetchAyat() async {
    try {
      final response = await http
          .get(Uri.parse('http://api.alquran.cloud/v1/surah/${widget.surahNumber}/ar'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          ayat = data['data']['ayahs'];
          loading = false;
        });
      } else {
        setState(() {
          error = "Failed to fetch verses";
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
      backgroundColor: const Color(0xFFF9F7F0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.surahName,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text("Error: $error"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: ayat.length,
                  itemBuilder: (context, index) {
                    final verse = ayat[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFD700),
                          width: 2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        "${verse['text']}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
