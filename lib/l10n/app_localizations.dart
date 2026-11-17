import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('ru'),
    Locale('zh')
  ];

  /// Mobile role title
  ///
  /// In en, this message translates to:
  /// **'SYSTEMS ARCHITECT'**
  String get roleTitle;

  /// Desktop role title
  ///
  /// In en, this message translates to:
  /// **'CLOUD ARCHITECT'**
  String get roleTitleCloud;

  /// Mobile biography
  ///
  /// In en, this message translates to:
  /// **'Systems Architect driving enterprise innovation through advanced IT solutions. 20 years of IT experience and 10 years cloud development, integration, and automation.'**
  String get bio;

  /// Desktop biography
  ///
  /// In en, this message translates to:
  /// **'Building high-performance cloud infrastructure and secure data pipelines.'**
  String get bioShort;

  /// User name
  ///
  /// In en, this message translates to:
  /// **'JONATHAN MARSHALL'**
  String get name;

  /// User name with newline
  ///
  /// In en, this message translates to:
  /// **'JONATHAN\nMARSHALL'**
  String get nameMultiline;

  /// Location
  ///
  /// In en, this message translates to:
  /// **'Washington, DC'**
  String get location;

  /// Resume button
  ///
  /// In en, this message translates to:
  /// **'Resume/CV'**
  String get resume;

  /// Capabilities button
  ///
  /// In en, this message translates to:
  /// **'Capabilities Statement'**
  String get capabilities;

  /// Skills header
  ///
  /// In en, this message translates to:
  /// **'SPECIALIZED IN'**
  String get specializedIn;

  /// Home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Chat tab
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// Services tab
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// Projects tab
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// Skills tab
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// Settings tab
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Select Language dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @enterDetails.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Details'**
  String get enterDetails;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @companyLabel.
  ///
  /// In en, this message translates to:
  /// **'Company (Optional)'**
  String get companyLabel;

  /// No description provided for @startChat.
  ///
  /// In en, this message translates to:
  /// **'Start Chat'**
  String get startChat;

  /// No description provided for @aiChat.
  ///
  /// In en, this message translates to:
  /// **'AI CHAT'**
  String get aiChat;

  /// No description provided for @aiProcessing.
  ///
  /// In en, this message translates to:
  /// **'AI is processing...'**
  String get aiProcessing;

  /// No description provided for @askHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about my skills, projects...'**
  String get askHint;

  /// No description provided for @enterNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get enterNameError;

  /// No description provided for @enterEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmailError;

  /// No description provided for @enterValidEmailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get enterValidEmailError;

  /// No description provided for @searchServices.
  ///
  /// In en, this message translates to:
  /// **'Search Services...'**
  String get searchServices;

  /// No description provided for @searchProjects.
  ///
  /// In en, this message translates to:
  /// **'Search Projects...'**
  String get searchProjects;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add Project'**
  String get addProject;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'SERVICES'**
  String get servicesTitle;

  /// No description provided for @projectsTitle.
  ///
  /// In en, this message translates to:
  /// **'PROJECTS'**
  String get projectsTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'ja',
        'ko',
        'ru',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
