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

  /// Display label for the Contact social tag.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get nodedexTagContact;

  /// Display label for the Trusted Node social tag.
  ///
  /// In en, this message translates to:
  /// **'Trusted Node'**
  String get nodedexTagTrustedNode;

  /// Display label for the Known Relay social tag.
  ///
  /// In en, this message translates to:
  /// **'Known Relay'**
  String get nodedexTagKnownRelay;

  /// Display label for the Frequent Peer social tag.
  ///
  /// In en, this message translates to:
  /// **'Frequent Peer'**
  String get nodedexTagFrequentPeer;

  /// Display label for the Wanderer node trait.
  ///
  /// In en, this message translates to:
  /// **'Wanderer'**
  String get nodedexTraitWanderer;

  /// Display label for the Beacon node trait.
  ///
  /// In en, this message translates to:
  /// **'Beacon'**
  String get nodedexTraitBeacon;

  /// Display label for the Ghost node trait.
  ///
  /// In en, this message translates to:
  /// **'Ghost'**
  String get nodedexTraitGhost;

  /// Display label for the Sentinel node trait.
  ///
  /// In en, this message translates to:
  /// **'Sentinel'**
  String get nodedexTraitSentinel;

  /// Display label for the Relay node trait.
  ///
  /// In en, this message translates to:
  /// **'Relay'**
  String get nodedexTraitRelay;

  /// Display label for the Courier node trait.
  ///
  /// In en, this message translates to:
  /// **'Courier'**
  String get nodedexTraitCourier;

  /// Display label for the Anchor node trait.
  ///
  /// In en, this message translates to:
  /// **'Anchor'**
  String get nodedexTraitAnchor;

  /// Display label for the Drifter node trait.
  ///
  /// In en, this message translates to:
  /// **'Drifter'**
  String get nodedexTraitDrifter;

  /// Display label for the Unknown (unclassified) node trait.
  ///
  /// In en, this message translates to:
  /// **'Newcomer'**
  String get nodedexTraitUnknown;

  /// Description for the Wanderer node trait.
  ///
  /// In en, this message translates to:
  /// **'Seen across multiple locations'**
  String get nodedexTraitWandererDescription;

  /// Description for the Beacon node trait.
  ///
  /// In en, this message translates to:
  /// **'Always active, high availability'**
  String get nodedexTraitBeaconDescription;

  /// Description for the Ghost node trait.
  ///
  /// In en, this message translates to:
  /// **'Rarely seen, elusive presence'**
  String get nodedexTraitGhostDescription;

  /// Description for the Sentinel node trait.
  ///
  /// In en, this message translates to:
  /// **'Fixed position, long-lived guardian'**
  String get nodedexTraitSentinelDescription;

  /// Description for the Relay node trait.
  ///
  /// In en, this message translates to:
  /// **'High throughput, forwards traffic'**
  String get nodedexTraitRelayDescription;

  /// Description for the Courier node trait.
  ///
  /// In en, this message translates to:
  /// **'Carries messages across the mesh'**
  String get nodedexTraitCourierDescription;

  /// Description for the Anchor node trait.
  ///
  /// In en, this message translates to:
  /// **'Persistent hub with many connections'**
  String get nodedexTraitAnchorDescription;

  /// Description for the Drifter node trait.
  ///
  /// In en, this message translates to:
  /// **'Irregular timing, fades in and out'**
  String get nodedexTraitDrifterDescription;

  /// Description for the Unknown (unclassified) node trait.
  ///
  /// In en, this message translates to:
  /// **'Recently discovered'**
  String get nodedexTraitUnknownDescription;

  /// Explorer title for fewer than 5 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Newcomer'**
  String get explorerTitleNewcomer;

  /// Explorer title for 5-19 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Observer'**
  String get explorerTitleObserver;

  /// Explorer title for 20-49 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get explorerTitleExplorer;

  /// Explorer title for 50-99 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Cartographer'**
  String get explorerTitleCartographer;

  /// Explorer title for 100-199 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Signal Hunter'**
  String get explorerTitleSignalHunter;

  /// Explorer title for 200+ discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Mesh Veteran'**
  String get explorerTitleMeshVeteran;

  /// Explorer title for 200+ nodes AND 5+ regions.
  ///
  /// In en, this message translates to:
  /// **'Mesh Cartographer'**
  String get explorerTitleMeshCartographer;

  /// Explorer title for the longest distance record above 10 km.
  ///
  /// In en, this message translates to:
  /// **'Long-Range Record Holder'**
  String get explorerTitleLongRangeRecordHolder;

  /// Description for the Newcomer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Beginning the mesh journey'**
  String get explorerTitleNewcomerDescription;

  /// Description for the Observer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Building awareness of the mesh'**
  String get explorerTitleObserverDescription;

  /// Description for the Explorer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Actively discovering the network'**
  String get explorerTitleExplorerDescription;

  /// Description for the Cartographer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Mapping the invisible infrastructure'**
  String get explorerTitleCartographerDescription;

  /// Description for the Signal Hunter explorer title.
  ///
  /// In en, this message translates to:
  /// **'Seeking signals across the spectrum'**
  String get explorerTitleSignalHunterDescription;

  /// Description for the Mesh Veteran explorer title.
  ///
  /// In en, this message translates to:
  /// **'Deep knowledge of the mesh'**
  String get explorerTitleMeshVeteranDescription;

  /// Description for the Mesh Cartographer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Charting regions and routes'**
  String get explorerTitleMeshCartographerDescription;

  /// Description for the Long-Range Record Holder explorer title.
  ///
  /// In en, this message translates to:
  /// **'Pushing the limits of range'**
  String get explorerTitleLongRangeRecordHolderDescription;

  /// Default status text shown on the connecting animation.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get scannerConnectingStatus;

  /// Title of the scanner screen in onboarding mode.
  ///
  /// In en, this message translates to:
  /// **'Connect Device'**
  String get scannerConnectDeviceTitle;

  /// Title of the scanner screen in normal mode.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get scannerDevicesTitle;

  /// Fallback name used when the last connected device has no stored name.
  ///
  /// In en, this message translates to:
  /// **'Your saved device'**
  String get scannerSavedDeviceFallbackName;

  /// Banner title when the saved device was not found during scan.
  ///
  /// In en, this message translates to:
  /// **'{name} not found'**
  String scannerDeviceNotFoundTitle(String name);

  /// Banner subtitle explaining why the saved device was not found.
  ///
  /// In en, this message translates to:
  /// **'If another app is connected to this device, disconnect from it first. Only one app can use Bluetooth at a time.'**
  String get scannerDeviceNotFoundSubtitle;

  /// Title of the info banner shown when auto-reconnect is off.
  ///
  /// In en, this message translates to:
  /// **'Auto-reconnect is disabled'**
  String get scannerAutoReconnectDisabledTitle;

  /// Subtitle of the auto-reconnect hint when a saved device name is known.
  ///
  /// In en, this message translates to:
  /// **'Select \"{name}\" below, or enable auto-reconnect.'**
  String scannerAutoReconnectDisabledSubtitleWithDevice(String name);

  /// Subtitle of the auto-reconnect hint when no saved device name is available.
  ///
  /// In en, this message translates to:
  /// **'Select a device below to connect manually.'**
  String get scannerAutoReconnectDisabledSubtitle;

  /// Title of the confirmation sheet for enabling auto-reconnect.
  ///
  /// In en, this message translates to:
  /// **'Enable Auto-Reconnect?'**
  String get scannerEnableAutoReconnectTitle;

  /// Auto-reconnect confirmation body when a saved device name is known.
  ///
  /// In en, this message translates to:
  /// **'This will automatically connect to \"{name}\" now and whenever you open the app.'**
  String scannerEnableAutoReconnectMessageWithDevice(String name);

  /// Auto-reconnect confirmation body when no saved device name is available.
  ///
  /// In en, this message translates to:
  /// **'This will automatically connect to your last used device whenever you open the app.'**
  String get scannerEnableAutoReconnectMessage;

  /// Confirm label for the enable auto-reconnect sheet.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get scannerEnableLabel;

  /// Hint shown when BLE pairing was invalidated (e.g. factory reset).
  ///
  /// In en, this message translates to:
  /// **'Bluetooth pairing was removed. Forget \"Meshtastic\" in Settings > Bluetooth and reconnect to continue.'**
  String get scannerPairingRemovedHint;

  /// Label for the button that opens the OS Bluetooth settings.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Settings'**
  String get scannerBluetoothSettings;

  /// Label for the retry scan button.
  ///
  /// In en, this message translates to:
  /// **'Retry Scan'**
  String get scannerRetryScan;

  /// Banner title shown while actively scanning for BLE devices.
  ///
  /// In en, this message translates to:
  /// **'Scanning for nearby devices'**
  String get scannerScanningTitle;

  /// Banner subtitle shown when the device list is empty during scan.
  ///
  /// In en, this message translates to:
  /// **'Looking for Meshtastic devices...'**
  String get scannerScanningSubtitle;

  /// Banner subtitle showing how many devices were found during an active scan.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} device found so far} other{{count} devices found so far}}'**
  String scannerDevicesFoundCount(int count);

  /// Header label above the list of discovered BLE/USB devices.
  ///
  /// In en, this message translates to:
  /// **'Available Devices'**
  String get scannerAvailableDevices;

  /// Large text shown when scan is not active and no devices are listed.
  ///
  /// In en, this message translates to:
  /// **'Looking for devices…'**
  String get scannerLookingForDevices;

  /// Helper text shown below the looking-for-devices message.
  ///
  /// In en, this message translates to:
  /// **'Make sure Bluetooth is enabled and your Meshtastic device is powered on'**
  String get scannerEnableBluetoothHint;

  /// Title of the bottom sheet warning for an unrecognised BLE device.
  ///
  /// In en, this message translates to:
  /// **'Unknown Protocol'**
  String get scannerUnknownProtocol;

  /// Body text in the unknown-protocol warning sheet.
  ///
  /// In en, this message translates to:
  /// **'This device was not detected as Meshtastic or MeshCore.'**
  String get scannerUnknownDeviceDescription;

  /// Second paragraph in the unknown-protocol warning sheet.
  ///
  /// In en, this message translates to:
  /// **'This device cannot be connected automatically. Only Meshtastic and MeshCore devices are supported.'**
  String get scannerUnsupportedDeviceMessage;

  /// Protocol badge label for Meshtastic devices.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic'**
  String get scannerProtocolMeshtastic;

  /// Protocol badge label for MeshCore devices.
  ///
  /// In en, this message translates to:
  /// **'MeshCore'**
  String get scannerProtocolMeshCore;

  /// Protocol badge label for devices with an unrecognised protocol.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get scannerProtocolUnknown;

  /// Transport type label for BLE devices in the device card.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get scannerTransportBluetooth;

  /// Transport type label for USB devices in the device card.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get scannerTransportUsb;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get scannerDetailDeviceName;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get scannerDetailAddress;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Connection Type'**
  String get scannerDetailConnectionType;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get scannerDetailSignalStrength;

  /// Column header in the device details table (dev mode only).
  ///
  /// In en, this message translates to:
  /// **'Service UUIDs'**
  String get scannerDetailServiceUuids;

  /// Column header in the device details table (dev mode only).
  ///
  /// In en, this message translates to:
  /// **'Manufacturer Data'**
  String get scannerDetailManufacturerData;

  /// Connection type value for BLE devices in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Low Energy'**
  String get scannerDetailBluetoothLowEnergy;

  /// Connection type value for USB devices in the device details table.
  ///
  /// In en, this message translates to:
  /// **'USB Serial'**
  String get scannerDetailUsbSerial;

  /// Version text shown at the bottom of the scanner screen.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh v{version}'**
  String scannerVersionText(String version);

  /// Short version text shown at the bottom of the inline scanner.
  ///
  /// In en, this message translates to:
  /// **'Version v{version}'**
  String scannerVersionTextShort(String version);

  /// Copyright notice at the bottom of the scanner screen.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Socialmesh. All rights reserved.'**
  String get scannerCopyright;

  /// Error message shown when BLE authentication fails during auto-reconnect.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. The device may need to be re-paired. Go to Settings > Bluetooth, forget the Meshtastic device, then tap it below to reconnect.'**
  String get scannerAuthFailedError;

  /// Fallback error message when MeshCore connection fails with no specific message.
  ///
  /// In en, this message translates to:
  /// **'MeshCore connection failed'**
  String get scannerMeshCoreConnectionFailed;

  /// Error snackbar message when MeshCore connection throws an exception.
  ///
  /// In en, this message translates to:
  /// **'MeshCore connection failed: {error}'**
  String scannerMeshCoreConnectionFailedWithError(String error);

  /// Error message set when a BLE/MeshCore connection fails with an exception.
  ///
  /// In en, this message translates to:
  /// **'Connection failed: {error}'**
  String scannerConnectionFailedWithError(String error);

  /// Error thrown when Meshtastic config is not received, indicating a PIN/auth issue.
  ///
  /// In en, this message translates to:
  /// **'Connection failed - please try again and enter the PIN when prompted'**
  String get scannerPinRequiredError;

  /// Error snackbar when the OS deep link to Bluetooth settings fails.
  ///
  /// In en, this message translates to:
  /// **'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.'**
  String get scannerBluetoothSettingsOpenFailed;

  /// Title of the messages container screen app bar.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesContainerTitle;

  /// Tab label for the contacts tab in the messages container.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get messagesContactsTab;

  /// Tab label for the channels tab in the messages container.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get messagesChannelsTab;

  /// Error shown when user tries to add a channel while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to add channels'**
  String get messagesAddChannelNotConnected;

  /// Error shown when user tries to scan a QR channel while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to scan channels'**
  String get messagesScanChannelNotConnected;

  /// Hint text in the contact search field.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get messagingSearchContactsHint;

  /// Label for the All filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get messagingFilterAll;

  /// Label for the Active filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get messagingFilterActive;

  /// Label for the Unread filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get messagingFilterUnread;

  /// Label for the Messaged filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Messaged'**
  String get messagingFilterMessaged;

  /// Label for the Favorites filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get messagingFilterFavorites;

  /// Empty state text when the contact search returns no results.
  ///
  /// In en, this message translates to:
  /// **'No contacts match \"{query}\"'**
  String messagingNoContactsMatchSearch(String query);

  /// Empty state text when the active filter returns no contacts.
  ///
  /// In en, this message translates to:
  /// **'No {filter} contacts'**
  String messagingNoFilteredContacts(String filter);

  /// Empty state text when no contacts exist at all.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get messagingNoContactsYet;

  /// Helper text shown below the no-contacts empty state.
  ///
  /// In en, this message translates to:
  /// **'Discovered nodes will appear here'**
  String get messagingContactsDiscoveredHint;

  /// Button label to clear the contact search query.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get messagingClearSearch;

  /// Title for the contacts list header when no contacts are present.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get messagingContactsTitle;

  /// Title for the contacts list header showing the contact count.
  ///
  /// In en, this message translates to:
  /// **'Contacts ({count})'**
  String messagingContactsTitleWithCount(int count);

  /// Section header for favorite contacts in the contact list.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get messagingSectionFavorites;

  /// Section header for contacts with unread messages.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get messagingSectionUnread;

  /// Section header for recently active contacts.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get messagingSectionActive;

  /// Section header for inactive contacts.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get messagingSectionInactive;

  /// Info snackbar shown when a message is queued because the device is offline.
  ///
  /// In en, this message translates to:
  /// **'Message queued - will send when connected'**
  String get messagingMessageQueuedOffline;

  /// Title of the encryption key issue bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Encryption Key Issue'**
  String get messagingEncryptionKeyIssueTitle;

  /// Subtitle of the encryption key issue sheet showing the target node name.
  ///
  /// In en, this message translates to:
  /// **'Direct message to {name} failed'**
  String messagingEncryptionKeyIssueSubtitle(String name);

  /// Warning banner body in the encryption key issue sheet.
  ///
  /// In en, this message translates to:
  /// **'The encryption keys may be out of sync. This can happen when a node has been reset or rolled out of the mesh database.'**
  String get messagingEncryptionKeyWarning;

  /// Success snackbar after requesting node info.
  ///
  /// In en, this message translates to:
  /// **'Requested fresh info from {name}'**
  String messagingRequestUserInfoSuccess(String name);

  /// Error snackbar when requesting node info fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to request info: {error}'**
  String messagingRequestUserInfoFailed(String error);

  /// Button label to request fresh node info.
  ///
  /// In en, this message translates to:
  /// **'Request User Info'**
  String get messagingRequestUserInfo;

  /// Button label to retry sending a failed message.
  ///
  /// In en, this message translates to:
  /// **'Retry Message'**
  String get messagingRetryMessage;

  /// Advanced option link in the encryption key issue sheet.
  ///
  /// In en, this message translates to:
  /// **'Advanced: Reset Node Database'**
  String get messagingAdvancedResetNodeDatabase;

  /// Title of the delete message confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Delete Message'**
  String get messagingDeleteMessageTitle;

  /// Body of the delete message confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this message? This only removes it locally.'**
  String get messagingDeleteMessageConfirmation;

  /// Success snackbar after deleting a message.
  ///
  /// In en, this message translates to:
  /// **'Message deleted'**
  String get messagingMessageDeleted;

  /// Subtitle shown below the channel name in the messaging screen header.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get messagingChannelSubtitle;

  /// Subtitle shown below the contact name in a DM conversation.
  ///
  /// In en, this message translates to:
  /// **'Direct Message'**
  String get messagingDirectMessageSubtitle;

  /// Tooltip for the icon button that closes the message search bar.
  ///
  /// In en, this message translates to:
  /// **'Close Search'**
  String get messagingCloseSearch;

  /// Tooltip for the icon button that opens the message search bar.
  ///
  /// In en, this message translates to:
  /// **'Search Messages'**
  String get messagingSearchMessages;

  /// Tooltip for the channel settings icon button in a channel conversation.
  ///
  /// In en, this message translates to:
  /// **'Channel Settings'**
  String get messagingChannelSettings;

  /// Hint text in the message search field.
  ///
  /// In en, this message translates to:
  /// **'Find a message'**
  String get messagingFindMessageHint;

  /// Empty state text in the message list when search returns no results.
  ///
  /// In en, this message translates to:
  /// **'No messages match your search'**
  String get messagingNoMessagesMatchSearch;

  /// Empty state text when a channel has no messages.
  ///
  /// In en, this message translates to:
  /// **'No messages in this channel'**
  String get messagingNoMessagesInChannel;

  /// Empty state text in a new DM conversation.
  ///
  /// In en, this message translates to:
  /// **'Start the conversation'**
  String get messagingStartConversation;

  /// Label shown in the reply banner above the text input.
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String messagingReplyingTo(String name);

  /// Hint text in the message compose field.
  ///
  /// In en, this message translates to:
  /// **'Message…'**
  String get messagingMessageHint;

  /// Source label for messages sent by an automation rule.
  ///
  /// In en, this message translates to:
  /// **'Automation'**
  String get messagingSourceAutomation;

  /// Source label for messages sent via a shortcut.
  ///
  /// In en, this message translates to:
  /// **'Shortcut'**
  String get messagingSourceShortcut;

  /// Source label for messages triggered by a notification action.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get messagingSourceNotification;

  /// Source label for tapback reaction messages.
  ///
  /// In en, this message translates to:
  /// **'Tapback'**
  String get messagingSourceTapback;

  /// Fallback text shown when the quoted reply message has no text.
  ///
  /// In en, this message translates to:
  /// **'Original message'**
  String get messagingOriginalMessage;

  /// Fallback error text shown on a message that failed to send.
  ///
  /// In en, this message translates to:
  /// **'Failed to send'**
  String get messagingFailedToSend;

  /// Title of the quick responses panel in the messaging bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Quick Responses'**
  String get messagingQuickResponses;

  /// Empty state text in the quick responses panel.
  ///
  /// In en, this message translates to:
  /// **'No quick responses configured.\nAdd some in Settings → Quick responses.'**
  String get messagingNoQuickResponsesConfigured;

  /// Helper text below an empty quick responses panel.
  ///
  /// In en, this message translates to:
  /// **'Configure quick responses in Settings'**
  String get messagingConfigureQuickResponses;

  /// Popup menu item to open the channel creation wizard.
  ///
  /// In en, this message translates to:
  /// **'Add channel'**
  String get messagingAddChannel;

  /// Popup menu item to scan a QR code for a channel.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get messagingScanQrCode;

  /// Popup menu item to start the messaging help tour.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get messagingHelp;

  /// Popup menu item to navigate to the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get messagingSettings;

  /// Fallback display name for a node with no stored name.
  ///
  /// In en, this message translates to:
  /// **'Unknown Node'**
  String get messagingUnknownNode;

  /// Label for the Reply action in the message context menu.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get messageContextMenuReply;

  /// Label for the Copy action in the message context menu.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get messageContextMenuCopy;

  /// Success snackbar after copying message text.
  ///
  /// In en, this message translates to:
  /// **'Message copied'**
  String get messageContextMenuMessageCopied;

  /// Success snackbar after sending a tapback reaction.
  ///
  /// In en, this message translates to:
  /// **'Tapback sent'**
  String get messageContextMenuTapbackSent;

  /// Error snackbar when sending a tapback fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to send tapback'**
  String get messageContextMenuTapbackFailed;

  /// Header label in the message details section of the context menu.
  ///
  /// In en, this message translates to:
  /// **'Message Details'**
  String get messageContextMenuMessageDetails;

  /// Delivery status text for a message that is currently being sent.
  ///
  /// In en, this message translates to:
  /// **'Sending…'**
  String get messageContextMenuStatusSending;

  /// Delivery status text for a message that has been sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get messageContextMenuStatusSent;

  /// Delivery status text for a message that has been acknowledged.
  ///
  /// In en, this message translates to:
  /// **'Delivered ✔️'**
  String get messageContextMenuStatusDelivered;

  /// Delivery status text for a message that failed to send.
  ///
  /// In en, this message translates to:
  /// **'Failed: {error}'**
  String messageContextMenuStatusFailed(String error);

  /// Placeholder text in the emoji picker when there are no recent emoji.
  ///
  /// In en, this message translates to:
  /// **'No Recents'**
  String get messageContextMenuNoRecents;

  /// Hint text in the emoji picker search field.
  ///
  /// In en, this message translates to:
  /// **'Search emoji…'**
  String get messageContextMenuSearchEmoji;

  /// Header label in the tapback reaction picker.
  ///
  /// In en, this message translates to:
  /// **'React'**
  String get tapbackReact;

  /// Reading time estimate shown on a help article.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min read'**
  String helpArticleMinRead(int minutes);

  /// Error text shown when a help article fails to load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load article'**
  String get helpArticleLoadFailed;

  /// Title of the help center screen.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenterTitle;

  /// Error text shown when the help center content fails to load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load help content'**
  String get helpCenterLoadFailed;

  /// Suffix label on the progress counter in the help center.
  ///
  /// In en, this message translates to:
  /// **'articles read'**
  String get helpCenterArticlesRead;

  /// Hint text in the help center article search field.
  ///
  /// In en, this message translates to:
  /// **'Search articles'**
  String get helpCenterSearchHint;

  /// Label for the All filter chip in the help center.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get helpCenterFilterAll;

  /// Empty state text when the article search returns no results.
  ///
  /// In en, this message translates to:
  /// **'No articles match your search.\nTry different keywords.'**
  String get helpCenterNoArticlesMatchSearch;

  /// Helper description shown in the search empty state.
  ///
  /// In en, this message translates to:
  /// **'Search by article title\nor description.'**
  String get helpCenterSearchByTitle;

  /// Empty state text when the selected category has no articles.
  ///
  /// In en, this message translates to:
  /// **'No articles in this category'**
  String get helpCenterNoArticlesInCategory;

  /// Empty state text shown when there are no articles at all.
  ///
  /// In en, this message translates to:
  /// **'No articles available'**
  String get helpCenterNoArticlesAvailable;

  /// Helper text in the no-articles-in-category empty state.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different category from the filter chips above.'**
  String get helpCenterTryDifferentCategory;

  /// Helper text when no articles are available yet.
  ///
  /// In en, this message translates to:
  /// **'Help content is being prepared. Check back soon.'**
  String get helpCenterContentBeingPrepared;

  /// Badge label on a completed help article.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get helpCenterCompleted;

  /// Button label to mark a help article as read.
  ///
  /// In en, this message translates to:
  /// **'Mark as Complete'**
  String get helpCenterMarkAsComplete;

  /// Chip label on a read help article.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get helpCenterArticleRead;

  /// Chip label on an unread help article.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get helpCenterArticleUnread;

  /// Section title for the interactive tours section of the help center.
  ///
  /// In en, this message translates to:
  /// **'Interactive Tours'**
  String get helpCenterInteractiveTours;

  /// Shows how many interactive tours have been completed out of total.
  ///
  /// In en, this message translates to:
  /// **'{completed} / {total} completed'**
  String helpCenterToursCompletedCount(int completed, int total);

  /// Description text for the interactive tours section.
  ///
  /// In en, this message translates to:
  /// **'Step-by-step walkthroughs for app features. These tours guide you through each screen with Ico.'**
  String get helpCenterToursDescription;

  /// Title for the show help hints preference toggle.
  ///
  /// In en, this message translates to:
  /// **'Show Help Hints'**
  String get helpCenterShowHelpHintsTitle;

  /// Subtitle for the show help hints preference toggle.
  ///
  /// In en, this message translates to:
  /// **'Display pulsing help buttons on screens'**
  String get helpCenterShowHelpHintsSubtitle;

  /// Title for the haptic feedback toggle in help preferences.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get helpCenterHapticFeedbackTitle;

  /// Subtitle for the haptic feedback toggle in help preferences.
  ///
  /// In en, this message translates to:
  /// **'Vibrate during typewriter text effect'**
  String get helpCenterHapticFeedbackSubtitle;

  /// Button label to reset all help progress.
  ///
  /// In en, this message translates to:
  /// **'Reset All Progress'**
  String get helpCenterResetAllProgress;

  /// Title of the reset help progress confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset Help Progress?'**
  String get helpCenterResetProgressTitle;

  /// Body of the reset help progress confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will mark all articles as unread and reset interactive tour progress. You can start fresh.'**
  String get helpCenterResetProgressMessage;

  /// Confirm label on the reset help progress sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get helpCenterResetProgressLabel;

  /// Section header for the help preferences section.
  ///
  /// In en, this message translates to:
  /// **'HELP PREFERENCES'**
  String get helpCenterHelpPreferences;

  /// Label shown on a help article chip indicating where the feature lives.
  ///
  /// In en, this message translates to:
  /// **'Find this in: {screenName}'**
  String helpCenterFindThisIn(String screenName);

  /// Empty state title when all articles have been read.
  ///
  /// In en, this message translates to:
  /// **'You’ve read everything!'**
  String get helpCenterReadEverything;

  /// Empty state title when no articles have been read yet.
  ///
  /// In en, this message translates to:
  /// **'Learn how Meshtastic works'**
  String get helpCenterLearnHowItWorks;

  /// Empty state subtitle when all articles have been read.
  ///
  /// In en, this message translates to:
  /// **'Come back anytime to refresh your knowledge.'**
  String get helpCenterComeBackToRefresh;

  /// Empty state subtitle when no articles have been read yet.
  ///
  /// In en, this message translates to:
  /// **'Tap an article to learn about mesh networking, radio settings, and more.'**
  String get helpCenterTapToLearn;

  /// Screen name shown in help article topic chips for the Channels screen.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get helpCenterScreenChannels;

  /// Screen name shown in help article topic chips for the Messages screen.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get helpCenterScreenMessages;

  /// Screen name shown in help article topic chips for the Nodes screen.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get helpCenterScreenNodes;

  /// Screen name shown in help article topic chips for the Signal Feed screen.
  ///
  /// In en, this message translates to:
  /// **'Signal Feed'**
  String get helpCenterScreenSignalFeed;

  /// Screen name shown in help article topic chips for the Create Signal screen.
  ///
  /// In en, this message translates to:
  /// **'Create Signal'**
  String get helpCenterScreenCreateSignal;

  /// Screen name shown in help article topic chips for the Scanner screen.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get helpCenterScreenScanner;

  /// Screen name shown in help article topic chips for the Region Selection screen.
  ///
  /// In en, this message translates to:
  /// **'Region Selection'**
  String get helpCenterScreenRegionSelection;

  /// Screen name shown in help article topic chips for the Radio Config screen.
  ///
  /// In en, this message translates to:
  /// **'Radio Config'**
  String get helpCenterScreenRadioConfig;

  /// Screen name shown in help article topic chips for the Mesh Health screen.
  ///
  /// In en, this message translates to:
  /// **'Mesh Health'**
  String get helpCenterScreenMeshHealth;

  /// Screen name shown in help article topic chips for the Reachability screen.
  ///
  /// In en, this message translates to:
  /// **'Reachability'**
  String get helpCenterScreenReachability;

  /// Screen name shown in help article topic chips for the Trace Route Log screen.
  ///
  /// In en, this message translates to:
  /// **'Trace Route Log'**
  String get helpCenterScreenTraceRouteLog;

  /// Screen name shown in help article topic chips for the Map screen.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get helpCenterScreenMap;

  /// Screen name shown in help article topic chips for the World Mesh screen.
  ///
  /// In en, this message translates to:
  /// **'World Mesh'**
  String get helpCenterScreenWorldMesh;

  /// Screen name shown in help article topic chips for the Globe screen.
  ///
  /// In en, this message translates to:
  /// **'Globe'**
  String get helpCenterScreenGlobe;

  /// Screen name shown in help article topic chips for the Mesh 3D screen.
  ///
  /// In en, this message translates to:
  /// **'Mesh 3D'**
  String get helpCenterScreenMesh3d;

  /// Screen name shown in help article topic chips for the Routes screen.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get helpCenterScreenRoutes;

  /// Screen name shown in help article topic chips for the Timeline screen.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get helpCenterScreenTimeline;

  /// Screen name shown in help article topic chips for the Presence screen.
  ///
  /// In en, this message translates to:
  /// **'Presence'**
  String get helpCenterScreenPresence;

  /// Screen name shown in help article topic chips for the Aether screen.
  ///
  /// In en, this message translates to:
  /// **'Aether'**
  String get helpCenterScreenAether;

  /// Screen name shown in help article topic chips for the TAK Gateway screen.
  ///
  /// In en, this message translates to:
  /// **'TAK Gateway'**
  String get helpCenterScreenTakGateway;

  /// Screen name shown in help article topic chips for the Widget Dashboard screen.
  ///
  /// In en, this message translates to:
  /// **'Widget Dashboard'**
  String get helpCenterScreenWidgetDashboard;

  /// Screen name shown in help article topic chips for the Widget Builder screen.
  ///
  /// In en, this message translates to:
  /// **'Widget Builder'**
  String get helpCenterScreenWidgetBuilder;

  /// Screen name shown in help article topic chips for the Widget Marketplace screen.
  ///
  /// In en, this message translates to:
  /// **'Widget Marketplace'**
  String get helpCenterScreenWidgetMarketplace;

  /// Screen name shown in help article topic chips for the Device Shop screen.
  ///
  /// In en, this message translates to:
  /// **'Device Shop'**
  String get helpCenterScreenDeviceShop;

  /// Screen name shown in help article topic chips for the NodeDex screen.
  ///
  /// In en, this message translates to:
  /// **'NodeDex'**
  String get helpCenterScreenNodeDex;

  /// Screen name shown in help article topic chips for the Settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get helpCenterScreenSettings;

  /// Screen name shown in help article topic chips for the Profile screen.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get helpCenterScreenProfile;

  /// Screen name shown in help article topic chips for the Automations screen.
  ///
  /// In en, this message translates to:
  /// **'Automations'**
  String get helpCenterScreenAutomations;

  /// Title of the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Hint text in the settings search field.
  ///
  /// In en, this message translates to:
  /// **'Find a setting'**
  String get settingsSearchHint;

  /// Tooltip for the help icon button in the settings app bar.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get settingsHelpTooltip;

  /// Empty state title in the settings search results.
  ///
  /// In en, this message translates to:
  /// **'No settings found'**
  String get settingsNoSettingsFound;

  /// Empty state subtitle in the settings search results.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term'**
  String get settingsTryDifferentSearch;

  /// Error text shown when the settings screen fails to load.
  ///
  /// In en, this message translates to:
  /// **'Error loading settings: {error}'**
  String settingsErrorLoading(String error);

  /// Subtitle shown for the region tile when no region has been configured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get settingsNotConfigured;

  /// Generic loading subtitle used across several settings tiles.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get settingsLoadingStatus;

  /// Section header label for the Premium section in settings.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get settingsSectionPremium;

  /// Section header label for the Feedback section in settings.
  ///
  /// In en, this message translates to:
  /// **'FEEDBACK'**
  String get settingsSectionFeedback;

  /// Section header label for the Account section in settings.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get settingsSectionAccount;

  /// Section header label for the Connection section in settings.
  ///
  /// In en, this message translates to:
  /// **'CONNECTION'**
  String get settingsSectionConnection;

  /// Section header label for the Haptic Feedback section in settings.
  ///
  /// In en, this message translates to:
  /// **'HAPTIC FEEDBACK'**
  String get settingsSectionHapticFeedback;

  /// Section header label for the Appearance section in settings.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get settingsSectionAppearance;

  /// Section header label for the What's New section in settings.
  ///
  /// In en, this message translates to:
  /// **'WHAT’S NEW'**
  String get settingsSectionWhatsNew;

  /// Section header label for the Animations section in settings.
  ///
  /// In en, this message translates to:
  /// **'ANIMATIONS'**
  String get settingsSectionAnimations;

  /// Section header label for the Notifications section in settings.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get settingsSectionNotifications;

  /// Section header label for the Messaging section in settings.
  ///
  /// In en, this message translates to:
  /// **'MESSAGING'**
  String get settingsSectionMessaging;

  /// Section header label for the Data and Storage section in settings.
  ///
  /// In en, this message translates to:
  /// **'DATA & STORAGE'**
  String get settingsSectionDataStorage;

  /// Section header label for the Device section in settings.
  ///
  /// In en, this message translates to:
  /// **'DEVICE'**
  String get settingsSectionDevice;

  /// Section header label for the Modules section in settings.
  ///
  /// In en, this message translates to:
  /// **'MODULES'**
  String get settingsSectionModules;

  /// Section header label for the Telemetry Logs section in settings.
  ///
  /// In en, this message translates to:
  /// **'TELEMETRY LOGS'**
  String get settingsSectionTelemetryLogs;

  /// Section header label for the Tools section in settings.
  ///
  /// In en, this message translates to:
  /// **'TOOLS'**
  String get settingsSectionTools;

  /// Section header label for the About section in settings.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get settingsSectionAbout;

  /// Section header label for the Social Notifications section in settings.
  ///
  /// In en, this message translates to:
  /// **'SOCIAL NOTIFICATIONS'**
  String get settingsSectionSocialNotifications;

  /// Section header label for the Remote Administration section in settings.
  ///
  /// In en, this message translates to:
  /// **'REMOTE ADMINISTRATION'**
  String get settingsSectionRemoteAdmin;

  /// Heading in the premium card when some features are locked.
  ///
  /// In en, this message translates to:
  /// **'Unlock Features'**
  String get settingsPremiumUnlockFeaturesTitle;

  /// Subtitle in the premium card when all features are owned.
  ///
  /// In en, this message translates to:
  /// **'All features unlocked!'**
  String get settingsPremiumAllUnlocked;

  /// Subtitle in the premium card showing how many features are unlocked.
  ///
  /// In en, this message translates to:
  /// **'{owned} of {total} unlocked'**
  String settingsPremiumPartiallyUnlocked(int owned, int total);

  /// Badge label on a premium feature tile in trial state.
  ///
  /// In en, this message translates to:
  /// **'TRY IT'**
  String get settingsPremiumBadgeTry;

  /// Badge label on a premium feature tile that has been purchased.
  ///
  /// In en, this message translates to:
  /// **'OWNED'**
  String get settingsPremiumBadgeOwned;

  /// Fallback badge label on a premium feature tile that is locked.
  ///
  /// In en, this message translates to:
  /// **'LOCKED'**
  String get settingsPremiumBadgeLocked;

  /// Title of the remote admin tile when a remote node is selected.
  ///
  /// In en, this message translates to:
  /// **'Configuring Remote Node'**
  String get settingsRemoteAdminConfiguringTitle;

  /// Title of the remote admin tile when viewing the local device.
  ///
  /// In en, this message translates to:
  /// **'Configure Device'**
  String get settingsRemoteAdminConfigureTitle;

  /// Fallback subtitle value in the remote admin tile when no device name is available.
  ///
  /// In en, this message translates to:
  /// **'Connected Device'**
  String get settingsRemoteAdminConnectedDevice;

  /// Trailing text on the remote admin tile showing how many adminable nodes exist.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes'**
  String settingsRemoteAdminNodeCount(int count);

  /// Warning text in the remote admin section explaining the PKI requirement.
  ///
  /// In en, this message translates to:
  /// **'Remote admin requires the target node to have your public key in its Admin Keys list.'**
  String get settingsRemoteAdminWarning;

  /// Title of the shake-to-report settings tile.
  ///
  /// In en, this message translates to:
  /// **'Shake to report a bug'**
  String get settingsTileShakeToReportTitle;

  /// Subtitle of the shake-to-report settings tile.
  ///
  /// In en, this message translates to:
  /// **'Shake your device to open the bug report flow'**
  String get settingsTileShakeToReportSubtitle;

  /// Title of the my bug reports settings tile.
  ///
  /// In en, this message translates to:
  /// **'My bug reports'**
  String get settingsTileMyBugReportsTitle;

  /// Subtitle of the my bug reports tile (when signed in).
  ///
  /// In en, this message translates to:
  /// **'View your reports and responses'**
  String get settingsTileMyBugReportsSubtitle;

  /// Subtitle of the my bug reports tile when the user is not signed in.
  ///
  /// In en, this message translates to:
  /// **'Sign in to track your reports and receive replies'**
  String get settingsTileMyBugReportsNotSignedIn;

  /// Title of the auto-reconnect settings tile.
  ///
  /// In en, this message translates to:
  /// **'Auto-reconnect'**
  String get settingsTileAutoReconnectTitle;

  /// Subtitle of the auto-reconnect settings tile.
  ///
  /// In en, this message translates to:
  /// **'Automatically reconnect to last device'**
  String get settingsTileAutoReconnectSubtitle;

  /// Title of the background connection settings tile.
  ///
  /// In en, this message translates to:
  /// **'Background connection'**
  String get settingsTileBackgroundConnectionTitle;

  /// Subtitle of the background connection settings tile.
  ///
  /// In en, this message translates to:
  /// **'Background BLE, notifications, and power settings'**
  String get settingsTileBackgroundConnectionSubtitle;

  /// Title of the provide phone location settings tile.
  ///
  /// In en, this message translates to:
  /// **'Provide phone location'**
  String get settingsTileProvideLocationTitle;

  /// Subtitle of the provide phone location settings tile.
  ///
  /// In en, this message translates to:
  /// **'Send phone GPS to mesh for devices without GPS hardware'**
  String get settingsTileProvideLocationSubtitle;

  /// Title of the haptic feedback toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get settingsTileHapticFeedbackTitle;

  /// Subtitle of the haptic feedback toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Vibration feedback for interactions'**
  String get settingsTileHapticFeedbackSubtitle;

  /// Title of the haptic intensity tile (shown when haptic feedback is enabled).
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get settingsTileIntensityTitle;

  /// Title of the appearance and accessibility settings tile.
  ///
  /// In en, this message translates to:
  /// **'Appearance & Accessibility'**
  String get settingsTileAppearanceTitle;

  /// Subtitle of the appearance and accessibility settings tile.
  ///
  /// In en, this message translates to:
  /// **'Font, text size, density, contrast, motion'**
  String get settingsTileAppearanceSubtitle;

  /// Title of the what's new settings tile.
  ///
  /// In en, this message translates to:
  /// **'What’s New'**
  String get settingsTileWhatsNewTitle;

  /// Subtitle of the what's new settings tile.
  ///
  /// In en, this message translates to:
  /// **'Browse recent features and updates'**
  String get settingsTileWhatsNewSubtitle;

  /// Title of the list animations toggle tile.
  ///
  /// In en, this message translates to:
  /// **'List animations'**
  String get settingsTileListAnimationsTitle;

  /// Subtitle of the list animations toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Slide and bounce effects on lists'**
  String get settingsTileListAnimationsSubtitle;

  /// Title of the 3D effects toggle tile.
  ///
  /// In en, this message translates to:
  /// **'3D effects'**
  String get settingsTile3dEffectsTitle;

  /// Subtitle of the 3D effects toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Perspective transforms and depth effects'**
  String get settingsTile3dEffectsSubtitle;

  /// Title of the push notifications master toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settingsTilePushNotificationsTitle;

  /// Subtitle of the push notifications master toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Master toggle for all notifications'**
  String get settingsTilePushNotificationsSubtitle;

  /// Title of the new-nodes notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'New nodes'**
  String get settingsTileNewNodesTitle;

  /// Subtitle of the new-nodes notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Notify when new nodes join the mesh'**
  String get settingsTileNewNodesSubtitle;

  /// Title of the direct messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Direct messages'**
  String get settingsTileDirectMessagesTitle;

  /// Subtitle of the direct messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Notify for private messages'**
  String get settingsTileDirectMessagesSubtitle;

  /// Title of the channel messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Channel messages'**
  String get settingsTileChannelMessagesTitle;

  /// Subtitle of the channel messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Notify for channel broadcasts'**
  String get settingsTileChannelMessagesSubtitle;

  /// Title of the notification sound toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsTileSoundTitle;

  /// Subtitle of the notification sound toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Play sound with notifications'**
  String get settingsTileSoundSubtitle;

  /// Title of the notification vibration toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsTileVibrationTitle;

  /// Subtitle of the notification vibration toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Vibrate with notifications'**
  String get settingsTileVibrationSubtitle;

  /// Title of the quick responses settings tile.
  ///
  /// In en, this message translates to:
  /// **'Quick responses'**
  String get settingsTileQuickResponsesTitle;

  /// Subtitle of the quick responses settings tile.
  ///
  /// In en, this message translates to:
  /// **'Manage canned responses for fast messaging'**
  String get settingsTileQuickResponsesSubtitle;

  /// Title of the canned messages module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Canned Messages Module'**
  String get settingsTileCannedMessagesTitle;

  /// Subtitle of the canned messages module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device-side canned message settings'**
  String get settingsTileCannedMessagesSubtitle;

  /// Title of the message history limit settings tile.
  ///
  /// In en, this message translates to:
  /// **'Message history'**
  String get settingsTileMessageHistoryTitle;

  /// Subtitle of the message history limit tile showing the current limit.
  ///
  /// In en, this message translates to:
  /// **'{count} messages stored'**
  String settingsTileMessageHistorySubtitle(int count);

  /// Title of the export messages settings tile.
  ///
  /// In en, this message translates to:
  /// **'Export Messages'**
  String get settingsTileExportMessagesTitle;

  /// Subtitle of the export messages settings tile.
  ///
  /// In en, this message translates to:
  /// **'Export messages to PDF or CSV'**
  String get settingsTileExportMessagesSubtitle;

  /// Title of the clear message history settings tile.
  ///
  /// In en, this message translates to:
  /// **'Clear message history'**
  String get settingsTileClearMessageHistoryTitle;

  /// Subtitle of the clear message history settings tile.
  ///
  /// In en, this message translates to:
  /// **'Delete all stored messages'**
  String get settingsTileClearMessageHistorySubtitle;

  /// Title of the reset local data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Reset local data'**
  String get settingsTileResetLocalDataTitle;

  /// Subtitle of the reset local data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Clear messages and nodes, keep settings'**
  String get settingsTileResetLocalDataSubtitle;

  /// Title of the clear all data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Clear all data'**
  String get settingsTileClearAllDataTitle;

  /// Subtitle of the clear all data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Delete messages, settings, and keys'**
  String get settingsTileClearAllDataSubtitle;

  /// Title of the force sync settings tile.
  ///
  /// In en, this message translates to:
  /// **'Force Sync'**
  String get settingsTileForceSyncTitle;

  /// Subtitle of the force sync settings tile.
  ///
  /// In en, this message translates to:
  /// **'Re-sync all data from connected device'**
  String get settingsTileForceSyncSubtitle;

  /// Title of the region/frequency settings tile.
  ///
  /// In en, this message translates to:
  /// **'Region / Frequency'**
  String get settingsTileRegionTitle;

  /// Title of the device role settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device Role & Settings'**
  String get settingsTileDeviceRoleTitle;

  /// Subtitle of the device role settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure device behavior and role'**
  String get settingsTileDeviceRoleSubtitle;

  /// Title of the radio configuration settings tile.
  ///
  /// In en, this message translates to:
  /// **'Radio Configuration'**
  String get settingsTileRadioConfigTitle;

  /// Subtitle of the radio configuration settings tile.
  ///
  /// In en, this message translates to:
  /// **'LoRa settings, modem preset, power'**
  String get settingsTileRadioConfigSubtitle;

  /// Title of the position & GPS settings tile.
  ///
  /// In en, this message translates to:
  /// **'Position & GPS'**
  String get settingsTilePositionTitle;

  /// Subtitle of the position & GPS settings tile.
  ///
  /// In en, this message translates to:
  /// **'GPS mode, broadcast intervals, fixed position'**
  String get settingsTilePositionSubtitle;

  /// Title of the display settings tile.
  ///
  /// In en, this message translates to:
  /// **'Display Settings'**
  String get settingsTileDisplaySettingsTitle;

  /// Subtitle of the display settings tile.
  ///
  /// In en, this message translates to:
  /// **'Screen timeout, units, display mode'**
  String get settingsTileDisplaySettingsSubtitle;

  /// Title of the Bluetooth device settings tile.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get settingsTileBluetoothTitle;

  /// Subtitle of the Bluetooth device settings tile.
  ///
  /// In en, this message translates to:
  /// **'Pairing mode, PIN settings'**
  String get settingsTileBluetoothSubtitle;

  /// Title of the network settings tile.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get settingsTileNetworkTitle;

  /// Subtitle of the network settings tile.
  ///
  /// In en, this message translates to:
  /// **'WiFi, Ethernet, NTP settings'**
  String get settingsTileNetworkSubtitle;

  /// Title of the power management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Power Management'**
  String get settingsTilePowerManagementTitle;

  /// Subtitle of the power management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Power saving, sleep settings'**
  String get settingsTilePowerManagementSubtitle;

  /// Title of the security settings tile.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsTileSecurityTitle;

  /// Subtitle of the security settings tile.
  ///
  /// In en, this message translates to:
  /// **'Access controls, managed mode'**
  String get settingsTileSecuritySubtitle;

  /// Title of the device management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device Management'**
  String get settingsTileDeviceManagementTitle;

  /// Subtitle of the device management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Reboot, shutdown, factory reset'**
  String get settingsTileDeviceManagementSubtitle;

  /// Title of the device info settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device info'**
  String get settingsTileDeviceInfoTitle;

  /// Subtitle of the device info settings tile.
  ///
  /// In en, this message translates to:
  /// **'View connected device details'**
  String get settingsTileDeviceInfoSubtitle;

  /// Title of the scan QR code settings tile.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get settingsTileScanQrCodeTitle;

  /// Subtitle of the scan QR code settings tile.
  ///
  /// In en, this message translates to:
  /// **'Import nodes, channels, or automations'**
  String get settingsTileScanQrCodeSubtitle;

  /// Title of the MQTT module settings tile.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get settingsTileMqttTitle;

  /// Subtitle of the MQTT module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure mesh-to-internet bridge'**
  String get settingsTileMqttSubtitle;

  /// Title of the range test module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Range Test'**
  String get settingsTileRangeTestTitle;

  /// Subtitle of the range test module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Test signal range with other nodes'**
  String get settingsTileRangeTestSubtitle;

  /// Title of the store & forward module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Store & Forward'**
  String get settingsTileStoreForwardTitle;

  /// Subtitle of the store & forward module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Store and relay messages for offline nodes'**
  String get settingsTileStoreForwardSubtitle;

  /// Title of the detection sensor module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Detection Sensor'**
  String get settingsTileDetectionSensorTitle;

  /// Subtitle of the detection sensor module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure GPIO-based motion/door sensors'**
  String get settingsTileDetectionSensorSubtitle;

  /// Title of the external notification module settings tile.
  ///
  /// In en, this message translates to:
  /// **'External Notification'**
  String get settingsTileExternalNotificationTitle;

  /// Subtitle of the external notification module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure buzzers, LEDs, and vibration alerts'**
  String get settingsTileExternalNotificationSubtitle;

  /// Title of the ambient lighting module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Ambient Lighting'**
  String get settingsTileAmbientLightingTitle;

  /// Subtitle of the ambient lighting module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure LED and RGB settings'**
  String get settingsTileAmbientLightingSubtitle;

  /// Title of the PAX counter module settings tile.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter'**
  String get settingsTilePaxCounterTitle;

  /// Subtitle of the PAX counter module settings tile.
  ///
  /// In en, this message translates to:
  /// **'WiFi/BLE device detection settings'**
  String get settingsTilePaxCounterSubtitle;

  /// Title of the telemetry intervals settings tile.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Intervals'**
  String get settingsTileTelemetryIntervalsTitle;

  /// Subtitle of the telemetry intervals settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure telemetry update frequency'**
  String get settingsTileTelemetryIntervalsSubtitle;

  /// Title of the serial module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Serial'**
  String get settingsTileSerialTitle;

  /// Subtitle of the serial module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Serial port configuration'**
  String get settingsTileSerialSubtitle;

  /// Title of the traffic management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Traffic Management'**
  String get settingsTileTrafficManagementTitle;

  /// Subtitle of the traffic management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Mesh traffic optimization and filtering'**
  String get settingsTileTrafficManagementSubtitle;

  /// Title of the device metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get settingsTileDeviceMetricsTitle;

  /// Subtitle of the device metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Battery, voltage, utilization history'**
  String get settingsTileDeviceMetricsSubtitle;

  /// Title of the environment metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Environment Metrics'**
  String get settingsTileEnvironmentMetricsTitle;

  /// Subtitle of the environment metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Temperature, humidity, pressure logs'**
  String get settingsTileEnvironmentMetricsSubtitle;

  /// Title of the air quality telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get settingsTileAirQualityTitle;

  /// Subtitle of the air quality telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'PM2.5, PM10, CO2 readings'**
  String get settingsTileAirQualitySubtitle;

  /// Title of the position history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Position History'**
  String get settingsTilePositionHistoryTitle;

  /// Subtitle of the position history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'GPS position logs'**
  String get settingsTilePositionHistorySubtitle;

  /// Title of the traceroute history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Traceroute History'**
  String get settingsTileTracerouteHistoryTitle;

  /// Subtitle of the traceroute history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Network path analysis logs'**
  String get settingsTileTracerouteHistorySubtitle;

  /// Title of the PAX counter logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter Logs'**
  String get settingsTilePaxCounterLogsTitle;

  /// Subtitle of the PAX counter logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'Device detection history'**
  String get settingsTilePaxCounterLogsSubtitle;

  /// Title of the detection sensor logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'Detection Sensor Logs'**
  String get settingsTileDetectionSensorLogsTitle;

  /// Subtitle of the detection sensor logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'Sensor event history'**
  String get settingsTileDetectionSensorLogsSubtitle;

  /// Title of the routes tools tile.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get settingsTileRoutesTitle;

  /// Subtitle of the routes tools tile.
  ///
  /// In en, this message translates to:
  /// **'Record and manage GPS routes'**
  String get settingsTileRoutesSubtitle;

  /// Title of the GPS status tools tile.
  ///
  /// In en, this message translates to:
  /// **'GPS Status'**
  String get settingsTileGpsStatusTitle;

  /// Subtitle of the GPS status tools tile.
  ///
  /// In en, this message translates to:
  /// **'View detailed GPS information'**
  String get settingsTileGpsStatusSubtitle;

  /// Title of the firmware update tools tile.
  ///
  /// In en, this message translates to:
  /// **'Firmware Update'**
  String get settingsTileFirmwareUpdateTitle;

  /// Subtitle of the firmware update tools tile.
  ///
  /// In en, this message translates to:
  /// **'Check for device firmware updates'**
  String get settingsTileFirmwareUpdateSubtitle;

  /// Title of the export data tools tile.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get settingsTileExportDataTitle;

  /// Subtitle of the export data tools tile.
  ///
  /// In en, this message translates to:
  /// **'Export messages, telemetry, routes'**
  String get settingsTileExportDataSubtitle;

  /// Title of the app log tools tile.
  ///
  /// In en, this message translates to:
  /// **'App Log'**
  String get settingsTileAppLogTitle;

  /// Subtitle of the app log tools tile.
  ///
  /// In en, this message translates to:
  /// **'View application debug logs'**
  String get settingsTileAppLogSubtitle;

  /// Title of the glyph matrix test tile (Nothing Phone 3 only).
  ///
  /// In en, this message translates to:
  /// **'Glyph Matrix Test'**
  String get settingsTileGlyphMatrixTitle;

  /// Subtitle of the glyph matrix test tile.
  ///
  /// In en, this message translates to:
  /// **'Nothing Phone 3 LED patterns'**
  String get settingsTileGlyphMatrixSubtitle;

  /// Title of the Socialmesh about tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh'**
  String get settingsTileSocialmeshTitle;

  /// Subtitle of the Socialmesh about tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic companion app'**
  String get settingsTileSocialmeshSubtitle;

  /// Title of the Help Center tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get settingsTileHelpCenterTitle;

  /// Subtitle of the Help Center tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Interactive guides with Ico, your mesh guide'**
  String get settingsTileHelpCenterSubtitle;

  /// Title of the Help & Support tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsTileHelpSupportTitle;

  /// Subtitle of the Help & Support tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'FAQ, troubleshooting, and contact info'**
  String get settingsTileHelpSupportSubtitle;

  /// Title of the Terms of Service tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get settingsTileTermsOfServiceTitle;

  /// Subtitle of the Terms of Service tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Legal terms and conditions'**
  String get settingsTileTermsOfServiceSubtitle;

  /// Title of the Privacy Policy tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsTilePrivacyPolicyTitle;

  /// Subtitle of the Privacy Policy tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get settingsTilePrivacyPolicySubtitle;

  /// Title of the Open Source Licenses tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get settingsTileOpenSourceTitle;

  /// Subtitle of the Open Source Licenses tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Third-party libraries and attributions'**
  String get settingsTileOpenSourceSubtitle;

  /// Title of the haptic intensity picker bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Haptic Intensity'**
  String get settingsHapticIntensityTitle;

  /// Description for the light/subtle haptic intensity option.
  ///
  /// In en, this message translates to:
  /// **'Subtle feedback for a gentle touch'**
  String get settingsHapticSubtleDescription;

  /// Description for the medium haptic intensity option.
  ///
  /// In en, this message translates to:
  /// **'Balanced feedback for most interactions'**
  String get settingsHapticMediumDescription;

  /// Description for the heavy/strong haptic intensity option.
  ///
  /// In en, this message translates to:
  /// **'Strong feedback for clear confirmation'**
  String get settingsHapticStrongDescription;

  /// Title of the message history limit picker bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Message History Limit'**
  String get settingsHistoryLimitTitle;

  /// List tile label for a message history limit option.
  ///
  /// In en, this message translates to:
  /// **'{limit} messages'**
  String settingsHistoryLimitOption(int limit);

  /// Title of the clear messages confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear Messages'**
  String get settingsClearMessagesTitle;

  /// Body of the clear messages confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will delete all stored messages. This action cannot be undone.'**
  String get settingsClearMessagesMessage;

  /// Confirm label for the clear messages sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsClearMessagesLabel;

  /// Success snackbar after clearing all messages.
  ///
  /// In en, this message translates to:
  /// **'Messages cleared'**
  String get settingsClearMessagesSuccess;

  /// Title of the reset local data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset Local Data'**
  String get settingsResetLocalDataTitle;

  /// Body of the reset local data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will clear all messages and node data, forcing a fresh sync from your device on next connection.\n\nYour settings, theme, and preferences will be kept.\n\nUse this if nodes show incorrect status or messages appear wrong.'**
  String get settingsResetLocalDataMessage;

  /// Confirm label for the reset local data sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get settingsResetLocalDataLabel;

  /// Success snackbar after resetting local data.
  ///
  /// In en, this message translates to:
  /// **'Local data reset. Reconnect to sync fresh data.'**
  String get settingsResetLocalDataSuccess;

  /// Error snackbar when force sync is triggered without a connected device.
  ///
  /// In en, this message translates to:
  /// **'Not connected to a device'**
  String get settingsForceSyncNotConnected;

  /// Title of the force sync confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Force Sync'**
  String get settingsForceSyncTitle;

  /// Body of the force sync confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will clear all local messages, nodes, and channels, then re-sync everything from the connected device.\n\nAre you sure you want to continue?'**
  String get settingsForceSyncMessage;

  /// Confirm label for the force sync sheet.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get settingsForceSyncLabel;

  /// Loading text shown inside the sync-in-progress bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Syncing from device…'**
  String get settingsForceSyncingStatus;

  /// Success snackbar after a successful force sync.
  ///
  /// In en, this message translates to:
  /// **'Sync complete'**
  String get settingsForceSyncSuccess;

  /// Error snackbar when force sync fails.
  ///
  /// In en, this message translates to:
  /// **'Sync failed: {error}'**
  String settingsForceSyncFailed(String error);

  /// Title of the clear all data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get settingsClearAllDataTitle;

  /// Body of the clear all data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will delete ALL app data: messages, nodes, channels, settings, keys, signals, bookmarks, automations, widgets, and saved preferences. This action cannot be undone.'**
  String get settingsClearAllDataMessage;

  /// Confirm label for the clear all data sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get settingsClearAllDataLabel;

  /// Success snackbar after clearing all app data.
  ///
  /// In en, this message translates to:
  /// **'All data cleared successfully'**
  String get settingsClearAllDataSuccess;

  /// Error snackbar when clearing all data only partially succeeds.
  ///
  /// In en, this message translates to:
  /// **'Failed to clear some data: {error}'**
  String settingsClearAllDataFailed(String error);

  /// Header title in the device information bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get settingsDeviceInfoTitle;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get settingsDeviceInfoDeviceName;

  /// Fallback value in the device information sheet when not connected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get settingsDeviceInfoNotConnected;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get settingsDeviceInfoConnection;

  /// Fallback value for the connection row in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get settingsDeviceInfoNone;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Node Number'**
  String get settingsDeviceInfoNodeNumber;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Long Name'**
  String get settingsDeviceInfoLongName;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Short Name'**
  String get settingsDeviceInfoShortName;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get settingsDeviceInfoHardware;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get settingsDeviceInfoUserId;

  /// Fallback value for unknown fields in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get settingsDeviceInfoUnknown;

  /// Title of the profile tile when no profile is loaded.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settingsProfileTitle;

  /// Subtitle of the profile tile when no profile exists.
  ///
  /// In en, this message translates to:
  /// **'Set up your profile'**
  String get settingsProfileSubtitle;

  /// Tag text on the profile tile when the profile is synced to the cloud.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get settingsProfileSynced;

  /// Tag text on the profile tile when the profile exists only locally.
  ///
  /// In en, this message translates to:
  /// **'Local only'**
  String get settingsProfileLocalOnly;

  /// Title of the Privacy settings tile in the Account section.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsTilePrivacyTitle;

  /// Subtitle of the Privacy settings tile in the Account section.
  ///
  /// In en, this message translates to:
  /// **'Analytics, crash reporting, and data controls'**
  String get settingsTilePrivacySubtitle;

  /// App version label in the About section.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersionString(String version);

  /// Snackbar text shown when tapping the Socialmesh about tile.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh v{version}'**
  String settingsSocialmeshVersionSnackbar(String version);

  /// Fallback subtitle for the Region tile when the region configuration fails to load.
  ///
  /// In en, this message translates to:
  /// **'Configure device radio frequency'**
  String get settingsRegionConfigureSubtitle;

  /// Title of the social notifications tile while preferences are loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get settingsSocialNotificationsLoading;

  /// Subtitle of the social notifications tile while preferences are loading.
  ///
  /// In en, this message translates to:
  /// **'Fetching notification preferences'**
  String get settingsSocialNotificationsLoadingSubtitle;

  /// Title of the new followers social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'New followers'**
  String get settingsSocialNewFollowersTitle;

  /// Subtitle of the new followers social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'When someone follows you or sends a request'**
  String get settingsSocialNewFollowersSubtitle;

  /// Title of the likes social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get settingsSocialLikesTitle;

  /// Subtitle of the likes social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'When someone likes your posts'**
  String get settingsSocialLikesSubtitle;

  /// Title of the comments & mentions social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'Comments & mentions'**
  String get settingsSocialCommentsTitle;

  /// Subtitle of the comments & mentions social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'When someone comments or @mentions you'**
  String get settingsSocialCommentsSubtitle;

  /// Initial title of the Meshtastic web view screen.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic'**
  String get settingsMeshtasticWebViewTitle;

  /// Tooltip for the back navigation button in the Meshtastic web view.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get settingsMeshtasticGoBack;

  /// Tooltip for the refresh button in the Meshtastic web view.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get settingsMeshtasticRefresh;

  /// Error title in the offline placeholder of the Meshtastic web view.
  ///
  /// In en, this message translates to:
  /// **'Unable to load page'**
  String get settingsMeshtasticUnableToLoad;

  /// Error body in the offline placeholder of the Meshtastic web view.
  ///
  /// In en, this message translates to:
  /// **'This content requires an internet connection. Please check your connection and try again.'**
  String get settingsMeshtasticOfflineMessage;

  /// Application name passed to the Flutter LicensePage.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh'**
  String get settingsOpenSourceAppName;

  /// Legalese text passed to the Flutter LicensePage.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Socialmesh\n\nThis app uses open source software. See below for the complete list of third-party licenses.'**
  String get settingsOpenSourceLegalese;

  /// Subtitle for the Unlock Features search item in the premium section.
  ///
  /// In en, this message translates to:
  /// **'Ringtones, themes, automations, IFTTT, widgets'**
  String get settingsSearchPremiumSubtitle;

  /// Fallback title for the ringtone pack search item.
  ///
  /// In en, this message translates to:
  /// **'Ringtone Pack'**
  String get settingsSearchRingtonePackTitle;

  /// Subtitle for the ringtone pack search item.
  ///
  /// In en, this message translates to:
  /// **'Custom notification sounds'**
  String get settingsSearchRingtonePackSubtitle;

  /// Fallback title for the theme pack search item.
  ///
  /// In en, this message translates to:
  /// **'Theme Pack'**
  String get settingsSearchThemePackTitle;

  /// Subtitle for the theme pack search item.
  ///
  /// In en, this message translates to:
  /// **'Accent colors and visual customization'**
  String get settingsSearchThemePackSubtitle;

  /// Fallback title for the automations pack search item.
  ///
  /// In en, this message translates to:
  /// **'Automations Pack'**
  String get settingsSearchAutomationsPackTitle;

  /// Subtitle for the automations pack search item.
  ///
  /// In en, this message translates to:
  /// **'Automated actions and triggers'**
  String get settingsSearchAutomationsPackSubtitle;

  /// Fallback title for the IFTTT pack search item.
  ///
  /// In en, this message translates to:
  /// **'IFTTT Pack'**
  String get settingsSearchIftttPackTitle;

  /// Subtitle for the IFTTT pack search item.
  ///
  /// In en, this message translates to:
  /// **'Integration with external services'**
  String get settingsSearchIftttPackSubtitle;

  /// Fallback title for the widget pack search item.
  ///
  /// In en, this message translates to:
  /// **'Widget Pack'**
  String get settingsSearchWidgetPackTitle;

  /// Subtitle for the widget pack search item.
  ///
  /// In en, this message translates to:
  /// **'Home screen widgets'**
  String get settingsSearchWidgetPackSubtitle;

  /// Subtitle for the Profile search item.
  ///
  /// In en, this message translates to:
  /// **'Your display name, avatar, and bio'**
  String get settingsSearchProfileSubtitle;

  /// Subtitle for the New followers search item.
  ///
  /// In en, this message translates to:
  /// **'Push notifications when someone follows you'**
  String get settingsSearchNewFollowersSubtitle;

  /// Subtitle for the Likes search item.
  ///
  /// In en, this message translates to:
  /// **'Push notifications for post likes'**
  String get settingsSearchLikesSubtitle;

  /// Subtitle for the Comments & mentions search item.
  ///
  /// In en, this message translates to:
  /// **'Push notifications for comments and @mentions'**
  String get settingsSearchCommentsSubtitle;

  /// Title for the Linked Devices search item.
  ///
  /// In en, this message translates to:
  /// **'Linked Devices'**
  String get settingsSearchLinkedDevicesTitle;

  /// Subtitle for the Linked Devices search item.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic devices connected to your profile'**
  String get settingsSearchLinkedDevicesSubtitle;

  /// Title for the TAK Gateway search item in the Connection section.
  ///
  /// In en, this message translates to:
  /// **'TAK Gateway'**
  String get settingsSearchTakGatewayTitle;

  /// Subtitle for the TAK Gateway search item.
  ///
  /// In en, this message translates to:
  /// **'Gateway URL, position publishing, callsign'**
  String get settingsSearchTakGatewaySubtitle;

  /// Subtitle for the Haptic Intensity search item.
  ///
  /// In en, this message translates to:
  /// **'Light, medium, or heavy feedback'**
  String get settingsSearchHapticIntensitySubtitle;

  /// Title for the new nodes notifications search item.
  ///
  /// In en, this message translates to:
  /// **'New nodes notifications'**
  String get settingsSearchNewNodesNotificationsTitle;

  /// Subtitle for the new nodes notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Notify when new nodes join the mesh'**
  String get settingsSearchNewNodesNotificationsSubtitle;

  /// Title for the direct message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Direct message notifications'**
  String get settingsSearchDmNotificationsTitle;

  /// Subtitle for the direct message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Notify for private messages'**
  String get settingsSearchDmNotificationsSubtitle;

  /// Title for the channel message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Channel message notifications'**
  String get settingsSearchChannelNotificationsTitle;

  /// Subtitle for the channel message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Notify for channel broadcasts'**
  String get settingsSearchChannelNotificationsSubtitle;

  /// Title for the notification sound search item.
  ///
  /// In en, this message translates to:
  /// **'Notification sound'**
  String get settingsSearchNotificationSoundTitle;

  /// Subtitle for the notification sound search item.
  ///
  /// In en, this message translates to:
  /// **'Play sound for notifications'**
  String get settingsSearchNotificationSoundSubtitle;

  /// Title for the notification vibration search item.
  ///
  /// In en, this message translates to:
  /// **'Notification vibration'**
  String get settingsSearchNotificationVibrationTitle;

  /// Subtitle for the notification vibration search item.
  ///
  /// In en, this message translates to:
  /// **'Vibrate for notifications'**
  String get settingsSearchNotificationVibrationSubtitle;

  /// Title for the canned messages search item.
  ///
  /// In en, this message translates to:
  /// **'Canned Messages'**
  String get settingsSearchCannedMessagesTitle;

  /// Subtitle for the canned messages search item.
  ///
  /// In en, this message translates to:
  /// **'Pre-configured device messages'**
  String get settingsSearchCannedMessagesSubtitle;

  /// Title for the file transfer search item.
  ///
  /// In en, this message translates to:
  /// **'File transfer'**
  String get settingsSearchFileTransferTitle;

  /// Subtitle for the file transfer search item.
  ///
  /// In en, this message translates to:
  /// **'Send and receive small files over mesh'**
  String get settingsSearchFileTransferSubtitle;

  /// Title for the auto-accept transfers search item.
  ///
  /// In en, this message translates to:
  /// **'Auto-accept transfers'**
  String get settingsSearchAutoAcceptTransfersTitle;

  /// Subtitle for the auto-accept transfers search item.
  ///
  /// In en, this message translates to:
  /// **'Automatically accept incoming file offers'**
  String get settingsSearchAutoAcceptTransfersSubtitle;

  /// Title for the message history limit search item.
  ///
  /// In en, this message translates to:
  /// **'Message history limit'**
  String get settingsSearchHistoryLimitTitle;

  /// Subtitle for the message history limit search item.
  ///
  /// In en, this message translates to:
  /// **'Maximum messages to keep'**
  String get settingsSearchHistoryLimitSubtitle;

  /// Title for the export data search item (lowercase variant).
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get settingsSearchExportDataTitle;

  /// Subtitle for the export data search item.
  ///
  /// In en, this message translates to:
  /// **'Export messages and settings'**
  String get settingsSearchExportDataSubtitle;

  /// Title for the clear all messages search item.
  ///
  /// In en, this message translates to:
  /// **'Clear all messages'**
  String get settingsSearchClearAllMessagesTitle;

  /// Subtitle for the clear all messages search item.
  ///
  /// In en, this message translates to:
  /// **'Delete all stored messages'**
  String get settingsSearchClearAllMessagesSubtitle;

  /// Title for the reset local data search item.
  ///
  /// In en, this message translates to:
  /// **'Reset local data'**
  String get settingsSearchResetLocalDataTitle;

  /// Subtitle for the reset local data search item.
  ///
  /// In en, this message translates to:
  /// **'Clear all local app data'**
  String get settingsSearchResetLocalDataSubtitle;

  /// Subtitle for the clear all data search item.
  ///
  /// In en, this message translates to:
  /// **'Delete messages, settings, and keys'**
  String get settingsSearchClearAllDataSubtitle;

  /// Title for the remote administration search item.
  ///
  /// In en, this message translates to:
  /// **'Remote Administration'**
  String get settingsSearchRemoteAdminTitle;

  /// Subtitle for the remote administration search item.
  ///
  /// In en, this message translates to:
  /// **'Configure remote nodes via PKI admin'**
  String get settingsSearchRemoteAdminSubtitle;

  /// Title for the force sync search item (lowercase variant).
  ///
  /// In en, this message translates to:
  /// **'Force sync'**
  String get settingsSearchForceSyncTitle;

  /// Subtitle for the force sync search item.
  ///
  /// In en, this message translates to:
  /// **'Force configuration sync'**
  String get settingsSearchForceSyncSubtitle;

  /// Title for the scan for device search item.
  ///
  /// In en, this message translates to:
  /// **'Scan for device'**
  String get settingsSearchScanForDeviceTitle;

  /// Subtitle for the scan for device search item.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code for easy setup'**
  String get settingsSearchScanForDeviceSubtitle;

  /// Title for the region search item.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get settingsSearchRegionTitle;

  /// Subtitle for the region search item.
  ///
  /// In en, this message translates to:
  /// **'Device radio frequency region'**
  String get settingsSearchRegionSubtitle;

  /// Title for the device config search item.
  ///
  /// In en, this message translates to:
  /// **'Device config'**
  String get settingsSearchDeviceConfigTitle;

  /// Subtitle for the device config search item.
  ///
  /// In en, this message translates to:
  /// **'Device name, role, and behavior'**
  String get settingsSearchDeviceConfigSubtitle;

  /// Title for the radio config search item (lowercase variant).
  ///
  /// In en, this message translates to:
  /// **'Radio config'**
  String get settingsSearchRadioConfigTitle;

  /// Subtitle for the radio config search item.
  ///
  /// In en, this message translates to:
  /// **'LoRa, modem, channel settings'**
  String get settingsSearchRadioConfigSubtitle;

  /// Title for the position config search item.
  ///
  /// In en, this message translates to:
  /// **'Position config'**
  String get settingsSearchPositionConfigTitle;

  /// Subtitle for the position config search item.
  ///
  /// In en, this message translates to:
  /// **'GPS and position sharing'**
  String get settingsSearchPositionConfigSubtitle;

  /// Title for the display config search item.
  ///
  /// In en, this message translates to:
  /// **'Display config'**
  String get settingsSearchDisplayConfigTitle;

  /// Subtitle for the display config search item.
  ///
  /// In en, this message translates to:
  /// **'Screen brightness and timeout'**
  String get settingsSearchDisplayConfigSubtitle;

  /// Title for the Bluetooth config search item.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth config'**
  String get settingsSearchBluetoothConfigTitle;

  /// Subtitle for the Bluetooth config search item.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth settings and PIN'**
  String get settingsSearchBluetoothConfigSubtitle;

  /// Title for the network config search item.
  ///
  /// In en, this message translates to:
  /// **'Network config'**
  String get settingsSearchNetworkConfigTitle;

  /// Subtitle for the network config search item.
  ///
  /// In en, this message translates to:
  /// **'WiFi and network settings'**
  String get settingsSearchNetworkConfigSubtitle;

  /// Title for the power config search item.
  ///
  /// In en, this message translates to:
  /// **'Power config'**
  String get settingsSearchPowerConfigTitle;

  /// Subtitle for the power config search item.
  ///
  /// In en, this message translates to:
  /// **'Power saving and sleep settings'**
  String get settingsSearchPowerConfigSubtitle;

  /// Title for the import channel via QR search item.
  ///
  /// In en, this message translates to:
  /// **'Import channel via QR'**
  String get settingsSearchImportChannelTitle;

  /// Subtitle for the import channel via QR search item.
  ///
  /// In en, this message translates to:
  /// **'Scan a Meshtastic channel QR code'**
  String get settingsSearchImportChannelSubtitle;

  /// Subtitle for the Socialmesh search item in the About section.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic companion app'**
  String get settingsSearchSocialmeshSubtitle;

  /// Subtitle for the Help & Support search item.
  ///
  /// In en, this message translates to:
  /// **'FAQ, troubleshooting, and contact info'**
  String get settingsSearchHelpSupportSubtitle;

  /// Subtitle for the Terms of Service search item.
  ///
  /// In en, this message translates to:
  /// **'Legal terms and conditions'**
  String get settingsSearchTermsSubtitle;

  /// Subtitle for the Privacy Policy search item.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get settingsSearchPrivacySubtitle;

  /// Error message when the OS removes stored BLE pairing data for the device.
  ///
  /// In en, this message translates to:
  /// **'Your phone removed the stored pairing info for this device. Return to Settings > Bluetooth, forget \"Meshtastic_XXXX\", and try again.'**
  String get scannerPairingInvalidatedError;

  /// User-friendly error message for GATT_ERROR 133 or discovery failed BLE errors.
  ///
  /// In en, this message translates to:
  /// **'Connection failed. This can happen if the device was previously paired with another app. Go to Settings > Bluetooth, find the Meshtastic device, tap \"Forget\", then try again.'**
  String get scannerGattConnectionFailed;

  /// User-friendly error message for BLE connection timeout errors.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. The device may be out of range, powered off, or connected to another phone.'**
  String get scannerConnectionTimedOut;

  /// User-friendly error message when the device disconnects unexpectedly during connection.
  ///
  /// In en, this message translates to:
  /// **'The device disconnected unexpectedly. It may have gone out of range or lost power.'**
  String get scannerDeviceDisconnectedUnexpectedly;

  /// Section header for the admin area in the navigation drawer.
  ///
  /// In en, this message translates to:
  /// **'ADMIN'**
  String get drawerAdminSectionHeader;

  /// Label for the Admin Dashboard menu tile in the navigation drawer.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get drawerAdminDashboard;

  /// Fallback node name shown in drawer header when no device is connected.
  ///
  /// In en, this message translates to:
  /// **'Not Connected'**
  String get drawerNodeNotConnected;

  /// Connection status chip label when the device is connected.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get drawerNodeOnline;

  /// Connection status chip label when the device is disconnected.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get drawerNodeOffline;

  /// Badge label for newly added drawer menu items.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get drawerBadgeNew;

  /// Badge label for locked premium features in the drawer.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get drawerBadgePro;

  /// Badge label for premium features available to try in the drawer.
  ///
  /// In en, this message translates to:
  /// **'TRY IT'**
  String get drawerBadgeTryIt;

  /// Section header for the enterprise (RBAC) area in the navigation drawer.
  ///
  /// In en, this message translates to:
  /// **'ENTERPRISE'**
  String get drawerEnterpriseSectionHeader;

  /// Label for the Incidents menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Incidents'**
  String get drawerEnterpriseIncidents;

  /// Label for the Tasks menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get drawerEnterpriseTasks;

  /// Label for the Field Reports menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Field Reports'**
  String get drawerEnterpriseFieldReports;

  /// Label for the Reports menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get drawerEnterpriseReports;

  /// Tooltip shown when a user without sufficient role tries to access export reports.
  ///
  /// In en, this message translates to:
  /// **'Requires Supervisor or Admin role'**
  String get drawerEnterpriseExportDenied;

  /// Label for the User Management menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'User Management'**
  String get drawerEnterpriseUserManagement;

  /// Label for the Device Management menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Device Management'**
  String get drawerEnterpriseDeviceManagement;

  /// Label for the Org Settings menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Org Settings'**
  String get drawerEnterpriseOrgSettings;

  /// Title shown in the discovery overlay while scanning for mesh nodes.
  ///
  /// In en, this message translates to:
  /// **'Scanning Network'**
  String get discoveryScanningNetwork;

  /// Subtitle shown while no nodes have been discovered yet.
  ///
  /// In en, this message translates to:
  /// **'Searching for nodes...'**
  String get discoverySearchingForNodes;

  /// Subtitle showing the number of discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 node found} other{{count} nodes found}}'**
  String discoveryNodesFound(int count);

  /// Fallback display name for a discovered node with no name.
  ///
  /// In en, this message translates to:
  /// **'Unknown Node'**
  String get discoveryUnknownNode;

  /// Signal quality label for strong RSSI values.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get discoverySignalExcellent;

  /// Signal quality label for moderate RSSI values.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get discoverySignalGood;

  /// Signal quality label for poor RSSI values.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get discoverySignalWeak;

  /// Badge label shown on newly discovered node cards.
  ///
  /// In en, this message translates to:
  /// **'DISCOVERED'**
  String get discoveryDiscoveredBadge;

  /// Tooltip for the hamburger menu button in the MeshCore app bar.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get meshcoreShellMenuTooltip;

  /// Tooltip for the device status button in the MeshCore app bar.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get meshcoreShellDeviceTooltip;

  /// Bottom navigation label for the Contacts tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get meshcoreShellNavContacts;

  /// Bottom navigation label for the Channels tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get meshcoreShellNavChannels;

  /// Bottom navigation label for the Map tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get meshcoreShellNavMap;

  /// Bottom navigation label for the Tools tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get meshcoreShellNavTools;

  /// Fallback short device name for MeshCore when no name is saved.
  ///
  /// In en, this message translates to:
  /// **'MeshCore'**
  String get meshcoreShellDefaultDeviceName;

  /// Banner text shown when the MeshCore device disconnects.
  ///
  /// In en, this message translates to:
  /// **'Disconnected from {deviceName}'**
  String meshcoreShellDisconnectedFrom(String deviceName);

  /// Button label to reconnect to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get meshcoreShellReconnectButton;

  /// Section header for the MeshCore menu items in the drawer.
  ///
  /// In en, this message translates to:
  /// **'MESHCORE'**
  String get meshcoreShellDrawerSectionHeader;

  /// Drawer menu item label for adding a MeshCore contact.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get meshcoreShellDrawerAddContact;

  /// Drawer menu item label for adding a MeshCore channel.
  ///
  /// In en, this message translates to:
  /// **'Add Channel'**
  String get meshcoreShellDrawerAddChannel;

  /// Drawer menu item label for discovering nearby MeshCore contacts.
  ///
  /// In en, this message translates to:
  /// **'Discover Contacts'**
  String get meshcoreShellDrawerDiscoverContacts;

  /// Drawer menu item label for showing the user's own MeshCore contact QR code.
  ///
  /// In en, this message translates to:
  /// **'My Contact Code'**
  String get meshcoreShellDrawerMyContactCode;

  /// Drawer menu item label for MeshCore settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get meshcoreShellDrawerSettings;

  /// Drawer disconnect button label.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get meshcoreShellDrawerDisconnect;

  /// Fallback full device name for MeshCore.
  ///
  /// In en, this message translates to:
  /// **'MeshCore Device'**
  String get meshcoreShellDefaultDeviceNameFull;

  /// Error snackbar when attempting to reconnect without a saved device.
  ///
  /// In en, this message translates to:
  /// **'No saved device to reconnect to'**
  String get meshcoreShellNoSavedDevice;

  /// Loading snackbar shown during MeshCore reconnection.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting to {deviceName}...'**
  String meshcoreShellReconnecting(String deviceName);

  /// Success snackbar after reconnecting to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Connected to {deviceName}'**
  String meshcoreShellConnectedTo(String deviceName);

  /// Error snackbar when MeshCore reconnection fails.
  ///
  /// In en, this message translates to:
  /// **'Reconnect failed: {error}'**
  String meshcoreShellReconnectFailed(String error);

  /// Info snackbar hint after navigating to contacts tab.
  ///
  /// In en, this message translates to:
  /// **'Use the + button to add a contact'**
  String get meshcoreShellAddContactHint;

  /// Info snackbar hint after navigating to channels tab.
  ///
  /// In en, this message translates to:
  /// **'Use the menu to create or join a channel'**
  String get meshcoreShellAddChannelHint;

  /// Error message when attempting an action while MeshCore is disconnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get meshcoreShellNotConnected;

  /// Success snackbar after sending a MeshCore contact discovery advertisement.
  ///
  /// In en, this message translates to:
  /// **'Advertisement sent - listen for responses'**
  String get meshcoreShellAdvertisementSent;

  /// Error message when device self-info is not yet available.
  ///
  /// In en, this message translates to:
  /// **'Device info not available'**
  String get meshcoreShellDeviceInfoNotAvailable;

  /// Fallback title for QR share when device has no node name.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Node'**
  String get meshcoreShellUnnamedNode;

  /// Subtitle on the QR share sheet for adding a MeshCore contact.
  ///
  /// In en, this message translates to:
  /// **'Scan to add as contact'**
  String get meshcoreShellScanToAddContact;

  /// Info text on the QR contact code share sheet.
  ///
  /// In en, this message translates to:
  /// **'Share your contact code so others can message you'**
  String get meshcoreShellShareContactInfo;

  /// Fallback avatar initials for MeshCore node.
  ///
  /// In en, this message translates to:
  /// **'MC'**
  String get meshcoreShellDefaultInitials;

  /// Connection status label when the MeshCore device is connected.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get meshcoreShellStatusOnline;

  /// Connection status label when the MeshCore device is disconnected.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get meshcoreShellStatusOffline;

  /// Device sheet status when connected to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get meshcoreShellStatusConnected;

  /// Device sheet status while connecting to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get meshcoreShellStatusConnecting;

  /// Device sheet status when disconnected from a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get meshcoreShellStatusDisconnected;

  /// Section title for device information in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get meshcoreShellSectionDeviceInfo;

  /// Section title for quick actions in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get meshcoreShellSectionQuickActions;

  /// Section title for connection actions in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get meshcoreShellSectionConnection;

  /// Subtitle for the Add Contact action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Scan QR or enter contact code'**
  String get meshcoreShellAddContactSubtitle;

  /// Title for the Join Channel action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Join Channel'**
  String get meshcoreShellJoinChannel;

  /// Subtitle for the Join Channel action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Scan QR or enter channel code'**
  String get meshcoreShellJoinChannelSubtitle;

  /// Info snackbar hint after navigating to channels tab from device sheet.
  ///
  /// In en, this message translates to:
  /// **'Use the menu to join a channel'**
  String get meshcoreShellJoinChannelHint;

  /// Subtitle for the My Contact Code action tile in the device sheet.
  ///
  /// In en, this message translates to:
  /// **'Share your contact info'**
  String get meshcoreShellShareContactSubtitle;

  /// Subtitle for the Discover Contacts action tile in the device sheet.
  ///
  /// In en, this message translates to:
  /// **'Send advertisement to find nearby nodes'**
  String get meshcoreShellDiscoverSubtitle;

  /// Title for the App Settings action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get meshcoreShellAppSettings;

  /// Subtitle for the App Settings action tile in the device sheet.
  ///
  /// In en, this message translates to:
  /// **'Notifications, theme, preferences'**
  String get meshcoreShellAppSettingsSubtitle;

  /// Info table label for the protocol row.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get meshcoreShellInfoProtocol;

  /// Info table protocol value for MeshCore.
  ///
  /// In en, this message translates to:
  /// **'MeshCore'**
  String get meshcoreShellInfoProtocolValue;

  /// Info table label for the node name row.
  ///
  /// In en, this message translates to:
  /// **'Node Name'**
  String get meshcoreShellInfoNodeName;

  /// Fallback value when a node name is empty.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get meshcoreShellUnknown;

  /// Info table label for the node ID row.
  ///
  /// In en, this message translates to:
  /// **'Node ID'**
  String get meshcoreShellInfoNodeId;

  /// Info table label for the public key row.
  ///
  /// In en, this message translates to:
  /// **'Public Key'**
  String get meshcoreShellInfoPublicKey;

  /// Info table label for the connection status row.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get meshcoreShellInfoStatus;

  /// Button label while disconnection is in progress.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get meshcoreShellDisconnecting;

  /// Button label and confirmation dialog title for disconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get meshcoreShellDisconnect;

  /// Confirmation dialog body when disconnecting from a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect from this MeshCore device?'**
  String get meshcoreShellDisconnectConfirmMessage;

  /// Success snackbar after sending discovery advertisement from device sheet.
  ///
  /// In en, this message translates to:
  /// **'Advertisement sent - listening for responses'**
  String get meshcoreShellAdvertisementSentListening;

  /// Success snackbar after linking a device to the user profile.
  ///
  /// In en, this message translates to:
  /// **'Device linked to your profile!'**
  String get linkDeviceBannerLinkedSuccess;

  /// Error snackbar when device linking fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to link: {error}'**
  String linkDeviceBannerLinkError(String error);

  /// Title text on the link device banner.
  ///
  /// In en, this message translates to:
  /// **'Link this device to your profile'**
  String get linkDeviceBannerTitle;

  /// Subtitle text on the link device banner.
  ///
  /// In en, this message translates to:
  /// **'Others can find and follow you'**
  String get linkDeviceBannerSubtitle;

  /// Button label to link the device.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get linkDeviceBannerLinkButton;

  /// App bar title showing node count.
  ///
  /// In en, this message translates to:
  /// **'Nodes ({count})'**
  String nodesScreenTitle(int count);

  /// Tooltip for the QR code scan button.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get nodesScreenScanQrCodeTooltip;

  /// Overflow menu item for help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get nodesScreenHelpMenu;

  /// Overflow menu item for settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nodesScreenSettingsMenu;

  /// Search bar placeholder text.
  ///
  /// In en, this message translates to:
  /// **'Find a node'**
  String get nodesScreenSearchHint;

  /// Filter chip label showing all nodes.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get nodesScreenFilterAll;

  /// Filter chip label for active nodes.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get nodesScreenFilterActive;

  /// Filter chip label for favorite nodes.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get nodesScreenFilterFavorites;

  /// Filter chip label for nodes with GPS position.
  ///
  /// In en, this message translates to:
  /// **'With Position'**
  String get nodesScreenFilterWithPosition;

  /// Filter chip label for inactive nodes.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get nodesScreenFilterInactive;

  /// Filter chip label for newly discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get nodesScreenFilterNew;

  /// Filter chip label for RF-connected nodes.
  ///
  /// In en, this message translates to:
  /// **'RF'**
  String get nodesScreenFilterRf;

  /// Filter chip label for MQTT-connected nodes.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get nodesScreenFilterMqtt;

  /// Empty state message when no nodes exist.
  ///
  /// In en, this message translates to:
  /// **'No nodes discovered yet'**
  String get nodesScreenEmptyAll;

  /// Empty state message when filter returns no results.
  ///
  /// In en, this message translates to:
  /// **'No nodes match this filter'**
  String get nodesScreenEmptyFiltered;

  /// Button to clear filters and show all nodes.
  ///
  /// In en, this message translates to:
  /// **'Show all nodes'**
  String get nodesScreenShowAllButton;

  /// Section header for Aether flight nodes.
  ///
  /// In en, this message translates to:
  /// **'Aether Flights Nearby'**
  String get nodesScreenSectionAetherFlights;

  /// Section header for nodes currently being discovered.
  ///
  /// In en, this message translates to:
  /// **'Discovering'**
  String get nodesScreenSectionDiscovering;

  /// Section header for the user's own device.
  ///
  /// In en, this message translates to:
  /// **'Your Device'**
  String get nodesScreenSectionYourDevice;

  /// Section header for favorite nodes.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get nodesScreenSectionFavorites;

  /// Section header for active nodes.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get nodesScreenSectionActive;

  /// Section header for recently seen nodes.
  ///
  /// In en, this message translates to:
  /// **'Seen Recently'**
  String get nodesScreenSectionSeenRecently;

  /// Section header for inactive nodes.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get nodesScreenSectionInactive;

  /// Section header for nodes with unknown status.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodesScreenSectionUnknown;

  /// Section header for nodes with strong signal.
  ///
  /// In en, this message translates to:
  /// **'Strong (>0 dB)'**
  String get nodesScreenSectionSignalStrong;

  /// Section header for nodes with medium signal.
  ///
  /// In en, this message translates to:
  /// **'Medium (-10 to 0 dB)'**
  String get nodesScreenSectionSignalMedium;

  /// Section header for nodes with weak signal.
  ///
  /// In en, this message translates to:
  /// **'Weak (<-10 dB)'**
  String get nodesScreenSectionSignalWeak;

  /// Section header for nodes currently charging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get nodesScreenSectionCharging;

  /// Section header for nodes with full battery.
  ///
  /// In en, this message translates to:
  /// **'Full (80-100%)'**
  String get nodesScreenSectionBatteryFull;

  /// Section header for nodes with good battery.
  ///
  /// In en, this message translates to:
  /// **'Good (50-80%)'**
  String get nodesScreenSectionBatteryGood;

  /// Section header for nodes with low battery.
  ///
  /// In en, this message translates to:
  /// **'Low (20-50%)'**
  String get nodesScreenSectionBatteryLow;

  /// Section header for nodes with critical battery.
  ///
  /// In en, this message translates to:
  /// **'Critical (<20%)'**
  String get nodesScreenSectionBatteryCritical;

  /// Label in long-press menu for the connected device.
  ///
  /// In en, this message translates to:
  /// **'Connected Device'**
  String get nodesScreenConnectedDevice;

  /// Long-press menu action to disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get nodesScreenDisconnect;

  /// Sort chip label for most recent sort.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get nodesScreenSortRecent;

  /// Sort chip label for name sort.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nodesScreenSortName;

  /// Sort chip label for signal sort.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get nodesScreenSortSignal;

  /// Sort chip label for battery sort.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodesScreenSortBattery;

  /// Sort menu option for most recent.
  ///
  /// In en, this message translates to:
  /// **'Most Recent'**
  String get nodesScreenSortMenuMostRecent;

  /// Sort menu option for alphabetical name sort.
  ///
  /// In en, this message translates to:
  /// **'Name (A-Z)'**
  String get nodesScreenSortMenuNameAZ;

  /// Sort menu option for signal strength sort.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get nodesScreenSortMenuSignalStrength;

  /// Sort menu option for battery level sort.
  ///
  /// In en, this message translates to:
  /// **'Battery Level'**
  String get nodesScreenSortMenuBatteryLevel;

  /// Distance label in meters on node card.
  ///
  /// In en, this message translates to:
  /// **'{meters} m away'**
  String nodesScreenDistanceMeters(String meters);

  /// Distance label in kilometers on node card.
  ///
  /// In en, this message translates to:
  /// **'{km} km away'**
  String nodesScreenDistanceKilometers(String km);

  /// Badge label on the user's own node card.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get nodesScreenYouBadge;

  /// Subtitle on the user's own node card.
  ///
  /// In en, this message translates to:
  /// **'This Device'**
  String get nodesScreenThisDevice;

  /// Badge label for nodes with GPS position.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get nodesScreenGps;

  /// Badge label for nodes without GPS position.
  ///
  /// In en, this message translates to:
  /// **'No GPS'**
  String get nodesScreenNoGps;

  /// Label prefix for node log count.
  ///
  /// In en, this message translates to:
  /// **'Logs:'**
  String get nodesScreenLogsLabel;

  /// Hop count label for directly connected nodes.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get nodesScreenHopDirect;

  /// Hop count label for multi-hop nodes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hop} other{{count} hops}}'**
  String nodesScreenHopCount(int count);

  /// Transport badge for MQTT nodes.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get nodesScreenTransportMqtt;

  /// Transport badge for RF nodes.
  ///
  /// In en, this message translates to:
  /// **'RF'**
  String get nodesScreenTransportRf;

  /// QR code sheet subtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan to add this node'**
  String get nodeDetailQrSubtitle;

  /// QR code sheet info text with hex node ID.
  ///
  /// In en, this message translates to:
  /// **'Node ID: {nodeId}'**
  String nodeDetailQrInfoText(String nodeId);

  /// Snackbar after removing a node from favorites.
  ///
  /// In en, this message translates to:
  /// **'{name} removed from favorites'**
  String nodeDetailRemovedFromFavorites(String name);

  /// Snackbar after adding a node to favorites.
  ///
  /// In en, this message translates to:
  /// **'{name} added to favorites'**
  String nodeDetailAddedToFavorites(String name);

  /// Error snackbar when favorite toggle fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to update favorite: {error}'**
  String nodeDetailFavoriteError(String error);

  /// Error when trying to mute while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot change mute status: Device not connected'**
  String get nodeDetailMuteNotConnected;

  /// Snackbar after unmuting a node.
  ///
  /// In en, this message translates to:
  /// **'{name} unmuted'**
  String nodeDetailUnmuted(String name);

  /// Snackbar after muting a node.
  ///
  /// In en, this message translates to:
  /// **'{name} muted'**
  String nodeDetailMuted(String name);

  /// Error snackbar when mute toggle fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to update mute status: {error}'**
  String nodeDetailMuteError(String error);

  /// Error when sending traceroute while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot send traceroute: Device not connected'**
  String get nodeDetailTracerouteNotConnected;

  /// Success snackbar after sending a traceroute.
  ///
  /// In en, this message translates to:
  /// **'Traceroute sent to {name} — check Traceroute History for results'**
  String nodeDetailTracerouteSent(String name);

  /// Error snackbar when traceroute fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to send traceroute: {error}'**
  String nodeDetailTracerouteError(String error);

  /// Error when rebooting while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot reboot: Device not connected'**
  String get nodeDetailRebootNotConnected;

  /// Confirmation dialog title for rebooting.
  ///
  /// In en, this message translates to:
  /// **'Reboot Device'**
  String get nodeDetailRebootTitle;

  /// Confirmation dialog body for rebooting.
  ///
  /// In en, this message translates to:
  /// **'This will reboot your Meshtastic device. The app will automatically reconnect once the device restarts.'**
  String get nodeDetailRebootMessage;

  /// Confirmation button label for rebooting.
  ///
  /// In en, this message translates to:
  /// **'Reboot'**
  String get nodeDetailRebootConfirm;

  /// Snackbar shown after initiating a reboot.
  ///
  /// In en, this message translates to:
  /// **'Device is rebooting...'**
  String get nodeDetailRebootingSnackbar;

  /// Error snackbar when reboot fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to reboot: {error}'**
  String nodeDetailRebootError(String error);

  /// Error when shutting down while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot shutdown: Device not connected'**
  String get nodeDetailShutdownNotConnected;

  /// Confirmation dialog title for shutdown.
  ///
  /// In en, this message translates to:
  /// **'Shutdown Device'**
  String get nodeDetailShutdownTitle;

  /// Confirmation dialog body for shutdown.
  ///
  /// In en, this message translates to:
  /// **'This will turn off your Meshtastic device. You will need to physically power it back on to reconnect.'**
  String get nodeDetailShutdownMessage;

  /// Confirmation button label for shutdown.
  ///
  /// In en, this message translates to:
  /// **'Shutdown'**
  String get nodeDetailShutdownConfirm;

  /// Snackbar shown after initiating a shutdown.
  ///
  /// In en, this message translates to:
  /// **'Device is shutting down...'**
  String get nodeDetailShuttingDownSnackbar;

  /// Error snackbar when shutdown fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to shutdown: {error}'**
  String nodeDetailShutdownError(String error);

  /// Confirmation dialog title for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove Node'**
  String get nodeDetailRemoveTitle;

  /// Confirmation dialog body for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from the node database? This will remove the node from your local device.'**
  String nodeDetailRemoveMessage(String name);

  /// Confirmation button label for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get nodeDetailRemoveConfirm;

  /// Snackbar after successfully removing a node.
  ///
  /// In en, this message translates to:
  /// **'{name} removed'**
  String nodeDetailRemovedSnackbar(String name);

  /// Error snackbar when node removal fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove node: {error}'**
  String nodeDetailRemoveError(String error);

  /// Error when node has no GPS position for fixed position.
  ///
  /// In en, this message translates to:
  /// **'Node has no position data'**
  String get nodeDetailNoPositionData;

  /// Success snackbar after setting fixed position.
  ///
  /// In en, this message translates to:
  /// **'Fixed position set to {name}\'s location'**
  String nodeDetailFixedPositionSet(String name);

  /// Error snackbar when fixed position fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to set fixed position: {error}'**
  String nodeDetailFixedPositionError(String error);

  /// Success snackbar after requesting user info.
  ///
  /// In en, this message translates to:
  /// **'User info requested from {name}'**
  String nodeDetailUserInfoRequested(String name);

  /// Error snackbar when user info request fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to request user info: {error}'**
  String nodeDetailUserInfoError(String error);

  /// Success snackbar after requesting position.
  ///
  /// In en, this message translates to:
  /// **'Position requested from {name}'**
  String nodeDetailPositionRequested(String name);

  /// Error snackbar when position request fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to request position: {error}'**
  String nodeDetailPositionError(String error);

  /// Relative time label when a node has never been heard.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get nodeDetailLastHeardNever;

  /// Relative time label for very recent contact.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get nodeDetailLastHeardJustNow;

  /// Relative time label in minutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String nodeDetailLastHeardMinutesAgo(int minutes);

  /// Relative time label in hours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String nodeDetailLastHeardHoursAgo(int hours);

  /// Relative time label in days.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String nodeDetailLastHeardDaysAgo(int days);

  /// Signal quality label when RSSI is unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodeDetailSignalUnknown;

  /// Signal quality label for excellent RSSI.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get nodeDetailSignalExcellent;

  /// Signal quality label for good RSSI.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get nodeDetailSignalGood;

  /// Signal quality label for fair RSSI.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get nodeDetailSignalFair;

  /// Signal quality label for weak RSSI.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get nodeDetailSignalWeak;

  /// Signal quality label for very weak RSSI.
  ///
  /// In en, this message translates to:
  /// **'Very Weak'**
  String get nodeDetailSignalVeryWeak;

  /// Badge on the user's own node in the detail screen.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get nodeDetailYouBadge;

  /// Badge for nodes with PKI encryption.
  ///
  /// In en, this message translates to:
  /// **'PKI'**
  String get nodeDetailPkiBadge;

  /// Badge for nodes without PKI encryption.
  ///
  /// In en, this message translates to:
  /// **'No PKI'**
  String get nodeDetailNoPkiBadge;

  /// Badge for muted nodes.
  ///
  /// In en, this message translates to:
  /// **'Muted'**
  String get nodeDetailMutedBadge;

  /// Badge for favorite nodes.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get nodeDetailFavoriteBadge;

  /// Battery status label when charging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get nodeDetailBatteryCharging;

  /// Battery percentage display.
  ///
  /// In en, this message translates to:
  /// **'{level}%'**
  String nodeDetailBatteryPercent(int level);

  /// Distance display in meters.
  ///
  /// In en, this message translates to:
  /// **'{meters} m'**
  String nodeDetailDistanceMeters(String meters);

  /// Distance display in kilometers.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String nodeDetailDistanceKilometers(String km);

  /// Section title for identity info.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get nodeDetailSectionIdentity;

  /// Info table label for user ID.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get nodeDetailLabelUserId;

  /// Info table label for hardware model.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get nodeDetailLabelHardware;

  /// Info table label for firmware version.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get nodeDetailLabelFirmware;

  /// Info table label for encryption status.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get nodeDetailLabelEncryption;

  /// Encryption value when PKI is enabled.
  ///
  /// In en, this message translates to:
  /// **'PKI Enabled'**
  String get nodeDetailValuePkiEnabled;

  /// Encryption value when no public key exists.
  ///
  /// In en, this message translates to:
  /// **'No Public Key'**
  String get nodeDetailValueNoPublicKey;

  /// Info table label for node status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get nodeDetailLabelStatus;

  /// Section title for radio info.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get nodeDetailSectionRadio;

  /// Info table label for RSSI.
  ///
  /// In en, this message translates to:
  /// **'RSSI'**
  String get nodeDetailLabelRssi;

  /// RSSI value with unit.
  ///
  /// In en, this message translates to:
  /// **'{rssi} dBm'**
  String nodeDetailValueRssi(int rssi);

  /// Info table label for SNR.
  ///
  /// In en, this message translates to:
  /// **'SNR'**
  String get nodeDetailLabelSnr;

  /// SNR value with unit.
  ///
  /// In en, this message translates to:
  /// **'{snr} dB'**
  String nodeDetailValueSnr(String snr);

  /// Info table label for noise floor.
  ///
  /// In en, this message translates to:
  /// **'Noise Floor'**
  String get nodeDetailLabelNoiseFloor;

  /// Noise floor value with unit.
  ///
  /// In en, this message translates to:
  /// **'{noiseFloor} dBm'**
  String nodeDetailValueNoiseFloor(int noiseFloor);

  /// Info table label for distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get nodeDetailLabelDistance;

  /// Info table label for GPS position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get nodeDetailLabelPosition;

  /// Info table label for altitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get nodeDetailLabelAltitude;

  /// Altitude value with unit.
  ///
  /// In en, this message translates to:
  /// **'{altitude} m'**
  String nodeDetailValueAltitude(int altitude);

  /// Section title for device metrics.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get nodeDetailSectionDeviceMetrics;

  /// Info table label for battery level.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodeDetailLabelBattery;

  /// Info table label for voltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get nodeDetailLabelVoltage;

  /// Voltage value with unit.
  ///
  /// In en, this message translates to:
  /// **'{voltage} V'**
  String nodeDetailValueVoltage(String voltage);

  /// Info table label for channel utilization.
  ///
  /// In en, this message translates to:
  /// **'Channel Util'**
  String get nodeDetailLabelChannelUtil;

  /// Generic percentage value display.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String nodeDetailValuePercent(String value);

  /// Info table label for air utilization TX.
  ///
  /// In en, this message translates to:
  /// **'Air Util TX'**
  String get nodeDetailLabelAirUtilTx;

  /// Info table label for uptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get nodeDetailLabelUptime;

  /// Section title for network info.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get nodeDetailSectionNetwork;

  /// Info table label for transmitted packets.
  ///
  /// In en, this message translates to:
  /// **'Packets TX'**
  String get nodeDetailLabelPacketsTx;

  /// Info table label for received packets.
  ///
  /// In en, this message translates to:
  /// **'Packets RX'**
  String get nodeDetailLabelPacketsRx;

  /// Info table label for bad packets.
  ///
  /// In en, this message translates to:
  /// **'Bad Packets'**
  String get nodeDetailLabelBadPackets;

  /// Info table label for online node count.
  ///
  /// In en, this message translates to:
  /// **'Online Nodes'**
  String get nodeDetailLabelOnlineNodes;

  /// Info table label for total node count.
  ///
  /// In en, this message translates to:
  /// **'Total Nodes'**
  String get nodeDetailLabelTotalNodes;

  /// Info table label for dropped transmissions.
  ///
  /// In en, this message translates to:
  /// **'TX Dropped'**
  String get nodeDetailLabelTxDropped;

  /// Section title for traffic management info.
  ///
  /// In en, this message translates to:
  /// **'Traffic Management'**
  String get nodeDetailSectionTraffic;

  /// Info table label for inspected packets.
  ///
  /// In en, this message translates to:
  /// **'Inspected'**
  String get nodeDetailLabelInspected;

  /// Info table label for position deduplication.
  ///
  /// In en, this message translates to:
  /// **'Position Dedup'**
  String get nodeDetailLabelPositionDedup;

  /// Info table label for cache hits.
  ///
  /// In en, this message translates to:
  /// **'Cache Hits'**
  String get nodeDetailLabelCacheHits;

  /// Info table label for rate-limited drops.
  ///
  /// In en, this message translates to:
  /// **'Rate Limit Drops'**
  String get nodeDetailLabelRateLimitDrops;

  /// Info table label for unknown drops.
  ///
  /// In en, this message translates to:
  /// **'Unknown Drops'**
  String get nodeDetailLabelUnknownDrops;

  /// Info table label for hop-exhausted packets.
  ///
  /// In en, this message translates to:
  /// **'Hop Exhausted'**
  String get nodeDetailLabelHopExhausted;

  /// Info table label for preserved hops.
  ///
  /// In en, this message translates to:
  /// **'Hops Preserved'**
  String get nodeDetailLabelHopsPreserved;

  /// Action button label for rebooting the device.
  ///
  /// In en, this message translates to:
  /// **'Reboot'**
  String get nodeDetailRebootButton;

  /// Action button label for shutting down the device.
  ///
  /// In en, this message translates to:
  /// **'Shutdown'**
  String get nodeDetailShutdownButton;

  /// Tooltip for removing from favorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get nodeDetailRemoveFromFavoritesTooltip;

  /// Tooltip for adding to favorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get nodeDetailAddToFavoritesTooltip;

  /// Tooltip for unmuting a node.
  ///
  /// In en, this message translates to:
  /// **'Unmute node'**
  String get nodeDetailUnmuteTooltip;

  /// Tooltip for muting a node.
  ///
  /// In en, this message translates to:
  /// **'Mute node'**
  String get nodeDetailMuteTooltip;

  /// Action button label for messaging the node.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get nodeDetailMessageButton;

  /// App bar title for the node detail screen.
  ///
  /// In en, this message translates to:
  /// **'Node Details'**
  String get nodeDetailAppBarTitle;

  /// Tooltip for the sigil card button.
  ///
  /// In en, this message translates to:
  /// **'Sigil Card'**
  String get nodeDetailSigilCardTooltip;

  /// Overflow menu item for QR code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get nodeDetailMenuQrCode;

  /// Overflow menu item for showing node on map.
  ///
  /// In en, this message translates to:
  /// **'Show on Map'**
  String get nodeDetailMenuShowOnMap;

  /// Overflow menu item for traceroute history.
  ///
  /// In en, this message translates to:
  /// **'Traceroute History'**
  String get nodeDetailMenuTracerouteHistory;

  /// Overflow menu item for requesting user info.
  ///
  /// In en, this message translates to:
  /// **'Request User Info'**
  String get nodeDetailMenuRequestUserInfo;

  /// Overflow menu item for exchanging positions.
  ///
  /// In en, this message translates to:
  /// **'Exchange Positions'**
  String get nodeDetailMenuExchangePositions;

  /// Overflow menu item for setting fixed position.
  ///
  /// In en, this message translates to:
  /// **'Set as Fixed Position'**
  String get nodeDetailMenuSetFixedPosition;

  /// Overflow menu item for remote admin settings.
  ///
  /// In en, this message translates to:
  /// **'Admin Settings'**
  String get nodeDetailMenuAdminSettings;

  /// Subtitle for the admin settings menu item.
  ///
  /// In en, this message translates to:
  /// **'Configure this node remotely'**
  String get nodeDetailMenuAdminSubtitle;

  /// Overflow menu item for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove Node'**
  String get nodeDetailMenuRemoveNode;

  /// Footer showing when the node was last heard.
  ///
  /// In en, this message translates to:
  /// **'Last heard {timestamp}'**
  String nodeDetailLastHeardTimestamp(String timestamp);

  /// Tooltip showing remaining traceroute cooldown.
  ///
  /// In en, this message translates to:
  /// **'Traceroute cooldown: {seconds}s'**
  String nodeDetailTracerouteCooldownTooltip(int seconds);

  /// Tooltip for the traceroute button.
  ///
  /// In en, this message translates to:
  /// **'Traceroute'**
  String get nodeDetailTracerouteTooltip;

  /// No description provided for @deviceConfigRoleClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get deviceConfigRoleClient;

  /// No description provided for @deviceConfigRoleClientDesc.
  ///
  /// In en, this message translates to:
  /// **'Default role. Mesh packets are routed through this node. Can send and receive messages.'**
  String get deviceConfigRoleClientDesc;

  /// No description provided for @deviceConfigRoleClientMute.
  ///
  /// In en, this message translates to:
  /// **'Client Mute'**
  String get deviceConfigRoleClientMute;

  /// No description provided for @deviceConfigRoleClientMuteDesc.
  ///
  /// In en, this message translates to:
  /// **'Same as client but will not transmit any messages from itself. Useful for monitoring.'**
  String get deviceConfigRoleClientMuteDesc;

  /// No description provided for @deviceConfigRoleClientHidden.
  ///
  /// In en, this message translates to:
  /// **'Client Hidden'**
  String get deviceConfigRoleClientHidden;

  /// No description provided for @deviceConfigRoleClientHiddenDesc.
  ///
  /// In en, this message translates to:
  /// **'Acts as client but hides from the node list. Still routes traffic.'**
  String get deviceConfigRoleClientHiddenDesc;

  /// No description provided for @deviceConfigRoleClientBase.
  ///
  /// In en, this message translates to:
  /// **'Client Base'**
  String get deviceConfigRoleClientBase;

  /// No description provided for @deviceConfigRoleClientBaseDesc.
  ///
  /// In en, this message translates to:
  /// **'Base station for favorited nodes. Routes their packets like a router, others as client.'**
  String get deviceConfigRoleClientBaseDesc;

  /// No description provided for @deviceConfigRoleRouter.
  ///
  /// In en, this message translates to:
  /// **'Router'**
  String get deviceConfigRoleRouter;

  /// No description provided for @deviceConfigRoleRouterDesc.
  ///
  /// In en, this message translates to:
  /// **'Routes mesh packets between nodes. Screen and Bluetooth disabled to conserve power.'**
  String get deviceConfigRoleRouterDesc;

  /// No description provided for @deviceConfigRoleRouterLate.
  ///
  /// In en, this message translates to:
  /// **'Router Late'**
  String get deviceConfigRoleRouterLate;

  /// No description provided for @deviceConfigRoleRouterLateDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcasts all packets after other routers. Extends coverage without consuming priority hops.'**
  String get deviceConfigRoleRouterLateDesc;

  /// No description provided for @deviceConfigRoleTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get deviceConfigRoleTracker;

  /// No description provided for @deviceConfigRoleTrackerDesc.
  ///
  /// In en, this message translates to:
  /// **'Optimized for GPS tracking. Sends position updates at defined intervals.'**
  String get deviceConfigRoleTrackerDesc;

  /// No description provided for @deviceConfigRoleSensor.
  ///
  /// In en, this message translates to:
  /// **'Sensor'**
  String get deviceConfigRoleSensor;

  /// No description provided for @deviceConfigRoleSensorDesc.
  ///
  /// In en, this message translates to:
  /// **'Designed for remote sensing. Reports telemetry data at defined intervals.'**
  String get deviceConfigRoleSensorDesc;

  /// No description provided for @deviceConfigRoleTak.
  ///
  /// In en, this message translates to:
  /// **'TAK'**
  String get deviceConfigRoleTak;

  /// No description provided for @deviceConfigRoleTakDesc.
  ///
  /// In en, this message translates to:
  /// **'Team Awareness Kit integration. Bridges Meshtastic and TAK systems.'**
  String get deviceConfigRoleTakDesc;

  /// No description provided for @deviceConfigRoleTakTracker.
  ///
  /// In en, this message translates to:
  /// **'TAK Tracker'**
  String get deviceConfigRoleTakTracker;

  /// No description provided for @deviceConfigRoleTakTrackerDesc.
  ///
  /// In en, this message translates to:
  /// **'Combination of TAK and Tracker modes.'**
  String get deviceConfigRoleTakTrackerDesc;

  /// No description provided for @deviceConfigRoleLostAndFound.
  ///
  /// In en, this message translates to:
  /// **'Lost and Found'**
  String get deviceConfigRoleLostAndFound;

  /// No description provided for @deviceConfigRoleLostAndFoundDesc.
  ///
  /// In en, this message translates to:
  /// **'Optimized for finding lost devices. Sends periodic beacons.'**
  String get deviceConfigRoleLostAndFoundDesc;

  /// No description provided for @deviceConfigRebroadcastAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get deviceConfigRebroadcastAll;

  /// No description provided for @deviceConfigRebroadcastAllDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast any observed message. Default behavior.'**
  String get deviceConfigRebroadcastAllDesc;

  /// No description provided for @deviceConfigRebroadcastAllSkipDecoding.
  ///
  /// In en, this message translates to:
  /// **'All (Skip Decoding)'**
  String get deviceConfigRebroadcastAllSkipDecoding;

  /// No description provided for @deviceConfigRebroadcastAllSkipDecodingDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast all messages without decoding. Faster, less CPU.'**
  String get deviceConfigRebroadcastAllSkipDecodingDesc;

  /// No description provided for @deviceConfigRebroadcastLocalOnly.
  ///
  /// In en, this message translates to:
  /// **'Local Only'**
  String get deviceConfigRebroadcastLocalOnly;

  /// No description provided for @deviceConfigRebroadcastLocalOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Only rebroadcast messages from local senders. Good for isolated networks.'**
  String get deviceConfigRebroadcastLocalOnlyDesc;

  /// No description provided for @deviceConfigRebroadcastKnownOnly.
  ///
  /// In en, this message translates to:
  /// **'Known Only'**
  String get deviceConfigRebroadcastKnownOnly;

  /// No description provided for @deviceConfigRebroadcastKnownOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Only rebroadcast messages from nodes in the node database.'**
  String get deviceConfigRebroadcastKnownOnlyDesc;

  /// No description provided for @deviceConfigRebroadcastCorePortnumsOnly.
  ///
  /// In en, this message translates to:
  /// **'Core Port Numbers Only'**
  String get deviceConfigRebroadcastCorePortnumsOnly;

  /// No description provided for @deviceConfigRebroadcastCorePortnumsOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast only core Meshtastic packets (position, telemetry, etc).'**
  String get deviceConfigRebroadcastCorePortnumsOnlyDesc;

  /// No description provided for @deviceConfigRebroadcastNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get deviceConfigRebroadcastNone;

  /// No description provided for @deviceConfigRebroadcastNoneDesc.
  ///
  /// In en, this message translates to:
  /// **'Do not rebroadcast any messages. Node only receives.'**
  String get deviceConfigRebroadcastNoneDesc;

  /// No description provided for @deviceConfigBuzzerAllEnabled.
  ///
  /// In en, this message translates to:
  /// **'All Enabled'**
  String get deviceConfigBuzzerAllEnabled;

  /// No description provided for @deviceConfigBuzzerAllEnabledDesc.
  ///
  /// In en, this message translates to:
  /// **'Buzzer sounds for all feedback including buttons and alerts.'**
  String get deviceConfigBuzzerAllEnabledDesc;

  /// No description provided for @deviceConfigBuzzerNotificationsOnly.
  ///
  /// In en, this message translates to:
  /// **'Notifications Only'**
  String get deviceConfigBuzzerNotificationsOnly;

  /// No description provided for @deviceConfigBuzzerNotificationsOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Buzzer only for notifications and alerts, not button presses.'**
  String get deviceConfigBuzzerNotificationsOnlyDesc;

  /// No description provided for @deviceConfigBuzzerDirectMsgOnly.
  ///
  /// In en, this message translates to:
  /// **'Direct Messages Only'**
  String get deviceConfigBuzzerDirectMsgOnly;

  /// No description provided for @deviceConfigBuzzerDirectMsgOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Buzzer only for direct messages and alerts.'**
  String get deviceConfigBuzzerDirectMsgOnlyDesc;

  /// No description provided for @deviceConfigBuzzerSystemOnly.
  ///
  /// In en, this message translates to:
  /// **'System Only'**
  String get deviceConfigBuzzerSystemOnly;

  /// No description provided for @deviceConfigBuzzerSystemOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Button presses, startup, shutdown sounds only. No alerts.'**
  String get deviceConfigBuzzerSystemOnlyDesc;

  /// No description provided for @deviceConfigBuzzerDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get deviceConfigBuzzerDisabled;

  /// No description provided for @deviceConfigBuzzerDisabledDesc.
  ///
  /// In en, this message translates to:
  /// **'All buzzer audio feedback is disabled.'**
  String get deviceConfigBuzzerDisabledDesc;

  /// No description provided for @deviceConfigBroadcastThreeHours.
  ///
  /// In en, this message translates to:
  /// **'Three Hours'**
  String get deviceConfigBroadcastThreeHours;

  /// No description provided for @deviceConfigBroadcastFourHours.
  ///
  /// In en, this message translates to:
  /// **'Four Hours'**
  String get deviceConfigBroadcastFourHours;

  /// No description provided for @deviceConfigBroadcastFiveHours.
  ///
  /// In en, this message translates to:
  /// **'Five Hours'**
  String get deviceConfigBroadcastFiveHours;

  /// No description provided for @deviceConfigBroadcastSixHours.
  ///
  /// In en, this message translates to:
  /// **'Six Hours'**
  String get deviceConfigBroadcastSixHours;

  /// No description provided for @deviceConfigBroadcastTwelveHours.
  ///
  /// In en, this message translates to:
  /// **'Twelve Hours'**
  String get deviceConfigBroadcastTwelveHours;

  /// No description provided for @deviceConfigBroadcastEighteenHours.
  ///
  /// In en, this message translates to:
  /// **'Eighteen Hours'**
  String get deviceConfigBroadcastEighteenHours;

  /// No description provided for @deviceConfigBroadcastTwentyFourHours.
  ///
  /// In en, this message translates to:
  /// **'Twenty Four Hours'**
  String get deviceConfigBroadcastTwentyFourHours;

  /// No description provided for @deviceConfigBroadcastThirtySixHours.
  ///
  /// In en, this message translates to:
  /// **'Thirty Six Hours'**
  String get deviceConfigBroadcastThirtySixHours;

  /// No description provided for @deviceConfigBroadcastFortyEightHours.
  ///
  /// In en, this message translates to:
  /// **'Forty Eight Hours'**
  String get deviceConfigBroadcastFortyEightHours;

  /// No description provided for @deviceConfigBroadcastSeventyTwoHours.
  ///
  /// In en, this message translates to:
  /// **'Seventy Two Hours'**
  String get deviceConfigBroadcastSeventyTwoHours;

  /// No description provided for @deviceConfigBroadcastNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get deviceConfigBroadcastNever;

  /// No description provided for @deviceConfigTitleRemote.
  ///
  /// In en, this message translates to:
  /// **'Device Config (Remote)'**
  String get deviceConfigTitleRemote;

  /// No description provided for @deviceConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Config'**
  String get deviceConfigTitle;

  /// No description provided for @deviceConfigSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get deviceConfigSave;

  /// No description provided for @deviceConfigSaveChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Changes?'**
  String get deviceConfigSaveChangesTitle;

  /// No description provided for @deviceConfigSaveChangesMessage.
  ///
  /// In en, this message translates to:
  /// **'Saving device configuration will cause the device to reboot. You will be briefly disconnected while the device restarts.'**
  String get deviceConfigSaveChangesMessage;

  /// No description provided for @deviceConfigSaveAndReboot.
  ///
  /// In en, this message translates to:
  /// **'Save & Reboot'**
  String get deviceConfigSaveAndReboot;

  /// No description provided for @deviceConfigSavedRemote.
  ///
  /// In en, this message translates to:
  /// **'Configuration sent to remote node'**
  String get deviceConfigSavedRemote;

  /// No description provided for @deviceConfigSavedLocal.
  ///
  /// In en, this message translates to:
  /// **'Configuration saved - device rebooting'**
  String get deviceConfigSavedLocal;

  /// No description provided for @deviceConfigSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error saving config: {error}'**
  String deviceConfigSaveError(String error);

  /// No description provided for @deviceConfigLongName.
  ///
  /// In en, this message translates to:
  /// **'Long Name'**
  String get deviceConfigLongName;

  /// No description provided for @deviceConfigLongNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display name visible on the mesh'**
  String get deviceConfigLongNameSubtitle;

  /// No description provided for @deviceConfigLongNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter display name'**
  String get deviceConfigLongNameHint;

  /// No description provided for @deviceConfigShortName.
  ///
  /// In en, this message translates to:
  /// **'Short Name'**
  String get deviceConfigShortName;

  /// No description provided for @deviceConfigShortNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Max {maxLength} characters (A-Z, 0-9)'**
  String deviceConfigShortNameSubtitle(int maxLength);

  /// No description provided for @deviceConfigShortNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. FUZZ'**
  String get deviceConfigShortNameHint;

  /// No description provided for @deviceConfigNameHelpText.
  ///
  /// In en, this message translates to:
  /// **'Your device name is broadcast to the mesh and visible to other nodes.'**
  String get deviceConfigNameHelpText;

  /// No description provided for @deviceConfigSectionUserFlags.
  ///
  /// In en, this message translates to:
  /// **'User Flags'**
  String get deviceConfigSectionUserFlags;

  /// No description provided for @deviceConfigSectionDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get deviceConfigSectionDeviceInfo;

  /// No description provided for @deviceConfigSectionDeviceRole.
  ///
  /// In en, this message translates to:
  /// **'Device Role'**
  String get deviceConfigSectionDeviceRole;

  /// No description provided for @deviceConfigSectionRebroadcastMode.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast Mode'**
  String get deviceConfigSectionRebroadcastMode;

  /// No description provided for @deviceConfigSectionNodeInfoBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Node Info Broadcast'**
  String get deviceConfigSectionNodeInfoBroadcast;

  /// No description provided for @deviceConfigSectionButtonInput.
  ///
  /// In en, this message translates to:
  /// **'Button & Input'**
  String get deviceConfigSectionButtonInput;

  /// No description provided for @deviceConfigSectionBuzzer.
  ///
  /// In en, this message translates to:
  /// **'Buzzer'**
  String get deviceConfigSectionBuzzer;

  /// No description provided for @deviceConfigSectionLed.
  ///
  /// In en, this message translates to:
  /// **'LED'**
  String get deviceConfigSectionLed;

  /// No description provided for @deviceConfigSectionSerial.
  ///
  /// In en, this message translates to:
  /// **'Serial'**
  String get deviceConfigSectionSerial;

  /// No description provided for @deviceConfigSectionTimezone.
  ///
  /// In en, this message translates to:
  /// **'Timezone'**
  String get deviceConfigSectionTimezone;

  /// No description provided for @deviceConfigSectionGpio.
  ///
  /// In en, this message translates to:
  /// **'GPIO (Advanced)'**
  String get deviceConfigSectionGpio;

  /// No description provided for @deviceConfigSectionDangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get deviceConfigSectionDangerZone;

  /// No description provided for @deviceConfigBleName.
  ///
  /// In en, this message translates to:
  /// **'BLE Name'**
  String get deviceConfigBleName;

  /// No description provided for @deviceConfigHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get deviceConfigHardware;

  /// No description provided for @deviceConfigUserId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get deviceConfigUserId;

  /// No description provided for @deviceConfigNodeNumber.
  ///
  /// In en, this message translates to:
  /// **'Node Number'**
  String get deviceConfigNodeNumber;

  /// No description provided for @deviceConfigUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get deviceConfigUnknown;

  /// No description provided for @deviceConfigBroadcastInterval.
  ///
  /// In en, this message translates to:
  /// **'Broadcast Interval'**
  String get deviceConfigBroadcastInterval;

  /// No description provided for @deviceConfigBroadcastIntervalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How often to broadcast node info to the mesh'**
  String get deviceConfigBroadcastIntervalSubtitle;

  /// No description provided for @deviceConfigDoubleTapAsButton.
  ///
  /// In en, this message translates to:
  /// **'Double Tap as Button'**
  String get deviceConfigDoubleTapAsButton;

  /// No description provided for @deviceConfigDoubleTapAsButtonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Treat accelerometer double-tap as button press'**
  String get deviceConfigDoubleTapAsButtonSubtitle;

  /// No description provided for @deviceConfigDisableTripleClick.
  ///
  /// In en, this message translates to:
  /// **'Disable Triple Click'**
  String get deviceConfigDisableTripleClick;

  /// No description provided for @deviceConfigDisableTripleClickSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Disable triple-click to toggle GPS'**
  String get deviceConfigDisableTripleClickSubtitle;

  /// No description provided for @deviceConfigDisableLedHeartbeat.
  ///
  /// In en, this message translates to:
  /// **'Disable LED Heartbeat'**
  String get deviceConfigDisableLedHeartbeat;

  /// No description provided for @deviceConfigDisableLedHeartbeatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn off the blinking status LED'**
  String get deviceConfigDisableLedHeartbeatSubtitle;

  /// No description provided for @deviceConfigSerialConsole.
  ///
  /// In en, this message translates to:
  /// **'Serial Console'**
  String get deviceConfigSerialConsole;

  /// No description provided for @deviceConfigSerialConsoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable serial port for debugging'**
  String get deviceConfigSerialConsoleSubtitle;

  /// No description provided for @deviceConfigPosixTimezone.
  ///
  /// In en, this message translates to:
  /// **'POSIX Timezone'**
  String get deviceConfigPosixTimezone;

  /// No description provided for @deviceConfigPosixTimezoneExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. EST5EDT,M3.2.0,M11.1.0'**
  String get deviceConfigPosixTimezoneExample;

  /// No description provided for @deviceConfigPosixTimezoneHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for UTC'**
  String get deviceConfigPosixTimezoneHint;

  /// No description provided for @deviceConfigGpioWarning.
  ///
  /// In en, this message translates to:
  /// **'Only change these if you know your hardware requires custom GPIO pins.'**
  String get deviceConfigGpioWarning;

  /// No description provided for @deviceConfigButtonGpio.
  ///
  /// In en, this message translates to:
  /// **'Button GPIO'**
  String get deviceConfigButtonGpio;

  /// No description provided for @deviceConfigBuzzerGpio.
  ///
  /// In en, this message translates to:
  /// **'Buzzer GPIO'**
  String get deviceConfigBuzzerGpio;

  /// No description provided for @deviceConfigUnmessagable.
  ///
  /// In en, this message translates to:
  /// **'Unmessagable'**
  String get deviceConfigUnmessagable;

  /// No description provided for @deviceConfigUnmessagableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as infrastructure node that won\'t respond to messages'**
  String get deviceConfigUnmessagableSubtitle;

  /// No description provided for @deviceConfigLicensedOperator.
  ///
  /// In en, this message translates to:
  /// **'Licensed Operator (Ham)'**
  String get deviceConfigLicensedOperator;

  /// No description provided for @deviceConfigLicensedOperatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sets call sign, overrides frequency/power, disables encryption'**
  String get deviceConfigLicensedOperatorSubtitle;

  /// No description provided for @deviceConfigHamModeInfo.
  ///
  /// In en, this message translates to:
  /// **'Ham mode uses your long name as call sign (max 8 chars), broadcasts node info every 10 minutes, overrides frequency, duty cycle, and TX power, and disables encryption.'**
  String get deviceConfigHamModeInfo;

  /// No description provided for @deviceConfigHamModeWarning.
  ///
  /// In en, this message translates to:
  /// **'HAM nodes cannot relay encrypted traffic. Other non-HAM nodes in your mesh will not be able to route encrypted messages through this node, creating a relay gap in the network.'**
  String get deviceConfigHamModeWarning;

  /// No description provided for @deviceConfigFrequencyOverride.
  ///
  /// In en, this message translates to:
  /// **'Frequency Override (MHz)'**
  String get deviceConfigFrequencyOverride;

  /// No description provided for @deviceConfigFrequencyOverrideHint.
  ///
  /// In en, this message translates to:
  /// **'0.0 (use default)'**
  String get deviceConfigFrequencyOverrideHint;

  /// No description provided for @deviceConfigTxPower.
  ///
  /// In en, this message translates to:
  /// **'TX Power'**
  String get deviceConfigTxPower;

  /// No description provided for @deviceConfigTxPowerValue.
  ///
  /// In en, this message translates to:
  /// **'{power} dBm'**
  String deviceConfigTxPowerValue(int power);

  /// No description provided for @deviceConfigRemoteAdminTitle.
  ///
  /// In en, this message translates to:
  /// **'Remote Administration'**
  String get deviceConfigRemoteAdminTitle;

  /// No description provided for @deviceConfigRemoteAdminConfiguring.
  ///
  /// In en, this message translates to:
  /// **'Configuring: {nodeName}'**
  String deviceConfigRemoteAdminConfiguring(String nodeName);

  /// No description provided for @deviceConfigRebootWarning.
  ///
  /// In en, this message translates to:
  /// **'Changes to device configuration will cause the device to reboot.'**
  String get deviceConfigRebootWarning;

  /// No description provided for @deviceConfigResetNodeDb.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceConfigResetNodeDb;

  /// No description provided for @deviceConfigResetNodeDbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all stored node information'**
  String get deviceConfigResetNodeDbSubtitle;

  /// No description provided for @deviceConfigFactoryReset.
  ///
  /// In en, this message translates to:
  /// **'Factory Reset'**
  String get deviceConfigFactoryReset;

  /// No description provided for @deviceConfigFactoryResetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset device to factory defaults'**
  String get deviceConfigFactoryResetSubtitle;

  /// No description provided for @deviceConfigResetNodeDbDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceConfigResetNodeDbDialogTitle;

  /// No description provided for @deviceConfigResetNodeDbDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will clear all stored node information from the device. The mesh network will need to rediscover all nodes.\n\nAre you sure you want to continue?'**
  String get deviceConfigResetNodeDbDialogMessage;

  /// No description provided for @deviceConfigResetNodeDbDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get deviceConfigResetNodeDbDialogConfirm;

  /// No description provided for @deviceConfigResetNodeDbSuccess.
  ///
  /// In en, this message translates to:
  /// **'Node database reset initiated'**
  String get deviceConfigResetNodeDbSuccess;

  /// No description provided for @deviceConfigResetNodeDbError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset: {error}'**
  String deviceConfigResetNodeDbError(String error);

  /// No description provided for @deviceConfigFactoryResetDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Factory Reset'**
  String get deviceConfigFactoryResetDialogTitle;

  /// No description provided for @deviceConfigFactoryResetDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will reset ALL device settings to factory defaults, including channels, configuration, and stored data.\n\nThis action cannot be undone!'**
  String get deviceConfigFactoryResetDialogMessage;

  /// No description provided for @deviceConfigFactoryResetDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Factory Reset'**
  String get deviceConfigFactoryResetDialogConfirm;

  /// No description provided for @deviceConfigFactoryResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Factory reset initiated - device will restart'**
  String get deviceConfigFactoryResetSuccess;

  /// No description provided for @deviceConfigFactoryResetError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset: {error}'**
  String deviceConfigFactoryResetError(String error);

  /// No description provided for @deviceSheetNoDevice.
  ///
  /// In en, this message translates to:
  /// **'No Device'**
  String get deviceSheetNoDevice;

  /// No description provided for @deviceSheetReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting...'**
  String get deviceSheetReconnecting;

  /// No description provided for @deviceSheetConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get deviceSheetConnecting;

  /// No description provided for @deviceSheetConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get deviceSheetConnected;

  /// No description provided for @deviceSheetDisconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get deviceSheetDisconnecting;

  /// No description provided for @deviceSheetError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get deviceSheetError;

  /// No description provided for @deviceSheetDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get deviceSheetDisconnected;

  /// No description provided for @deviceSheetSectionConnectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Connection Details'**
  String get deviceSheetSectionConnectionDetails;

  /// No description provided for @deviceSheetSectionQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get deviceSheetSectionQuickActions;

  /// No description provided for @deviceSheetSectionDeveloperTools.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get deviceSheetSectionDeveloperTools;

  /// No description provided for @deviceSheetActionDeviceConfig.
  ///
  /// In en, this message translates to:
  /// **'Device Config'**
  String get deviceSheetActionDeviceConfig;

  /// No description provided for @deviceSheetActionDeviceConfigSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure device role and settings'**
  String get deviceSheetActionDeviceConfigSubtitle;

  /// No description provided for @deviceSheetActionDeviceManagement.
  ///
  /// In en, this message translates to:
  /// **'Device Management'**
  String get deviceSheetActionDeviceManagement;

  /// No description provided for @deviceSheetActionDeviceManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Radio, display, power, and position settings'**
  String get deviceSheetActionDeviceManagementSubtitle;

  /// No description provided for @deviceSheetActionScanQr.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get deviceSheetActionScanQr;

  /// No description provided for @deviceSheetActionScanQrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import nodes, channels, or automations'**
  String get deviceSheetActionScanQrSubtitle;

  /// No description provided for @deviceSheetActionAppSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get deviceSheetActionAppSettings;

  /// No description provided for @deviceSheetActionAppSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications, theme, preferences'**
  String get deviceSheetActionAppSettingsSubtitle;

  /// No description provided for @deviceSheetActionResetNodeDb.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceSheetActionResetNodeDb;

  /// No description provided for @deviceSheetActionResetNodeDbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all learned nodes from device'**
  String get deviceSheetActionResetNodeDbSubtitle;

  /// No description provided for @deviceSheetDisconnectingButton.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get deviceSheetDisconnectingButton;

  /// No description provided for @deviceSheetDisconnectButton.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get deviceSheetDisconnectButton;

  /// No description provided for @deviceSheetScanForDevices.
  ///
  /// In en, this message translates to:
  /// **'Scan for Devices'**
  String get deviceSheetScanForDevices;

  /// No description provided for @deviceSheetDisconnectDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get deviceSheetDisconnectDialogTitle;

  /// No description provided for @deviceSheetDisconnectDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect from this device?'**
  String get deviceSheetDisconnectDialogMessage;

  /// No description provided for @deviceSheetDisconnectDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get deviceSheetDisconnectDialogConfirm;

  /// No description provided for @deviceSheetResetNodeDbDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceSheetResetNodeDbDialogTitle;

  /// No description provided for @deviceSheetResetNodeDbDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will clear all learned nodes from the device and app. The device will need to rediscover nodes on the mesh.\n\nAre you sure you want to continue?'**
  String get deviceSheetResetNodeDbDialogMessage;

  /// No description provided for @deviceSheetResetNodeDbDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get deviceSheetResetNodeDbDialogConfirm;

  /// No description provided for @deviceSheetResetNodeDbSuccess.
  ///
  /// In en, this message translates to:
  /// **'Node database reset successfully'**
  String get deviceSheetResetNodeDbSuccess;

  /// No description provided for @deviceSheetResetNodeDbError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset node database: {error}'**
  String deviceSheetResetNodeDbError(String error);

  /// No description provided for @deviceSheetProtocol.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get deviceSheetProtocol;

  /// No description provided for @deviceSheetNodeName.
  ///
  /// In en, this message translates to:
  /// **'Node Name'**
  String get deviceSheetNodeName;

  /// No description provided for @deviceSheetDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get deviceSheetDeviceName;

  /// No description provided for @deviceSheetUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get deviceSheetUnknown;

  /// No description provided for @deviceSheetFirmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get deviceSheetFirmware;

  /// No description provided for @deviceSheetNodeId.
  ///
  /// In en, this message translates to:
  /// **'Node ID'**
  String get deviceSheetNodeId;

  /// No description provided for @deviceSheetStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get deviceSheetStatus;

  /// No description provided for @deviceSheetConnectionType.
  ///
  /// In en, this message translates to:
  /// **'Connection Type'**
  String get deviceSheetConnectionType;

  /// No description provided for @deviceSheetBluetoothLe.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth LE'**
  String get deviceSheetBluetoothLe;

  /// No description provided for @deviceSheetUsb.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get deviceSheetUsb;

  /// No description provided for @deviceSheetAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get deviceSheetAddress;

  /// No description provided for @deviceSheetSignalStrength.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get deviceSheetSignalStrength;

  /// No description provided for @deviceSheetSignalStrengthValue.
  ///
  /// In en, this message translates to:
  /// **'{rssi} dBm'**
  String deviceSheetSignalStrengthValue(String rssi);

  /// No description provided for @deviceSheetBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get deviceSheetBattery;

  /// No description provided for @deviceSheetCharging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get deviceSheetCharging;

  /// No description provided for @deviceSheetBatteryPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String deviceSheetBatteryPercent(String percent);

  /// No description provided for @deviceSheetInfoCardConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get deviceSheetInfoCardConnecting;

  /// No description provided for @deviceSheetInfoCardConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get deviceSheetInfoCardConnected;

  /// No description provided for @deviceSheetInfoCardDisconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get deviceSheetInfoCardDisconnecting;

  /// No description provided for @deviceSheetInfoCardConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get deviceSheetInfoCardConnectionError;

  /// No description provided for @deviceSheetInfoCardDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get deviceSheetInfoCardDisconnected;

  /// No description provided for @deviceSheetRefreshingBattery.
  ///
  /// In en, this message translates to:
  /// **'Refreshing battery...'**
  String get deviceSheetRefreshingBattery;

  /// No description provided for @deviceSheetBatteryRefreshResult.
  ///
  /// In en, this message translates to:
  /// **'{percent}%{millivolts}'**
  String deviceSheetBatteryRefreshResult(String percent, String millivolts);

  /// No description provided for @deviceSheetBatteryRefreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get deviceSheetBatteryRefreshFailed;

  /// No description provided for @deviceSheetBatteryRefreshIdle.
  ///
  /// In en, this message translates to:
  /// **'Fetch battery from device'**
  String get deviceSheetBatteryRefreshIdle;

  /// No description provided for @deviceSheetRefreshBattery.
  ///
  /// In en, this message translates to:
  /// **'Refresh Battery'**
  String get deviceSheetRefreshBattery;

  /// No description provided for @regionSelectionTitleInitial.
  ///
  /// In en, this message translates to:
  /// **'Select Your Region'**
  String get regionSelectionTitleInitial;

  /// No description provided for @regionSelectionTitleChange.
  ///
  /// In en, this message translates to:
  /// **'Change Region'**
  String get regionSelectionTitleChange;

  /// No description provided for @regionSelectionBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Important: Select Your Region'**
  String get regionSelectionBannerTitle;

  /// No description provided for @regionSelectionBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the correct frequency for your location to comply with local regulations.'**
  String get regionSelectionBannerSubtitle;

  /// No description provided for @regionSelectionSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search regions...'**
  String get regionSelectionSearchHint;

  /// No description provided for @regionSelectionApplying.
  ///
  /// In en, this message translates to:
  /// **'Applying...'**
  String get regionSelectionApplying;

  /// No description provided for @regionSelectionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get regionSelectionContinue;

  /// No description provided for @regionSelectionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get regionSelectionSave;

  /// No description provided for @regionSelectionCurrentBadge.
  ///
  /// In en, this message translates to:
  /// **'CURRENT'**
  String get regionSelectionCurrentBadge;

  /// No description provided for @regionSelectionApplyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply Region'**
  String get regionSelectionApplyDialogTitle;

  /// No description provided for @regionSelectionApplyDialogMessageInitial.
  ///
  /// In en, this message translates to:
  /// **'Your device will reboot to apply the region settings. This may take up to 30 seconds.\n\nThe app will automatically reconnect when ready.'**
  String get regionSelectionApplyDialogMessageInitial;

  /// No description provided for @regionSelectionApplyDialogMessageChange.
  ///
  /// In en, this message translates to:
  /// **'Changing the region will cause your device to reboot. This may take up to 30 seconds.\n\nYou will be briefly disconnected while the device restarts.'**
  String get regionSelectionApplyDialogMessageChange;

  /// No description provided for @regionSelectionApplyDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get regionSelectionApplyDialogConfirm;

  /// No description provided for @regionSelectionDeviceDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Device disconnected. Please reconnect and try again.'**
  String get regionSelectionDeviceDisconnected;

  /// No description provided for @regionSelectionReconnectTimeout.
  ///
  /// In en, this message translates to:
  /// **'Reconnect timed out. Please try again.'**
  String get regionSelectionReconnectTimeout;

  /// No description provided for @regionSelectionPairingInvalidation.
  ///
  /// In en, this message translates to:
  /// **'Your phone removed the stored pairing info for this device.\nGo to Settings > Bluetooth, forget the Meshtastic device, and try again.'**
  String get regionSelectionPairingInvalidation;

  /// No description provided for @regionSelectionSetRegionError.
  ///
  /// In en, this message translates to:
  /// **'Failed to set region: {error}'**
  String regionSelectionSetRegionError(String error);

  /// No description provided for @regionSelectionOpenBluetoothSettingsError.
  ///
  /// In en, this message translates to:
  /// **'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.'**
  String get regionSelectionOpenBluetoothSettingsError;

  /// No description provided for @regionSelectionPairingHintMessage.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth pairing was removed. Forget \"Meshtastic_XXXX\" in Settings > Bluetooth and reconnect to continue.'**
  String get regionSelectionPairingHintMessage;

  /// No description provided for @regionSelectionBluetoothSettings.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Settings'**
  String get regionSelectionBluetoothSettings;

  /// No description provided for @regionSelectionViewScanner.
  ///
  /// In en, this message translates to:
  /// **'View Scanner'**
  String get regionSelectionViewScanner;

  /// No description provided for @regionSelectionRegionUs.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get regionSelectionRegionUs;

  /// No description provided for @regionSelectionRegionUsFreq.
  ///
  /// In en, this message translates to:
  /// **'915 MHz'**
  String get regionSelectionRegionUsFreq;

  /// No description provided for @regionSelectionRegionUsDesc.
  ///
  /// In en, this message translates to:
  /// **'US, Canada, Mexico'**
  String get regionSelectionRegionUsDesc;

  /// No description provided for @regionSelectionRegionEu868.
  ///
  /// In en, this message translates to:
  /// **'Europe 868'**
  String get regionSelectionRegionEu868;

  /// No description provided for @regionSelectionRegionEu868Freq.
  ///
  /// In en, this message translates to:
  /// **'868 MHz'**
  String get regionSelectionRegionEu868Freq;

  /// No description provided for @regionSelectionRegionEu868Desc.
  ///
  /// In en, this message translates to:
  /// **'EU, UK, and most of Europe'**
  String get regionSelectionRegionEu868Desc;

  /// No description provided for @regionSelectionRegionEu433.
  ///
  /// In en, this message translates to:
  /// **'Europe 433'**
  String get regionSelectionRegionEu433;

  /// No description provided for @regionSelectionRegionEu433Freq.
  ///
  /// In en, this message translates to:
  /// **'433 MHz'**
  String get regionSelectionRegionEu433Freq;

  /// No description provided for @regionSelectionRegionEu433Desc.
  ///
  /// In en, this message translates to:
  /// **'EU alternate frequency'**
  String get regionSelectionRegionEu433Desc;

  /// No description provided for @regionSelectionRegionAnz.
  ///
  /// In en, this message translates to:
  /// **'Australia/NZ'**
  String get regionSelectionRegionAnz;

  /// No description provided for @regionSelectionRegionAnzFreq.
  ///
  /// In en, this message translates to:
  /// **'915 MHz'**
  String get regionSelectionRegionAnzFreq;

  /// No description provided for @regionSelectionRegionAnzDesc.
  ///
  /// In en, this message translates to:
  /// **'Australia and New Zealand'**
  String get regionSelectionRegionAnzDesc;

  /// No description provided for @regionSelectionRegionCn.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get regionSelectionRegionCn;

  /// No description provided for @regionSelectionRegionCnFreq.
  ///
  /// In en, this message translates to:
  /// **'470 MHz'**
  String get regionSelectionRegionCnFreq;

  /// No description provided for @regionSelectionRegionCnDesc.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get regionSelectionRegionCnDesc;

  /// No description provided for @regionSelectionRegionJp.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get regionSelectionRegionJp;

  /// No description provided for @regionSelectionRegionJpFreq.
  ///
  /// In en, this message translates to:
  /// **'920 MHz'**
  String get regionSelectionRegionJpFreq;

  /// No description provided for @regionSelectionRegionJpDesc.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get regionSelectionRegionJpDesc;

  /// No description provided for @regionSelectionRegionKr.
  ///
  /// In en, this message translates to:
  /// **'Korea'**
  String get regionSelectionRegionKr;

  /// No description provided for @regionSelectionRegionKrFreq.
  ///
  /// In en, this message translates to:
  /// **'920 MHz'**
  String get regionSelectionRegionKrFreq;

  /// No description provided for @regionSelectionRegionKrDesc.
  ///
  /// In en, this message translates to:
  /// **'South Korea'**
  String get regionSelectionRegionKrDesc;

  /// No description provided for @regionSelectionRegionTw.
  ///
  /// In en, this message translates to:
  /// **'Taiwan'**
  String get regionSelectionRegionTw;

  /// No description provided for @regionSelectionRegionTwFreq.
  ///
  /// In en, this message translates to:
  /// **'923 MHz'**
  String get regionSelectionRegionTwFreq;

  /// No description provided for @regionSelectionRegionTwDesc.
  ///
  /// In en, this message translates to:
  /// **'Taiwan'**
  String get regionSelectionRegionTwDesc;

  /// No description provided for @regionSelectionRegionRu.
  ///
  /// In en, this message translates to:
  /// **'Russia'**
  String get regionSelectionRegionRu;

  /// No description provided for @regionSelectionRegionRuFreq.
  ///
  /// In en, this message translates to:
  /// **'868 MHz'**
  String get regionSelectionRegionRuFreq;

  /// No description provided for @regionSelectionRegionRuDesc.
  ///
  /// In en, this message translates to:
  /// **'Russia'**
  String get regionSelectionRegionRuDesc;

  /// No description provided for @regionSelectionRegionIn.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get regionSelectionRegionIn;

  /// No description provided for @regionSelectionRegionInFreq.
  ///
  /// In en, this message translates to:
  /// **'865 MHz'**
  String get regionSelectionRegionInFreq;

  /// No description provided for @regionSelectionRegionInDesc.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get regionSelectionRegionInDesc;

  /// No description provided for @regionSelectionRegionNz865.
  ///
  /// In en, this message translates to:
  /// **'New Zealand 865'**
  String get regionSelectionRegionNz865;

  /// No description provided for @regionSelectionRegionNz865Freq.
  ///
  /// In en, this message translates to:
  /// **'865 MHz'**
  String get regionSelectionRegionNz865Freq;

  /// No description provided for @regionSelectionRegionNz865Desc.
  ///
  /// In en, this message translates to:
  /// **'New Zealand alternate'**
  String get regionSelectionRegionNz865Desc;

  /// No description provided for @regionSelectionRegionTh.
  ///
  /// In en, this message translates to:
  /// **'Thailand'**
  String get regionSelectionRegionTh;

  /// No description provided for @regionSelectionRegionThFreq.
  ///
  /// In en, this message translates to:
  /// **'920 MHz'**
  String get regionSelectionRegionThFreq;

  /// No description provided for @regionSelectionRegionThDesc.
  ///
  /// In en, this message translates to:
  /// **'Thailand'**
  String get regionSelectionRegionThDesc;

  /// No description provided for @regionSelectionRegionUa433.
  ///
  /// In en, this message translates to:
  /// **'Ukraine 433'**
  String get regionSelectionRegionUa433;

  /// No description provided for @regionSelectionRegionUa433Freq.
  ///
  /// In en, this message translates to:
  /// **'433 MHz'**
  String get regionSelectionRegionUa433Freq;

  /// No description provided for @regionSelectionRegionUa433Desc.
  ///
  /// In en, this message translates to:
  /// **'Ukraine'**
  String get regionSelectionRegionUa433Desc;

  /// No description provided for @regionSelectionRegionUa868.
  ///
  /// In en, this message translates to:
  /// **'Ukraine 868'**
  String get regionSelectionRegionUa868;

  /// No description provided for @regionSelectionRegionUa868Freq.
  ///
  /// In en, this message translates to:
  /// **'868 MHz'**
  String get regionSelectionRegionUa868Freq;

  /// No description provided for @regionSelectionRegionUa868Desc.
  ///
  /// In en, this message translates to:
  /// **'Ukraine'**
  String get regionSelectionRegionUa868Desc;

  /// No description provided for @regionSelectionRegionMy433.
  ///
  /// In en, this message translates to:
  /// **'Malaysia 433'**
  String get regionSelectionRegionMy433;

  /// No description provided for @regionSelectionRegionMy433Freq.
  ///
  /// In en, this message translates to:
  /// **'433 MHz'**
  String get regionSelectionRegionMy433Freq;

  /// No description provided for @regionSelectionRegionMy433Desc.
  ///
  /// In en, this message translates to:
  /// **'Malaysia'**
  String get regionSelectionRegionMy433Desc;

  /// No description provided for @regionSelectionRegionMy919.
  ///
  /// In en, this message translates to:
  /// **'Malaysia 919'**
  String get regionSelectionRegionMy919;

  /// No description provided for @regionSelectionRegionMy919Freq.
  ///
  /// In en, this message translates to:
  /// **'919 MHz'**
  String get regionSelectionRegionMy919Freq;

  /// No description provided for @regionSelectionRegionMy919Desc.
  ///
  /// In en, this message translates to:
  /// **'Malaysia'**
  String get regionSelectionRegionMy919Desc;

  /// No description provided for @regionSelectionRegionSg923.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get regionSelectionRegionSg923;

  /// No description provided for @regionSelectionRegionSg923Freq.
  ///
  /// In en, this message translates to:
  /// **'923 MHz'**
  String get regionSelectionRegionSg923Freq;

  /// No description provided for @regionSelectionRegionSg923Desc.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get regionSelectionRegionSg923Desc;

  /// No description provided for @regionSelectionRegionLora24.
  ///
  /// In en, this message translates to:
  /// **'2.4 GHz'**
  String get regionSelectionRegionLora24;

  /// No description provided for @regionSelectionRegionLora24Freq.
  ///
  /// In en, this message translates to:
  /// **'2.4 GHz'**
  String get regionSelectionRegionLora24Freq;

  /// No description provided for @regionSelectionRegionLora24Desc.
  ///
  /// In en, this message translates to:
  /// **'Worldwide 2.4GHz band'**
  String get regionSelectionRegionLora24Desc;

  /// No description provided for @gpsStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'GPS Status'**
  String get gpsStatusTitle;

  /// No description provided for @gpsStatusSectionPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get gpsStatusSectionPosition;

  /// No description provided for @gpsStatusSectionMotion.
  ///
  /// In en, this message translates to:
  /// **'Motion'**
  String get gpsStatusSectionMotion;

  /// No description provided for @gpsStatusSectionSatellites.
  ///
  /// In en, this message translates to:
  /// **'Satellites'**
  String get gpsStatusSectionSatellites;

  /// No description provided for @gpsStatusSectionLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get gpsStatusSectionLastUpdate;

  /// No description provided for @gpsStatusLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get gpsStatusLatitude;

  /// No description provided for @gpsStatusLatitudeValue.
  ///
  /// In en, this message translates to:
  /// **'{value}°'**
  String gpsStatusLatitudeValue(String value);

  /// No description provided for @gpsStatusLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get gpsStatusLongitude;

  /// No description provided for @gpsStatusLongitudeValue.
  ///
  /// In en, this message translates to:
  /// **'{value}°'**
  String gpsStatusLongitudeValue(String value);

  /// No description provided for @gpsStatusAltitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get gpsStatusAltitude;

  /// No description provided for @gpsStatusAltitudeValue.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String gpsStatusAltitudeValue(String meters);

  /// No description provided for @gpsStatusAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get gpsStatusAccuracy;

  /// No description provided for @gpsStatusAccuracyValue.
  ///
  /// In en, this message translates to:
  /// **'±{meters}m'**
  String gpsStatusAccuracyValue(String meters);

  /// No description provided for @gpsStatusPrecisionBits.
  ///
  /// In en, this message translates to:
  /// **'Precision Bits'**
  String get gpsStatusPrecisionBits;

  /// No description provided for @gpsStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get gpsStatusUnknown;

  /// No description provided for @gpsStatusGroundSpeed.
  ///
  /// In en, this message translates to:
  /// **'Ground Speed'**
  String get gpsStatusGroundSpeed;

  /// No description provided for @gpsStatusGroundSpeedValue.
  ///
  /// In en, this message translates to:
  /// **'{mps} m/s ({kmh} km/h)'**
  String gpsStatusGroundSpeedValue(String mps, String kmh);

  /// No description provided for @gpsStatusGroundTrack.
  ///
  /// In en, this message translates to:
  /// **'Ground Track'**
  String get gpsStatusGroundTrack;

  /// No description provided for @gpsStatusGroundTrackValue.
  ///
  /// In en, this message translates to:
  /// **'{degrees}° {direction}'**
  String gpsStatusGroundTrackValue(String degrees, String direction);

  /// No description provided for @gpsStatusOpenInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get gpsStatusOpenInMaps;

  /// No description provided for @gpsStatusNoGpsFix.
  ///
  /// In en, this message translates to:
  /// **'No GPS Fix'**
  String get gpsStatusNoGpsFix;

  /// No description provided for @gpsStatusNoGpsFixMessage.
  ///
  /// In en, this message translates to:
  /// **'The device has not acquired a GPS position yet. Make sure the device has a clear view of the sky.'**
  String get gpsStatusNoGpsFixMessage;

  /// No description provided for @gpsStatusSatellitesInView.
  ///
  /// In en, this message translates to:
  /// **'Satellites in View'**
  String get gpsStatusSatellitesInView;

  /// No description provided for @gpsStatusSatNoFix.
  ///
  /// In en, this message translates to:
  /// **'No Fix'**
  String get gpsStatusSatNoFix;

  /// No description provided for @gpsStatusSatPoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get gpsStatusSatPoor;

  /// No description provided for @gpsStatusSatFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get gpsStatusSatFair;

  /// No description provided for @gpsStatusSatGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get gpsStatusSatGood;

  /// No description provided for @gpsStatusFixAcquired.
  ///
  /// In en, this message translates to:
  /// **'GPS Fix Acquired'**
  String get gpsStatusFixAcquired;

  /// No description provided for @gpsStatusAcquiring.
  ///
  /// In en, this message translates to:
  /// **'Acquiring GPS...'**
  String get gpsStatusAcquiring;

  /// No description provided for @gpsStatusSatellitesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} satellites in view'**
  String gpsStatusSatellitesCount(int count);

  /// No description provided for @gpsStatusSearchingSatellites.
  ///
  /// In en, this message translates to:
  /// **'Searching for satellites...'**
  String get gpsStatusSearchingSatellites;

  /// No description provided for @gpsStatusActiveBadge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get gpsStatusActiveBadge;

  /// No description provided for @gpsStatusTodayAt.
  ///
  /// In en, this message translates to:
  /// **'Today at {time}'**
  String gpsStatusTodayAt(String time);

  /// No description provided for @gpsStatusDateAt.
  ///
  /// In en, this message translates to:
  /// **'{date} {time}'**
  String gpsStatusDateAt(String date, String time);

  /// No description provided for @gpsStatusSecondsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} seconds ago'**
  String gpsStatusSecondsAgo(int count);

  /// No description provided for @gpsStatusMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String gpsStatusMinutesAgo(int count);

  /// No description provided for @gpsStatusHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String gpsStatusHoursAgo(int count);

  /// No description provided for @gpsStatusDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String gpsStatusDaysAgo(int count);

  /// No description provided for @gpsStatusCardinalN.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get gpsStatusCardinalN;

  /// No description provided for @gpsStatusCardinalNE.
  ///
  /// In en, this message translates to:
  /// **'NE'**
  String get gpsStatusCardinalNE;

  /// No description provided for @gpsStatusCardinalE.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get gpsStatusCardinalE;

  /// No description provided for @gpsStatusCardinalSE.
  ///
  /// In en, this message translates to:
  /// **'SE'**
  String get gpsStatusCardinalSE;

  /// No description provided for @gpsStatusCardinalS.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get gpsStatusCardinalS;

  /// No description provided for @gpsStatusCardinalSW.
  ///
  /// In en, this message translates to:
  /// **'SW'**
  String get gpsStatusCardinalSW;

  /// No description provided for @gpsStatusCardinalW.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get gpsStatusCardinalW;

  /// No description provided for @gpsStatusCardinalNW.
  ///
  /// In en, this message translates to:
  /// **'NW'**
  String get gpsStatusCardinalNW;

  /// No description provided for @serialConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Serial Config'**
  String get serialConfigTitle;

  /// No description provided for @serialConfigSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get serialConfigSave;

  /// No description provided for @serialConfigSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get serialConfigSectionGeneral;

  /// No description provided for @serialConfigSectionBaudRate.
  ///
  /// In en, this message translates to:
  /// **'Baud Rate'**
  String get serialConfigSectionBaudRate;

  /// No description provided for @serialConfigSectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get serialConfigSectionTimeout;

  /// No description provided for @serialConfigSectionSerialMode.
  ///
  /// In en, this message translates to:
  /// **'Serial Mode'**
  String get serialConfigSectionSerialMode;

  /// No description provided for @serialConfigEnabled.
  ///
  /// In en, this message translates to:
  /// **'Serial Enabled'**
  String get serialConfigEnabled;

  /// No description provided for @serialConfigEnabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable serial port communication'**
  String get serialConfigEnabledSubtitle;

  /// No description provided for @serialConfigEcho.
  ///
  /// In en, this message translates to:
  /// **'Echo'**
  String get serialConfigEcho;

  /// No description provided for @serialConfigEchoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Echo sent packets back to the serial port'**
  String get serialConfigEchoSubtitle;

  /// No description provided for @serialConfigRxdGpio.
  ///
  /// In en, this message translates to:
  /// **'RXD GPIO Pin'**
  String get serialConfigRxdGpio;

  /// No description provided for @serialConfigRxdGpioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive data GPIO pin number'**
  String get serialConfigRxdGpioSubtitle;

  /// No description provided for @serialConfigTxdGpio.
  ///
  /// In en, this message translates to:
  /// **'TXD GPIO Pin'**
  String get serialConfigTxdGpio;

  /// No description provided for @serialConfigTxdGpioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Transmit data GPIO pin number'**
  String get serialConfigTxdGpioSubtitle;

  /// No description provided for @serialConfigOverrideConsole.
  ///
  /// In en, this message translates to:
  /// **'Override Console Serial'**
  String get serialConfigOverrideConsole;

  /// No description provided for @serialConfigOverrideConsoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use serial module instead of console'**
  String get serialConfigOverrideConsoleSubtitle;

  /// No description provided for @serialConfigBaudRate.
  ///
  /// In en, this message translates to:
  /// **'Baud Rate'**
  String get serialConfigBaudRate;

  /// No description provided for @serialConfigBaudRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Serial communication speed'**
  String get serialConfigBaudRateSubtitle;

  /// No description provided for @serialConfigTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get serialConfigTimeout;

  /// No description provided for @serialConfigTimeoutValue.
  ///
  /// In en, this message translates to:
  /// **'{seconds} seconds'**
  String serialConfigTimeoutValue(int seconds);

  /// No description provided for @serialConfigModeSimpleDesc.
  ///
  /// In en, this message translates to:
  /// **'Simple serial output for basic terminal usage'**
  String get serialConfigModeSimpleDesc;

  /// No description provided for @serialConfigModeProtoDesc.
  ///
  /// In en, this message translates to:
  /// **'Protobuf binary protocol for programmatic access'**
  String get serialConfigModeProtoDesc;

  /// No description provided for @serialConfigModeTextmsgDesc.
  ///
  /// In en, this message translates to:
  /// **'Text message mode for SMS-style communication'**
  String get serialConfigModeTextmsgDesc;

  /// No description provided for @serialConfigModeNmeaDesc.
  ///
  /// In en, this message translates to:
  /// **'NMEA GPS sentence output for GPS applications'**
  String get serialConfigModeNmeaDesc;

  /// No description provided for @serialConfigModeCaltopoDesc.
  ///
  /// In en, this message translates to:
  /// **'CalTopo format for mapping applications'**
  String get serialConfigModeCaltopoDesc;

  /// No description provided for @serialConfigGpioUnset.
  ///
  /// In en, this message translates to:
  /// **'Unset'**
  String get serialConfigGpioUnset;

  /// No description provided for @serialConfigGpioPin.
  ///
  /// In en, this message translates to:
  /// **'Pin {pin}'**
  String serialConfigGpioPin(int pin);

  /// No description provided for @serialConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Serial configuration saved'**
  String get serialConfigSaved;

  /// No description provided for @serialConfigSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error saving config: {error}'**
  String serialConfigSaveError(String error);

  /// No description provided for @firmwareUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Firmware Update'**
  String get firmwareUpdateTitle;

  /// No description provided for @firmwareUpdateSectionCurrentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current Version'**
  String get firmwareUpdateSectionCurrentVersion;

  /// No description provided for @firmwareUpdateSectionAvailableUpdate.
  ///
  /// In en, this message translates to:
  /// **'Available Update'**
  String get firmwareUpdateSectionAvailableUpdate;

  /// No description provided for @firmwareUpdateSectionHowToUpdate.
  ///
  /// In en, this message translates to:
  /// **'How to Update'**
  String get firmwareUpdateSectionHowToUpdate;

  /// No description provided for @firmwareUpdateInstalledFirmware.
  ///
  /// In en, this message translates to:
  /// **'Installed Firmware'**
  String get firmwareUpdateInstalledFirmware;

  /// No description provided for @firmwareUpdateUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get firmwareUpdateUnknown;

  /// No description provided for @firmwareUpdateHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get firmwareUpdateHardware;

  /// No description provided for @firmwareUpdateNodeId.
  ///
  /// In en, this message translates to:
  /// **'Node ID'**
  String get firmwareUpdateNodeId;

  /// No description provided for @firmwareUpdateUptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get firmwareUpdateUptime;

  /// No description provided for @firmwareUpdateWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get firmwareUpdateWifi;

  /// No description provided for @firmwareUpdateBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get firmwareUpdateBluetooth;

  /// No description provided for @firmwareUpdateSupported.
  ///
  /// In en, this message translates to:
  /// **'Supported'**
  String get firmwareUpdateSupported;

  /// No description provided for @firmwareUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get firmwareUpdateAvailable;

  /// No description provided for @firmwareUpdateUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Up to Date'**
  String get firmwareUpdateUpToDate;

  /// No description provided for @firmwareUpdateLatestVersion.
  ///
  /// In en, this message translates to:
  /// **'Latest: {version}'**
  String firmwareUpdateLatestVersion(String version);

  /// No description provided for @firmwareUpdateNewBadge.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get firmwareUpdateNewBadge;

  /// No description provided for @firmwareUpdateDownload.
  ///
  /// In en, this message translates to:
  /// **'Download Update'**
  String get firmwareUpdateDownload;

  /// No description provided for @firmwareUpdateReleaseNotes.
  ///
  /// In en, this message translates to:
  /// **'Release Notes'**
  String get firmwareUpdateReleaseNotes;

  /// No description provided for @firmwareUpdateChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking for updates...'**
  String get firmwareUpdateChecking;

  /// No description provided for @firmwareUpdateCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to check for updates'**
  String get firmwareUpdateCheckFailed;

  /// No description provided for @firmwareUpdateUnableToCheck.
  ///
  /// In en, this message translates to:
  /// **'Unable to check for updates'**
  String get firmwareUpdateUnableToCheck;

  /// No description provided for @firmwareUpdateVisitWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit the Meshtastic website for the latest firmware.'**
  String get firmwareUpdateVisitWebsite;

  /// No description provided for @firmwareUpdateStep1.
  ///
  /// In en, this message translates to:
  /// **'Download the firmware file for your device'**
  String get firmwareUpdateStep1;

  /// No description provided for @firmwareUpdateStep2.
  ///
  /// In en, this message translates to:
  /// **'Connect your device via USB'**
  String get firmwareUpdateStep2;

  /// No description provided for @firmwareUpdateStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the Meshtastic Web Flasher or CLI to flash'**
  String get firmwareUpdateStep3;

  /// No description provided for @firmwareUpdateStep4.
  ///
  /// In en, this message translates to:
  /// **'Wait for device to reboot and reconnect'**
  String get firmwareUpdateStep4;

  /// No description provided for @firmwareUpdateOpenWebFlasher.
  ///
  /// In en, this message translates to:
  /// **'Open Web Flasher'**
  String get firmwareUpdateOpenWebFlasher;

  /// No description provided for @firmwareUpdateBackupWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup Your Settings'**
  String get firmwareUpdateBackupWarningTitle;

  /// No description provided for @firmwareUpdateBackupWarningSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Firmware updates may reset your device configuration. Consider exporting your settings before updating.'**
  String get firmwareUpdateBackupWarningSubtitle;

  /// No description provided for @telemetryConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Telemetry'**
  String get telemetryConfigTitle;

  /// No description provided for @telemetryConfigSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get telemetryConfigSave;

  /// No description provided for @telemetryConfigSectionDeviceMetrics.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get telemetryConfigSectionDeviceMetrics;

  /// No description provided for @telemetryConfigSectionEnvironmentMetrics.
  ///
  /// In en, this message translates to:
  /// **'Environment Metrics'**
  String get telemetryConfigSectionEnvironmentMetrics;

  /// No description provided for @telemetryConfigSectionAirQuality.
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get telemetryConfigSectionAirQuality;

  /// No description provided for @telemetryConfigSectionPowerMetrics.
  ///
  /// In en, this message translates to:
  /// **'Power Metrics'**
  String get telemetryConfigSectionPowerMetrics;

  /// No description provided for @telemetryConfigDeviceMetricsDesc.
  ///
  /// In en, this message translates to:
  /// **'Battery level, voltage, channel utilization, air util TX'**
  String get telemetryConfigDeviceMetricsDesc;

  /// No description provided for @telemetryConfigEnvironmentMetricsDesc.
  ///
  /// In en, this message translates to:
  /// **'Temperature, humidity, barometric pressure, gas resistance'**
  String get telemetryConfigEnvironmentMetricsDesc;

  /// No description provided for @telemetryConfigAirQualityDesc.
  ///
  /// In en, this message translates to:
  /// **'PM1.0, PM2.5, PM10, particle counts, CO2'**
  String get telemetryConfigAirQualityDesc;

  /// No description provided for @telemetryConfigPowerMetricsDesc.
  ///
  /// In en, this message translates to:
  /// **'Voltage and current for channels 1-3'**
  String get telemetryConfigPowerMetricsDesc;

  /// No description provided for @telemetryConfigDisplayOnScreen.
  ///
  /// In en, this message translates to:
  /// **'Display on Screen'**
  String get telemetryConfigDisplayOnScreen;

  /// No description provided for @telemetryConfigDisplayOnScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show environment data on device screen'**
  String get telemetryConfigDisplayOnScreenSubtitle;

  /// No description provided for @telemetryConfigDisplayFahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Display Fahrenheit'**
  String get telemetryConfigDisplayFahrenheit;

  /// No description provided for @telemetryConfigDisplayFahrenheitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show temperature in Fahrenheit instead of Celsius'**
  String get telemetryConfigDisplayFahrenheitSubtitle;

  /// No description provided for @telemetryConfigEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get telemetryConfigEnabled;

  /// No description provided for @telemetryConfigUpdateInterval.
  ///
  /// In en, this message translates to:
  /// **'Update Interval'**
  String get telemetryConfigUpdateInterval;

  /// No description provided for @telemetryConfigMinutes.
  ///
  /// In en, this message translates to:
  /// **' minutes'**
  String get telemetryConfigMinutes;

  /// No description provided for @telemetryConfigAirtimeWarning.
  ///
  /// In en, this message translates to:
  /// **'Telemetry data is shared with all nodes on the mesh network. Shorter intervals increase airtime usage.'**
  String get telemetryConfigAirtimeWarning;

  /// No description provided for @telemetryConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Telemetry config saved'**
  String get telemetryConfigSaved;

  /// No description provided for @telemetryConfigSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String telemetryConfigSaveError(String error);

  /// No description provided for @ambientLightingTitle.
  ///
  /// In en, this message translates to:
  /// **'Ambient Lighting'**
  String get ambientLightingTitle;

  /// No description provided for @ambientLightingSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get ambientLightingSave;

  /// No description provided for @ambientLightingLedEnabled.
  ///
  /// In en, this message translates to:
  /// **'LED Enabled'**
  String get ambientLightingLedEnabled;

  /// No description provided for @ambientLightingLedEnabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn ambient lighting on or off'**
  String get ambientLightingLedEnabledSubtitle;

  /// No description provided for @ambientLightingPresetColors.
  ///
  /// In en, this message translates to:
  /// **'Preset Colors'**
  String get ambientLightingPresetColors;

  /// No description provided for @ambientLightingCustomColor.
  ///
  /// In en, this message translates to:
  /// **'Custom Color'**
  String get ambientLightingCustomColor;

  /// No description provided for @ambientLightingRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get ambientLightingRed;

  /// No description provided for @ambientLightingGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get ambientLightingGreen;

  /// No description provided for @ambientLightingBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get ambientLightingBlue;

  /// No description provided for @ambientLightingBrightness.
  ///
  /// In en, this message translates to:
  /// **'LED Brightness'**
  String get ambientLightingBrightness;

  /// No description provided for @ambientLightingCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get ambientLightingCurrent;

  /// No description provided for @ambientLightingCurrentValue.
  ///
  /// In en, this message translates to:
  /// **'{milliamps} mA'**
  String ambientLightingCurrentValue(int milliamps);

  /// No description provided for @ambientLightingCurrentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'LED drive current (brightness)'**
  String get ambientLightingCurrentSubtitle;

  /// No description provided for @ambientLightingDeviceSupportInfo.
  ///
  /// In en, this message translates to:
  /// **'Ambient lighting is only available on devices with LED support (RAK WisBlock, T-Beam, etc.)'**
  String get ambientLightingDeviceSupportInfo;

  /// No description provided for @ambientLightingSaved.
  ///
  /// In en, this message translates to:
  /// **'Ambient lighting saved'**
  String get ambientLightingSaved;

  /// No description provided for @ambientLightingSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String ambientLightingSaveError(String error);

  /// No description provided for @paxCounterTitle.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter'**
  String get paxCounterTitle;

  /// No description provided for @paxCounterSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get paxCounterSave;

  /// No description provided for @paxCounterCardTitle.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter'**
  String get paxCounterCardTitle;

  /// No description provided for @paxCounterCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Counts nearby WiFi and Bluetooth devices'**
  String get paxCounterCardSubtitle;

  /// No description provided for @paxCounterEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable PAX Counter'**
  String get paxCounterEnable;

  /// No description provided for @paxCounterEnableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Count nearby devices and report to mesh'**
  String get paxCounterEnableSubtitle;

  /// No description provided for @paxCounterUpdateInterval.
  ///
  /// In en, this message translates to:
  /// **'Update Interval'**
  String get paxCounterUpdateInterval;

  /// No description provided for @paxCounterIntervalMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String paxCounterIntervalMinutes(int minutes);

  /// No description provided for @paxCounterMinLabel.
  ///
  /// In en, this message translates to:
  /// **'1 min'**
  String get paxCounterMinLabel;

  /// No description provided for @paxCounterMaxLabel.
  ///
  /// In en, this message translates to:
  /// **'60 min'**
  String get paxCounterMaxLabel;

  /// No description provided for @paxCounterAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About PAX Counter'**
  String get paxCounterAboutTitle;

  /// No description provided for @paxCounterAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter passively listens for WiFi and Bluetooth probe requests from nearby devices. It does not store MAC addresses or any personal data.'**
  String get paxCounterAboutSubtitle;

  /// No description provided for @paxCounterSaved.
  ///
  /// In en, this message translates to:
  /// **'PAX counter config saved'**
  String get paxCounterSaved;

  /// No description provided for @paxCounterSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String paxCounterSaveError(String error);

  /// No description provided for @meshcoreConsoleTitle.
  ///
  /// In en, this message translates to:
  /// **'MeshCore Console'**
  String get meshcoreConsoleTitle;

  /// No description provided for @meshcoreConsoleDevBadge.
  ///
  /// In en, this message translates to:
  /// **'DEV'**
  String get meshcoreConsoleDevBadge;

  /// No description provided for @meshcoreConsoleFramesCaptured.
  ///
  /// In en, this message translates to:
  /// **'{count} frames captured'**
  String meshcoreConsoleFramesCaptured(int count);

  /// No description provided for @meshcoreConsoleRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get meshcoreConsoleRefresh;

  /// No description provided for @meshcoreConsoleCopyHex.
  ///
  /// In en, this message translates to:
  /// **'Copy Hex'**
  String get meshcoreConsoleCopyHex;

  /// No description provided for @meshcoreConsoleClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get meshcoreConsoleClear;

  /// No description provided for @meshcoreConsoleNoFrames.
  ///
  /// In en, this message translates to:
  /// **'No frames captured yet'**
  String get meshcoreConsoleNoFrames;

  /// No description provided for @meshcoreConsoleHexCopied.
  ///
  /// In en, this message translates to:
  /// **'Hex log copied to clipboard'**
  String get meshcoreConsoleHexCopied;

  /// No description provided for @meshcoreConsoleCaptureCleared.
  ///
  /// In en, this message translates to:
  /// **'Capture cleared'**
  String get meshcoreConsoleCaptureCleared;
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
