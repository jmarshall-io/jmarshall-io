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
    return '${DateFormat('HH:mm:ss').format(now)} ${now.timeZoneName}';
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
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // LEFT: Profile (Name & Photo)
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  // Photo
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00FFFF).withOpacity(0.25),
                          blurRadius: 6,
                          spreadRadius: 0,
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFF00FFFF),
                        width: 1.5,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://avatars.githubusercontent.com/u/252984706?v=4',
                        width: 34,
                        height: 34,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/profile-photo-bw.jpeg',
                          width: 34,
                          height: 34,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Name & Title
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.name,
                          style: const TextStyle(
                            fontFamily: 'Audiowide',
                            fontSize: 10.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppLocalizations.of(context)!.roleTitle,
                          style: const TextStyle(
                            fontFamily: 'Audiowide',
                            fontSize: 7.5,
                            color: Color(0xFF00FFFF),
                            letterSpacing: 0.8,
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
            const SizedBox(width: 8),
            // RIGHT: Compact Time & Location
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF00FFFF),
                      size: 11,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      AppLocalizations.of(context)!.location,
                      style: const TextStyle(
                        fontFamily: 'Audiowide',
                        fontSize: 9,
                        color: Color(0xFF00FFFF),
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontFamily: 'TrueType',
                    fontSize: 12.5,
                    color: Color(0xFF00FFFF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    height: 1.1,
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
