import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmarshall_io/data/profile_data.dart';
import 'package:jmarshall_io/l10n/app_localizations.dart';

class ProjectsPage extends StatefulWidget {
  final VoidCallback? onStartInquiry;

  const ProjectsPage({super.key, this.onStartInquiry});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  String _selectedCategory = 'All';
  int? _hoveredCardIndex;

  static const List<String> _categories = [
    'All',
    'Orchestration & ETL/ELT',
    'Cloud & CNCF K8s',
    'TOGAF & EA',
    'Healthcare & Public Health',
    'Federal & Defense',
    'Finance & Insurance',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Stream<String> getTimeStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      DateTime now = DateTime.now();
      yield "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} ${now.timeZoneName}";
    }
  }

  List<Map<String, dynamic>> get projects => ProfileData.projects;

  bool _matchesFilters(Map<String, dynamic> project) {
    if (_selectedCategory != 'All') {
      final List<String> cats =
          ((project['categories'] as List?) ?? []).map((e) => e.toString()).toList();
      if (!cats.contains(_selectedCategory)) {
        return false;
      }
    }

    if (searchText.trim().isEmpty) return true;
    final String q = searchText.toLowerCase().trim();
    final String name = (project['name'] ?? '').toString().toLowerCase();
    final String role = (project['role'] ?? '').toString().toLowerCase();
    final String sector = (project['sector'] ?? '').toString().toLowerCase();
    final String tags =
        ((project['tags'] as List?) ?? []).join(' ').toLowerCase();
    final String desc =
        ((project['description'] as List?) ?? []).join(' ').toLowerCase();

    return name.contains(q) ||
        role.contains(q) ||
        sector.contains(q) ||
        tags.contains(q) ||
        desc.contains(q);
  }

  @override
  Widget build(BuildContext context) {
    final allProjects = projects;
    final filteredProjects = allProjects.where(_matchesFilters).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF00FFFF).withOpacity(0.35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.projectsTitle} (${filteredProjects.length}/${allProjects.length})',
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Audiowide',
                          color: Color(0xFF00FFFF),
                          letterSpacing: 1.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Full 20+ Year Career History · Click Any Category or Tech Pill to Filter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 4),
                      StreamBuilder<String>(
                        stream: getTimeStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontFamily: 'TrueType',
                                color: Colors.white54,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Search Bar across all 18 Engagements, Tools, & Sectors
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 780),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xFF00FFFF).withOpacity(0.5),
                      ),
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
                          searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Search 18 engagements by tool, client, or standard (Prefect, dbt, Azure, GCP, AWS, Talend, SSIS, SAS, K8s, TOGAF, HIPAA)...',
                        hintStyle: const TextStyle(
                          color: Colors.white38,
                          fontFamily: 'Audiowide',
                          fontSize: 11.5,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF00FFFF),
                        ),
                        suffixIcon: searchText.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.white54,
                                  size: 18,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => searchText = '');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Audiowide',
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Interactive Domain / Sector Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _categories.map((cat) {
                      final bool isSelected = _selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(
                            cat,
                            style: TextStyle(
                              fontFamily: 'Audiowide',
                              fontSize: 11,
                              color: isSelected
                                  ? Colors.black
                                  : const Color(0xFF00FFFF),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFF00FFFF),
                          backgroundColor: Colors.black.withOpacity(0.6),
                          side: BorderSide(
                            color: const Color(0xFF00FFFF)
                                .withOpacity(isSelected ? 1.0 : 0.35),
                          ),
                          onSelected: (_) {
                            HapticFeedback.selectionClick();
                            setState(() => _selectedCategory = cat);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  final int cols = constraints.maxWidth > 1350 ? 3 : 2;
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      childAspectRatio: 1.05,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) => _buildProjectCard(
                      context,
                      filteredProjects[index],
                      index: index,
                      isGrid: true,
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildProjectCard(
                        context,
                        filteredProjects[index],
                        index: index,
                        isGrid: false,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          if (widget.onStartInquiry != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF00FFFF),
                  backgroundColor: const Color(0xFF00FFFF).withOpacity(0.15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Color(0xFF00FFFF)),
                  ),
                ),
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  widget.onStartInquiry?.call();
                },
                icon: const Icon(Icons.bolt, size: 18),
                label: const Text(
                  'DISCUSS A SIMILAR ARCHITECTURE ENGAGEMENT →',
                  style: TextStyle(fontFamily: 'Audiowide', fontSize: 11.5),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    Map<String, dynamic> project, {
    required int index,
    bool isGrid = false,
  }) {
    final bool isHovered = _hoveredCardIndex == index;
    final List<String> tags =
        ((project['tags'] as List?) ?? []).map((e) => e.toString()).toList();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredCardIndex = index),
      onExit: (_) => setState(() => _hoveredCardIndex = null),
      child: GestureDetector(
        onTap: () => HapticFeedback.selectionClick(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(isHovered ? 0.78 : 0.62),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00FFFF).withOpacity(isHovered ? 0.9 : 0.4),
              width: isHovered ? 1.8 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FFFF)
                    .withOpacity(isHovered ? 0.28 : 0.08),
                blurRadius: isHovered ? 20 : 12,
                spreadRadius: isHovered ? 2 : 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF00FFFF).withOpacity(0.12),
                        border: Border.all(
                          color: const Color(0xFF00FFFF).withOpacity(0.4),
                        ),
                      ),
                      child: Icon(
                        project['icon'] as IconData,
                        size: 22,
                        color: const Color(0xFF00FFFF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.5,
                              fontFamily: 'Audiowide',
                              letterSpacing: 1.0,
                            ),
                          ),
                          if (project['role'] != null) ...[
                            const SizedBox(height: 3),
                            Text(
                              project['role'] as String,
                              style: const TextStyle(
                                color: Color(0xFF00FFFF),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          if (project['sector'] != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              project['sector'] as String,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (tags.isNotEmpty) ...[
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags.map((tag) {
                      return InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          _searchController.text = tag;
                          setState(() => searchText = tag);
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00FFFF).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: const Color(0xFF00FFFF).withOpacity(0.4),
                            ),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'Audiowide',
                              color: Color(0xFF00FFFF),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                ],
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
        ),
      ),
    );
  }

  Widget _buildDescription(Map<String, dynamic> project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: (project['description'] as List).map<Widget>((desc) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  color: Color(0xFF00FFFF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  desc.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.4,
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
