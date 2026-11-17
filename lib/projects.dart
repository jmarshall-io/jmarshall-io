import 'package:flutter/material.dart';
import 'dart:async'; // For StreamBuilder

import 'package:jmarshall_io/l10n/app_localizations.dart';

import 'package:jmarshall_io/data/profile_data.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String searchText = ""; // Variable to store search query

  // Stream to update time
  Stream<String> getTimeStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      DateTime now = DateTime.now();
      yield "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    }
  }

  // List of projects from ProfileData
  List<Map<String, dynamic>> get projects => ProfileData.projects;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent to show CircuitBackground
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Header (Same as before)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.projectsTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontFamily: 'Audiowide',
                          color: Color(0xFF00FFFF),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 5),
                      StreamBuilder<String>(
                        stream: getTimeStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'TrueType',
                                color: Colors.white54,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Glass Search Bar (Same as before)
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
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchProjects,
                      hintStyle: const TextStyle(
                          color: Colors.white30, fontFamily: 'Audiowide', fontSize: 14),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF00FFFF)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    style: const TextStyle(color: Colors.white, fontFamily: 'Audiowide'),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final filteredProjects = projects.where((project) {
                    return project['name']
                        .toLowerCase()
                        .contains(searchText.toLowerCase());
                  }).toList();

                if (constraints.maxWidth > 800) {
                  // Desktop: Grid View
                  return GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) => _buildProjectCard(context, filteredProjects[index], isGrid: true),
                  );
                } else {
                  // Mobile: List View
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: _buildProjectCard(context, filteredProjects[index], isGrid: false),
                    ),
                  );
                }
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF00FFFF),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: const Color(0xFF00FFFF).withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: const Color(0xFF00FFFF).withOpacity(0.5)),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.add, size: 18),
              label: Text(
                AppLocalizations.of(context)!.addProject,
                style: const TextStyle(fontFamily: 'Audiowide'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project, {bool isGrid = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Glass
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FFFF).withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00FFFF).withOpacity(0.1),
                border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
              ),
              child: Icon(
                project['icon'],
                size: 40,
                color: const Color(0xFF00FFFF),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              project['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Audiowide',
                letterSpacing: 1.5,
                shadows: [
                  BoxShadow(
                    color: const Color(0xFF00FFFF).withOpacity(0.8),
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            // Use Flexible/Expanded only if in Grid (constrained height)
            if (isGrid)
              Expanded(
                child: SingleChildScrollView(
                  child: _buildDescription(project),
                ),
              )
            else
              _buildDescription(project),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(Map<String, dynamic> project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: project['description']
          .map<Widget>((desc) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• ", style: TextStyle(color: Color(0xFF00FFFF))),
              Expanded(
                child: Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
