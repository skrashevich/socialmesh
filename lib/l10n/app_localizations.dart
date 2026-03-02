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
