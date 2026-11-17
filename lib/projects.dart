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
  final Set<String> _expandedCards = {};
  bool _expandAll = false;

  static const List<String> _categories = [
    'All',
    'Orchestration & ETL/ELT',
    'Cloud & CNCF K8s',
    'TOGAF & EA',
    'Healthcare & Public Health',
    'Federal & Defense',
    'Finance & Insurance',
    'Early Career & Telecom (1994–2007)',
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
      final List<String> cats = ((project['categories'] as List?) ?? [])
          .map((e) => e.toString())
          .toList();
      if (!cats.contains(_selectedCategory)) {
        return false;
      }
    }

    if (searchText.trim().isEmpty) return true;
    final String q = searchText.toLowerCase().trim();
    final String name = (project['name'] ?? '').toString().toLowerCase();
    final String role = (project['role'] ?? '').toString().toLowerCase();
    final String location =
        (project['location'] ?? '').toString().toLowerCase();
    final String sector = (project['sector'] ?? '').toString().toLowerCase();
    final String tags =
        ((project['tags'] as List?) ?? []).join(' ').toLowerCase();
    final String desc =
        ((project['description'] as List?) ?? []).join(' ').toLowerCase();

    return name.contains(q) ||
        role.contains(q) ||
        location.contains(q) ||
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
                        'Complete 30+ Year Chronological Career History (1994 – Present) · Search Any Tool, Client, or Location',
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
                const SizedBox(height: 10),

                // Search Bar across all 23 Engagements (1994–Present)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Row(
                    children: [
                      Expanded(
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
                                  'Search 23 engagements (1994–Present): Prefect, dbt, TOGAF, GCP, Azure, AWS, Talend, SSIS, SAS, USCP, MH-53, StarTAC...',
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: 'Audiowide',
                                fontSize: 11,
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
                      const SizedBox(width: 8),
                      Tooltip(
                        message: _expandAll
                            ? 'Collapse bullet lists to summary view'
                            : 'Expand all career bullets across all cards',
                        child: InkWell(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _expandAll = !_expandAll;
                              if (!_expandAll) {
                                _expandedCards.clear();
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: _expandAll
                                  ? const Color(0xFF00FFFF)
                                  : Colors.black.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFF00FFFF).withOpacity(0.6),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _expandAll
                                      ? Icons.unfold_less
                                      : Icons.unfold_more,
                                  size: 16,
                                  color: _expandAll
                                      ? Colors.black
                                      : const Color(0xFF00FFFF),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _expandAll ? 'Collapse' : 'Expand All',
                                  style: TextStyle(
                                    fontFamily: 'Audiowide',
                                    fontSize: 10.5,
                                    color: _expandAll
                                        ? Colors.black
                                        : const Color(0xFF00FFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
                              fontSize: 10.5,
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
                if (constraints.maxWidth > 950) {
                  final int cols = constraints.maxWidth > 1400 ? 3 : 2;
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      childAspectRatio: 0.98,
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

  Widget _buildLogoOrIcon(Map<String, dynamic> project) {
    final String? logoPath = project['logo'] as String?;
    final IconData fallbackIcon =
        (project['icon'] as IconData?) ?? Icons.work_outline;

    if (logoPath != null && logoPath.isNotEmpty) {
      return Container(
        width: 48,
        height: 48,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF00FFFF).withOpacity(0.55),
            width: 1.2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            logoPath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              fallbackIcon,
              size: 24,
              color: const Color(0xFF005577),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF00FFFF).withOpacity(0.12),
        border: Border.all(
          color: const Color(0xFF00FFFF).withOpacity(0.45),
        ),
      ),
      child: Icon(
        fallbackIcon,
        size: 24,
        color: const Color(0xFF00FFFF),
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
    final String cardKey = (project['name'] ?? index.toString()).toString();
    final List<String> tags =
        ((project['tags'] as List?) ?? []).map((e) => e.toString()).toList();
    final List<String> allBullets = ((project['description'] as List?) ?? [])
        .map((e) => e.toString())
        .toList();
    final bool isExpanded = _expandAll ||
        searchText.trim().isNotEmpty ||
        _expandedCards.contains(cardKey);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredCardIndex = index),
      onExit: (_) => setState(() => _hoveredCardIndex = null),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() {
            if (_expandedCards.contains(cardKey)) {
              _expandedCards.remove(cardKey);
            } else {
              _expandedCards.add(cardKey);
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(isHovered ? 0.80 : 0.65),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLogoOrIcon(project),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Audiowide',
                              letterSpacing: 0.8,
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
                          if (project['location'] != null) ...[
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 12,
                                  color: Colors.white54,
                                ),
                                const SizedBox(width: 3),
                                Expanded(
                                  child: Text(
                                    '${project['location']} · ${project['sector'] ?? ''}',
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ] else if (project['sector'] != null) ...[
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
                      child: _buildDescription(
                        allBullets,
                        isExpanded: isExpanded,
                        cardKey: cardKey,
                      ),
                    ),
                  )
                else
                  _buildDescription(
                    allBullets,
                    isExpanded: isExpanded,
                    cardKey: cardKey,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(
    List<String> allBullets, {
    required bool isExpanded,
    required String cardKey,
  }) {
    final String q = searchText.trim().toLowerCase();
    final List<String> visibleBullets =
        (isExpanded || allBullets.length <= 4)
            ? allBullets
            : allBullets.take(4).toList();
    final int hiddenCount = allBullets.length - visibleBullets.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...visibleBullets.map<Widget>((desc) {
          final bool matchesQuery =
              q.isNotEmpty && desc.toLowerCase().contains(q);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    color: matchesQuery
                        ? const Color(0xFF00FFAA)
                        : const Color(0xFF00FFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    desc,
                    style: TextStyle(
                      color: matchesQuery
                          ? const Color(0xFF00FFFF)
                          : Colors.white,
                      fontWeight:
                          matchesQuery ? FontWeight.w600 : FontWeight.normal,
                      fontSize: 12.8,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        if (allBullets.length > 4 && q.isEmpty) ...[
          const SizedBox(height: 6),
          InkWell(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                if (_expandedCards.contains(cardKey)) {
                  _expandedCards.remove(cardKey);
                } else {
                  _expandedCards.add(cardKey);
                }
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF00FFFF).withOpacity(0.10),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF00FFFF).withOpacity(0.35),
                ),
              ),
              child: Text(
                hiddenCount > 0
                    ? '+ Show $hiddenCount More Career Bullets (${allBullets.length} Total)'
                    : '− Show Summary (4 of ${allBullets.length} Bullets)',
                style: const TextStyle(
                  fontFamily: 'Audiowide',
                  fontSize: 10,
                  color: Color(0xFF00FFFF),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
