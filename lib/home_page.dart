import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jmarshall_io/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onStartInquiry;

  const HomePage({super.key, this.onStartInquiry});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPhaseIndex = 0;
  int? _hoveredPhaseIndex;

  static const List<Map<String, String>> _fiveAPhases = [
    {
      'step': '01',
      'title': 'ASSESS',
      'togaf': 'TOGAF Vision · Baseline Ecosystem & Gap Discovery',
      'summary':
          'Evaluate the organization\'s Current-State ("As-Is") systems, data silos, operational bottlenecks, and security/compliance posture to establish a clear, measurable modernization vision.',
      'deliverable':
          'Deliverable: As-Is Systems Topology Map, Gap Analysis & Modernization Vision',
    },
    {
      'step': '02',
      'title': 'ASSIMILATE',
      'togaf': 'TOGAF Alignment · Connect & Unify Disparate Systems',
      'summary':
          'Bridge fragmented applications, databases, APIs, and cross-team workflows into standardized data contracts and clean integration boundaries—agnostic of the underlying vendor stack.',
      'deliverable':
          'Deliverable: Unified System Integration Contracts, Data Lineage & Domain Model',
    },
    {
      'step': '03',
      'title': 'ARCHITECT',
      'togaf': 'TOGAF Target State · Cloud, On-Prem & Hybrid Blueprint',
      'summary':
          'Design resilient Target-State ("To-Be") architectures across Cloud, On-Premises, and Hybrid environments (ETL & ELT)—balancing scalability, Zero-Trust security, and FinOps cost efficiency.',
      'deliverable':
          'Deliverable: To-Be Reference Architectures, ADRs & Phased Transition Roadmap',
    },
    {
      'step': '04',
      'title': 'AUTOMATE',
      'togaf': 'TOGAF Execution · Orchestrate Workflows & Infrastructure',
      'summary':
          'Replace manual toil and disconnected scripts with end-to-end pipeline orchestration, Infrastructure as Code (IaC), CI/CD delivery, and AI-ready automation tailored to the organization\'s stack.',
      'deliverable':
          'Deliverable: Automated Orchestration Pipelines, Declarative IaC & Live Telemetry',
    },
    {
      'step': '05',
      'title': 'ADAPT',
      'togaf': 'TOGAF Governance · Enablement, Training & Evolution',
      'summary':
          'Sustain long-term organizational agility through architecture governance, CNCF cloud-native standards, operational runbooks, and hands-on team training as AI and agentic systems evolve.',
      'deliverable':
          'Deliverable: Governance Standards, Team Training Playbooks & Continuous Evolution',
    },
  ];

  Future<void> _launchURL(String url) async {
    HapticFeedback.mediumImpact();
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double contentWidth = MediaQuery.of(context).size.width * 0.85;
    if (contentWidth > 860) contentWidth = 860;
    final activePhase = _fiveAPhases[_selectedPhaseIndex];

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 16),

            // Animated Bio Text
            Container(
              width: contentWidth > 620 ? 620 : contentWidth,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      AppLocalizations.of(context)!.bio,
                      textStyle: const TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 45),
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // Primary Action Buttons with Hover Glow & Haptics
            Wrap(
              spacing: 20,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _GlowingActionButton(
                  icon: Icons.download,
                  label: AppLocalizations.of(context)!.resume,
                  onPressed: () => _launchURL(
                    'https://jmarshall.io/docs/Jonathan-Marshall-Resume-CV.pdf',
                  ),
                ),
                _GlowingActionButton(
                  icon: Icons.file_copy,
                  label: AppLocalizations.of(context)!.capabilities,
                  onPressed: () => _launchURL(
                    'https://jmarshall.io/docs/Jonathan-Marshall-Capabilities-Statement.pdf',
                  ),
                ),
                _GlowingActionButton(
                  icon: Icons.bolt,
                  label: 'Submit Role / Project Inquiry',
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    widget.onStartInquiry?.call();
                  },
                ),
              ],
            ),

            const SizedBox(height: 36),

            // --- HOW IT WORKS: 3-STEP FAST TRACK FOR COMPANIES & RECRUITERS ---
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentWidth),
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF00FFFF).withOpacity(0.4),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'HOW IT WORKS · FAST-TRACK INTAKE FOR COMPANIES & RECRUITERS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 12.5,
                        color: Color(0xFF00FFFF),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      alignment: WrapAlignment.center,
                      children: [
                        _HowItWorksStepCard(
                          stepNumber: 'STEP 1',
                          title: 'Tap Scope & Model',
                          description:
                              'Select 5-A Phase, Remote/Hybrid, & Retainer/C2C/Direct chips (pre-filled defaults).',
                          icon: Icons.touch_app_outlined,
                          onTap: widget.onStartInquiry,
                        ),
                        _HowItWorksStepCard(
                          stepNumber: 'STEP 2',
                          title: 'Add Contact & Optional JD',
                          description:
                              'Only Name & Email are required. Rate/Budget & JD/SOW paste or file upload are optional.',
                          icon: Icons.description_outlined,
                          onTap: widget.onStartInquiry,
                        ),
                        _HowItWorksStepCard(
                          stepNumber: 'STEP 3',
                          title: 'Instant Mobile & Inbox Alert',
                          description:
                              'Dispatches a real-time push alert to Jonathan\'s device + email for rapid scheduling.',
                          icon: Icons.notifications_active_outlined,
                          onTap: widget.onStartInquiry,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          widget.onStartInquiry?.call();
                        },
                        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                        label: const Text(
                          'OPEN 30-SECOND ROLE & PROJECT INTAKE →',
                          style: TextStyle(
                            fontFamily: 'Audiowide',
                            fontSize: 12,
                            letterSpacing: 1.1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF00FFFF).withOpacity(0.18),
                          foregroundColor: const Color(0xFF00FFFF),
                          side: const BorderSide(color: Color(0xFF00FFFF)),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // --- 5-A TOGAF ENGAGEMENT FRAMEWORK (INTERACTIVE BUBBLE PIPELINE) ---
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: contentWidth),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF00FFFF).withOpacity(0.35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FFFF).withOpacity(0.08),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'ARCHITECTURAL ENGAGEMENT FRAMEWORK (TOGAF-ALIGNED)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 13,
                        color: Color(0xFF00FFFF),
                        letterSpacing: 1.8,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Fractional Systems Architect · Enterprise Modernization · Greenfield AI & Cloud Systems',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Connected Step Bubbles (1 -> 2 -> 3 -> 4 -> 5) with Hover Light-Up & Device Haptics
                    Wrap(
                      spacing: 12,
                      runSpacing: 14,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: List.generate(_fiveAPhases.length, (index) {
                        final phase = _fiveAPhases[index];
                        final bool isSelected = index == _selectedPhaseIndex;
                        final bool isHovered = index == _hoveredPhaseIndex;
                        final bool isLit = isSelected || isHovered;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  setState(() => _hoveredPhaseIndex = index),
                              onExit: (_) =>
                                  setState(() => _hoveredPhaseIndex = null),
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.mediumImpact();
                                  setState(() => _selectedPhaseIndex = index);
                                },
                                child: AnimatedScale(
                                  scale: isLit ? 1.07 : 1.0,
                                  duration: const Duration(milliseconds: 180),
                                  curve: Curves.easeOutBack,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF00FFFF)
                                          : isHovered
                                              ? const Color(
                                                  0xFF00FFFF,
                                                ).withOpacity(0.22)
                                              : Colors.black.withOpacity(0.75),
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                        color: const Color(0xFF00FFFF),
                                        width: isLit ? 2.0 : 1.0,
                                      ),
                                      boxShadow: isLit
                                          ? [
                                              BoxShadow(
                                                color: const Color(
                                                  0xFF00FFFF,
                                                ).withOpacity(
                                                  isSelected ? 0.65 : 0.45,
                                                ),
                                                blurRadius:
                                                    isSelected ? 20 : 14,
                                                spreadRadius:
                                                    isSelected ? 2 : 1,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isSelected
                                                ? Colors.black
                                                : const Color(
                                                    0xFF00FFFF,
                                                  ).withOpacity(0.22),
                                          ),
                                          child: Text(
                                            phase['step']!,
                                            style: const TextStyle(
                                              fontFamily: 'Audiowide',
                                              fontSize: 11,
                                              color: Color(0xFF00FFFF),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          phase['title']!,
                                          style: TextStyle(
                                            fontFamily: 'Audiowide',
                                            fontSize: 12.5,
                                            color: isSelected
                                                ? Colors.black
                                                : isHovered
                                                    ? const Color(0xFF00FFFF)
                                                    : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (index < _fiveAPhases.length - 1) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 16,
                                color: const Color(0xFF00FFFF).withOpacity(0.5),
                              ),
                            ],
                          ],
                        );
                      }),
                    ),

                    const SizedBox(height: 22),

                    // Detail Card for Selected Step Bubble
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A).withOpacity(0.88),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFF00FFFF).withOpacity(0.45),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00FFFF).withOpacity(0.12),
                            blurRadius: 14,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF00FFFF,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'STEP ${activePhase['step']} · ${activePhase['title']}',
                                  style: const TextStyle(
                                    fontFamily: 'Audiowide',
                                    fontSize: 12,
                                    color: Color(0xFF00FFFF),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  activePhase['togaf']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white70,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            activePhase['summary']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.verified_outlined,
                                size: 16,
                                color: Color(0xFF00FFFF),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  activePhase['deliverable']!,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    color: Color(0xFF00FFFF),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // --- SKILLS CLOUD (Interactive Hover Glow + Tap Haptics) ---
            Text(
              AppLocalizations.of(context)!.specializedIn,
              style: const TextStyle(
                fontFamily: 'Audiowide',
                fontSize: 12,
                color: Colors.white30,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: const Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  _SkillChip(label: 'Systems Architecture & Orchestration'),
                  _SkillChip(label: 'Cloud · On-Prem · Hybrid (ETL & ELT)'),
                  _SkillChip(label: 'Prefect 3.x · Talend · SSIS · SAS DI'),
                  _SkillChip(label: 'dbt · BigQuery · SQL Server'),
                  _SkillChip(label: 'CNCF · Kubernetes (CKA/CKAD/CKS) · Istio'),
                  _SkillChip(label: 'Terraform · Helm · ArgoCD · GitOps'),
                  _SkillChip(label: 'Observability (Grafana · Loki · Prometheus)'),
                  _SkillChip(label: 'Zero-Trust DevSecOps (gMSA · IAM · OPA)'),
                  _SkillChip(label: 'TOGAF · FinOps · Team Enablement'),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- SOCIAL ICONS (Mobile only; Desktop uses ProfileSidebar) ---
            if (MediaQuery.of(context).size.width <= 800) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialButton(
                    iconPath: 'assets/github-black-bg.png',
                    onTap: () => _launchURL('https://github.com/jmarshall-io'),
                  ),
                  const SizedBox(width: 20),
                  _SocialButton(
                    iconPath: 'assets/linked-in-black-bg.png',
                    onTap: () => _launchURL(
                      'https://www.linkedin.com/in/systemintegrationengineer/',
                    ),
                  ),
                  const SizedBox(width: 20),
                  _SocialButton(
                    iconPath: 'assets/twitter-black-bg.png',
                    onTap: () => _launchURL('https://x.com/jmarshallio'),
                  ),
                  const SizedBox(width: 20),
                  _SocialButton(
                    iconPath: 'assets/logos/obsidian-logo-gradient.svg',
                    onTap: () => _launchURL('https://jmarshall.io'),
                    tooltip: 'Portfolio CV Resume',
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }
}

class _GlowingActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _GlowingActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_GlowingActionButton> createState() => _GlowingActionButtonState();
}

class _HowItWorksStepCard extends StatefulWidget {
  final String stepNumber;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;

  const _HowItWorksStepCard({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
  });

  @override
  State<_HowItWorksStepCard> createState() => _HowItWorksStepCardState();
}

class _HowItWorksStepCardState extends State<_HowItWorksStepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          widget.onTap?.call();
        },
        child: AnimatedScale(
          scale: _isHovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 160),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: 245,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _isHovered
                  ? const Color(0xFF00FFFF).withOpacity(0.14)
                  : const Color(0xFF0F172A).withOpacity(0.85),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF00FFFF)
                    .withOpacity(_isHovered ? 0.9 : 0.35),
                width: _isHovered ? 1.5 : 1.0,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00FFFF).withOpacity(0.35),
                        blurRadius: 14,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      widget.icon,
                      size: 18,
                      color: const Color(0xFF00FFFF),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.stepNumber,
                      style: const TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 11,
                        color: Color(0xFF00FFFF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontFamily: 'Audiowide',
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowingActionButtonState extends State<_GlowingActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 160),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF00FFFF).withOpacity(0.55),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: ElevatedButton.icon(
            onPressed: widget.onPressed,
            icon: Icon(
              widget.icon,
              color: _isHovered ? Colors.black : const Color(0xFF00FFFF),
            ),
            label: Text(widget.label),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _isHovered ? const Color(0xFF00FFFF) : Colors.black,
              foregroundColor: _isHovered ? Colors.black : Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              textStyle: const TextStyle(
                fontFamily: 'Audiowide',
                fontWeight: FontWeight.bold,
              ),
              side: const BorderSide(color: Color(0xFF00FFFF), width: 1.5),
            ),
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    final bool isLit = _isHovered || _isActive;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _isActive = !_isActive);
        },
        child: AnimatedScale(
          scale: isLit ? 1.06 : 1.0,
          duration: const Duration(milliseconds: 160),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isLit
                  ? const Color(0xFF00FFFF).withOpacity(0.22)
                  : const Color(0xFF00FFFF).withOpacity(0.05),
              border: Border.all(
                color: const Color(0xFF00FFFF).withOpacity(isLit ? 0.95 : 0.3),
                width: isLit ? 1.5 : 1.0,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isLit
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00FFFF).withOpacity(0.45),
                        blurRadius: 14,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Audiowide',
                fontSize: 12,
                color: isLit ? Colors.white : const Color(0xFF00FFFF),
                fontWeight: isLit ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  final String? tooltip;

  const _SocialButton({
    required this.iconPath,
    required this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    bool isSvg = iconPath.toLowerCase().endsWith('.svg');
    Widget button = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00FFFF).withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: isSvg ? SvgPicture.asset(iconPath) : Image.asset(iconPath),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }
    return button;
  }
}
