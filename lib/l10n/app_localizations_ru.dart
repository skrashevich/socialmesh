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
  String get commonOk => 'ОК';

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
}
