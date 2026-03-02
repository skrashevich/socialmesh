// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Socialmesh';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonDone => 'Done';

  @override
  String get commonGoBack => 'Go Back';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonClose => 'Close';

  @override
  String get commonOk => 'OK';

  @override
  String get commonContinue => 'Continue';

  @override
  String get navigationMenuTooltip => 'Menu';

  @override
  String get navigationDeviceTooltip => 'Device';

  @override
  String get navigationSectionSocial => 'SOCIAL';

  @override
  String get navigationSectionMesh => 'MESH';

  @override
  String get navigationSectionPremium => 'PREMIUM';

  @override
  String get navigationSectionAccount => 'ACCOUNT';

  @override
  String get navigationSignals => 'Signals';

  @override
  String get navigationSocial => 'Social';

  @override
  String get navigationNodeDex => 'NodeDex';

  @override
  String get navigationFileTransfers => 'File Transfers';

  @override
  String get navigationAether => 'Aether';

  @override
  String get navigationTakGateway => 'TAK Gateway';

  @override
  String get navigationTakMap => 'TAK Map';

  @override
  String get navigationActivity => 'Activity';

  @override
  String get navigationPresence => 'Presence';

  @override
  String get navigationTimeline => 'Timeline';

  @override
  String get navigationWorldMap => 'World Map';

  @override
  String get navigationMesh3dView => '3D Mesh View';

  @override
  String get navigationRoutes => 'Routes';

  @override
  String get navigationReachability => 'Reachability';

  @override
  String get navigationMeshHealth => 'Mesh Health';

  @override
  String get navigationDeviceLogs => 'Device Logs';

  @override
  String get navigationThemePack => 'Theme Pack';

  @override
  String get navigationRingtonePack => 'Ringtone Pack';

  @override
  String get navigationWidgets => 'Widgets';

  @override
  String get navigationAutomations => 'Automations';

  @override
  String get navigationIftttIntegration => 'IFTTT Integration';

  @override
  String get navigationHelpSupport => 'Help & Support';

  @override
  String get navigationMessages => 'Messages';

  @override
  String get navigationMap => 'Map';

  @override
  String get navigationNodes => 'Nodes';

  @override
  String get navigationDashboard => 'Dashboard';

  @override
  String get navigationGuestName => 'Guest';

  @override
  String get navigationNotSignedIn => 'Not signed in';

  @override
  String get navigationOffline => 'Offline';

  @override
  String get navigationSyncing => 'Syncing...';

  @override
  String get navigationSyncError => 'Sync error';

  @override
  String get navigationSynced => 'Synced';

  @override
  String get navigationViewProfile => 'View Profile';

  @override
  String navigationFirmwareMessage(String message) {
    return 'Firmware: $message';
  }

  @override
  String get navigationFirmwareErrorTitle => 'Meshtastic Device Error';

  @override
  String get navigationFirmwareWarningTitle => 'Meshtastic Device Warning';

  @override
  String navigationFlightActivated(String flightNumber, String route) {
    return '$flightNumber ($route) is now in flight!';
  }

  @override
  String navigationFlightCompleted(String flightNumber, String route) {
    return '$flightNumber ($route) flight completed';
  }
}
