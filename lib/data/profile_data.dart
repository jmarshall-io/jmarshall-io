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
  // Complete 30+ Year Career Engagement History (1994 – Present) — 23 Chronological Engagements
  static List<Map<String, dynamic>> get projects => [
        {
          'name': 'CDC Foundation',
          'role': 'Systems Architect (Remote) · 01/2025 – Present',
          'location': 'Washington, DC (Remote)',
          'sector': 'Public Health & Regulated Healthcare Modernization',
          'logo': 'assets/logos/cdc-logo.png',
          'categories': [
            'Orchestration & ETL/ELT',
            'Healthcare & Public Health',
            'TOGAF & EA',
          ],
          'tags': [
            'Prefect 3.6.10',
            'dbt Medallion',
            'Pixi / Python 3.12',
            'Zero-Trust gMSA',
            'Grafana / Loki / Fluent Bit',
            'PowerShell DSC (LCM)',
            'GitHub Actions',
            'SQL Server Tuning',
            'Lucidchart / Visio',
          ],
          'description': [
            'Provided architectural strategy and technical advisory services to leadership supporting public health data modernization initiatives.',
            'Conducted comprehensive environmental assessments as part of a public health data modernization effort to right-size application, database, monitoring servers, and data governance infrastructure.',
            'Developed detailed architecture diagrams (As-Is → To-Be) using Lucidchart and Visio, facilitating clear visualization of system transitions for public health modernization.',
            'Architected a metadata-driven dbt Medallion Architecture bridge (Bronze → Silver → Gold), reducing new data source staging time by 80%.',
            'Orchestration & Runtime Strategy: Architected Prefect 3.6.10 pipelines on Windows by migrating legacy Conda/Pip dependencies to Pixi, enforcing deterministic Python 3.12 environments to guarantee exact synchronization between Development and Production tiers.',
            'Infrastructure Observability: Engineered a centralized Grafana, Loki, & Fluent Bit stack alongside SQL Server audit marts to establish comprehensive logging and performance monitoring for distributed on-premise services, cutting pipeline failures by 30%.',
            'DevSecOps Identity: Implemented gMSA (Group Managed Service Accounts) and dynamic Python object provisioning to enforce Zero-Trust, passwordless authentication for Windows workloads in Active Directory.',
            'Automated Infrastructure as Code (IaC) installations and environment state management (Prefect, Python) using PowerShell DSC (LCM), facilitating lifecycle automation (Build → Maintain → Destroy, and Backup → Restore).',
            'Defined and implemented GitHub best practices, advanced branching strategies, directory reorganization, and standardized project templates cutting engineer onboarding time by 40%.',
            'Provided Agile support including backlog grooming, planning, task automation, roadmap development, and dependency management for Data Engineering MVP workloads.',
            'Integrated comprehensive DevSecOps practices, conducting pre-flight checks, access validations, network drive verifications, and codebase refactoring with enhanced API return-code handling.',
            'Optimized database performance through strategic SQL performance tuning, indexing, partitioning, and alternate-route pipeline redundancy for high availability.',
            'Built unified PowerShell and GitHub Actions workflows integrated with event-driven Slack notifications to automate Continuous Deployment (CD) and rapid incident response.',
            'Researched, developed, and tested WSL Docker containerization and authored comprehensive Git and Agile training documentation for modernization teams.',
          ],
          'icon': Icons.hub_outlined,
        },
        {
          'name': 'MarshallsMind International',
          'role': 'Technologist | Enterprise Architect · 2018 – Present',
          'location': 'Remote / Contract / Self-Employed',
          'sector': 'Independent Systems Architecture & Multi-Cloud Advisory',
          'logo': 'assets/marshallsmind-logo.png',
          'categories': [
            'TOGAF & EA',
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            '5-A TOGAF Framework',
            'Self-Managed Kubernetes',
            'Apache Airflow DAGs',
            'Prometheus & Grafana',
            'Helm Charts',
            'Terraform & Jenkins',
            'GCP / AWS / Azure DR',
            'M365 → Google Workspace',
          ],
          'description': [
            'Developed comprehensive IT strategy documents and multi-year roadmaps for corporate IT aligned with long-term goals across healthcare, finance, technology, and government sectors.',
            'Collaborated with cross-functional IT teams across operations, security, and application development to ensure strategic alignment and smooth integration of enterprise architecture solutions.',
            'Delivered architecture and development services for clients including Lumen Technologies, Travelers, Delta Dental, Coquina Systems, and Vitu, focusing on scalable and secure IT infrastructure.',
            'Installed and configured hardened self-managed Kubernetes clusters on Ubuntu VMs, deploying Apache Airflow, Grafana, and Prometheus using Helm charts.',
            'Designed and managed Apache Airflow DAGs for enterprise ETL workflows with resource quotas, high availability, fault tolerance, and real-time Prometheus/Grafana anomaly detection.',
            'Deployed, managed, and hardened Kubernetes clusters and cloud lifecycle processes across Google Cloud, AWS, and Azure environments.',
            'Deployed CI/CD pipelines using Jenkins and Terraform to streamline development and deployment of enterprise applications.',
            'Implemented multi-cloud disaster recovery solutions to ensure business continuity and resiliency while optimizing for cost and operational efficiency.',
            'Led mailbox and collaboration migrations from Microsoft 365 (O365) to Google Workspace and legacy-to-cloud data migrations with end-to-end validation and compliance.',
          ],
          'icon': Icons.architecture_outlined,
        },
        {
          'name': 'Coquina Systems',
          'role': 'Google Workspace Admin / Cloud Architect · 10/2023 – 07/2024',
          'location': 'Washington, DC (Remote)',
          'sector': 'Multi-Cloud Infrastructure & Large-Scale Migration',
          'logo': 'assets/logos/coquina-systems.png',
          'categories': [
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
            'TOGAF & EA',
          ],
          'tags': [
            'AWS ↔ GCP HA VPN',
            'Azure ↔ GCP HA VPN',
            'Terraform / Bash / Python',
            'Google Workspace (9,850 Users)',
            'GAMADV-XTD & GWMME',
            'AWS Redshift & Glue',
            'Parquet / S3 Endpoints',
          ],
          'description': [
            'Spearheaded Hands-on Migration: Executed a high-velocity hybrid migration from Microsoft 365 / Exchange to Google Workspace for approximately 9,850 total user mailboxes (2,171 Staff and 7,679 Students) with minimal disruption.',
            'Set up High-Availability (HA) VPN Tunnels between AWS and GCP, and created Lucidchart enterprise architectural diagrams depicting Azure and GCP HA VPN endpoint integration.',
            'Documented environments using Terraform, Bash, and Python, providing markdown-based technical documentation with reproducible command examples.',
            'Set up AWS Redshift and AWS Glue for ETL processes loading data in Parquet format; resolved HTTP request errors during AWS Glue execution by diagnosing VPC routing and configuring Amazon S3 gateway endpoints.',
            'Configured and deployed GAMADV-XTD for advanced Google Workspace administration and automated lifecycle tasks.',
            'Configured Google Workspace Migration for Microsoft Exchange (GWMME) and Google Migrate POCs for on-prem to Google Cloud transitions.',
            'Developed and enforced Google Workspace security, compliance, directory service, and governance policies across Gmail, Drive, Calendar, and Meet.',
            'Led triage efforts, IT technology research, and technical pre-sales scoping supporting reseller proposals across Google Cloud, Azure, and AWS.',
          ],
          'icon': Icons.cloud_sync_outlined,
        },
        {
          'name': 'Federal Railroad Administration | U.S. DOT (FRA)',
          'role': 'Enterprise Architect (Remote) · 07/2023 – 07/2024',
          'location': 'Washington, DC',
          'sector': 'Federal Transportation · TOGAF & FISMA Governance',
          'logo': 'assets/logos/fra-dot.png',
          'categories': [
            'TOGAF & EA',
            'Federal & Defense',
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'TOGAF',
            'FISMA Compliance',
            'Azure Data Factory (ADF)',
            'Power Automate',
            'Azure AD / Entra ID',
            'BPMN (Visio / Lucidchart)',
            'SharePoint & Confluence',
            'CDO AI & Data Governance',
          ],
          'description': [
            'Captured and categorized Federal Railroad logical, physical, and technology components in compliance with FISMA (Federal Information Security Management Act), utilizing TOGAF best practices to support IT infrastructure planning.',
            'Developed SharePoint lists and lookups to represent data, application, and technology components for ATIP, MERMEC, ENSCO, FRA HOSTS, and FRA DYNAMICS systems.',
            'Leveraged GitBash to traverse FRA repositories to create application architectural views, ensuring clear visibility of system infrastructure and data integration across Microsoft Azure environments.',
            'Supported the design and automation of Azure Data Factory (ADF) workflows and created Power Automate flows to streamline Standard Operating Procedures (SOPs).',
            'Created BPMN diagrams for system process flows using Visio, SmartDraw, and Lucidchart to standardize integration across Azure/Microsoft environments.',
            'Established an FRA Data Management SharePoint site and facilitated data lifecycle management policies in alignment with the FRA Chief Data Office (CDO).',
            'Designed and implemented Azure AD identity management for the Business Intelligence Service (PaaS), ensuring secure access control between on-premise and cloud environments.',
            'Created a centralized Confluence governance portal for the Data CDO aligned with Federal Government AI best practices and the White House Executive Order on Safe, Secure, and Trustworthy AI.',
          ],
          'icon': Icons.account_balance_outlined,
        },
        {
          'name': 'Delta Dental Michigan',
          'role': 'Kubernetes Platform Engineer (Remote) · 04/2022 – 10/2022',
          'location': 'Washington, DC (Remote)',
          'sector': 'Healthcare Insurance · CNCF Platform Engineering',
          'logo': 'assets/logos/delta-dental-mi.png',
          'categories': [
            'Cloud & CNCF K8s',
            'Healthcare & Public Health',
          ],
          'tags': [
            'On-Prem Kubernetes',
            'Helm & kubeadm',
            'ArgoCD GitOps',
            'OPA Gatekeeper',
            'Dynatrace & Elasticsearch',
            'K9s & Bash',
            'Docker & Artifactory',
            'SAFe Agile',
          ],
          'description': [
            'Supported day-to-day KTLO (Keep The Lights On) operations for on-premises Kubernetes clusters, ensuring platform stability, security, and ongoing development.',
            'Upgraded Kubernetes clusters using Helm charts, Bash scripts, and kubeadm, improving platform security and operational efficiency.',
            'Performed upgrades of ArgoCD clusters using Helm charts to ensure continuous delivery pipelines remained effective and up to date.',
            'Developed a Proof of Concept (POC) for OPA Gatekeeper integration, establishing policy-as-code governance and admission compliance across Kubernetes infrastructure.',
            'Leveraged Dynatrace, Elasticsearch, K9s, and Kubernetes Dashboard for monitoring, observability, and real-time cluster triage.',
            'Created Docker images and managed containers using Artifactory for seamless image storage and retrieval.',
            'Collaborated with engineering teams using SAFe Agile methodologies and documented current baseline (As-Is) and recommended future-state (To-Be) architectures.',
          ],
          'icon': Icons.security_outlined,
        },
        {
          'name': 'Lumen Technologies',
          'role': 'Google Cloud Architect (Remote) · 01/2022 – 07/2022',
          'location': 'Washington, DC (Remote)',
          'sector': 'Telecommunications · Cloud FinOps & Hybrid Mesh',
          'logo': 'assets/logos/lumen.png',
          'categories': [
            'Cloud & CNCF K8s',
            'TOGAF & EA',
          ],
          'tags': [
            'GKE Usage Metering',
            'BigQuery & Data Studio FinOps',
            'Terraform (csvdecode)',
            'ServiceNow Automation',
            'Traffic Director & Envoy',
            'Cloud SQL Auth Proxy',
            'GCP ↔ Azure IAM / AD',
          ],
          'description': [
            'Delivered GKE Cluster Usage Metering to monitor resource consumption across multi-tenant environments using BigQuery, providing critical insights for FinOps, budgeting, capacity planning, and cost optimization via Google Data Studio.',
            'Provided Platform Support SRE (Site Reliability Engineering) for Google Cloud services and KTLO initiatives.',
            'Implemented data-driven Terraform integration to provision GCP project creation based on ServiceNow CSV report extraction, leveraging the Terraform csvdecode function for dynamic automated provisioning.',
            'Set up VPCs and configured network connectivity between on-premise infrastructure and GCP using multi-NIC configurations.',
            'Configured a VM with Google Cloud SQL Auth Proxy as a reverse proxy to enable secure, encrypted connections to Google Cloud SQL from both GCP and on-prem infrastructure.',
            'Set up a Proof of Concept (POC) configuration of Google Traffic Director with Envoy as part of a Google Cloud Service Mesh, serving as a reverse proxy between on-prem and Class-E network spaces.',
            'Automated Google Cloud Asset Inventory management using Google Cloud Foundation Toolkit, Terraform, Cloud Shell, Bash, and Python.',
            'Developed Terraform scripts for Azure AD User and Group creation and managed multi-cloud IAM across GCP and Azure environments.',
          ],
          'icon': Icons.analytics_outlined,
        },
        {
          'name': 'Vitu',
          'role': 'Google Cloud Architect (Remote) · 01/2022 – 03/2022',
          'location': 'Washington, DC (Remote)',
          'sector': 'Enterprise SaaS · Anthos & Istio Service Mesh',
          'logo': 'assets/logos/vitu-dmvdesk.png',
          'categories': [
            'Cloud & CNCF K8s',
          ],
          'tags': [
            'GCP Anthos',
            'Istio Service Mesh',
            'GKE & FinOps',
            'kube-state-metrics',
            'Cloud Monitoring',
            'Terraform & YAML',
            'Single Pane of Glass Logging',
          ],
          'description': [
            'Spearheaded the rollout of GCP Anthos Istio Service Mesh, enhancing service-to-service communication, mTLS security, and systems integration between on-premise infrastructure and Google Cloud in a microservices environment.',
            'Set up a Proof of Concept (POC) for GCP centralized logging within the test environment, utilizing Jira, Confluence, Lucidchart, and Gliffy to produce architectural diagrams while integrating IAM best practices.',
            'Developed a POC for GCP FinOps automated billing for projects, streamlining cost tracking across GKE and Data Studio for visualization and disaster recovery planning.',
            'Integrated kube-state-metrics for granular metrics capture and created monitoring graphs with native Google Cloud Monitoring tools.',
            'Established a Single Pane of Glass logging solution, centralizing log collection and monitoring across GCP services using Bash, Python, and YAML.',
            'Created Terraform scripts and YAML manifests to automate deployment, management, and lifecycle of GKE clusters, IAM, FinOps, and disaster recovery.',
          ],
          'icon': Icons.lan_outlined,
        },
        {
          'name': 'Travelers Insurance',
          'role': 'Talend Developer (Remote) · 08/2020 – 02/2021',
          'location': 'Remote (6 Months)',
          'sector': 'Enterprise Insurance · Serverless AWS ETL & APIs',
          'logo': 'assets/logos/travelers.png',
          'categories': [
            'Orchestration & ETL/ELT',
            'Cloud & CNCF K8s',
            'Finance & Insurance',
          ],
          'tags': [
            'Talend 7.3',
            'AWS S3 / Glue / Athena',
            'REST API Retry Engines',
            'tRestClient / tParallelize',
            'Athena DDL',
            'Postman API Validation',
            'Rally Agile',
          ],
          'description': [
            'Automated end-to-end processing of REST API calls (POST/GET) in an AWS environment using Talend 7.3 components with retry logic and built-in redundancy for handling API call failures.',
            'Used Talend components including tRest, tRestClient, tS3List, tS3Put, tS3Get, tParallelize, tMap, tJava, tSubJob, tLoop, and tFlowMeter to manage data flow and API interactions with AWS S3, Glue, and Athena.',
            'Integrated AWS Glue for ETL orchestration to clean, transform, and load data into Amazon Athena tables for querying and analysis.',
            'Implemented fault-tolerant retry loops using tLoop, tJava, and tFlowMeter to retry failed API calls until valid HTTP return codes were received.',
            'Used Postman to validate API calls and simulate error conditions to guarantee zero process interruption during connectivity issues.',
            'Formulated DDLs (Data Definition Language) for Athena table creation and merged/cleansed delimited files across S3 buckets.',
            'Coordinated with offshore resources and tracked milestones using Rally within an Agile environment.',
          ],
          'icon': Icons.cloud_upload_outlined,
        },
        {
          'name': 'Deloitte, Motiva',
          'role': 'Independent Talend Big Data Consultant · 11/2020 – 01/2021',
          'location': 'Remote / Contract (3 Months)',
          'sector': 'Enterprise Energy · Azure & Cloudera Big Data',
          'logo': 'assets/logos/deloitte.png',
          'categories': [
            'Orchestration & ETL/ELT',
            'Cloud & CNCF K8s',
          ],
          'tags': [
            'Talend Data Fabric (TAC)',
            'Azure Data Factory (ADF)',
            'Azure Data Lake & Databricks',
            'Azure SQL DWH',
            'Cloudera Hadoop / HUE / HDFS',
            'tPigLoad / tHDFSInput',
          ],
          'description': [
            'Oversaw and advised management on potential roadblocks and risks within the enterprise data integration lifecycle.',
            'Triaged data discrepancies within Azure and Hadoop pipelines using HUE, Azure Data Factory (ADF), Talend 7.3, and SQL.',
            'Administered Talend Data Fabric using Talend Administration Center (TAC) on Linux, ensuring seamless orchestration of ETL processes.',
            'Advised and architected a roadmap for refactoring Talend code based on industry best practices for optimal performance and scalability.',
            'Utilized tAzureStorageInput, tAzureStorageOutput, tAzureSQLInput, and tAzureSQLDWH for connectivity with Azure Data Lake and Databricks.',
            'Leveraged tHDFSInput, tHDFSOutput, tMap, and tPigLoad to process and integrate data into Hadoop and Cloudera environments.',
            'Operationalized and automated capture of key operational metrics using Talend, SQL, and custom reporting solutions, and authored technical documentation using SnagIt and Office 365.',
          ],
          'icon': Icons.schema_outlined,
        },
        {
          'name': 'Otis Elevator',
          'role': 'Independent Talend Consultant (Remote) · 07/2020 – 10/2020',
          'location': 'Remote / Contract (3 Months)',
          'sector': 'Global Manufacturing · Enterprise ERP Consolidation',
          'logo': 'assets/logos/otis.jpeg',
          'categories': [
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'SAP HANA / BAPI / IDoc',
            'JD Edwards (JDE)',
            'BAAN ERP',
            'SQL Server 2017',
            'Talend Data Quality',
            'Subledger Reconciliation',
          ],
          'description': [
            'Migrated ERP data from JD Edwards, BAAN, and SAP systems into the Talend data platform, aligning with enterprise IT strategy and system integration goals.',
            'Centralized ETL processes using Talend tMap, tJoin, tFilterRow, tAggregateRow, and tSchemaComplianceCheck to ensure data quality and compliance across systems.',
            'Integrated SQL Server components (tSQLServerInput, tSQLServerOutput, tFlowToIterate) to handle data migration into SQL Server 2017 for subledger reporting and data reconciliation.',
            'Established retry logic using tFlowMeter, tLogCatcher, and tRetry to handle errors during ETL execution.',
            'Utilized Talend SAP components to ensure smooth integration of SAP HANA, BAPI, and IDoc processes across disparate platforms.',
            'Performed reconciliation and data quality tasks using Talend Data Quality, SQL Server, and Talend Data Fabric.',
          ],
          'icon': Icons.precision_manufacturing_outlined,
        },
        {
          'name': 'MarshallsMind Int’l LLC (GCP Streaming & KMS)',
          'role': 'Data Management | Google Cloud Architect · 01/2020 – 07/2020',
          'location': 'Remote / Contract (6 Months)',
          'sector': 'Cloud Streaming Data Pipelines & Infrastructure Security',
          'logo': 'assets/marshallsmind-logo.png',
          'categories': [
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'GCP Pub/Sub',
            'Google Cloud Dataflow',
            'BigQuery Streaming',
            'Cloud KMS Encryption',
            'Cloud Storage Lifecycle',
            'Managed Instance Groups',
            'YAML IaC',
          ],
          'description': [
            'Constructed a real-time streaming data pipeline using GCP Pub/Sub, Dataflow, and BigQuery for handling high-volume data ingestion, transformation, and analysis.',
            'Implemented lifecycle management for Google Cloud Storage classes, optimizing storage usage and cost based on data access frequency.',
            'Configured and managed Encryption Keys using Google Cloud Key Management Service (KMS) to ensure secure data encryption and protection.',
            'Designed and deployed Load-Balanced Managed Instance Groups on Google Cloud Platform (GCP) to ensure high availability and scalability.',
            'Used YAML for defining GCP Infrastructure as Code to streamline deployment and management of cloud resources.',
          ],
          'icon': Icons.stream_outlined,
        },
        {
          'name': 'KPMG, GreenKey LLC | U.S. Dept. of Housing (HUD)',
          'role': 'Talend Big Data Architect Consultant · 07/2019 – 01/2020',
          'location': 'Tysons Corner / McLean, VA (Partial Remote)',
          'sector': 'Federal Housing & Financial Data Engineering',
          'logo': 'assets/logos/kpmg.png',
          'categories': [
            'Orchestration & ETL/ELT',
            'Cloud & CNCF K8s',
            'Federal & Defense',
            'Finance & Insurance',
          ],
          'tags': [
            'Azure Databricks',
            'Azure Blob Storage',
            'Azure SQL Database',
            'Talend Big Data',
            'Python / Jupyter Notebooks',
            'JDBC & Outlook 360 Ingestion',
          ],
          'description': [
            'Designed, developed, and implemented end-to-end systems integration solutions to ingest Excel data files from Outlook 360 mailboxes using Talend components (tPOP, tFileInputMail, tFileInputExcel).',
            'Successfully ingested 60+ raw Excel file sheets with embedded tabs into the enterprise Azure Data Lake using tAzureBlobInput and tFileOutputDelimited, delivering results two sprints (2 months) ahead of schedule.',
            'Developed Talend jobs to parse multi-sheet Excel files into flat files and publish to Azure Blob Storage (tAzureBlobStorageConnection, tAzureBlobOutput).',
            'Published data from flat files to Azure Databricks (tAzureDatabricksOutput) and created schema DDLs in Databricks notebooks (tDatabricksConnection) for enterprise analysts.',
            'Managed and orchestrated Azure Databricks jobs within Talend using tAzureDatabricksJobRun and tAzureDatabricksNotebook to run Python-based transformations in Jupyter Notebooks.',
            'Queried and integrated Azure SQL Databases and external databases using tAzureSQLConnection, tAzureSQLInput, tJDBCInput, and tJDBCOutput.',
          ],
          'icon': Icons.domain_verification_outlined,
        },
        {
          'name': 'Maven Wave',
          'role': 'Google Cloud Engineer / Manager Consultant · 2018 – 2019',
          'location': 'Chicago, IL (Full Remote / Travel)',
          'sector': 'Enterprise Cloud Data Warehouse Modernization',
          'logo': 'assets/logos/maven-wave.png',
          'categories': [
            'Cloud & CNCF K8s',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'Google BigQuery (bq CLI)',
            'Netezza & Teradata Migration',
            'Cloud Composer / Airflow',
            'Kubernetes (GKE) & YAML',
            'Google Cloud Storage (gsutil)',
            'Adobe Analytics OAuth 2.0',
            'SSIS / .NET / SQL Server 2016',
          ],
          'description': [
            'Translated and migrated SQL Netezza queries into Google BigQuery syntax for ingestion into cloud data warehouses from Teradata.',
            'Utilized BigQuery bq CLI commands and gsutil to create, load, and extract data between Google Cloud Storage (with least-privilege IAM) and on-prem environments.',
            'Converted Bash scripts into Python for Apache Airflow ingestion and constructed DAGs orchestrated via Google Cloud Composer and YAML configurations.',
            'Deployed, monitored, and managed scalable VM and Kubernetes clusters, including pod configurations written in YAML.',
            'Designed an end-to-end application solution leveraging SSIS, .NET, and PowerShell to integrate and load Adobe Analytics API endpoints, capturing impression and conversion data into SQL Server 2016 data warehouses via OAuth 2.0 and Google App Engine.',
            'Delivered digital demos and technical documentation using Camtasia screencasting software for client communication and training.',
          ],
          'icon': Icons.storage_outlined,
        },
        {
          'name': 'Office of Financial Research (OFR) | U.S. Treasury',
          'role': 'IT Specialist / Lead ETL Developer · 2013 – 2018',
          'location': 'Washington, DC (Partial Telecommute)',
          'sector': 'Federal Financial Stability & Big Data Governance',
          'logo': 'assets/logos/ofr.jpeg',
          'categories': [
            'Orchestration & ETL/ELT',
            'Federal & Defense',
            'Finance & Insurance',
          ],
          'tags': [
            'Talend Big Data (RHEL 6 / Win 2012)',
            'Cloudera Hadoop & Hive',
            'SAS DI Studio & Base SAS',
            'SSIS 2012 & SQL Server 2012',
            'Kerberos Authentication',
            'Splunk Security Auditing',
            'Talend AMC & PostgreSQL',
            'Data Quality & Stewardship Portal',
          ],
          'description': [
            'Installed and configured Talend Studio for Big Data Enterprise for federal accreditation in Linux (RedHat 6) and Windows 2012 environments (supporting versions 5.5, 5.6, 6.01, and 6.2).',
            'Integrated Talend Studio with Cloudera Hadoop and Hive, architected dynamic data-driven loads using implicit context variables across XML, CSV, and RDBMS sources.',
            'Researched and implemented Kerberos ticketing authentication and automation frameworks for Talend Data Integration execution servers across hybrid Windows and Linux environments.',
            'Migrated and translated SSIS jobs to SAS jobs utilizing SAS Data Integration Studio, and administered the SAS Platform with Base SAS, shell scripting, and SAS ODS reporting.',
            'Developed a mobile reporting solution for iPhone users using Base SAS and HTML5, referencing published SAS ODS mobile reporting white papers.',
            'Led implementation of a custom metadata audit database for tracking SAS data feeds, and utilized SSIS 2012 data profiling components to capture enterprise KPIs.',
            'Integrated Talend with Splunk for security event logging and deployed Talend Activity Monitoring Console (AMC) backed by PostgreSQL.',
            'Configured and implemented the Data Quality Portal and Data Stewardship Console, and created training tutorials using SnagIt 12 and XMind.',
          ],
          'icon': Icons.policy_outlined,
        },
        {
          'name': 'Booz Allen Hamilton',
          'role': 'Lead Integration Engineer Consultant · 2012 – 2013',
          'location': 'Washington, DC',
          'sector': 'Federal Enterprise Architecture & Financial Data Stand-Up',
          'logo': 'assets/logos/booz-allen.png',
          'categories': [
            'TOGAF & EA',
            'Federal & Defense',
            'Finance & Insurance',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            '5-Year Federal EA Roadmaps',
            'U.S. Dept. of Labor OCIO',
            'U.S. Treasury OFR Stand-Up',
            'DTCC / FINRA / LEI / Markit',
            'SSIS & SQL Server 2008 R2',
            'SAS Data Integration Studio',
            'Visio Data-Driven Smart Shapes',
          ],
          'description': [
            'Led ETL development for the Phase I stand-up of the Office of Financial Research (OFR) data services using SSIS and SQL Server.',
            'Analyzed, inspected, loaded, and restructured complex financial datasets from XML and CSV sources including DTCC, FINRA, OptionMetrics, Lipper, LEI, and Markit into a metadata audit database.',
            'Assisted in standing up SAS Data Integration Studio for ingestion of financial data into SQL Server 2008 R2.',
            'Played a key role in developing and implementing a 5-year IT roadmap for enterprise architecture addressing system integration, application architecture, and infrastructure improvements.',
            'Utilized Visio data-driven smart shapes to assist in developing a strategic 5-year IT roadmap for the Department of Labor Office of the Chief Information Officer (OCIO), defining initiatives for system upgrades and disaster recovery.',
            'Collaborated with security teams to ensure data governance and published architectural documentation on Confluence and SharePoint.',
          ],
          'icon': Icons.timeline_outlined,
        },
        {
          'name': 'BAE Systems',
          'role': 'Lead Database Administrator · 2011 – 2012',
          'location': 'Washington, DC',
          'sector': 'Defense & National Security · High-Availability Data',
          'logo': 'assets/logos/bae-systems.png',
          'categories': [
            'Federal & Defense',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'SQL Server 2008 R2 HA/DR',
            '1TB+ Database Tuning',
            'Database Mirroring',
            'SSIS Centralization',
            'Data Quality Metadata Framework',
          ],
          'description': [
            'Implemented high availability solutions using Database Mirroring in SQL Server 2008 R2, ensuring uninterrupted data access and operational continuity for mission-critical applications.',
            'Maintained, optimized, and tuned 1+ terabyte databases, improving performance, query efficiency, and storage management for enterprise-level operations.',
            'Reconfigured database backup and restore processes to align with Microsoft best practices, bolstering data security and disaster recovery readiness.',
            'Centralized ETL processes using SSIS, consolidating previously distributed and ad-hoc workflows into streamlined, automated pipelines.',
            'Developed a metadata framework and SQL Server stored procedures to perform automated data quality checks and enforce data governance.',
          ],
          'icon': Icons.shield_outlined,
        },
        {
          'name': 'Mirixa Corporation',
          'role': 'Data Operations Engineer · 2008 – 2011',
          'location': 'Reston, VA',
          'sector': 'Clinical Pharmacy & Healthcare Interoperability (HIPAA)',
          'logo': 'assets/logos/mirixa-corp.png',
          'categories': [
            'Healthcare & Public Health',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            'CMS Medicare / Medicaid',
            'HL7 & FHIR Interoperability',
            'EMR & PHI Protection',
            'HIPAA Security Auditing',
            'Star Schema Data Mart',
            'SSIS / SSRS / .NET / Automate 6',
          ],
          'description': [
            'Automated the ingestion of CMS (Centers for Medicare and Medicaid Services) data feeds using Network Automate 6, SSIS, SSRS, Stored Procedures, and .NET Framework, streamlining critical healthcare and HL7 data flows.',
            'Implemented security audit logging using SSIS, SSMS, and SSIS expressions, safeguarding Protected Health Information (PHI), ensuring HIPAA compliance, and restricting unauthorized access.',
            'Led the design of a Data Mart Star Schema for CMS reporting, enabling compliant reporting of healthcare metrics for Medicare and Medicaid services.',
            'Triaged, optimized, and debugged large incremental patient data loads within the data warehouse, improving scalability for healthcare analytics.',
            'Authored technical documentation detailing standards and guidelines for Electronic Medical Records (EMR), data governance, backup, and disaster recovery.',
            'Provided key contributions in managing healthcare systems integration using standardized interoperability formats including HL7 and FHIR.',
          ],
          'icon': Icons.medical_information_outlined,
        },
        {
          'name': 'Navy Federal Credit Union (NFCU)',
          'role': 'SQL Developer and Database Administrator · 2007 – 2008',
          'location': 'Washington, DC',
          'sector': 'Enterprise Banking & Credit Union Database Operations',
          'logo': 'assets/logos/nfcu.png',
          'categories': [
            'Finance & Insurance',
            'Orchestration & ETL/ELT',
          ],
          'tags': [
            '32 SQL Server 2000/2005 Instances',
            'DTS → SSIS Modernization',
            'Transactional Replication',
            'Log Shipping & Double-Take DR',
            'Data Warehouse Conversion',
            'DBA SOPs & Governance',
          ],
          'description': [
            'Administered 32 SQL Server 2000/2005 instances, ensuring stable and efficient database operations across production and non-production environments in alignment with IT strategy.',
            'Developed data conversion and migration routines using SQL Server utilities to support seamless transitions across data warehouse environments.',
            'Managed data distribution and replication across databases and replication servers, ensuring data integrity, data governance, and high availability for mission-critical banking applications.',
            'Installed, configured, and upgraded databases from MS SQL Server 2000 to MS SQL Server 2005, implementing best practices for data management and scalability.',
            'Converted DTS packages from SQL Server 2000 to SSIS packages in SQL Server 2005, modernizing ETL processes and improving data integration workflows.',
            'Implemented high availability and disaster recovery solutions including Log Shipping, Transactional Replication, and Double-Take to ensure business continuity and minimal downtime.',
            'Developed Standard Operating Procedures (SOPs) for database administration, development, and data process workflows.',
          ],
          'icon': Icons.account_balance_wallet_outlined,
        },
        {
          'name': 'General Dynamics',
          'role': 'Programmer Analyst (05–07) · Engineer I (01–05) · Web Dev (00–01) · 2000 – 2007',
          'location': 'Washington, DC · Virginia Beach, VA · Hartford, CT (7 Years)',
          'sector': 'Defense Simulation, U.S. Capitol Police & Public Health Systems',
          'logo': 'assets/logos/general-dynamics.png',
          'categories': [
            'Federal & Defense',
            'Healthcare & Public Health',
            'Orchestration & ETL/ELT',
            'Early Career & Telecom (1994–2007)',
          ],
          'tags': [
            'U.S. Capitol Police (USCP)',
            'MH-53 Flight Simulator (UNIX / C / FORTRAN)',
            'NAWCTSD Naval Aviation',
            'Dept. of Public Health Alert Network',
            'SQL Server 2000 Self-Correcting Agent',
            'ASP.NET 1.1 / IIS 5.0 / ColdFusion',
          ],
          'description': [
            '[Programmer Analyst · 2005–2007] Delivered training sessions on scheduling software usage and best practices to the United States Capitol Police (USCP), installing client software and authoring comprehensive technical documentation.',
            '[Programmer Analyst · 2005–2007] Orchestrated and scheduled self-correcting SQL Server 2000 Agent tasks, and performed testing, debugging, and daily backup maintenance on Windows NT/2000 platforms.',
            '[Engineer I · 2001–2005] Supported, scripted, and debugged the MH-53 helicopter flight simulator using C and FORTRAN in a UNIX environment, ensuring accurate simulation performance.',
            '[Engineer I · 2001–2005] Revamped intranet applications for the Naval Air Warfare Center Training Systems Division (NAWCTSD) using ASP, IIS 5.0, and Access 2000 (transitioning from ColdFusion), and developed .NET 1.1 / ASP.NET data-grid UI dashboards tied to SQL Server to mine Naval Air Warfare inventory data.',
            '[Web Developer · 2000–2001] Designed and deployed data-driven web pages for the Department of Public Health and the Health Alert Network using CSS, ASP, HTML, JavaScript, and Paint Shop Pro v6 to enable rapid receipt and broadcast of urgent state and local health alerts.',
          ],
          'icon': Icons.radar_outlined,
        },
        {
          'name': 'Technical Marketing Systems',
          'role': 'Web Developer · 1999',
          'location': 'New Milford, CT',
          'sector': 'Commercial Web & Intranet Application Development',
          'categories': [
            'Early Career & Telecom (1994–2007)',
          ],
          'tags': [
            'ColdFusion',
            'Lotus Notes',
            'FrontPage 98',
            'Internet Scripting',
            'E-Commerce Frontend',
          ],
          'description': [
            'Developed intranet and internet sites using FrontPage 98, ColdFusion, and Lotus Notes, meeting client requirements for internal and external web functionality.',
            'Expanded the use of internet scripting and web tools, contributing to improved interactivity and functionality across client websites.',
            'Updated Inter/Intranet web pages based on client requests, ensuring timely and accurate content updates in alignment with business goals.',
            'Created the front-end e-commerce showcase website for Claddagh rings, enhancing online presence and sales platform capabilities.',
          ],
          'icon': Icons.language_outlined,
        },
        {
          'name': 'United Health Care (UnitedHealth Group)',
          'role': 'Systems Consultant (Intern) · May 1999 – Sept 1999',
          'location': 'Hartford, CT',
          'sector': 'Enterprise Healthcare Information Services',
          'logo': 'assets/logos/UnitedHealthGroup.jpeg',
          'categories': [
            'Healthcare & Public Health',
            'Early Career & Telecom (1994–2007)',
          ],
          'tags': [
            'Channel Point Project',
            'Access 97 Beta Validation',
            'Microsoft Visio Diagrams',
            'IIS & FrontPage Intranet',
            'HTML / CSS / TextPad',
          ],
          'description': [
            'Developed and maintained intranet sites for the Information Services department using TextPad, HTML, and CSS, ensuring efficient internal communication and resource sharing.',
            'Assisted in Beta testing and validating Access 97 databases, contributing to the successful rollout of key departmental projects.',
            'Worked on the Channel Point project, participating in beta testing of internal tools and database functionalities to optimize data management.',
            'Utilized Microsoft FrontPage and IIS (Internet Information Services) to manage and deploy intranet pages and issue operational alerts.',
            'Maintained Excel spreadsheets and created workflow diagrams and web architecture diagrams using Microsoft Visio for project stakeholders.',
          ],
          'icon': Icons.local_hospital_outlined,
        },
        {
          'name': 'WCSU University Computing (Western Connecticut State Univ.)',
          'role': 'Help Desk & Network Support · Jan 1997 – Jan 1999',
          'location': 'Danbury, CT',
          'sector': 'Higher Education Campus IT, PBX Telecom & ResNet IP Networking',
          'logo': 'assets/logos/wcsu.jpeg',
          'categories': [
            'Early Career & Telecom (1994–2007)',
          ],
          'tags': [
            'Windows NT Campus IT',
            'ResNet IP Networking',
            'PBX Telecom Switchroom',
            'Hardware & Software Triage',
            'Network SLA Optimization',
          ],
          'description': [
            'Provided comprehensive technical support to faculty, university staff, and students within a Windows NT environment across campus.',
            'Collaborated with university professors and administrative staff on software installation, troubleshooting, and network connectivity.',
            'Worked in the PBX telecommunications room, assisting with testing and maintaining dormitory phone lines and resolving communication system issues.',
            'Assisted with IP networking, including installation and configuration of network connections across university buildings as part of the ResNet campus network.',
            'Played a key role in configuring and maintaining network infrastructure and establishing network service levels for long-term campus IT sustainability.',
          ],
          'icon': Icons.settings_ethernet_outlined,
        },
        {
          'name': 'Southern New England Telecommunications (SNET)',
          'role': 'Telecommunications Intern · Summer 1994 – 1995',
          'location': 'New England, CT, USA',
          'sector': 'Telecommunications & Mobile Hardware Rollout',
          'logo': 'assets/logos/snet.png',
          'categories': [
            'Early Career & Telecom (1994–2007)',
          ],
          'tags': [
            'Motorola StarTAC Mobile',
            'Telecom Network Plans',
            'Pager & Wireless Rollout',
            'Customer Engineering Foundation',
          ],
          'description': [
            'Attended regional fairs and events to promote and sell telephones, Motorola StarTAC mobile phones, pagers, and telecommunication service plans.',
            'Engaged with prospective customers by explaining telecommunication network plans and emerging mobile and pager technologies.',
            'Built a foundational customer-centric communication and telecommunications perspective supporting a 30+ year career in systems engineering and enterprise architecture.',
          ],
          'icon': Icons.cell_tower_outlined,
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
