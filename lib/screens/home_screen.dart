  import 'dart:math';
  import 'package:flutter/material.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'prayer_times_screen.dart';
  import 'surah_list_screen.dart';

  class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

    // 🔹 List of short Quran verses (Arabic + English)
    final List<Map<String, String>> quranVerses = const [
      {
        "text": "“Indeed, in the remembrance of Allah do hearts find rest.”",
        "ref": "— Surah Ar-Ra’d [13:28]"
      },
      {
        "text": "“So remember Me; I will remember you.”",
        "ref": "— Surah Al-Baqarah [2:152]"
      },
      {
        "text": "“And He found you lost and guided you.”",
        "ref": "— Surah Ad-Duhaa [93:7]"
      },
      {
        "text": "“Indeed, Allah is with the patient.”",
        "ref": "— Surah Al-Baqarah [2:153]"
      },
      {
        "text": "“Do not despair of the mercy of Allah.”",
        "ref": "— Surah Az-Zumar [39:53]"
      },
    ];

    Map<String, String> getRandomVerse() {
      final random = Random();
      return quranVerses[random.nextInt(quranVerses.length)];
    }

    @override
    Widget build(BuildContext context) {
      final user = FirebaseAuth.instance.currentUser;
      final displayName = user?.displayName ?? "Guest";

      // Pick random verse on build
      final verse = getRandomVerse();

      return Scaffold(
        backgroundColor: const Color(0xFFF9F7F0), // soft beige background
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Ramadan Todak 🌙",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black87),
              onPressed: () async {
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );

                if (shouldLogout ?? false) {
                  await FirebaseAuth.instance.signOut();
                }
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Elegant Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFF8E1), // warm cream
                    Color(0xFFFFECB3), // soft gold
                    Color(0xFFFFD54F), // golden accent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.nightlight_round,
                      size: 36,
                      color: Color(0xFFB8860B),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Assalamu Alaikum,",
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "May this Ramadan bring peace and blessings 🌙",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Quran Verse Card (Random)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFFDE7), Color(0xFFFFF9C4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    verse["text"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      verse["ref"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Features grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrayerTimeScreen(),
                          ),
                        );
                      },
                      child: _buildFeatureCard(
                        title: "Prayer Times",
                        icon: Icons.access_time,
                        color: Colors.teal,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SurahListScreen()),
                          );
                      },
                      child: _buildFeatureCard(
                          title: "Quran",
                          icon: Icons.book,
                          color: Colors.deepPurple,
                      ),
                      ),
                  //   _buildComingSoonCard("Qibla Finder", Icons.explore),
                    _buildComingSoonCard("Ramadan Tips", Icons.book),
                    _buildComingSoonCard("Donation", Icons.volunteer_activism),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildFeatureCard({
      required String title,
      required IconData icon,
      required Color color,
    }) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFFFD700), width: 2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildComingSoonCard(String title, IconData icon) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFAF3E0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 48, color: Colors.brown.shade400),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5D4037),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Coming Soon",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
