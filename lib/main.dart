import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jmarshall_io/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:jmarshall_io/projects.dart';
import 'package:jmarshall_io/services.dart';
import 'package:jmarshall_io/home_page.dart'; // Import HomePage
import 'chat_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jmarshall_io/data/profile_data.dart';
import 'package:jmarshall_io/widgets/circuit_background.dart';
import 'package:jmarshall_io/widgets/profile_sidebar.dart';
import 'package:jmarshall_io/widgets/hud_header.dart'; 
import 'package:jmarshall_io/settings_page.dart'; // Add SettingsPage

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await ProfileData.loadSkills();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jonathan Marshall Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        // fontFamily: 'Orbitron', // Removed to allow standard readable font by default
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale, 
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = _resolveInitialTabFromUrl();
  }

  int _resolveInitialTabFromUrl() {
    final Uri uri = Uri.base;
    final String path = uri.path.toLowerCase();
    final String fragment = uri.fragment.toLowerCase();
    final String tabParam = (uri.queryParameters['tab'] ?? '').toLowerCase();
    final String combined = '$path $fragment $tabParam';

    if (combined.contains('chat') ||
        combined.contains('align') ||
        combined.contains('intake') ||
        combined.contains('inquire') ||
        combined.contains('contact')) {
      return 1;
    }
    if (combined.contains('service')) {
      return 2;
    }
    if (combined.contains('project') || combined.contains('work')) {
      return 3;
    }
    if (combined.contains('setting')) {
      return 4;
    }
    return 0;
  }

  List<Widget> get _pages => <Widget>[
        HomePage(onStartInquiry: () => _onItemTapped(1)),
        const ChatPage(),
        const ServicesPage(),
        ProjectsPage(onStartInquiry: () => _onItemTapped(1)),
        const SettingsPage(),
      ];

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // 1. Technical Circuit Background
          const CircuitBackground(),

          // 2. Responsive Layout
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                // DESKTOP: Sidebar + Content
                return Row(
                  children: [
                    const ProfileSidebar(),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: _pages[_selectedIndex],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // MOBILE: Stacked
                return Column(
                  children: [
                    const HudHeader(), // Global Header for Mobile
                    Expanded(
                      child: _pages[_selectedIndex],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          border: Border(top: BorderSide(color: const Color(0xFF00FFFF).withOpacity(0.3))),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat_bubble_outline),
              label: AppLocalizations.of(context)!.chat,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.design_services_outlined),
              label: AppLocalizations.of(context)!.services,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.work_outline),
              label: AppLocalizations.of(context)!.projects,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF00FFFF),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          elevation: 0,
        ),
      ),
    );
  }
}
