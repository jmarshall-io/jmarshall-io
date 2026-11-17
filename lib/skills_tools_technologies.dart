import 'package:flutter/material.dart';
// For animations

import 'package:jmarshall_io/data/profile_data.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _searchController;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Set the animation duration
    );
    _controller.forward(); // Start the animation
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent to show CircuitBackground
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
                ),
                child: const Column(
                  children: [
                    Text(
                      'SKILLS & TOOLS',
                      style: TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 24,
                        color: Color(0xFF00FFFF),
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Stack & Expertise",
                      style: TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Glass Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00FFFF).withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase(); 
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search Skills (e.g. Flutter, AWS)...',
                  hintStyle: TextStyle(
                    fontFamily: 'Audiowide',
                    color: Colors.white30,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF00FFFF)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                style: const TextStyle(
                  fontFamily: 'Audiowide',
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Filtered Skills List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: ProfileData.skills.length,
                itemBuilder: (context, index) {
                  final skill = ProfileData.skills[index];
                  if (searchQuery.isEmpty ||
                      skill.name.toLowerCase().contains(searchQuery)) {
                    return skillCard(skill.name, skill.experience);
                  } else {
                    return Container(); 
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget skillCard(String skillName, double experienceLevel) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4), // Glass effect
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  skillName,
                  style: const TextStyle(
                    fontFamily: 'Audiowide', // Reverted to Cyberpunk Font
                    fontSize: 12, // Slightly smaller to fit width
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Text(
                "${(experienceLevel * 100).toInt()}%",
                style: const TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 12,
                  color: Color(0xFF00FFFF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Animated Bar
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  // Rail
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  // Progress
                  FractionallySizedBox(
                    widthFactor: _controller.value * experienceLevel,
                    child: Container(
                      height: 8, 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00FFFF), // Cyan
                            Color(0xFF0088FF), // Blue
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00FFFF).withOpacity(0.6),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SkillsPage(),
  ));
}
