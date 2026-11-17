import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class Skill {
  final String name;
  final double experience;

  Skill({required this.name, required this.experience});
}

class ProfileData {
  static List<Skill> skills = [];

  static const List<Map<String, dynamic>> projects = [
    {
      'name': 'General Dynamics',
      'description': [
        'NAWCSTD MH-53 Triage Support',
        'Cold Fusion -> ASP refactor',
        'Windows System Administration',
        'USCP technical Training'
      ],
      'icon': Icons.settings, 
    },
    {
      'name': 'Lumen Technologies',
      'description': [
        'IaC Terraform Multi-Cloud',
        'GCP Platform Administration',
        'On-Prem Cloud Integration',
        'Container Triage'
      ],
      'icon': Icons.cloud, 
    },
    {
      'name': 'Coquina Systems',
      'description': [
        'AWS Google HA-VPN',
        'Google Workspace Migration',
        'Project Scoping'
      ],
      'icon': Icons.security, 
    },
    {
      'name': 'KPMG',
      'description': [
        'AWS Google HA-VPN',
        'Google Workspace Migration',
        'Project Scoping'
      ],
      'icon': Icons.security, 
    }
  ];

  static Future<void> loadSkills() async {
    try {
        final rawData = await rootBundle.loadString("assets/skills_experience.csv");
        List<List<dynamic>> listData = const CsvToListConverter().convert(rawData, eol: "\n");
        
        skills = [];
        // Skip header if present
        var rows = listData;
        if (rows.isNotEmpty && rows[0][0] == 'name') {
            rows = rows.sublist(1);
        }

        for (var row in rows) {
            if (row.length >= 2) {
                skills.add(Skill(
                    name: row[0].toString(),
                    experience: double.tryParse(row[1].toString()) ?? 0.5
                ));
            }
        }
    } catch (e) {
        debugPrint("Error loading skills: $e");
    }
  }

  static String getProfileContext() {
      StringBuffer sb = StringBuffer();
      sb.writeln("Projects:");
      for (var p in projects) {
          sb.writeln("- ${p['name']}: ${(p['description'] as List).join(', ')}");
      }
      sb.writeln("\nSkills:");
      for (var s in skills) {
          sb.writeln("- ${s.name} (${(s.experience * 100).toInt()}%)");
      }
      return sb.toString();
  }
}
