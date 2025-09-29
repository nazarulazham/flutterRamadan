import 'package:flutter/material.dart';
import '../widgets/quran_verse_widget.dart';

class QuranVerseScreen extends StatelessWidget {
  const QuranVerseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran Verses"),
        backgroundColor: const Color(0xFFFFD54F),
      ),
      body: Column(
        children: [
          const QuranVerseWidget(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // refresh by pushing new state
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const QuranVerseScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6A1B9A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text("Get New Verse"),
          ),
        ],
      ),
    );
  }
}
