import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:jmarshall_io/l10n/app_localizations.dart';

class HudHeader extends StatefulWidget {
  const HudHeader({super.key});

  @override
  State<HudHeader> createState() => _HudHeaderState();
}

class _HudHeaderState extends State<HudHeader> {
  late String formattedDate;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    formattedDate = _getCurrentTime();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  String _getCurrentTime() {
    final DateTime now = DateTime.now();
    return '${DateFormat('yyyy-MM-dd HH:mm:ss').format(now)} ${now.timeZoneName}';
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        formattedDate = _getCurrentTime();
      });
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hide HUD on desktop as it repeats the Sidebar info
    if (MediaQuery.of(context).size.width > 800) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Reduced vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT: Profile (Name & Photo)
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  // Photo
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00FFFF).withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                      ],
                      border: Border.all(color: const Color(0xFF00FFFF), width: 1.5),
                    ),
                    child: const CircleAvatar(
                      radius: 18, // Reduced size
                      backgroundImage: AssetImage('assets/profile-photo.jpeg'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Name & Title
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.name,
                          style: const TextStyle(
                            fontFamily: 'Audiowide',
                            fontSize: 10, // Reduced from 11
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          AppLocalizations.of(context)!.roleTitle,
                          style: const TextStyle(
                            fontFamily: 'Audiowide',
                            fontSize: 7, // Reduced from 8
                            color: Color(0xFF00FFFF),
                            letterSpacing: 1.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // RIGHT: Time & Location
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF00FFFF), size: 12),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context)!.location,
                      style: const TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 10,
                        color: Color(0xFF00FFFF),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontFamily: 'TrueType',
                    fontSize: 14,
                    color: Color(0xFF00FFFF),
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
