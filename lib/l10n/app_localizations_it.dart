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

  @override
  String get nodedexTagContact => 'Contatto';

  @override
  String get nodedexTagTrustedNode => 'Nodo Fidato';

  @override
  String get nodedexTagKnownRelay => 'Relay Conosciuto';

  @override
  String get nodedexTagFrequentPeer => 'Peer Frequente';

  @override
  String get nodedexTraitWanderer => 'Giramondo';

  @override
  String get nodedexTraitBeacon => 'Faro';

  @override
  String get nodedexTraitGhost => 'Fantasma';

  @override
  String get nodedexTraitSentinel => 'Sentinella';

  @override
  String get nodedexTraitRelay => 'Relay';

  @override
  String get nodedexTraitCourier => 'Corriere';

  @override
  String get nodedexTraitAnchor => 'Ancora';

  @override
  String get nodedexTraitDrifter => 'Vagabondo';

  @override
  String get nodedexTraitUnknown => 'Nuovo';

  @override
  String get nodedexTraitWandererDescription => 'Visto in più luoghi';

  @override
  String get nodedexTraitBeaconDescription =>
      'Sempre attivo, alta disponibilità';

  @override
  String get nodedexTraitGhostDescription =>
      'Raramente visto, presenza sfuggente';

  @override
  String get nodedexTraitSentinelDescription =>
      'Posizione fissa, guardiano di lunga vita';

  @override
  String get nodedexTraitRelayDescription => 'Alto volume, inoltra traffico';

  @override
  String get nodedexTraitCourierDescription => 'Trasporta messaggi nella rete';

  @override
  String get nodedexTraitAnchorDescription =>
      'Hub persistente con molte connessioni';

  @override
  String get nodedexTraitDrifterDescription =>
      'Tempi irregolari, appare e scompare';

  @override
  String get nodedexTraitUnknownDescription => 'Scoperto di recente';

  @override
  String get explorerTitleNewcomer => 'Nuovo Arrivato';

  @override
  String get explorerTitleObserver => 'Osservatore';

  @override
  String get explorerTitleExplorer => 'Esploratore';

  @override
  String get explorerTitleCartographer => 'Cartografo';

  @override
  String get explorerTitleSignalHunter => 'Cacciatore di Segnali';

  @override
  String get explorerTitleMeshVeteran => 'Veterano della Rete';

  @override
  String get explorerTitleMeshCartographer => 'Cartografo della Rete';

  @override
  String get explorerTitleLongRangeRecordHolder =>
      'Detentore del Record di Distanza';

  @override
  String get explorerTitleNewcomerDescription =>
      'Agli inizi del viaggio nella rete';

  @override
  String get explorerTitleObserverDescription =>
      'Sviluppa la consapevolezza della rete';

  @override
  String get explorerTitleExplorerDescription => 'Scopre attivamente la rete';

  @override
  String get explorerTitleCartographerDescription =>
      'Mappa l\'infrastruttura invisibile';

  @override
  String get explorerTitleSignalHunterDescription =>
      'Cerca segnali in tutto lo spettro';

  @override
  String get explorerTitleMeshVeteranDescription =>
      'Profonda conoscenza della rete';

  @override
  String get explorerTitleMeshCartographerDescription =>
      'Traccia regioni e percorsi';

  @override
  String get explorerTitleLongRangeRecordHolderDescription =>
      'Spinge i limiti della portata';
}
