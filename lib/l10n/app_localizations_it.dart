// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Socialmesh';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonDone => 'Fatto';

  @override
  String get commonGoBack => 'Indietro';

  @override
  String get commonConfirm => 'Conferma';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonOk => 'OK';

  @override
  String get commonContinue => 'Continua';

  @override
  String get navigationMenuTooltip => 'Menu';

  @override
  String get navigationDeviceTooltip => 'Dispositivo';

  @override
  String get navigationSectionSocial => 'SOCIAL';

  @override
  String get navigationSectionMesh => 'MESH';

  @override
  String get navigationSectionPremium => 'PREMIUM';

  @override
  String get navigationSectionAccount => 'ACCOUNT';

  @override
  String get navigationSignals => 'Segnali';

  @override
  String get navigationSocial => 'Social';

  @override
  String get navigationNodeDex => 'NodeDex';

  @override
  String get navigationFileTransfers => 'Trasferimento File';

  @override
  String get navigationAether => 'Aether';

  @override
  String get navigationTakGateway => 'TAK Gateway';

  @override
  String get navigationTakMap => 'Mappa TAK';

  @override
  String get navigationActivity => 'Attività';

  @override
  String get navigationPresence => 'Presenza';

  @override
  String get navigationTimeline => 'Cronologia';

  @override
  String get navigationWorldMap => 'Mappa Mondiale';

  @override
  String get navigationMesh3dView => 'Vista Mesh 3D';

  @override
  String get navigationRoutes => 'Percorsi';

  @override
  String get navigationReachability => 'Raggiungibilità';

  @override
  String get navigationMeshHealth => 'Stato Mesh';

  @override
  String get navigationDeviceLogs => 'Log Dispositivo';

  @override
  String get navigationThemePack => 'Pacchetto Temi';

  @override
  String get navigationRingtonePack => 'Pacchetto Suonerie';

  @override
  String get navigationWidgets => 'Widget';

  @override
  String get navigationAutomations => 'Automazioni';

  @override
  String get navigationIftttIntegration => 'Integrazione IFTTT';

  @override
  String get navigationHelpSupport => 'Aiuto e Supporto';

  @override
  String get navigationMessages => 'Messaggi';

  @override
  String get navigationMap => 'Mappa';

  @override
  String get navigationNodes => 'Nodi';

  @override
  String get navigationDashboard => 'Pannello';

  @override
  String get navigationGuestName => 'Ospite';

  @override
  String get navigationNotSignedIn => 'Non autenticato';

  @override
  String get navigationOffline => 'Offline';

  @override
  String get navigationSyncing => 'Sincronizzazione...';

  @override
  String get navigationSyncError => 'Errore di sincronizzazione';

  @override
  String get navigationSynced => 'Sincronizzato';

  @override
  String get navigationViewProfile => 'Visualizza Profilo';

  @override
  String navigationFirmwareMessage(String message) {
    return 'Firmware: $message';
  }

  @override
  String get navigationFirmwareErrorTitle => 'Errore Dispositivo Meshtastic';

  @override
  String get navigationFirmwareWarningTitle => 'Avviso Dispositivo Meshtastic';

  @override
  String navigationFlightActivated(String flightNumber, String route) {
    return '$flightNumber ($route) è ora in volo!';
  }

  @override
  String navigationFlightCompleted(String flightNumber, String route) {
    return '$flightNumber ($route) volo completato';
  }
}
