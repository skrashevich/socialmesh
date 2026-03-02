// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Socialmesh';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonDone => 'Готово';

  @override
  String get commonGoBack => 'Назад';

  @override
  String get commonConfirm => 'Подтвердить';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonOk => 'OК';

  @override
  String get commonContinue => 'Продолжить';

  @override
  String get navigationMenuTooltip => 'Меню';

  @override
  String get navigationDeviceTooltip => 'Устройство';

  @override
  String get navigationSectionSocial => 'СОЦИАЛЬНОЕ';

  @override
  String get navigationSectionMesh => 'MESH';

  @override
  String get navigationSectionPremium => 'ПРЕМИУМ';

  @override
  String get navigationSectionAccount => 'АККАУНТ';

  @override
  String get navigationSignals => 'Сигналы';

  @override
  String get navigationSocial => 'Социальное';

  @override
  String get navigationNodeDex => 'NodeDex';

  @override
  String get navigationFileTransfers => 'Передача файлов';

  @override
  String get navigationAether => 'Aether';

  @override
  String get navigationTakGateway => 'TAK Шлюз';

  @override
  String get navigationTakMap => 'TAK Карта';

  @override
  String get navigationActivity => 'Активность';

  @override
  String get navigationPresence => 'Присутствие';

  @override
  String get navigationTimeline => 'Хронология';

  @override
  String get navigationWorldMap => 'Карта мира';

  @override
  String get navigationMesh3dView => '3D-вид сети';

  @override
  String get navigationRoutes => 'Маршруты';

  @override
  String get navigationReachability => 'Доступность';

  @override
  String get navigationMeshHealth => 'Состояние сети';

  @override
  String get navigationDeviceLogs => 'Журнал устройства';

  @override
  String get navigationThemePack => 'Пакет тем';

  @override
  String get navigationRingtonePack => 'Пакет рингтонов';

  @override
  String get navigationWidgets => 'Виджеты';

  @override
  String get navigationAutomations => 'Автоматизации';

  @override
  String get navigationIftttIntegration => 'Интеграция IFTTT';

  @override
  String get navigationHelpSupport => 'Помощь и поддержка';

  @override
  String get navigationMessages => 'Сообщения';

  @override
  String get navigationMap => 'Карта';

  @override
  String get navigationNodes => 'Узлы';

  @override
  String get navigationDashboard => 'Панель';

  @override
  String get navigationGuestName => 'Гость';

  @override
  String get navigationNotSignedIn => 'Не выполнен вход';

  @override
  String get navigationOffline => 'Офлайн';

  @override
  String get navigationSyncing => 'Синхронизация...';

  @override
  String get navigationSyncError => 'Ошибка синхронизации';

  @override
  String get navigationSynced => 'Синхронизировано';

  @override
  String get navigationViewProfile => 'Просмотр профиля';

  @override
  String navigationFirmwareMessage(String message) {
    return 'Прошивка: $message';
  }

  @override
  String get navigationFirmwareErrorTitle => 'Ошибка устройства Meshtastic';

  @override
  String get navigationFirmwareWarningTitle =>
      'Предупреждение устройства Meshtastic';

  @override
  String navigationFlightActivated(String flightNumber, String route) {
    return '$flightNumber ($route) в воздухе!';
  }

  @override
  String navigationFlightCompleted(String flightNumber, String route) {
    return '$flightNumber ($route) рейс завершён';
  }

  @override
  String get nodedexTagContact => 'Контакт';

  @override
  String get nodedexTagTrustedNode => 'Доверенный узел';

  @override
  String get nodedexTagKnownRelay => 'Известный ретранслятор';

  @override
  String get nodedexTagFrequentPeer => 'Частый партнёр';

  @override
  String get nodedexTraitWanderer => 'Странник';

  @override
  String get nodedexTraitBeacon => 'Маяк';

  @override
  String get nodedexTraitGhost => 'Призрак';

  @override
  String get nodedexTraitSentinel => 'Часовой';

  @override
  String get nodedexTraitRelay => 'Ретранслятор';

  @override
  String get nodedexTraitCourier => 'Курьер';

  @override
  String get nodedexTraitAnchor => 'Якорь';

  @override
  String get nodedexTraitDrifter => 'Дрейфер';

  @override
  String get nodedexTraitUnknown => 'Новичок';

  @override
  String get nodedexTraitWandererDescription => 'Замечен в разных местах';

  @override
  String get nodedexTraitBeaconDescription =>
      'Всегда активен, высокая доступность';

  @override
  String get nodedexTraitGhostDescription =>
      'Редко встречается, неуловимое присутствие';

  @override
  String get nodedexTraitSentinelDescription =>
      'Фиксированное положение, долговечный страж';

  @override
  String get nodedexTraitRelayDescription =>
      'Высокая пропускная способность, пересылает трафик';

  @override
  String get nodedexTraitCourierDescription => 'Доставляет сообщения по сети';

  @override
  String get nodedexTraitAnchorDescription =>
      'Постоянный узел со множеством соединений';

  @override
  String get nodedexTraitDrifterDescription =>
      'Нерегулярные появления, исчезает и появляется';

  @override
  String get nodedexTraitUnknownDescription => 'Недавно обнаружен';

  @override
  String get explorerTitleNewcomer => 'Новичок';

  @override
  String get explorerTitleObserver => 'Наблюдатель';

  @override
  String get explorerTitleExplorer => 'Исследователь';

  @override
  String get explorerTitleCartographer => 'Картограф';

  @override
  String get explorerTitleSignalHunter => 'Охотник за сигналами';

  @override
  String get explorerTitleMeshVeteran => 'Ветеран сети';

  @override
  String get explorerTitleMeshCartographer => 'Картограф сети';

  @override
  String get explorerTitleLongRangeRecordHolder => 'Рекордсмен дальней связи';

  @override
  String get explorerTitleNewcomerDescription => 'Только начинает путь по сети';

  @override
  String get explorerTitleObserverDescription => 'Изучает сеть Mesh';

  @override
  String get explorerTitleExplorerDescription => 'Активно исследует сеть';

  @override
  String get explorerTitleCartographerDescription =>
      'Картографирует невидимую инфраструктуру';

  @override
  String get explorerTitleSignalHunterDescription =>
      'Ищет сигналы по всему диапазону';

  @override
  String get explorerTitleMeshVeteranDescription => 'Глубокое знание сети';

  @override
  String get explorerTitleMeshCartographerDescription =>
      'Прокладывает регионы и маршруты';

  @override
  String get explorerTitleLongRangeRecordHolderDescription =>
      'Раздвигает границы дальности';
}
