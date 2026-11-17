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

  // Dynamic getter (not static const) so Flutter Hot Reload ('r') always updates immediately
  static List<Map<String, dynamic>> get projects => [
        {
          'name': 'CDC Foundation',
          'role': 'Senior Systems Architect & Orchestrator · 2025–Present',
          'sector': 'Public Health & Regulated Healthcare Modernization',
          'categories': [
            'Orchestration & ETL/ELT',
            'Healthcare & Public Health',
            'TOGAF & EA',
          ],
          'tags': [
            'Prefect 3.x',
            'dbt Medallion',
            'Pixi / Python 3.12',
            'Zero-Trust gMSA',
            'Grafana / Loki',
            'PowerShell IaC',
            'GitHub Actions',
          ],
          'description': [
            'Guided public health data modernization using TOGAF principles, mapping As-Is to To-Be state models across application, database, and governance tiers.',
            'Unified 40+ legacy ETL pipelines under Prefect 3.x and deterministic Pixi (Python 3.12) environments.',
            'Engineered a metadata-driven dbt Medallion Architecture bridge (Bronze → Silver → Gold), reducing new data source staging time by 80%.',
            'Architected dual-telemetry observability (Grafana, Loki, Fluent Bit + SQL Server audit marts), cutting pipeline failures by 30%.',
            'Implemented Zero-Trust passwordless AD authentication (gMSA), PowerShell DSC IaC (LCM), and standardized templates cutting engineer onboarding time by 40%.',
          ],
          'icon': Icons.hub_outlined,
        },
        {
          'name': 'U.S. DOT / Federal Railroad Admin (FRA)',
          'role': 'Enterprise Architect · 2023–2024',
          'sector': 'Federal Transportation · TOGAF & FISMA Governance',
          'categories': [
            'TOGAF & EA',
            'Federal & Defense',
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'TOGAF',
            'FISMA',
            'Azure Data Factory',
            'Azure AD / Entra ID',
            'Power Automate',
            'BPMN / Visio',
            'CDO Data Governance',
          ],
          'description': [
            'Captured and rationalized Logical, Physical, Application, and Technology architecture components in compliance with FISMA and TOGAF standards.',
            'Mapped application and integration topologies across ATIP, MERMEC, ENSCO, FRA HOSTS, and FRA DYNAMICS systems.',
            'Designed and automated Microsoft Azure Data Factory (ADF) pipelines and Power Automate workflows to modernize enterprise SOPs.',
            'Architected Azure Active Directory (Entra ID) identity management for Business Intelligence PaaS services and authored federal AI governance playbooks with the CDO.',
          ],
          'icon': Icons.account_balance_outlined,
        },
        {
          'name': 'Coquina Systems',
          'role': 'Cloud & Enterprise Integration Architect · 2023–2024',
          'sector': 'Multi-Cloud Infrastructure & Large-Scale Migration',
          'categories': [
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
            'TOGAF & EA',
          ],
          'tags': [
            'AWS ↔ GCP HA VPN',
            'Terraform IaC',
            'Google Workspace (9,850 Users)',
            'AWS Glue & Redshift',
            'Parquet Data Lake',
            'GAMADV-XTD / GWMME',
          ],
          'description': [
            'Spearheaded high-velocity hybrid migration from Microsoft 365 / Exchange to Google Workspace for 9,850 user mailboxes (2,171 Staff, 7,679 Students) with zero downtime.',
            'Architected High-Availability (HA) VPN tunnels bridging AWS, GCP, and Azure workloads with Terraform, Bash, and Python.',
            'Designed AWS Redshift, AWS Glue, and S3 Parquet ETL data lakes and resolved VPC endpoint routing bottlenecks.',
            'Led technical pre-sales architecture scoping and multi-cloud reseller proposals across GCP, AWS, and Azure.',
          ],
          'icon': Icons.cloud_sync_outlined,
        },
        {
          'name': 'Delta Dental Michigan',
          'role': 'Kubernetes Platform Engineer · 2022',
          'sector': 'Healthcare Insurance · CNCF Platform Engineering',
          'categories': [
            'Cloud & CNCF K8s',
            'Healthcare & Public Health',
          ],
          'tags': [
            'Kubernetes (CKA/CKS)',
            'ArgoCD GitOps',
            'OPA Gatekeeper',
            'Helm & kubeadm',
            'Dynatrace & Elasticsearch',
            'Artifactory / Docker',
          ],
          'description': [
            'Directed day-to-day Keep-The-Lights-On (KTLO) operations and cluster upgrades for on-premises Kubernetes clusters using Helm charts and kubeadm.',
            'Developed OPA Gatekeeper policy-as-code governance to enforce namespace compliance and admission control.',
            'Upgraded ArgoCD GitOps continuous delivery pipelines and integrated Dynatrace, Elasticsearch, and K9s for real-time cluster triage.',
            'Documented baseline As-Is and future-state To-Be container platform architectures.',
          ],
          'icon': Icons.security_outlined,
        },
        {
          'name': 'Lumen Technologies',
          'role': 'Google Cloud Architect · 2022',
          'sector': 'Telecommunications · Cloud FinOps & Hybrid Mesh',
          'categories': [
            'Cloud & CNCF K8s',
            'TOGAF & EA',
          ],
          'tags': [
            'GCP BigQuery FinOps',
            'GKE Metering',
            'Terraform (csvdecode)',
            'Traffic Director / Envoy',
            'Cloud SQL Auth Proxy',
            'ServiceNow Automation',
          ],
          'description': [
            'Delivered GKE Cluster Usage Metering into BigQuery and Data Studio FinOps dashboards, driving 20% multi-tenant cloud spend optimization.',
            'Implemented data-driven Terraform (csvdecode) automation to ingest ServiceNow reports and dynamically provision GCP projects and IAM.',
            'Architected hybrid on-prem to GCP connectivity using multi-NIC VPCs, Cloud SQL Auth Proxy, and Google Traffic Director with Envoy service mesh proxies.',
          ],
          'icon': Icons.analytics_outlined,
        },
        {
          'name': 'Vitu',
          'role': 'Google Cloud & Service Mesh Architect · 2022',
          'sector': 'Enterprise SaaS · Anthos & Microservices',
          'categories': [
            'Cloud & CNCF K8s',
          ],
          'tags': [
            'GCP Anthos',
            'Istio Service Mesh (ICA)',
            'GKE',
            'kube-state-metrics',
            'Cloud Monitoring',
            'Terraform',
          ],
          'description': [
            'Spearheaded enterprise rollout of GCP Anthos Istio Service Mesh to govern mTLS microservice security and hybrid traffic routing.',
            'Established a Single Pane of Glass observability solution integrating kube-state-metrics and Google Cloud Monitoring.',
            'Authored reusable Terraform and YAML infrastructure blueprints for GKE clusters, IAM governance, and disaster recovery.',
          ],
          'icon': Icons.lan_outlined,
        },
        {
          'name': 'MarshallsMind International',
          'role': 'Principal Technologist & Enterprise Architect · 2018–Present',
          'sector': 'Independent Systems Architecture & Multi-Cloud Advisory',
          'categories': [
            'TOGAF & EA',
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            '5-A TOGAF Framework',
            'Self-Managed Kubernetes',
            'Apache Airflow',
            'Prometheus & Grafana',
            'Terraform & Jenkins',
            'Multi-Cloud DR',
          ],
          'description': [
            'Delivered enterprise IT strategy roadmaps, cloud migrations, and systems integration across healthcare, finance, telecom, and government clients.',
            'Deployed hardened self-managed Kubernetes clusters on Ubuntu VMs running Apache Airflow, Prometheus, and Grafana via Helm charts.',
            'Architected multi-cloud disaster recovery, CI/CD automation (Jenkins, Terraform, GitHub Actions), and M365-to-Google Workspace transitions.',
          ],
          'icon': Icons.architecture_outlined,
        },
        {
          'name': 'Travelers Insurance',
          'role': 'AWS & Talend Data Integration Architect · 2020–2021',
          'sector': 'Enterprise Insurance · Serverless AWS ETL',
          'categories': [
            'Orchestration & ETL/ELT',
            'Cloud & CNCF K8s',
            'Finance & Insurance',
          ],
          'tags': [
            'AWS S3 / Glue / Athena',
            'Talend 7.3',
            'REST API Orchestration',
            'Athena DDL',
            'Automated Retry Engines',
          ],
          'description': [
            'Automated end-to-end multi-threaded REST API extraction pipelines in AWS using Talend 7.3 with fault-tolerant retry loops.',
            'Orchestrated data cleansing and transformation across AWS S3, AWS Glue, and Amazon Athena analytical tables.',
            'Formulated optimized Athena DDLs and validated API failure-recovery scenarios.',
          ],
          'icon': Icons.cloud_upload_outlined,
        },
        {
          'name': 'Deloitte / Motiva (Saudi Aramco)',
          'role': 'Independent Talend Big Data Consultant · 2020–2021',
          'sector': 'Enterprise Energy · Azure & Cloudera Big Data',
          'categories': [
            'Orchestration & ETL/ELT',
            'Cloud & CNCF K8s',
          ],
          'tags': [
            'Azure Data Factory (ADF)',
            'Talend Data Fabric (TAC)',
            'Azure Databricks',
            'Cloudera Hadoop / HDFS',
            'Azure SQL DWH',
          ],
          'description': [
            'Triaged complex data discrepancies across Azure Data Factory (ADF), Cloudera Hadoop (HUE/HDFS), Talend 7.3, and Azure SQL Data Warehouse.',
            'Administered Talend Data Fabric (TAC on Linux) for enterprise ETL orchestration.',
            'Authored the architectural refactoring roadmap for big data pipelines integrating Azure Data Lake and Databricks.',
          ],
          'icon': Icons.schema_outlined,
        },
        {
          'name': 'Otis Elevator',
          'role': 'Independent ERP Data Integration Consultant · 2020',
          'sector': 'Global Manufacturing · Enterprise ERP Consolidation',
          'categories': [
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'SAP HANA / BAPI / IDoc',
            'JD Edwards (JDE)',
            'BAAN ERP',
            'SQL Server 2017',
            'Talend Data Quality',
          ],
          'description': [
            'Migrated and consolidated global enterprise ERP data from SAP HANA (BAPI/IDoc), JD Edwards, and BAAN into a centralized SQL Server 2017 platform.',
            'Engineered automated reconciliation, subledger reporting, and schema compliance checks with built-in retry orchestration.',
          ],
          'icon': Icons.precision_manufacturing_outlined,
        },
        {
          'name': 'KPMG · U.S. Dept. of Housing (HUD)',
          'role': 'Talend & Azure Big Data Architect · 2019–2020',
          'sector': 'Federal Housing & Financial Data Engineering',
          'categories': [
            'Orchestration & ETL/ELT',
            'Cloud & CNCF K8s',
            'Federal & Defense',
            'Finance & Insurance',
          ],
          'tags': [
            'Azure Databricks',
            'Azure Blob Storage',
            'Azure SQL',
            'Talend Big Data',
            'Python / Jupyter',
          ],
          'description': [
            'Designed and delivered end-to-end Microsoft Azure integration pipelines ingesting 60+ multi-sheet Excel financial datasets into Azure Blob Storage and Azure Databricks two sprints ahead of schedule.',
            'Automated Databricks job execution and schema DDL provisioning for federal analysts.',
          ],
          'icon': Icons.domain_verification_outlined,
        },
        {
          'name': 'Maven Wave',
          'role': 'Google Cloud Engineer & Manager Consultant · 2018–2019',
          'sector': 'Enterprise Cloud Data Warehouse Modernization',
          'categories': [
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'Google BigQuery',
            'Cloud Composer / Airflow',
            'Netezza / Teradata Migration',
            'GKE / Kubernetes',
            'SSIS & .NET OAuth 2.0',
          ],
          'description': [
            'Translated and migrated legacy Netezza and Teradata SQL data warehouses into Google BigQuery using bq CLI and gsutil.',
            'Converted legacy Bash scripts into Python DAGs orchestrated on Google Cloud Composer (Apache Airflow) and GKE.',
            'Engineered OAuth 2.0 Adobe Analytics ingestion pipelines into SQL Server 2016.',
          ],
          'icon': Icons.storage_outlined,
        },
        {
          'name': 'U.S. Treasury · Office of Financial Research (OFR)',
          'role': 'IT Specialist & Lead ETL Architect · 2013–2018',
          'sector': 'Federal Financial Stability & Big Data Governance',
          'categories': [
            'Orchestration & ETL/ELT',
            'Federal & Defense',
            'Finance & Insurance',
          ],
          'tags': [
            'Talend Big Data (RHEL)',
            'SAS DI Studio & Base SAS',
            'Cloudera Hadoop / Hive',
            'SSIS 2012',
            'Kerberos & Splunk',
            'Metadata Audit DB',
          ],
          'description': [
            'Installed, configured, and accredited Talend Studio for Big Data Enterprise across hardened RHEL Linux and Windows servers integrated with Cloudera Hadoop/Hive.',
            'Administered the enterprise SAS Platform (SAS Data Integration Studio & Base SAS) and migrated legacy SSIS workflows.',
            'Architected metadata-driven audit databases, Talend AMC PostgreSQL telemetry, Kerberos ticket automation, and Splunk security logging.',
          ],
          'icon': Icons.policy_outlined,
        },
        {
          'name': 'Booz Allen Hamilton',
          'role': 'Lead Integration Engineer Consultant · 2012–2013',
          'sector': 'Federal Enterprise Architecture & Financial Data Stand-Up',
          'categories': [
            'TOGAF & EA',
            'Federal & Defense',
            'Finance & Insurance',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            '5-Year Federal EA Roadmaps',
            'SSIS & SQL Server',
            'SAS DI Studio',
            'DTCC / FINRA / LEI Feeds',
            'OCIO Strategy',
          ],
          'description': [
            'Led Phase I ETL stand-up for U.S. Treasury OFR data services, ingesting DTCC, FINRA, OptionMetrics, Lipper, LEI, and Markit financial feeds into SQL Server and metadata audit schemas.',
            'Authored 5-year Enterprise Architecture IT roadmaps for the Department of Labor OCIO and federal leadership.',
          ],
          'icon': Icons.timeline_outlined,
        },
        {
          'name': 'BAE Systems',
          'role': 'Lead Database Administrator · 2011–2012',
          'sector': 'Defense & National Security · High-Availability Data',
          'categories': [
            'Federal & Defense',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'SQL Server HA/DR (1TB+)',
            'Database Mirroring',
            'SSIS Consolidation',
            'Data Quality Metadata',
          ],
          'description': [
            'Engineered High-Availability (HA) Database Mirroring and disaster recovery for 1TB+ mission-critical SQL Server clusters.',
            'Consolidated distributed ad-hoc workflows into centralized SSIS pipelines with automated metadata data-quality auditing.',
          ],
          'icon': Icons.shield_outlined,
        },
        {
          'name': 'Mirixa Corporation',
          'role': 'Healthcare Data Operations Engineer · 2008–2011',
          'sector': 'Clinical Pharmacy & Healthcare Interoperability (HIPAA)',
          'categories': [
            'Healthcare & Public Health',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'CMS Medicare / Medicaid',
            'HL7 & FHIR Interoperability',
            'HIPAA Security Auditing',
            'Clinical Star Schema Marts',
            'SSIS / SSRS / .NET',
          ],
          'description': [
            'Automated ingestion of CMS (Medicare & Medicaid) and HL7/FHIR clinical EMR feeds using SSIS, SSRS, Stored Procedures, and .NET.',
            'Designed clinical Star Schema Data Marts and implemented HIPAA security audit logging to safeguard Protected Health Information (PHI).',
          ],
          'icon': Icons.medical_information_outlined,
        },
        {
          'name': 'Navy Federal Credit Union',
          'role': 'SQL Developer & Database Administrator · 2007–2008',
          'sector': 'Enterprise Banking & Financial Services',
          'categories': [
            'Finance & Insurance',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            '32 SQL Server Instances',
            'Transactional Replication',
            'Log Shipping & HA/DR',
            'DTS → SSIS Modernization',
          ],
          'description': [
            'Administered 32 production and non-production SQL Server instances, managing transactional replication, log shipping, and Double-Take HA/DR.',
            'Modernized legacy DTS packages into SQL Server Integration Services (SSIS) workflows and authored enterprise DBA SOPs.',
          ],
          'icon': Icons.account_balance_wallet_outlined,
        },
        {
          'name': 'General Dynamics · USCP · Public Health',
          'role': 'Programmer Analyst / Systems Engineer · 2000–2007',
          'sector': 'Defense Simulation, Capitol Police & Public Health Alerting',
          'categories': [
            'Federal & Defense',
            'Healthcare & Public Health',
          ],
          'tags': [
            'MH-53 Flight Simulator (UNIX / C / FORTRAN)',
            'U.S. Capitol Police (USCP)',
            'Public Health Alert Network',
            'ASP.NET & SQL Server',
          ],
          'description': [
            'Supported and debugged MH-53 helicopter flight simulator systems in C and FORTRAN on UNIX for the Naval Air Warfare Center (NAWCTSD).',
            'Delivered scheduling database systems and training for the United States Capitol Police (USCP).',
            'Engineered data-driven web alert portals for the Department of Public Health and the Health Alert Network.',
          ],
          'icon': Icons.radar_outlined,
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
