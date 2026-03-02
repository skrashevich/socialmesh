import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ru.dart';

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
    Locale('en'),
    Locale('it'),
    Locale('ru'),
  ];

  /// The name of the application.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh'**
  String get appTitle;

  /// Label for a Cancel button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Label for a Save button.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// Label for a Retry button.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// Label for a Done button.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// Label for a Go Back button.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get commonGoBack;

  /// Label for a Confirm button.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// Label for a Delete button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// Label for a Close button.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// Label for an OK button.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// Label for a Continue button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// Tooltip for the hamburger menu button.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navigationMenuTooltip;

  /// Tooltip for the device status button.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get navigationDeviceTooltip;

  /// Drawer section header for social features.
  ///
  /// In en, this message translates to:
  /// **'SOCIAL'**
  String get navigationSectionSocial;

  /// Drawer section header for mesh features.
  ///
  /// In en, this message translates to:
  /// **'MESH'**
  String get navigationSectionMesh;

  /// Drawer section header for premium features.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get navigationSectionPremium;

  /// Drawer section header for account section.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get navigationSectionAccount;

  /// Label for the Signals feature in drawer and bottom nav.
  ///
  /// In en, this message translates to:
  /// **'Signals'**
  String get navigationSignals;

  /// Label for the Social Hub drawer item.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get navigationSocial;

  /// Label for the NodeDex drawer item.
  ///
  /// In en, this message translates to:
  /// **'NodeDex'**
  String get navigationNodeDex;

  /// Label for the File Transfers drawer item.
  ///
  /// In en, this message translates to:
  /// **'File Transfers'**
  String get navigationFileTransfers;

  /// Label for the Aether drawer item.
  ///
  /// In en, this message translates to:
  /// **'Aether'**
  String get navigationAether;

  /// Label for the TAK Gateway drawer item.
  ///
  /// In en, this message translates to:
  /// **'TAK Gateway'**
  String get navigationTakGateway;

  /// Label for the TAK Map drawer item.
  ///
  /// In en, this message translates to:
  /// **'TAK Map'**
  String get navigationTakMap;

  /// Label for the Activity drawer item.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get navigationActivity;

  /// Label for the Presence drawer item.
  ///
  /// In en, this message translates to:
  /// **'Presence'**
  String get navigationPresence;

  /// Label for the Timeline drawer item.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get navigationTimeline;

  /// Label for the World Map drawer item.
  ///
  /// In en, this message translates to:
  /// **'World Map'**
  String get navigationWorldMap;

  /// Label for the 3D Mesh View drawer item.
  ///
  /// In en, this message translates to:
  /// **'3D Mesh View'**
  String get navigationMesh3dView;

  /// Label for the Routes drawer item.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get navigationRoutes;

  /// Label for the Reachability drawer item.
  ///
  /// In en, this message translates to:
  /// **'Reachability'**
  String get navigationReachability;

  /// Label for the Mesh Health drawer item.
  ///
  /// In en, this message translates to:
  /// **'Mesh Health'**
  String get navigationMeshHealth;

  /// Label for the Device Logs drawer item.
  ///
  /// In en, this message translates to:
  /// **'Device Logs'**
  String get navigationDeviceLogs;

  /// Label for the Theme Pack premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Theme Pack'**
  String get navigationThemePack;

  /// Label for the Ringtone Pack premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Ringtone Pack'**
  String get navigationRingtonePack;

  /// Label for the Widgets premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get navigationWidgets;

  /// Label for the Automations premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Automations'**
  String get navigationAutomations;

  /// Label for the IFTTT Integration premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'IFTTT Integration'**
  String get navigationIftttIntegration;

  /// Label for the Help and Support drawer item.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get navigationHelpSupport;

  /// Label for the Messages bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navigationMessages;

  /// Label for the Map bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navigationMap;

  /// Label for the Nodes bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get navigationNodes;

  /// Label for the Dashboard bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navigationDashboard;

  /// Default display name when user is not signed in.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get navigationGuestName;

  /// Sync status text when user is not authenticated.
  ///
  /// In en, this message translates to:
  /// **'Not signed in'**
  String get navigationNotSignedIn;

  /// Sync status text when device has no internet.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get navigationOffline;

  /// Sync status text during active sync.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get navigationSyncing;

  /// Sync status text when sync failed.
  ///
  /// In en, this message translates to:
  /// **'Sync error'**
  String get navigationSyncError;

  /// Sync status text when sync is complete.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get navigationSynced;

  /// Sync status text linking to profile screen.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get navigationViewProfile;

  /// Snackbar text for firmware client notifications.
  ///
  /// In en, this message translates to:
  /// **'Firmware: {message}'**
  String navigationFirmwareMessage(String message);

  /// Push notification title for firmware errors.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic Device Error'**
  String get navigationFirmwareErrorTitle;

  /// Push notification title for firmware warnings.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic Device Warning'**
  String get navigationFirmwareWarningTitle;

  /// Snackbar text when an Aether flight becomes active.
  ///
  /// In en, this message translates to:
  /// **'{flightNumber} ({route}) is now in flight!'**
  String navigationFlightActivated(String flightNumber, String route);

  /// Snackbar text when an Aether flight completes.
  ///
  /// In en, this message translates to:
  /// **'{flightNumber} ({route}) flight completed'**
  String navigationFlightCompleted(String flightNumber, String route);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
