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

  @override
  String get nodedexTagContact => 'Contact';

  @override
  String get nodedexTagTrustedNode => 'Trusted Node';

  @override
  String get nodedexTagKnownRelay => 'Known Relay';

  @override
  String get nodedexTagFrequentPeer => 'Frequent Peer';

  @override
  String get nodedexTraitWanderer => 'Wanderer';

  @override
  String get nodedexTraitBeacon => 'Beacon';

  @override
  String get nodedexTraitGhost => 'Ghost';

  @override
  String get nodedexTraitSentinel => 'Sentinel';

  @override
  String get nodedexTraitRelay => 'Relay';

  @override
  String get nodedexTraitCourier => 'Courier';

  @override
  String get nodedexTraitAnchor => 'Anchor';

  @override
  String get nodedexTraitDrifter => 'Drifter';

  @override
  String get nodedexTraitUnknown => 'Newcomer';

  @override
  String get nodedexTraitWandererDescription =>
      'Seen across multiple locations';

  @override
  String get nodedexTraitBeaconDescription =>
      'Always active, high availability';

  @override
  String get nodedexTraitGhostDescription => 'Rarely seen, elusive presence';

  @override
  String get nodedexTraitSentinelDescription =>
      'Fixed position, long-lived guardian';

  @override
  String get nodedexTraitRelayDescription =>
      'High throughput, forwards traffic';

  @override
  String get nodedexTraitCourierDescription =>
      'Carries messages across the mesh';

  @override
  String get nodedexTraitAnchorDescription =>
      'Persistent hub with many connections';

  @override
  String get nodedexTraitDrifterDescription =>
      'Irregular timing, fades in and out';

  @override
  String get nodedexTraitUnknownDescription => 'Recently discovered';

  @override
  String get explorerTitleNewcomer => 'Newcomer';

  @override
  String get explorerTitleObserver => 'Observer';

  @override
  String get explorerTitleExplorer => 'Explorer';

  @override
  String get explorerTitleCartographer => 'Cartographer';

  @override
  String get explorerTitleSignalHunter => 'Signal Hunter';

  @override
  String get explorerTitleMeshVeteran => 'Mesh Veteran';

  @override
  String get explorerTitleMeshCartographer => 'Mesh Cartographer';

  @override
  String get explorerTitleLongRangeRecordHolder => 'Long-Range Record Holder';

  @override
  String get explorerTitleNewcomerDescription => 'Beginning the mesh journey';

  @override
  String get explorerTitleObserverDescription =>
      'Building awareness of the mesh';

  @override
  String get explorerTitleExplorerDescription =>
      'Actively discovering the network';

  @override
  String get explorerTitleCartographerDescription =>
      'Mapping the invisible infrastructure';

  @override
  String get explorerTitleSignalHunterDescription =>
      'Seeking signals across the spectrum';

  @override
  String get explorerTitleMeshVeteranDescription =>
      'Deep knowledge of the mesh';

  @override
  String get explorerTitleMeshCartographerDescription =>
      'Charting regions and routes';

  @override
  String get explorerTitleLongRangeRecordHolderDescription =>
      'Pushing the limits of range';
}
