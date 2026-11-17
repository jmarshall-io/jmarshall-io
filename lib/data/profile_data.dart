import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Skill {
  final String name;
  final double experience;

  Skill({required this.name, required this.experience});
}

class ProfileData {
  static List<Skill> skills = [];

  static const List<Map<String, dynamic>> projects = [
    {
      'name': 'CDC Foundation',
      'role': 'Senior Systems Architect & Orchestrator · 2025–Present',
      'sector': 'Public Health & Regulated Data Modernization',
      'tags': ['Prefect 3.x', 'dbt Medallion', 'Pixi', 'Zero-Trust gMSA', 'Grafana/Loki'],
      'description': [
        'Unified 40+ legacy ETL pipelines under Prefect 3.x and deterministic Pixi (Python 3.12) environments.',
        'Engineered metadata-driven dbt Medallion Architecture bridge (Bronze → Silver → Gold), cutting staging build time by 80%.',
        'Architected dual-telemetry observability (Grafana, Loki, Fluent Bit + SQL audit marts), reducing pipeline failures by 30%.',
        'Implemented Zero-Trust passwordless AD authentication (gMSA), PowerShell IaC (LCM), and GitHub Actions CI/CD.'
      ],
      'icon': Icons.hub_outlined,
    },
    {
      'name': 'U.S. DOT / Federal Railroad Admin (FRA)',
      'role': 'Enterprise Architect · 2023–2024',
      'sector': 'Federal Enterprise Architecture (TOGAF & FISMA)',
      'tags': ['TOGAF', 'FISMA', 'Azure Data Factory', 'Azure AD / Entra', 'Power Automate'],
      'description': [
        'Cataloged and rationalized Logical, Physical, Application, and Technology architecture components under TOGAF & FISMA.',
        'Designed As-Is to To-Be transition roadmaps across ATIP, MERMEC, ENSCO, and FRA DYNAMICS enterprise systems.',
        'Architected Microsoft Azure Data Factory (ADF) pipelines, Power Automate SOP workflows, and Azure AD BI PaaS identity.',
        'Partnered with the Chief Data Office (CDO) to establish enterprise data lifecycle governance and federal AI standards.'
      ],
      'icon': Icons.account_balance_outlined,
    },
    {
      'name': 'Coquina Systems',
      'role': 'Cloud & Integration Architect · 2023–2024',
      'sector': 'Multi-Cloud Infrastructure & Enterprise Migration',
      'tags': ['AWS ↔ GCP HA VPN', 'Terraform', 'Google Workspace (9,850 Users)', 'AWS Glue/Redshift'],
      'description': [
        'Spearheaded hybrid cloud migration from Microsoft 365 to Google Workspace for 9,850 mailboxes with zero downtime.',
        'Architected High-Availability (HA) VPN tunnels bridging AWS, GCP, and Azure workloads using Terraform IaC.',
        'Engineered AWS Glue, Redshift, and S3 Parquet ETL data lake pipelines and resolved VPC endpoint routing.'
      ],
      'icon': Icons.cloud_sync_outlined,
    },
    {
      'name': 'Delta Dental Michigan',
      'role': 'Kubernetes Platform Engineer · 2022',
      'sector': 'Healthcare Insurance & CNCF Platform Engineering',
      'tags': ['Kubernetes (CKA/CKS)', 'ArgoCD GitOps', 'OPA Gatekeeper', 'Helm', 'Dynatrace'],
      'description': [
        'Operated and hardened on-premises Kubernetes clusters using kubeadm, Helm charts, and automated Bash runbooks.',
        'Delivered OPA Gatekeeper policy-as-code governance to enforce namespace security and admission compliance.',
        'Upgraded ArgoCD GitOps continuous delivery pipelines and full-stack observability (Dynatrace, Elasticsearch, K9s).'
      ],
      'icon': Icons.security_outlined,
    },
    {
      'name': 'Lumen Technologies',
      'role': 'Google Cloud Architect · 2022',
      'sector': 'Telecommunications · Cloud FinOps & Hybrid Mesh',
      'tags': ['GCP BigQuery FinOps', 'GKE', 'Terraform (csvdecode)', 'Traffic Director / Envoy'],
      'description': [
        'Delivered GKE Cluster Usage Metering to BigQuery FinOps dashboards, driving 20% multi-tenant cloud spend reduction.',
        'Implemented data-driven Terraform (csvdecode) automation to dynamically provision GCP projects and IAM from ServiceNow.',
        'Architected hybrid connectivity using multi-NIC VPCs, Cloud SQL Auth Proxy, and Traffic Director with Envoy.'
      ],
      'icon': Icons.analytics_outlined,
    },
    {
      'name': 'Vitu',
      'role': 'Google Cloud & Service Mesh Architect · 2022',
      'sector': 'Enterprise SaaS · Anthos & Microservices',
      'tags': ['GCP Anthos', 'Istio Service Mesh (ICA)', 'GKE', 'Cloud Monitoring', 'Terraform'],
      'description': [
        'Spearheaded enterprise rollout of GCP Anthos Istio Service Mesh for secure mTLS microservice communication.',
        'Engineered centralized Single Pane of Glass observability integrating kube-state-metrics and Google Cloud Monitoring.',
        'Authored reusable Terraform and YAML infrastructure blueprints for GKE, IAM governance, and disaster recovery.'
      ],
      'icon': Icons.lan_outlined,
    },
    {
      'name': 'Travelers · Deloitte (Motiva) · Otis',
      'role': 'Principal ETL & Big Data Orchestrator · 2020–2021',
      'sector': 'Insurance, Energy & Global Manufacturing',
      'tags': ['Talend Data Fabric (TAC)', 'AWS S3/Glue/Athena', 'Azure ADF & Databricks', 'SAP / JDE / BAAN'],
      'description': [
        'Travelers: Automated resilient REST API extraction pipelines into AWS S3, Glue, and Athena via Talend 7.3.',
        'Deloitte / Motiva: Triaged and refactored Azure Data Factory (ADF), Talend TAC (Linux), Databricks, and Cloudera Hadoop flows.',
        'Otis Elevator: Migrated global ERP datasets across SAP HANA/IDoc, JD Edwards, and BAAN into SQL Server reconciliation marts.'
      ],
      'icon': Icons.schema_outlined,
    },
    {
      'name': 'KPMG (U.S. HUD) & Maven Wave',
      'role': 'Cloud & Data Warehouse Architect · 2018–2020',
      'sector': 'Federal Housing & Enterprise Cloud Consulting',
      'tags': ['Azure Databricks', 'Azure Blob/SQL', 'Google BigQuery', 'Cloud Composer / Airflow'],
      'description': [
        'KPMG / HUD: Architected end-to-end Azure pipelines ingesting 60+ complex multi-sheet datasets into Azure Blob & Databricks (2 sprints early).',
        'Maven Wave: Translated legacy Netezza/Teradata warehouses into Google BigQuery and orchestrated Python DAGs on Cloud Composer / Airflow.'
      ],
      'icon': Icons.storage_outlined,
    },
    {
      'name': 'U.S. Treasury (OFR) & Booz Allen',
      'role': 'Lead Integration Architect · 2012–2018',
      'sector': 'Federal Financial Research & OCIO Strategy',
      'tags': ['Talend Big Data', 'SAS DI Studio', 'SSIS / SQL Server', 'RHEL / Kerberos', '5-Yr EA Roadmaps'],
      'description': [
        'Accredited Talend Studio for Big Data Enterprise and SAS Data Integration Studio across hardened RHEL and Windows tiers.',
        'Engineered metadata audit governance databases tracking DTCC, FINRA, and OptionMetrics financial feeds.',
        'Developed 5-year Enterprise Architecture IT roadmaps for federal OCIO leadership (Dept. of Labor & OFR).'
      ],
      'icon': Icons.policy_outlined,
    },
    {
      'name': 'Mirixa · BAE Systems · Navy Federal · GD',
      'role': 'Healthcare Data Ops, Lead DBA & Systems Engineer · 2000–2012',
      'sector': 'Healthcare (HIPAA/CMS), Defense & Financial Services',
      'tags': ['HIPAA / HL7 / FHIR', 'CMS Medicare/Medicaid', 'SQL Server HA/DR (32 Nodes)', 'UNIX / C / .NET'],
      'description': [
        'Mirixa Corp: Automated CMS Medicare/Medicaid and HL7/FHIR clinical data feeds under strict HIPAA audit governance.',
        'BAE Systems & Navy Federal: Administered 32 SQL Server instances, 1TB+ HA/DR clusters, Database Mirroring, and SSIS consolidation.',
        'General Dynamics: Engineered MH-53 flight simulator UNIX/C/FORTRAN systems and deployed Public Health Alert Networks.'
      ],
      'icon': Icons.medical_information_outlined,
    },
  ];

  static Future<void> loadSkills() async {
    try {
      final rawData =
          await rootBundle.loadString('assets/skills_experience.csv');
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(rawData, eol: '\n');

      skills = [];
      var rows = listData;
      if (rows.isNotEmpty && rows[0][0] == 'name') {
        rows = rows.sublist(1);
      }

      for (var row in rows) {
        if (row.length >= 2) {
          skills.add(
            Skill(
              name: row[0].toString(),
              experience: double.tryParse(row[1].toString()) ?? 0.5,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error loading skills: $e');
    }
  }

  static String getProfileContext() {
    StringBuffer sb = StringBuffer();
    sb.writeln('Projects:');
    for (var p in projects) {
      sb.writeln("- ${p['name']}: ${(p['description'] as List).join(', ')}");
    }
    sb.writeln('\nSkills:');
    for (var s in skills) {
      sb.writeln('- ${s.name} (${(s.experience * 100).toInt()}%)');
    }
    return sb.toString();
  }
}
