import 'package:flutter/material.dart';
import 'package:jmarshall_io/l10n/app_localizations.dart';
import 'package:jmarshall_io/widgets/language_selector.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // A simple centered settings card
    return Center(
      child: Container(
        width: 600,
        height: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
             Text(
               AppLocalizations.of(context)!.settings,
               style: const TextStyle(
                 fontFamily: 'Audiowide',
                 fontSize: 24,
                 color: Colors.white,
                 letterSpacing: 2,
               ),
             ),
             const SizedBox(height: 50),
             
             // Language Row
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
               decoration: BoxDecoration(
                 color: Colors.black.withOpacity(0.5),
                 border: Border.all(color: const Color(0xFF00FFFF).withOpacity(0.5)),
                 borderRadius: BorderRadius.circular(10),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       const Icon(Icons.language, color: Colors.white70),
                       const SizedBox(width: 15),
                       Text(
                         AppLocalizations.of(context)!.language,
                         style: const TextStyle(
                           color: Colors.white,
                           fontSize: 16,
                           letterSpacing: 1.1,
                         ),
                       ),
                     ],
                   ),
                   // Reuse selector but maybe we should just show the icon
                   const LanguageSelector(),
                 ],
               ),
             ),
             
             const Spacer(),
             
             Text(
               "Version 1.0.0",
               style: TextStyle(color: Colors.white.withOpacity(0.3)),
             ),
          ],
        ),
      ),
    );
  }
}
