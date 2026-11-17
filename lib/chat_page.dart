import 'dart:async';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jmarshall_io/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

const String profileContext = """
Name: Jonathan Marshall
Role: Principal Systems Architect & Orchestrator | Enterprise & Cloud Integration Leader
Location: Washington, DC Area (Remote-First)
Contact: jmarshall.systems@gmail.com | https://jmarshall.io
Core Stack: Prefect 3.x, dbt, Talend TAC, SSIS, SAS Data Integration Studio, Apache Airflow, Google Cloud Platform (GCP, BigQuery, GKE, Anthos/Istio), AWS (Glue, S3, Athena, Redshift), Azure (Data Factory, Entra ID/AD, Databricks), CNCF / Kubernetes (CKA, CKAD, CKS, Istio ICA, Helm, ArgoCD, OPA Gatekeeper), Terraform, Pixi/uv, Grafana/Loki/Fluent Bit/Prometheus, Zero-Trust gMSA, TOGAF & FISMA.
Flagship Deliveries:
1. Public Health Data Modernization (CDC Foundation): Unified 40+ pipelines under Prefect 3.x & Pixi, built metadata-driven dbt Medallion bridge (80% faster staging), dual-telemetry observability, Zero-Trust gMSA, and engineering onboarding/training playbooks (cutting setup time by 40%).
2. Enterprise Cloud, Hybrid & CNCF Platform Engineering: Coquina (9,850-mailbox M365 to Google Workspace migration, AWS-GCP HA VPN), FRA/DOT (TOGAF/FISMA EA & Azure Data Factory), Delta Dental (On-Prem K8s, ArgoCD, OPA Gatekeeper), Lumen (GKE BigQuery FinOps, Traffic Director), Vitu (Anthos Istio Service Mesh).
""";

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _roleSummaryController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _hoveredChip;

  // Structured Role & Alignment Selections (Non-draconian, tap-to-select)
  String _fiveAStage = 'Full 5-A Lifecycle (Assess → Adapt)';
  String _workLocation = '100% Remote';
  String _engagementType = 'C2C / 1099 Contract';
  String _interviewProcess = 'Architecture & Portfolio Walkthrough';
  String _compModel = 'Fixed Monthly Retainer (Fractional)';
  final Set<String> _selectedDomains = {
    'Cloud, On-Prem & Hybrid (ETL & ELT — dbt / BigQuery / SQL)',
    'Enterprise Orchestration (Prefect / Talend / SSIS / SAS DI / K8s)',
  };

  static const List<String> _fiveAOptions = [
    'Full 5-A Lifecycle (Assess → Adapt)',
    '01 Assess (Discovery / TOGAF Audit)',
    '02 Assimilate (Data & Schema Unification)',
    '03 Architect (Cloud / On-Prem / Hybrid ETL & ELT)',
    '04 Automate (Prefect / Talend / SSIS / SAS DI / K8s)',
    '05 Adapt (CNCF Governance, Training & Enablement)',
  ];

  static const List<String> _locationOptions = [
    '100% Remote',
    'Remote-First (<10% Travel)',
    'Hybrid (DC Metro)',
    'On-Site Required',
  ];

  static const List<String> _engagementOptions = [
    'C2C / 1099 Contract',
    'Architecture Advisory / Fractional',
    'Direct W2 / Principal Role',
    'Prime Vendor (Direct to Hiring Mgr)',
  ];

  static const List<String> _processOptions = [
    'Architecture & Portfolio Walkthrough',
    'Hiring Manager / Executive Discussion',
    'Live System Design / Pairing',
    'Automated Coding / Quiz Assessment',
  ];

  static const List<String> _compModelOptions = [
    'Fixed Monthly Retainer (Fractional)',
    'Milestone / Fixed-Scope SOW',
    'Hourly C2C / 1099 Rate',
    'Direct Principal Comp (Base + Bonus)',
    'Open — Align on Discovery Call',
  ];

  static const List<String> _domainOptions = [
    'Cloud, On-Prem & Hybrid (ETL & ELT — dbt / BigQuery / SQL)',
    'Enterprise Orchestration (Prefect / Talend / SSIS / SAS DI / K8s)',
    'Multi-Cloud Infrastructure (GCP / AWS / Azure / Terraform)',
    'CNCF Cloud-Native (K8s CKA/CKAD/CKS · Istio · ArgoCD · OPA)',
    'Observability, Runbooks & Training (Grafana · Loki · Prometheus)',
    'Enterprise Architecture (TOGAF / FinOps / Zero-Trust)',
  ];

  bool _isChatStarted = false;
  bool _isLoading = false;
  final List<Map<String, dynamic>> _messages = [];
  String? userName;
  String? _attachedFileName;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _budgetController.dispose();
    _roleSummaryController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _pickJdOrSowFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'md'],
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        final PlatformFile file = result.files.first;
        setState(() {
          _attachedFileName = file.name;
        });
        // If it's a text/markdown file, automatically populate the JD/SOW box
        if ((file.extension == 'txt' || file.extension == 'md') &&
            file.bytes != null) {
          final String content = utf8.decode(file.bytes!, allowMalformed: true);
          if (_roleSummaryController.text.trim().isEmpty) {
            _roleSummaryController.text = content;
          }
        }
      }
    } catch (_) {
      // Ignore file picker cancellation/errors
    }
  }

  Future<void> _sendNtfyAlignmentAlert({required String triggerSource}) async {
    final String envTopic = dotenv.env['NTFY_ADMIN_TOPIC'] ??
        const String.fromEnvironment(
          'NTFY_ADMIN_TOPIC',
          defaultValue: 'jmarshall-systems-io',
        );
    final String topic =
        envTopic.trim().isEmpty ? 'jmarshall-systems-io' : envTopic.trim();

    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String org = _companyController.text.trim().isEmpty
        ? 'Unspecified Org'
        : _companyController.text.trim();
    final String budget = _budgetController.text.trim().isEmpty
        ? 'Open for Discovery Call'
        : _budgetController.text.trim();
    final String domains = _selectedDomains.join(' · ');
    final String attachmentInfo =
        _attachedFileName != null ? ' [Attached: $_attachedFileName]' : '';
    final String summary = _roleSummaryController.text.trim().isEmpty
        ? (_attachedFileName ?? 'None provided')
        : '${_roleSummaryController.text.trim()}$attachmentInfo';

    final String body = 'Contact: $name ($email)\n'
        'Organization: $org\n'
        '5-A Phase: $_fiveAStage\n'
        'Location: $_workLocation\n'
        'Model: $_engagementType\n'
        'Comp Structure: $_compModel\n'
        'Proposed Rate/Budget: $budget\n'
        'Process: $_interviewProcess\n'
        'Domains: $domains\n'
        'Summary: $summary\n'
        'Trigger: $triggerSource';

    // 1. Instant Push Notification to Pixel 9a (jmarshall-systems-io & jmarshall-systems-inquiry)
    try {
      final String replySubject = Uri.encodeComponent(
        'Re: $_engagementType ($_workLocation) — $org',
      );
      final Set<String> inquiryTopics = {
        topic,
        'jmarshall-systems-io',
        'jmarshall-systems-inquiry',
      };
      for (final String t in inquiryTopics) {
        await http.post(
          Uri.parse('https://ntfy.sh/$t'),
          headers: {
            'Title': 'Role Alignment ($org): $_engagementType | $_workLocation',
            'Priority': 'high',
            'Tags': 'briefcase,rocket',
            'Actions':
                'view, Reply to $name, mailto:$email?subject=$replySubject',
          },
          body: body,
        );
      }
    } catch (_) {
      // Non-blocking telemetry
    }

    // 2. Automatic Background Email Delivery to jmarshall.systems@gmail.com
    try {
      await http.post(
        Uri.parse('https://formsubmit.co/ajax/jmarshall.systems@gmail.com'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          '_subject':
              '[jmarshall.io Role Alignment] $_engagementType | $_workLocation — $org',
          '_replyto': email,
          'Contact_Name': name,
          'Contact_Email': email,
          'Organization_End_Client': org,
          'Five_A_Phase': _fiveAStage,
          'Work_Location_Model': _workLocation,
          'Engagement_Structure': _engagementType,
          'Compensation_Structure': _compModel,
          'Proposed_Rate_Or_Budget': budget,
          'Interview_Evaluation_Process': _interviewProcess,
          'Architectural_Domains': domains,
          'JD_Or_SOW_Summary': summary,
          'Trigger_Source': triggerSource,
        }),
      );
    } catch (_) {
      // Non-blocking background email relay
    }
  }

  Future<void> _dispatchEmailSummary() async {
    unawaited(_sendNtfyAlignmentAlert(triggerSource: 'Email Dispatch Button'));
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String org = _companyController.text.trim().isEmpty
        ? 'Unspecified Organization'
        : _companyController.text.trim();
    final String budget = _budgetController.text.trim().isEmpty
        ? 'Open for Discovery Call'
        : _budgetController.text.trim();
    final String domains = _selectedDomains.join(', ');
    final String summary = _roleSummaryController.text.trim().isEmpty
        ? 'See alignment choices above.'
        : _roleSummaryController.text.trim();

    final String subject = Uri.encodeComponent(
      '[VETTED ROLE ALIGNMENT] $_engagementType | $_workLocation — $org',
    );
    final String body = Uri.encodeComponent(
      'Role & Architecture Alignment Brief (via jmarshall.io)\n'
      '------------------------------------------------------\n'
      'Contact Name: $name\n'
      'Contact Email: $email\n'
      'Organization / End-Client: $org\n'
      '5-A Engagement Phase: $_fiveAStage\n'
      'Work Location Model: $_workLocation\n'
      'Engagement Structure: $_engagementType\n'
      'Compensation Structure: $_compModel\n'
      'Proposed Rate Range / Budget: $budget\n'
      'Interview / Evaluation Process: $_interviewProcess\n'
      'Architectural Scope: $domains\n\n'
      'Role Summary / Requisition Notes:\n$summary\n',
    );

    final Uri mailtoUri = Uri.parse(
      'mailto:jmarshall.systems@gmail.com?subject=$subject&body=$body',
    );
    await launchUrl(mailtoUri);
  }

  void _startChat() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.enterNameError)),
      );
      return;
    }
    if (_emailController.text.trim().isEmpty ||
        !_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.enterValidEmailError),
        ),
      );
      return;
    }

    final String processNote =
        _interviewProcess == 'Automated Coding / Quiz Assessment'
            ? '\n\n• Note on Evaluation Process: In the AI-agentic era, live walkthroughs of production architectures, ADRs, and hybrid-cloud repositories (Prefect, dbt, BigQuery, Kubernetes) provide far stronger architectural signal than synthetic coding quizzes—happy to walk through live systems directly with the hiring team.'
            : '\n\n• Evaluation Alignment: "$_interviewProcess" aligns directly with walking through production reference architectures and system design trade-offs.';

    final String budgetDisplay = _budgetController.text.trim().isEmpty
        ? _compModel
        : '$_compModel (${_budgetController.text.trim()})';

    unawaited(
      _sendNtfyAlignmentAlert(triggerSource: 'Start Alignment Intake'),
    );

    setState(() {
      userName = _nameController.text.trim();
      _isChatStarted = true;
      _messages.add({
        'role': 'assistant',
        'content':
            'Welcome, $userName. The 5-A role alignment profile has been captured:\n'
                '• 5-A Phase: $_fiveAStage\n'
                '• Location: $_workLocation\n'
                '• Model & Comp: $_engagementType — $budgetDisplay\n'
                '• Domains: ${_selectedDomains.join(" · ")}'
                '$processNote\n\n'
                'Use the "Send Vetted Brief to Email" button in the top bar to dispatch this directly to jmarshall.systems@gmail.com, or ask any questions below about recent architecture deliveries (CDC Foundation, Coquina, FRA/DOT, Delta Dental, Lumen).'
      });
    });
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': text});
      _isLoading = true;
      _messageController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    try {
      await Future.delayed(const Duration(milliseconds: 900));
      String reply = '';
      final lowerText = text.toLowerCase();

      if (lowerText.contains('process') ||
          lowerText.contains('interview') ||
          lowerText.contains('assessment') ||
          lowerText.contains('test')) {
        reply =
            'For Systems & Enterprise Architect engagements, the most effective evaluation is a direct Architecture & Portfolio Walkthrough with the hiring manager or technical lead—reviewing live Prefect/dbt/BigQuery medallion pipelines, Terraform IaC, and TOGAF/ADR blueprints rather than generic syntax tests.';
      } else if (lowerText.contains('remote') ||
          lowerText.contains('location') ||
          lowerText.contains('travel')) {
        reply =
            'Jonathan operates Remote-First from the Washington, DC area, with 10+ years of distributed architecture delivery across federal (CDC Foundation, DOT/FRA, OFR) and commercial enterprises.';
      } else if (lowerText.contains('prefect') ||
          lowerText.contains('dbt') ||
          lowerText.contains('data') ||
          lowerText.contains('bigquery')) {
        reply =
            'Recent delivery at CDC Foundation unified 40+ pipelines under Prefect 3.x and Pixi, paired with a metadata-driven dbt Medallion bridge (cutting staging build time by 80%) and a Dual-Target DuckDB/BigQuery hybrid cloud refinery.';
      } else if (lowerText.contains('kubernetes') ||
          lowerText.contains('k8s') ||
          lowerText.contains('cloud') ||
          lowerText.contains('gcp')) {
        reply =
            'Certifications include Google Cloud Professional Cloud Architect, CKA, CKAD, CKS, Istio (ICA), and TOGAF Foundations—backed by production deliveries at Lumen (GKE BigQuery FinOps), Delta Dental (ArgoCD & OPA Gatekeeper), and Vitu (Anthos Istio Service Mesh).';
      } else if (lowerText.contains('contact') ||
          lowerText.contains('email') ||
          lowerText.contains('call') ||
          lowerText.contains('phone')) {
        reply =
            'To keep calls focused on aligned engagements, phone consultations are scheduled after dispatching the role brief. Click "Send Vetted Brief to Email" at the top of this panel to send the structured profile to jmarshall.systems@gmail.com.';
      } else {
        reply =
            'Alignment noted for $_engagementType ($_workLocation). Click "Send Vetted Brief to Email" in the header to forward these role specifications directly to jmarshall.systems@gmail.com for review.';
      }

      if (mounted) {
        setState(() {
          _messages.add({'role': 'assistant', 'content': reply});
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isChatStarted) {
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 680,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                border: Border.all(
                  color: const Color(0xFF00FFFF).withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00FFFF).withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.verified_user_outlined,
                        size: 36,
                        color: Color(0xFF00FFFF),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ROLE & ARCHITECTURE ALIGNMENT',
                              style: TextStyle(
                                fontFamily: 'Audiowide',
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Quick 30-second alignment for Systems / Cloud / Data Architecture engagements before scheduling a call.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 520) {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _nameController,
                                label:
                                    '${AppLocalizations.of(context)!.nameLabel} * (Required)',
                                icon: Icons.person,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _buildTextField(
                                controller: _emailController,
                                label:
                                    '${AppLocalizations.of(context)!.emailLabel} * (Required)',
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          _buildTextField(
                            controller: _nameController,
                            label:
                                '${AppLocalizations.of(context)!.nameLabel} * (Required)',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 14),
                          _buildTextField(
                            controller: _emailController,
                            label:
                                '${AppLocalizations.of(context)!.emailLabel} * (Required)',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 14),
                  _buildTextField(
                    controller: _companyController,
                    label: 'Organization / End-Client Name (Optional)',
                    icon: Icons.business,
                  ),
                  const SizedBox(height: 22),
                  _buildSectionLabel(
                    '1. 5-A ENGAGEMENT PHASE (TOGAF MODERNIZATION / GREENFIELD)',
                  ),
                  _buildChoiceWrap(
                    options: _fiveAOptions,
                    selected: _fiveAStage,
                    onSelected: (val) => setState(() => _fiveAStage = val),
                  ),
                  const SizedBox(height: 18),
                  _buildSectionLabel('2. WORK LOCATION MODEL'),
                  _buildChoiceWrap(
                    options: _locationOptions,
                    selected: _workLocation,
                    onSelected: (val) => setState(() => _workLocation = val),
                  ),
                  const SizedBox(height: 18),
                  _buildSectionLabel('3. ENGAGEMENT STRUCTURE'),
                  _buildChoiceWrap(
                    options: _engagementOptions,
                    selected: _engagementType,
                    onSelected: (val) => setState(() => _engagementType = val),
                  ),
                  const SizedBox(height: 18),
                  _buildSectionLabel(
                    '4. COMPENSATION & RETAINER STRUCTURE (NEGOTIABLE ON CALL)',
                  ),
                  _buildChoiceWrap(
                    options: _compModelOptions,
                    selected: _compModel,
                    onSelected: (val) => setState(() => _compModel = val),
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _budgetController,
                    label:
                        'Proposed Rate Range or Retainer Budget — \$/hr, \$/mo, or Open (Optional)',
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                  const SizedBox(height: 18),
                  _buildSectionLabel(
                    '5. INTERVIEW & EVALUATION PROCESS (AI-ERA ALIGNMENT)',
                  ),
                  _buildChoiceWrap(
                    options: _processOptions,
                    selected: _interviewProcess,
                    onSelected: (val) =>
                        setState(() => _interviewProcess = val),
                  ),
                  if (_interviewProcess ==
                      'Automated Coding / Quiz Assessment') ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FFFF).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF00FFFF).withOpacity(0.4),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Color(0xFF00FFFF),
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'In the AI-agentic era, live walkthroughs of production architectures, ADRs, and GitHub repositories provide much stronger signal than timed coding trivia.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  _buildSectionLabel(
                    '6. PRIMARY ARCHITECTURAL SCOPE (SELECT ALL THAT APPLY)',
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _domainOptions.map((domain) {
                      final bool isSelected = _selectedDomains.contains(domain);
                      return FilterChip(
                        label: Text(
                          domain,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? Colors.black
                                : const Color(0xFF00FFFF),
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: const Color(0xFF00FFFF),
                        checkmarkColor: Colors.black,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        side: BorderSide(
                          color: const Color(0xFF00FFFF).withOpacity(0.4),
                        ),
                        onSelected: (bool selected) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            if (selected) {
                              _selectedDomains.add(domain);
                            } else if (_selectedDomains.length > 1) {
                              _selectedDomains.remove(domain);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  _buildSectionLabel(
                    '7. JOB DESCRIPTION (JD) OR STATEMENT OF WORK (SOW) (OPTIONAL)',
                  ),
                  _buildTextField(
                    controller: _roleSummaryController,
                    label:
                        'Paste Job Description (JD), Statement of Work (SOW), or Link (Optional)',
                    icon: Icons.description_outlined,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: _pickJdOrSowFile,
                        icon: const Icon(
                          Icons.attach_file,
                          size: 16,
                          color: Color(0xFF00FFFF),
                        ),
                        label: Text(
                          _attachedFileName == null
                              ? 'Attach JD / SOW File (.pdf, .docx, .md, .txt)'
                              : 'Attached: $_attachedFileName',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF00FFFF),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: const Color(0xFF00FFFF).withOpacity(0.45),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      if (_attachedFileName != null) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          tooltip: 'Remove attachment',
                          icon: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white54,
                          ),
                          onPressed: () =>
                              setState(() => _attachedFileName = null),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: _startChat,
                            icon: const Icon(Icons.bolt),
                            label: const Text(
                              'START ALIGNMENT & PREVIEW BRIEF',
                              style: TextStyle(
                                fontFamily: 'Audiowide',
                                fontSize: 13,
                                letterSpacing: 1.1,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF00FFFF).withOpacity(0.2),
                              foregroundColor: const Color(0xFF00FFFF),
                              side: const BorderSide(color: Color(0xFF00FFFF)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            border: Border(
              bottom: BorderSide(
                color: const Color(0xFF00FFFF).withOpacity(0.3),
              ),
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.android, color: Color(0xFF00FFFF)),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.aiChat,
                    style: const TextStyle(
                      fontFamily: 'Audiowide',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: _dispatchEmailSummary,
                    icon: const Icon(Icons.send_outlined, size: 16),
                    label: const Text(
                      'Send Vetted Brief to Email',
                      style: TextStyle(fontFamily: 'Audiowide', fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FFFF).withOpacity(0.2),
                      foregroundColor: const Color(0xFF00FFFF),
                      side: const BorderSide(color: Color(0xFF00FFFF)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: 'Edit Role Alignment Choices',
                    icon: const Icon(Icons.tune, color: Colors.white70),
                    onPressed: () {
                      setState(() {
                        _isChatStarted = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(20),
            itemCount: _messages.length + (_isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white10,
                        child: Icon(
                          Icons.android,
                          size: 15,
                          color: Color(0xFF00FFFF),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.aiProcessing,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final msg = _messages[index];
              final isUser = msg['role'] == 'user';

              return Align(
                alignment: isUser ? Alignment.topRight : Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? const Color(0xFF00FFFF).withOpacity(0.2)
                        : Colors.white10,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft:
                          isUser ? const Radius.circular(15) : Radius.zero,
                      bottomRight:
                          isUser ? Radius.zero : const Radius.circular(15),
                    ),
                    border: Border.all(
                      color: isUser
                          ? const Color(0xFF00FFFF).withOpacity(0.5)
                          : Colors.white12,
                      width: 1,
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  child: Text(
                    msg['content'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            border: Border(
              top: BorderSide(color: const Color(0xFF00FFFF).withOpacity(0.3)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (_) => _sendMessage(),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.askHint,
                    hintStyle: const TextStyle(color: Colors.white30),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF00FFFF)),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Audiowide',
          fontSize: 11.5,
          color: Color(0xFF00FFFF),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildChoiceWrap({
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((option) {
        final bool isSelected = selected == option;
        final bool isHovered = _hoveredChip == option;
        final bool isLit = isSelected || isHovered;
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hoveredChip = option),
          onExit: (_) => setState(() => _hoveredChip = null),
          child: AnimatedScale(
            scale: isLit ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: isLit
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00FFFF).withOpacity(
                            isSelected ? 0.45 : 0.3,
                          ),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: ChoiceChip(
                label: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? Colors.black
                        : isHovered
                            ? const Color(0xFF00FFFF)
                            : Colors.white70,
                    fontWeight: isLit ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                selectedColor: const Color(0xFF00FFFF),
                backgroundColor: Colors.black.withOpacity(0.6),
                side: BorderSide(
                  color: isLit
                      ? const Color(0xFF00FFFF)
                      : const Color(0xFF00FFFF).withOpacity(0.3),
                  width: isLit ? 1.5 : 1.0,
                ),
                onSelected: (_) {
                  HapticFeedback.selectionClick();
                  onSelected(option);
                },
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.white54,
          fontFamily: 'Audiowide',
          fontSize: 12,
        ),
        prefixIcon: Icon(icon, color: const Color(0xFF00FFFF), size: 20),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: const Color(0xFF00FFFF).withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00FFFF)),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
      ),
    );
  }
}
