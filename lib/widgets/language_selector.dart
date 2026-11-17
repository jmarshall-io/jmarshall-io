import 'package:flutter/material.dart';
import 'package:jmarshall_io/main.dart'; // Import to access MyApp

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language, color: Color(0xFF00FFFF), size: 20),
      padding: EdgeInsets.zero,
      tooltip: 'Change Language',
      onSelected: (Locale locale) {
        MyApp.setLocale(context, locale);
      },
      itemBuilder: (context) => [
        _buildItem('English', 'en'),
        _buildItem('Español', 'es'),
        _buildItem('Deutsch', 'de'),
        _buildItem('Français', 'fr'),
        _buildItem('中文', 'zh'),
        _buildItem('日本語', 'ja'),
        _buildItem('한국어', 'ko'),
        _buildItem('Русский', 'ru'),
        _buildItem('العربية', 'ar'),
      ],
    );
  }

  PopupMenuItem<Locale> _buildItem(String name, String code) {
    return PopupMenuItem(
      value: Locale(code),
      child: Text(name),
    );
  }
}
