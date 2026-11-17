import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // Import for animated text
import 'dart:async';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:jmarshall_io/l10n/app_localizations.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late String formattedDate;
  late Timer timer;

  String searchText = ""; // Variable to store search query

  @override
  void initState() {
    super.initState();
    formattedDate = _getCurrentTime();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  // Format current time
  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  }

  // Update time every second
  void _updateTime() {
    setState(() {
      formattedDate = _getCurrentTime();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // List of services aligned with 5-A TOGAF & Enterprise Orchestration
  final List<Map<String, dynamic>> services = [
    {
      'title': 'Enterprise & Systems Architecture (TOGAF)',
      'description':
          'Current-to-Target (As-Is → To-Be) roadmaps, ADRs, and portfolio rationalization across regulated federal, healthcare, and commercial sectors.',
      'icon': Icons.account_balance_outlined,
      'skills': [
        '5-A Engagement Lifecycle (Assess → Assimilate → Architect → Automate → Adapt)',
        'TOGAF Foundations & Architectural Decision Records (ADRs)',
        'Current-State (As-Is) to Target-State (To-Be) Roadmaps',
        'HIPAA, FISMA & Zero-Trust Governance (gMSA, IAM, Azure AD / Entra)',
        'FinOps Cloud Cost Modeling, Metering & Trade-Off Analysis',
      ]
    },
    {
      'title': 'Enterprise Workflow & Pipeline Orchestration',
      'description':
          'Unifying fragmented scheduled tasks and legacy scripts under resilient, observable orchestration engines.',
      'icon': Icons.hub_outlined,
      'skills': [
        'Prefect 3.x Unified Pipeline Orchestration & Self-Healing Hooks',
        'Talend Data Fabric (TAC) & Talend Studio Big Data Enterprise',
        'SQL Server Integration Services (SSIS) & SAS Data Integration Studio',
        'Google Cloud Composer & Apache Airflow DAG Engineering',
        'Deterministic Python 3.12 Runtime Management (Pixi & uv)',
      ]
    },
    {
      'title': 'Cloud, On-Prem & Hybrid Data Platforms (ETL & ELT)',
      'description':
          'Designing governed Medallion data refineries and cross-cloud data lakes across Cloud, On-Premises, and Hybrid environments.',
      'icon': Icons.storage_outlined,
      'skills': [
        'dbt (Data Build Tool) Medallion Architecture (Bronze → Silver → Gold)',
        'Google BigQuery, SQL Server (HA/DR Clusters), PostgreSQL & DuckDB',
        'Microsoft Azure Data Factory (ADF), Azure Databricks & Blob Storage',
        'AWS Glue, Redshift, S3 Parquet & Athena Serverless Pipelines',
        'Enterprise ERP & Healthcare Data Migration (SAP, JDE, BAAN, HL7/FHIR, CMS)',
      ]
    },
    {
      'title': 'Multi-Cloud Infrastructure & CNCF Platform Engineering',
      'description':
          'Production-grade Kubernetes clusters, service meshes, cross-cloud HA VPN interconnects, and Infrastructure as Code.',
      'icon': Icons.cloud_sync_outlined,
      'skills': [
        'CNCF Kubernetes Platform Engineering (CKA, CKAD & CKS Certified)',
        'GCP Anthos & Istio Service Mesh (ICA Certified) + Traffic Director / Envoy',
        'OPA Gatekeeper Policy-as-Code, ArgoCD GitOps & Helm Charts',
        'Terraform IaC, PowerShell DSC (LCM) & GitHub Actions CI/CD',
        'Cross-Cloud HA VPN Interconnects (AWS ↔ GCP ↔ Azure) & Workspace Migrations',
      ]
    },
    {
      'title': 'Full-Stack Observability, Runbooks & Team Enablement',
      'description':
          'Real-time pipeline/cluster telemetry, executive dashboards, and hands-on engineering enablement.',
      'icon': Icons.analytics_outlined,
      'skills': [
        'Grafana, Loki, Fluent Bit & Prometheus Telemetry Stacks',
        'Dynatrace, Elasticsearch & K9s Cluster Triage',
        'Dual-Telemetry Pipeline Audit Schemas & Stage-Level Lineage',
        'Operational Runbooks, SOPs & Engineering Team Training (40% Faster Onboarding)',
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent to show CircuitBackground
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.servicesTitle,
                      style: const TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 24,
                        color: Color(0xFF00FFFF),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formattedDate, 
                      style: const TextStyle(
                        fontFamily: 'TrueType',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
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
                onChanged: (value) {
                  setState(() {
                    searchText = value; 
                  });
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchServices,
                  hintStyle: const TextStyle(color: Colors.white30, fontFamily: 'Audiowide', fontSize: 14),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF00FFFF)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                style: const TextStyle(color: Colors.white, fontFamily: 'Audiowide'),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: services.where((service) {
                  return service['title']
                      .toLowerCase()
                      .contains(searchText.toLowerCase());
                }).map((service) {
                  return expandableServiceCard(
                      service['title'],
                      service['description'],
                      service['icon'],
                      service['skills']);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget expandableServiceCard(
      String title, String description, IconData icon, List<String> skills) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Glass
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FFFF).withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ExpansionTile(
        collapsedIconColor: const Color(0xFF00FFFF),
        iconColor: const Color(0xFF00FFFF),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF00FFFF).withOpacity(0.1),
          ),
          child: Icon(icon, color: const Color(0xFF00FFFF), size: 20),
        ), 
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Audiowide',
            fontSize: 20, // Increased
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: const Color(0xFF00FFFF).withOpacity(0.8),
                blurRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        subtitle: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              description,
              textStyle: const TextStyle(
                // fontFamily: 'TrueType', // Removed for standard font
                fontSize: 14, 
                color: Colors.white70,
                height: 1.4,
              ),
              speed: const Duration(milliseconds: 50), 
            ),
          ],
          totalRepeatCount: 1, 
          pause: const Duration(milliseconds: 500),
          displayFullTextOnTap: true, 
          stopPauseOnTap: true,
        ),
        children: skills
            .map((skill) => skillTile(skill))
            .toList(), 
      ),
    );
  }

  Widget skillTile(String skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to top for multi-line
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(Icons.check_circle_outline, color: Color(0xFF00FFFF), size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              skill,
              style: const TextStyle(
                // fontFamily: 'TrueType', // Removed for standard font
                fontSize: 15,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
