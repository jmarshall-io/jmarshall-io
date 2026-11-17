import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:intl/intl.dart';
import 'package:jmarshall_io/l10n/app_localizations.dart';
import 'package:jmarshall_io/widgets/language_selector.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSidebar extends StatefulWidget {
  const ProfileSidebar({super.key});

  @override
  State<ProfileSidebar> createState() => _ProfileSidebarState();
}

class _ProfileSidebarState extends State<ProfileSidebar> {
  late String _formattedTime;
  late String _tzLabel;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateClock();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateClock(),
    );
  }

  void _updateClock() {
    final DateTime now = DateTime.now();
    final Duration offset = now.timeZoneOffset;
    final String sign = offset.isNegative ? '-' : '+';
    final String hours = offset.inHours.abs().toString().padLeft(2, '0');
    final String minutes =
        (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final String tzName = now.timeZoneName;

    final String nextTime = DateFormat('yyyy-MM-dd  HH:mm:ss').format(now);
    final String nextTz = '$tzName (UTC$sign$hours:$minutes)';

    if (mounted) {
      setState(() {
        _formattedTime = nextTime;
        _tzLabel = nextTz;
      });
    } else {
      _formattedTime = nextTime;
      _tzLabel = nextTz;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    HapticFeedback.selectionClick();
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        border: Border(
          right: BorderSide(color: const Color(0xFF00FFFF).withOpacity(0.25)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          // Profile Photo
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00FFFF).withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 56,
                backgroundImage: AssetImage('assets/profile-photo-bw.jpeg'),
                backgroundColor: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Name & Title
          Text(
            AppLocalizations.of(context)!.nameMultiline,
            style: const TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.roleTitle,
            style: const TextStyle(
              fontFamily: 'Audiowide',
              fontSize: 15,
              color: Color(0xFF00FFFF),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // --- LIVE HUD DIGITAL CLOCK & VISITOR TIMEZONE / LOCATION ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF00FFFF).withOpacity(0.35),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00FFFF).withOpacity(0.08),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF00FFFF),
                      size: 13,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.location,
                        style: const TextStyle(
                          fontFamily: 'Audiowide',
                          fontSize: 10,
                          color: Color(0xFF00FFFF),
                          letterSpacing: 1.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _formattedTime,
                  style: const TextStyle(
                    fontFamily: 'TrueType',
                    fontSize: 16,
                    color: Color(0xFF00FFFF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'LOCAL TZ: $_tzLabel',
                  style: const TextStyle(
                    fontFamily: 'Audiowide',
                    fontSize: 9.5,
                    color: Colors.white54,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),
          // Description
          Text(
            AppLocalizations.of(context)!.bioShort,
            style: const TextStyle(
              fontSize: 13.5,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const Spacer(),
          // Socials
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SocialButton(
                iconPath: 'assets/github-black-bg.png',
                onTap: () => _launchURL('https://github.com/jmarshall-io'),
                tooltip: 'GitHub (jmarshall-io)',
              ),
              _SocialButton(
                iconPath: 'assets/linked-in-black-bg.png',
                onTap: () => _launchURL(
                  'https://www.linkedin.com/in/systemintegrationengineer/',
                ),
                tooltip: 'LinkedIn',
              ),
              _SocialButton(
                iconPath: 'assets/twitter-black-bg.png',
                onTap: () => _launchURL('https://x.com/jmarshallio'),
                tooltip: 'X / Twitter',
              ),
              _SocialButton(
                iconPath: 'assets/logos/obsidian-logo-gradient.svg',
                onTap: () => _launchURL('https://jmarshall.io'),
                tooltip: 'Portfolio Architecture Hub',
              ),
              const LanguageSelector(),
            ],
          ),
          const SizedBox(height: 16),
        ],
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
      child: GlassContainer(
        height: 40,
        width: 40,
        blur: 10,
        border: 1,
        borderRadius: BorderRadius.circular(10),
        linearGradient: LinearGradient(
          colors: [
            const Color(0xFF00FFFF).withOpacity(0.1),
            const Color(0xFF00FFFF).withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            const Color(0xFF00FFFF).withOpacity(0.5),
            Colors.transparent,
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
