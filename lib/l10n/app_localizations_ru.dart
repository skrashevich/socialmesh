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

  @override
  String get scannerConnectingStatus => 'Connecting...';

  @override
  String get scannerConnectDeviceTitle => 'Connect Device';

  @override
  String get scannerDevicesTitle => 'Devices';

  @override
  String get scannerSavedDeviceFallbackName => 'Your saved device';

  @override
  String scannerDeviceNotFoundTitle(String name) {
    return '$name not found';
  }

  @override
  String get scannerDeviceNotFoundSubtitle =>
      'If another app is connected to this device, disconnect from it first. Only one app can use Bluetooth at a time.';

  @override
  String get scannerAutoReconnectDisabledTitle => 'Auto-reconnect is disabled';

  @override
  String scannerAutoReconnectDisabledSubtitleWithDevice(String name) {
    return 'Select \"$name\" below, or enable auto-reconnect.';
  }

  @override
  String get scannerAutoReconnectDisabledSubtitle =>
      'Select a device below to connect manually.';

  @override
  String get scannerEnableAutoReconnectTitle => 'Enable Auto-Reconnect?';

  @override
  String scannerEnableAutoReconnectMessageWithDevice(String name) {
    return 'This will automatically connect to \"$name\" now and whenever you open the app.';
  }

  @override
  String get scannerEnableAutoReconnectMessage =>
      'This will automatically connect to your last used device whenever you open the app.';

  @override
  String get scannerEnableLabel => 'Enable';

  @override
  String get scannerPairingRemovedHint =>
      'Bluetooth pairing was removed. Forget \"Meshtastic\" in Settings > Bluetooth and reconnect to continue.';

  @override
  String get scannerBluetoothSettings => 'Bluetooth Settings';

  @override
  String get scannerRetryScan => 'Retry Scan';

  @override
  String get scannerScanningTitle => 'Scanning for nearby devices';

  @override
  String get scannerScanningSubtitle => 'Looking for Meshtastic devices...';

  @override
  String scannerDevicesFoundCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count devices found so far',
      one: '$count device found so far',
    );
    return '$_temp0';
  }

  @override
  String get scannerAvailableDevices => 'Available Devices';

  @override
  String get scannerLookingForDevices => 'Looking for devices…';

  @override
  String get scannerEnableBluetoothHint =>
      'Make sure Bluetooth is enabled and your Meshtastic device is powered on';

  @override
  String get scannerUnknownProtocol => 'Unknown Protocol';

  @override
  String get scannerUnknownDeviceDescription =>
      'This device was not detected as Meshtastic or MeshCore.';

  @override
  String get scannerUnsupportedDeviceMessage =>
      'This device cannot be connected automatically. Only Meshtastic and MeshCore devices are supported.';

  @override
  String get scannerProtocolMeshtastic => 'Meshtastic';

  @override
  String get scannerProtocolMeshCore => 'MeshCore';

  @override
  String get scannerProtocolUnknown => 'Unknown';

  @override
  String get scannerTransportBluetooth => 'Bluetooth';

  @override
  String get scannerTransportUsb => 'USB';

  @override
  String get scannerDetailDeviceName => 'Device Name';

  @override
  String get scannerDetailAddress => 'Address';

  @override
  String get scannerDetailConnectionType => 'Connection Type';

  @override
  String get scannerDetailSignalStrength => 'Signal Strength';

  @override
  String get scannerDetailServiceUuids => 'Service UUIDs';

  @override
  String get scannerDetailManufacturerData => 'Manufacturer Data';

  @override
  String get scannerDetailBluetoothLowEnergy => 'Bluetooth Low Energy';

  @override
  String get scannerDetailUsbSerial => 'USB Serial';

  @override
  String scannerVersionText(String version) {
    return 'Socialmesh v$version';
  }

  @override
  String scannerVersionTextShort(String version) {
    return 'Version v$version';
  }

  @override
  String get scannerCopyright => '© 2026 Socialmesh. All rights reserved.';

  @override
  String get scannerAuthFailedError =>
      'Authentication failed. The device may need to be re-paired. Go to Settings > Bluetooth, forget the Meshtastic device, then tap it below to reconnect.';

  @override
  String get scannerMeshCoreConnectionFailed => 'MeshCore connection failed';

  @override
  String scannerMeshCoreConnectionFailedWithError(String error) {
    return 'MeshCore connection failed: $error';
  }

  @override
  String scannerConnectionFailedWithError(String error) {
    return 'Connection failed: $error';
  }

  @override
  String get scannerPinRequiredError =>
      'Connection failed - please try again and enter the PIN when prompted';

  @override
  String get scannerBluetoothSettingsOpenFailed =>
      'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.';

  @override
  String get messagesContainerTitle => 'Messages';

  @override
  String get messagesContactsTab => 'Contacts';

  @override
  String get messagesChannelsTab => 'Channels';

  @override
  String get messagesAddChannelNotConnected =>
      'Connect to a device to add channels';

  @override
  String get messagesScanChannelNotConnected =>
      'Connect to a device to scan channels';

  @override
  String get messagingSearchContactsHint => 'Search contacts';

  @override
  String get messagingFilterAll => 'All';

  @override
  String get messagingFilterActive => 'Active';

  @override
  String get messagingFilterUnread => 'Unread';

  @override
  String get messagingFilterMessaged => 'Messaged';

  @override
  String get messagingFilterFavorites => 'Favorites';

  @override
  String messagingNoContactsMatchSearch(String query) {
    return 'No contacts match \"$query\"';
  }

  @override
  String messagingNoFilteredContacts(String filter) {
    return 'No $filter contacts';
  }

  @override
  String get messagingNoContactsYet => 'No contacts yet';

  @override
  String get messagingContactsDiscoveredHint =>
      'Discovered nodes will appear here';

  @override
  String get messagingClearSearch => 'Clear search';

  @override
  String get messagingContactsTitle => 'Contacts';

  @override
  String messagingContactsTitleWithCount(int count) {
    return 'Contacts ($count)';
  }

  @override
  String get messagingSectionFavorites => 'Favorites';

  @override
  String get messagingSectionUnread => 'Unread';

  @override
  String get messagingSectionActive => 'Active';

  @override
  String get messagingSectionInactive => 'Inactive';

  @override
  String get messagingMessageQueuedOffline =>
      'Message queued - will send when connected';

  @override
  String get messagingEncryptionKeyIssueTitle => 'Encryption Key Issue';

  @override
  String messagingEncryptionKeyIssueSubtitle(String name) {
    return 'Direct message to $name failed';
  }

  @override
  String get messagingEncryptionKeyWarning =>
      'The encryption keys may be out of sync. This can happen when a node has been reset or rolled out of the mesh database.';

  @override
  String messagingRequestUserInfoSuccess(String name) {
    return 'Requested fresh info from $name';
  }

  @override
  String messagingRequestUserInfoFailed(String error) {
    return 'Failed to request info: $error';
  }

  @override
  String get messagingRequestUserInfo => 'Request User Info';

  @override
  String get messagingRetryMessage => 'Retry Message';

  @override
  String get messagingAdvancedResetNodeDatabase =>
      'Advanced: Reset Node Database';

  @override
  String get messagingDeleteMessageTitle => 'Delete Message';

  @override
  String get messagingDeleteMessageConfirmation =>
      'Are you sure you want to delete this message? This only removes it locally.';

  @override
  String get messagingMessageDeleted => 'Message deleted';

  @override
  String get messagingChannelSubtitle => 'Channel';

  @override
  String get messagingDirectMessageSubtitle => 'Direct Message';

  @override
  String get messagingCloseSearch => 'Close Search';

  @override
  String get messagingSearchMessages => 'Search Messages';

  @override
  String get messagingChannelSettings => 'Channel Settings';

  @override
  String get messagingFindMessageHint => 'Find a message';

  @override
  String get messagingNoMessagesMatchSearch => 'No messages match your search';

  @override
  String get messagingNoMessagesInChannel => 'No messages in this channel';

  @override
  String get messagingStartConversation => 'Start the conversation';

  @override
  String messagingReplyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get messagingMessageHint => 'Message…';

  @override
  String get messagingSourceAutomation => 'Automation';

  @override
  String get messagingSourceShortcut => 'Shortcut';

  @override
  String get messagingSourceNotification => 'Notification';

  @override
  String get messagingSourceTapback => 'Tapback';

  @override
  String get messagingOriginalMessage => 'Original message';

  @override
  String get messagingFailedToSend => 'Failed to send';

  @override
  String get messagingQuickResponses => 'Quick Responses';

  @override
  String get messagingNoQuickResponsesConfigured =>
      'No quick responses configured.\nAdd some in Settings → Quick responses.';

  @override
  String get messagingConfigureQuickResponses =>
      'Configure quick responses in Settings';

  @override
  String get messagingAddChannel => 'Add channel';

  @override
  String get messagingScanQrCode => 'Scan QR code';

  @override
  String get messagingHelp => 'Help';

  @override
  String get messagingSettings => 'Settings';

  @override
  String get messagingUnknownNode => 'Unknown Node';

  @override
  String get messageContextMenuReply => 'Reply';

  @override
  String get messageContextMenuCopy => 'Copy';

  @override
  String get messageContextMenuMessageCopied => 'Message copied';

  @override
  String get messageContextMenuTapbackSent => 'Tapback sent';

  @override
  String get messageContextMenuTapbackFailed => 'Failed to send tapback';

  @override
  String get messageContextMenuMessageDetails => 'Message Details';

  @override
  String get messageContextMenuStatusSending => 'Sending…';

  @override
  String get messageContextMenuStatusSent => 'Sent';

  @override
  String get messageContextMenuStatusDelivered => 'Delivered ✔️';

  @override
  String messageContextMenuStatusFailed(String error) {
    return 'Failed: $error';
  }

  @override
  String get messageContextMenuNoRecents => 'No Recents';

  @override
  String get messageContextMenuSearchEmoji => 'Search emoji…';

  @override
  String get tapbackReact => 'React';

  @override
  String helpArticleMinRead(int minutes) {
    return '$minutes min read';
  }

  @override
  String get helpArticleLoadFailed => 'Failed to load article';

  @override
  String get helpCenterTitle => 'Help Center';

  @override
  String get helpCenterLoadFailed => 'Failed to load help content';

  @override
  String get helpCenterArticlesRead => 'articles read';

  @override
  String get helpCenterSearchHint => 'Search articles';

  @override
  String get helpCenterFilterAll => 'All';

  @override
  String get helpCenterNoArticlesMatchSearch =>
      'No articles match your search.\nTry different keywords.';

  @override
  String get helpCenterSearchByTitle =>
      'Search by article title\nor description.';

  @override
  String get helpCenterNoArticlesInCategory => 'No articles in this category';

  @override
  String get helpCenterNoArticlesAvailable => 'No articles available';

  @override
  String get helpCenterTryDifferentCategory =>
      'Try selecting a different category from the filter chips above.';

  @override
  String get helpCenterContentBeingPrepared =>
      'Help content is being prepared. Check back soon.';

  @override
  String get helpCenterCompleted => 'Completed';

  @override
  String get helpCenterMarkAsComplete => 'Mark as Complete';

  @override
  String get helpCenterArticleRead => 'Read';

  @override
  String get helpCenterArticleUnread => 'Unread';

  @override
  String get helpCenterInteractiveTours => 'Interactive Tours';

  @override
  String helpCenterToursCompletedCount(int completed, int total) {
    return '$completed / $total completed';
  }

  @override
  String get helpCenterToursDescription =>
      'Step-by-step walkthroughs for app features. These tours guide you through each screen with Ico.';

  @override
  String get helpCenterShowHelpHintsTitle => 'Show Help Hints';

  @override
  String get helpCenterShowHelpHintsSubtitle =>
      'Display pulsing help buttons on screens';

  @override
  String get helpCenterHapticFeedbackTitle => 'Haptic Feedback';

  @override
  String get helpCenterHapticFeedbackSubtitle =>
      'Vibrate during typewriter text effect';

  @override
  String get helpCenterResetAllProgress => 'Reset All Progress';

  @override
  String get helpCenterResetProgressTitle => 'Reset Help Progress?';

  @override
  String get helpCenterResetProgressMessage =>
      'This will mark all articles as unread and reset interactive tour progress. You can start fresh.';

  @override
  String get helpCenterResetProgressLabel => 'Reset';

  @override
  String get helpCenterHelpPreferences => 'HELP PREFERENCES';

  @override
  String helpCenterFindThisIn(String screenName) {
    return 'Find this in: $screenName';
  }

  @override
  String get helpCenterReadEverything => 'You’ve read everything!';

  @override
  String get helpCenterLearnHowItWorks => 'Learn how Meshtastic works';

  @override
  String get helpCenterComeBackToRefresh =>
      'Come back anytime to refresh your knowledge.';

  @override
  String get helpCenterTapToLearn =>
      'Tap an article to learn about mesh networking, radio settings, and more.';

  @override
  String get helpCenterScreenChannels => 'Channels';

  @override
  String get helpCenterScreenMessages => 'Messages';

  @override
  String get helpCenterScreenNodes => 'Nodes';

  @override
  String get helpCenterScreenSignalFeed => 'Signal Feed';

  @override
  String get helpCenterScreenCreateSignal => 'Create Signal';

  @override
  String get helpCenterScreenScanner => 'Scanner';

  @override
  String get helpCenterScreenRegionSelection => 'Region Selection';

  @override
  String get helpCenterScreenRadioConfig => 'Radio Config';

  @override
  String get helpCenterScreenMeshHealth => 'Mesh Health';

  @override
  String get helpCenterScreenReachability => 'Reachability';

  @override
  String get helpCenterScreenTraceRouteLog => 'Trace Route Log';

  @override
  String get helpCenterScreenMap => 'Map';

  @override
  String get helpCenterScreenWorldMesh => 'World Mesh';

  @override
  String get helpCenterScreenGlobe => 'Globe';

  @override
  String get helpCenterScreenMesh3d => 'Mesh 3D';

  @override
  String get helpCenterScreenRoutes => 'Routes';

  @override
  String get helpCenterScreenTimeline => 'Timeline';

  @override
  String get helpCenterScreenPresence => 'Presence';

  @override
  String get helpCenterScreenAether => 'Aether';

  @override
  String get helpCenterScreenTakGateway => 'TAK Gateway';

  @override
  String get helpCenterScreenWidgetDashboard => 'Widget Dashboard';

  @override
  String get helpCenterScreenWidgetBuilder => 'Widget Builder';

  @override
  String get helpCenterScreenWidgetMarketplace => 'Widget Marketplace';

  @override
  String get helpCenterScreenDeviceShop => 'Device Shop';

  @override
  String get helpCenterScreenNodeDex => 'NodeDex';

  @override
  String get helpCenterScreenSettings => 'Settings';

  @override
  String get helpCenterScreenProfile => 'Profile';

  @override
  String get helpCenterScreenAutomations => 'Automations';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSearchHint => 'Find a setting';

  @override
  String get settingsHelpTooltip => 'Help';

  @override
  String get settingsNoSettingsFound => 'No settings found';

  @override
  String get settingsTryDifferentSearch => 'Try a different search term';

  @override
  String settingsErrorLoading(String error) {
    return 'Error loading settings: $error';
  }

  @override
  String get settingsNotConfigured => 'Not configured';

  @override
  String get settingsLoadingStatus => 'Loading…';

  @override
  String get settingsSectionPremium => 'PREMIUM';

  @override
  String get settingsSectionFeedback => 'FEEDBACK';

  @override
  String get settingsSectionAccount => 'ACCOUNT';

  @override
  String get settingsSectionConnection => 'CONNECTION';

  @override
  String get settingsSectionHapticFeedback => 'HAPTIC FEEDBACK';

  @override
  String get settingsSectionAppearance => 'APPEARANCE';

  @override
  String get settingsSectionWhatsNew => 'WHAT’S NEW';

  @override
  String get settingsSectionAnimations => 'ANIMATIONS';

  @override
  String get settingsSectionNotifications => 'NOTIFICATIONS';

  @override
  String get settingsSectionMessaging => 'MESSAGING';

  @override
  String get settingsSectionDataStorage => 'DATA & STORAGE';

  @override
  String get settingsSectionDevice => 'DEVICE';

  @override
  String get settingsSectionModules => 'MODULES';

  @override
  String get settingsSectionTelemetryLogs => 'TELEMETRY LOGS';

  @override
  String get settingsSectionTools => 'TOOLS';

  @override
  String get settingsSectionAbout => 'ABOUT';

  @override
  String get settingsSectionSocialNotifications => 'SOCIAL NOTIFICATIONS';

  @override
  String get settingsSectionRemoteAdmin => 'REMOTE ADMINISTRATION';

  @override
  String get settingsPremiumUnlockFeaturesTitle => 'Unlock Features';

  @override
  String get settingsPremiumAllUnlocked => 'All features unlocked!';

  @override
  String settingsPremiumPartiallyUnlocked(int owned, int total) {
    return '$owned of $total unlocked';
  }

  @override
  String get settingsPremiumBadgeTry => 'TRY IT';

  @override
  String get settingsPremiumBadgeOwned => 'OWNED';

  @override
  String get settingsPremiumBadgeLocked => 'LOCKED';

  @override
  String get settingsRemoteAdminConfiguringTitle => 'Configuring Remote Node';

  @override
  String get settingsRemoteAdminConfigureTitle => 'Configure Device';

  @override
  String get settingsRemoteAdminConnectedDevice => 'Connected Device';

  @override
  String settingsRemoteAdminNodeCount(int count) {
    return '$count nodes';
  }

  @override
  String get settingsRemoteAdminWarning =>
      'Remote admin requires the target node to have your public key in its Admin Keys list.';

  @override
  String get settingsTileShakeToReportTitle => 'Shake to report a bug';

  @override
  String get settingsTileShakeToReportSubtitle =>
      'Shake your device to open the bug report flow';

  @override
  String get settingsTileMyBugReportsTitle => 'My bug reports';

  @override
  String get settingsTileMyBugReportsSubtitle =>
      'View your reports and responses';

  @override
  String get settingsTileMyBugReportsNotSignedIn =>
      'Sign in to track your reports and receive replies';

  @override
  String get settingsTileAutoReconnectTitle => 'Auto-reconnect';

  @override
  String get settingsTileAutoReconnectSubtitle =>
      'Automatically reconnect to last device';

  @override
  String get settingsTileBackgroundConnectionTitle => 'Background connection';

  @override
  String get settingsTileBackgroundConnectionSubtitle =>
      'Background BLE, notifications, and power settings';

  @override
  String get settingsTileProvideLocationTitle => 'Provide phone location';

  @override
  String get settingsTileProvideLocationSubtitle =>
      'Send phone GPS to mesh for devices without GPS hardware';

  @override
  String get settingsTileHapticFeedbackTitle => 'Haptic feedback';

  @override
  String get settingsTileHapticFeedbackSubtitle =>
      'Vibration feedback for interactions';

  @override
  String get settingsTileIntensityTitle => 'Intensity';

  @override
  String get settingsTileAppearanceTitle => 'Appearance & Accessibility';

  @override
  String get settingsTileAppearanceSubtitle =>
      'Font, text size, density, contrast, motion';

  @override
  String get settingsTileWhatsNewTitle => 'What’s New';

  @override
  String get settingsTileWhatsNewSubtitle =>
      'Browse recent features and updates';

  @override
  String get settingsTileListAnimationsTitle => 'List animations';

  @override
  String get settingsTileListAnimationsSubtitle =>
      'Slide and bounce effects on lists';

  @override
  String get settingsTile3dEffectsTitle => '3D effects';

  @override
  String get settingsTile3dEffectsSubtitle =>
      'Perspective transforms and depth effects';

  @override
  String get settingsTilePushNotificationsTitle => 'Push notifications';

  @override
  String get settingsTilePushNotificationsSubtitle =>
      'Master toggle for all notifications';

  @override
  String get settingsTileNewNodesTitle => 'New nodes';

  @override
  String get settingsTileNewNodesSubtitle =>
      'Notify when new nodes join the mesh';

  @override
  String get settingsTileDirectMessagesTitle => 'Direct messages';

  @override
  String get settingsTileDirectMessagesSubtitle =>
      'Notify for private messages';

  @override
  String get settingsTileChannelMessagesTitle => 'Channel messages';

  @override
  String get settingsTileChannelMessagesSubtitle =>
      'Notify for channel broadcasts';

  @override
  String get settingsTileSoundTitle => 'Sound';

  @override
  String get settingsTileSoundSubtitle => 'Play sound with notifications';

  @override
  String get settingsTileVibrationTitle => 'Vibration';

  @override
  String get settingsTileVibrationSubtitle => 'Vibrate with notifications';

  @override
  String get settingsTileQuickResponsesTitle => 'Quick responses';

  @override
  String get settingsTileQuickResponsesSubtitle =>
      'Manage canned responses for fast messaging';

  @override
  String get settingsTileCannedMessagesTitle => 'Canned Messages Module';

  @override
  String get settingsTileCannedMessagesSubtitle =>
      'Device-side canned message settings';

  @override
  String get settingsTileMessageHistoryTitle => 'Message history';

  @override
  String settingsTileMessageHistorySubtitle(int count) {
    return '$count messages stored';
  }

  @override
  String get settingsTileExportMessagesTitle => 'Export Messages';

  @override
  String get settingsTileExportMessagesSubtitle =>
      'Export messages to PDF or CSV';

  @override
  String get settingsTileClearMessageHistoryTitle => 'Clear message history';

  @override
  String get settingsTileClearMessageHistorySubtitle =>
      'Delete all stored messages';

  @override
  String get settingsTileResetLocalDataTitle => 'Reset local data';

  @override
  String get settingsTileResetLocalDataSubtitle =>
      'Clear messages and nodes, keep settings';

  @override
  String get settingsTileClearAllDataTitle => 'Clear all data';

  @override
  String get settingsTileClearAllDataSubtitle =>
      'Delete messages, settings, and keys';

  @override
  String get settingsTileForceSyncTitle => 'Force Sync';

  @override
  String get settingsTileForceSyncSubtitle =>
      'Re-sync all data from connected device';

  @override
  String get settingsTileRegionTitle => 'Region / Frequency';

  @override
  String get settingsTileDeviceRoleTitle => 'Device Role & Settings';

  @override
  String get settingsTileDeviceRoleSubtitle =>
      'Configure device behavior and role';

  @override
  String get settingsTileRadioConfigTitle => 'Radio Configuration';

  @override
  String get settingsTileRadioConfigSubtitle =>
      'LoRa settings, modem preset, power';

  @override
  String get settingsTilePositionTitle => 'Position & GPS';

  @override
  String get settingsTilePositionSubtitle =>
      'GPS mode, broadcast intervals, fixed position';

  @override
  String get settingsTileDisplaySettingsTitle => 'Display Settings';

  @override
  String get settingsTileDisplaySettingsSubtitle =>
      'Screen timeout, units, display mode';

  @override
  String get settingsTileBluetoothTitle => 'Bluetooth';

  @override
  String get settingsTileBluetoothSubtitle => 'Pairing mode, PIN settings';

  @override
  String get settingsTileNetworkTitle => 'Network';

  @override
  String get settingsTileNetworkSubtitle => 'WiFi, Ethernet, NTP settings';

  @override
  String get settingsTilePowerManagementTitle => 'Power Management';

  @override
  String get settingsTilePowerManagementSubtitle =>
      'Power saving, sleep settings';

  @override
  String get settingsTileSecurityTitle => 'Security';

  @override
  String get settingsTileSecuritySubtitle => 'Access controls, managed mode';

  @override
  String get settingsTileDeviceManagementTitle => 'Device Management';

  @override
  String get settingsTileDeviceManagementSubtitle =>
      'Reboot, shutdown, factory reset';

  @override
  String get settingsTileDeviceInfoTitle => 'Device info';

  @override
  String get settingsTileDeviceInfoSubtitle => 'View connected device details';

  @override
  String get settingsTileScanQrCodeTitle => 'Scan QR Code';

  @override
  String get settingsTileScanQrCodeSubtitle =>
      'Import nodes, channels, or automations';

  @override
  String get settingsTileMqttTitle => 'MQTT';

  @override
  String get settingsTileMqttSubtitle => 'Configure mesh-to-internet bridge';

  @override
  String get settingsTileRangeTestTitle => 'Range Test';

  @override
  String get settingsTileRangeTestSubtitle =>
      'Test signal range with other nodes';

  @override
  String get settingsTileStoreForwardTitle => 'Store & Forward';

  @override
  String get settingsTileStoreForwardSubtitle =>
      'Store and relay messages for offline nodes';

  @override
  String get settingsTileDetectionSensorTitle => 'Detection Sensor';

  @override
  String get settingsTileDetectionSensorSubtitle =>
      'Configure GPIO-based motion/door sensors';

  @override
  String get settingsTileExternalNotificationTitle => 'External Notification';

  @override
  String get settingsTileExternalNotificationSubtitle =>
      'Configure buzzers, LEDs, and vibration alerts';

  @override
  String get settingsTileAmbientLightingTitle => 'Ambient Lighting';

  @override
  String get settingsTileAmbientLightingSubtitle =>
      'Configure LED and RGB settings';

  @override
  String get settingsTilePaxCounterTitle => 'PAX Counter';

  @override
  String get settingsTilePaxCounterSubtitle =>
      'WiFi/BLE device detection settings';

  @override
  String get settingsTileTelemetryIntervalsTitle => 'Telemetry Intervals';

  @override
  String get settingsTileTelemetryIntervalsSubtitle =>
      'Configure telemetry update frequency';

  @override
  String get settingsTileSerialTitle => 'Serial';

  @override
  String get settingsTileSerialSubtitle => 'Serial port configuration';

  @override
  String get settingsTileTrafficManagementTitle => 'Traffic Management';

  @override
  String get settingsTileTrafficManagementSubtitle =>
      'Mesh traffic optimization and filtering';

  @override
  String get settingsTileDeviceMetricsTitle => 'Device Metrics';

  @override
  String get settingsTileDeviceMetricsSubtitle =>
      'Battery, voltage, utilization history';

  @override
  String get settingsTileEnvironmentMetricsTitle => 'Environment Metrics';

  @override
  String get settingsTileEnvironmentMetricsSubtitle =>
      'Temperature, humidity, pressure logs';

  @override
  String get settingsTileAirQualityTitle => 'Air Quality';

  @override
  String get settingsTileAirQualitySubtitle => 'PM2.5, PM10, CO2 readings';

  @override
  String get settingsTilePositionHistoryTitle => 'Position History';

  @override
  String get settingsTilePositionHistorySubtitle => 'GPS position logs';

  @override
  String get settingsTileTracerouteHistoryTitle => 'Traceroute History';

  @override
  String get settingsTileTracerouteHistorySubtitle =>
      'Network path analysis logs';

  @override
  String get settingsTilePaxCounterLogsTitle => 'PAX Counter Logs';

  @override
  String get settingsTilePaxCounterLogsSubtitle => 'Device detection history';

  @override
  String get settingsTileDetectionSensorLogsTitle => 'Detection Sensor Logs';

  @override
  String get settingsTileDetectionSensorLogsSubtitle => 'Sensor event history';

  @override
  String get settingsTileRoutesTitle => 'Routes';

  @override
  String get settingsTileRoutesSubtitle => 'Record and manage GPS routes';

  @override
  String get settingsTileGpsStatusTitle => 'GPS Status';

  @override
  String get settingsTileGpsStatusSubtitle => 'View detailed GPS information';

  @override
  String get settingsTileFirmwareUpdateTitle => 'Firmware Update';

  @override
  String get settingsTileFirmwareUpdateSubtitle =>
      'Check for device firmware updates';

  @override
  String get settingsTileExportDataTitle => 'Export Data';

  @override
  String get settingsTileExportDataSubtitle =>
      'Export messages, telemetry, routes';

  @override
  String get settingsTileAppLogTitle => 'App Log';

  @override
  String get settingsTileAppLogSubtitle => 'View application debug logs';

  @override
  String get settingsTileGlyphMatrixTitle => 'Glyph Matrix Test';

  @override
  String get settingsTileGlyphMatrixSubtitle => 'Nothing Phone 3 LED patterns';

  @override
  String get settingsTileSocialmeshTitle => 'Socialmesh';

  @override
  String get settingsTileSocialmeshSubtitle => 'Meshtastic companion app';

  @override
  String get settingsTileHelpCenterTitle => 'Help Center';

  @override
  String get settingsTileHelpCenterSubtitle =>
      'Interactive guides with Ico, your mesh guide';

  @override
  String get settingsTileHelpSupportTitle => 'Help & Support';

  @override
  String get settingsTileHelpSupportSubtitle =>
      'FAQ, troubleshooting, and contact info';

  @override
  String get settingsTileTermsOfServiceTitle => 'Terms of Service';

  @override
  String get settingsTileTermsOfServiceSubtitle => 'Legal terms and conditions';

  @override
  String get settingsTilePrivacyPolicyTitle => 'Privacy Policy';

  @override
  String get settingsTilePrivacyPolicySubtitle => 'How we handle your data';

  @override
  String get settingsTileOpenSourceTitle => 'Open Source Licenses';

  @override
  String get settingsTileOpenSourceSubtitle =>
      'Third-party libraries and attributions';

  @override
  String get settingsHapticIntensityTitle => 'Haptic Intensity';

  @override
  String get settingsHapticSubtleDescription =>
      'Subtle feedback for a gentle touch';

  @override
  String get settingsHapticMediumDescription =>
      'Balanced feedback for most interactions';

  @override
  String get settingsHapticStrongDescription =>
      'Strong feedback for clear confirmation';

  @override
  String get settingsHistoryLimitTitle => 'Message History Limit';

  @override
  String settingsHistoryLimitOption(int limit) {
    return '$limit messages';
  }

  @override
  String get settingsClearMessagesTitle => 'Clear Messages';

  @override
  String get settingsClearMessagesMessage =>
      'This will delete all stored messages. This action cannot be undone.';

  @override
  String get settingsClearMessagesLabel => 'Clear';

  @override
  String get settingsClearMessagesSuccess => 'Messages cleared';

  @override
  String get settingsResetLocalDataTitle => 'Reset Local Data';

  @override
  String get settingsResetLocalDataMessage =>
      'This will clear all messages and node data, forcing a fresh sync from your device on next connection.\n\nYour settings, theme, and preferences will be kept.\n\nUse this if nodes show incorrect status or messages appear wrong.';

  @override
  String get settingsResetLocalDataLabel => 'Reset';

  @override
  String get settingsResetLocalDataSuccess =>
      'Local data reset. Reconnect to sync fresh data.';

  @override
  String get settingsForceSyncNotConnected => 'Not connected to a device';

  @override
  String get settingsForceSyncTitle => 'Force Sync';

  @override
  String get settingsForceSyncMessage =>
      'This will clear all local messages, nodes, and channels, then re-sync everything from the connected device.\n\nAre you sure you want to continue?';

  @override
  String get settingsForceSyncLabel => 'Sync';

  @override
  String get settingsForceSyncingStatus => 'Syncing from device…';

  @override
  String get settingsForceSyncSuccess => 'Sync complete';

  @override
  String settingsForceSyncFailed(String error) {
    return 'Sync failed: $error';
  }

  @override
  String get settingsClearAllDataTitle => 'Clear All Data';

  @override
  String get settingsClearAllDataMessage =>
      'This will delete ALL app data: messages, nodes, channels, settings, keys, signals, bookmarks, automations, widgets, and saved preferences. This action cannot be undone.';

  @override
  String get settingsClearAllDataLabel => 'Clear All';

  @override
  String get settingsClearAllDataSuccess => 'All data cleared successfully';

  @override
  String settingsClearAllDataFailed(String error) {
    return 'Failed to clear some data: $error';
  }

  @override
  String get settingsDeviceInfoTitle => 'Device Information';

  @override
  String get settingsDeviceInfoDeviceName => 'Device Name';

  @override
  String get settingsDeviceInfoNotConnected => 'Not connected';

  @override
  String get settingsDeviceInfoConnection => 'Connection';

  @override
  String get settingsDeviceInfoNone => 'None';

  @override
  String get settingsDeviceInfoNodeNumber => 'Node Number';

  @override
  String get settingsDeviceInfoLongName => 'Long Name';

  @override
  String get settingsDeviceInfoShortName => 'Short Name';

  @override
  String get settingsDeviceInfoHardware => 'Hardware';

  @override
  String get settingsDeviceInfoUserId => 'User ID';

  @override
  String get settingsDeviceInfoUnknown => 'Unknown';

  @override
  String get settingsProfileTitle => 'Profile';

  @override
  String get settingsProfileSubtitle => 'Set up your profile';

  @override
  String get settingsProfileSynced => 'Synced';

  @override
  String get settingsProfileLocalOnly => 'Local only';

  @override
  String get settingsTilePrivacyTitle => 'Privacy';

  @override
  String get settingsTilePrivacySubtitle =>
      'Analytics, crash reporting, and data controls';

  @override
  String settingsVersionString(String version) {
    return 'Version $version';
  }

  @override
  String settingsSocialmeshVersionSnackbar(String version) {
    return 'Socialmesh v$version';
  }

  @override
  String get settingsRegionConfigureSubtitle =>
      'Configure device radio frequency';

  @override
  String get settingsSocialNotificationsLoading => 'Loading…';

  @override
  String get settingsSocialNotificationsLoadingSubtitle =>
      'Fetching notification preferences';

  @override
  String get settingsSocialNewFollowersTitle => 'New followers';

  @override
  String get settingsSocialNewFollowersSubtitle =>
      'When someone follows you or sends a request';

  @override
  String get settingsSocialLikesTitle => 'Likes';

  @override
  String get settingsSocialLikesSubtitle => 'When someone likes your posts';

  @override
  String get settingsSocialCommentsTitle => 'Comments & mentions';

  @override
  String get settingsSocialCommentsSubtitle =>
      'When someone comments or @mentions you';

  @override
  String get settingsMeshtasticWebViewTitle => 'Meshtastic';

  @override
  String get settingsMeshtasticGoBack => 'Go back';

  @override
  String get settingsMeshtasticRefresh => 'Refresh';

  @override
  String get settingsMeshtasticUnableToLoad => 'Unable to load page';

  @override
  String get settingsMeshtasticOfflineMessage =>
      'This content requires an internet connection. Please check your connection and try again.';

  @override
  String get settingsOpenSourceAppName => 'Socialmesh';

  @override
  String get settingsOpenSourceLegalese =>
      '© 2024 Socialmesh\n\nThis app uses open source software. See below for the complete list of third-party licenses.';

  @override
  String get settingsSearchPremiumSubtitle =>
      'Ringtones, themes, automations, IFTTT, widgets';

  @override
  String get settingsSearchRingtonePackTitle => 'Ringtone Pack';

  @override
  String get settingsSearchRingtonePackSubtitle => 'Custom notification sounds';

  @override
  String get settingsSearchThemePackTitle => 'Theme Pack';

  @override
  String get settingsSearchThemePackSubtitle =>
      'Accent colors and visual customization';

  @override
  String get settingsSearchAutomationsPackTitle => 'Automations Pack';

  @override
  String get settingsSearchAutomationsPackSubtitle =>
      'Automated actions and triggers';

  @override
  String get settingsSearchIftttPackTitle => 'IFTTT Pack';

  @override
  String get settingsSearchIftttPackSubtitle =>
      'Integration with external services';

  @override
  String get settingsSearchWidgetPackTitle => 'Widget Pack';

  @override
  String get settingsSearchWidgetPackSubtitle => 'Home screen widgets';

  @override
  String get settingsSearchProfileSubtitle =>
      'Your display name, avatar, and bio';

  @override
  String get settingsSearchNewFollowersSubtitle =>
      'Push notifications when someone follows you';

  @override
  String get settingsSearchLikesSubtitle => 'Push notifications for post likes';

  @override
  String get settingsSearchCommentsSubtitle =>
      'Push notifications for comments and @mentions';

  @override
  String get settingsSearchLinkedDevicesTitle => 'Linked Devices';

  @override
  String get settingsSearchLinkedDevicesSubtitle =>
      'Meshtastic devices connected to your profile';

  @override
  String get settingsSearchTakGatewayTitle => 'TAK Gateway';

  @override
  String get settingsSearchTakGatewaySubtitle =>
      'Gateway URL, position publishing, callsign';

  @override
  String get settingsSearchHapticIntensitySubtitle =>
      'Light, medium, or heavy feedback';

  @override
  String get settingsSearchNewNodesNotificationsTitle =>
      'New nodes notifications';

  @override
  String get settingsSearchNewNodesNotificationsSubtitle =>
      'Notify when new nodes join the mesh';

  @override
  String get settingsSearchDmNotificationsTitle =>
      'Direct message notifications';

  @override
  String get settingsSearchDmNotificationsSubtitle =>
      'Notify for private messages';

  @override
  String get settingsSearchChannelNotificationsTitle =>
      'Channel message notifications';

  @override
  String get settingsSearchChannelNotificationsSubtitle =>
      'Notify for channel broadcasts';

  @override
  String get settingsSearchNotificationSoundTitle => 'Notification sound';

  @override
  String get settingsSearchNotificationSoundSubtitle =>
      'Play sound for notifications';

  @override
  String get settingsSearchNotificationVibrationTitle =>
      'Notification vibration';

  @override
  String get settingsSearchNotificationVibrationSubtitle =>
      'Vibrate for notifications';

  @override
  String get settingsSearchCannedMessagesTitle => 'Canned Messages';

  @override
  String get settingsSearchCannedMessagesSubtitle =>
      'Pre-configured device messages';

  @override
  String get settingsSearchFileTransferTitle => 'File transfer';

  @override
  String get settingsSearchFileTransferSubtitle =>
      'Send and receive small files over mesh';

  @override
  String get settingsSearchAutoAcceptTransfersTitle => 'Auto-accept transfers';

  @override
  String get settingsSearchAutoAcceptTransfersSubtitle =>
      'Automatically accept incoming file offers';

  @override
  String get settingsSearchHistoryLimitTitle => 'Message history limit';

  @override
  String get settingsSearchHistoryLimitSubtitle => 'Maximum messages to keep';

  @override
  String get settingsSearchExportDataTitle => 'Export data';

  @override
  String get settingsSearchExportDataSubtitle => 'Export messages and settings';

  @override
  String get settingsSearchClearAllMessagesTitle => 'Clear all messages';

  @override
  String get settingsSearchClearAllMessagesSubtitle =>
      'Delete all stored messages';

  @override
  String get settingsSearchResetLocalDataTitle => 'Reset local data';

  @override
  String get settingsSearchResetLocalDataSubtitle => 'Clear all local app data';

  @override
  String get settingsSearchClearAllDataSubtitle =>
      'Delete messages, settings, and keys';

  @override
  String get settingsSearchRemoteAdminTitle => 'Remote Administration';

  @override
  String get settingsSearchRemoteAdminSubtitle =>
      'Configure remote nodes via PKI admin';

  @override
  String get settingsSearchForceSyncTitle => 'Force sync';

  @override
  String get settingsSearchForceSyncSubtitle => 'Force configuration sync';

  @override
  String get settingsSearchScanForDeviceTitle => 'Scan for device';

  @override
  String get settingsSearchScanForDeviceSubtitle =>
      'Scan QR code for easy setup';

  @override
  String get settingsSearchRegionTitle => 'Region';

  @override
  String get settingsSearchRegionSubtitle => 'Device radio frequency region';

  @override
  String get settingsSearchDeviceConfigTitle => 'Device config';

  @override
  String get settingsSearchDeviceConfigSubtitle =>
      'Device name, role, and behavior';

  @override
  String get settingsSearchRadioConfigTitle => 'Radio config';

  @override
  String get settingsSearchRadioConfigSubtitle =>
      'LoRa, modem, channel settings';

  @override
  String get settingsSearchPositionConfigTitle => 'Position config';

  @override
  String get settingsSearchPositionConfigSubtitle => 'GPS and position sharing';

  @override
  String get settingsSearchDisplayConfigTitle => 'Display config';

  @override
  String get settingsSearchDisplayConfigSubtitle =>
      'Screen brightness and timeout';

  @override
  String get settingsSearchBluetoothConfigTitle => 'Bluetooth config';

  @override
  String get settingsSearchBluetoothConfigSubtitle =>
      'Bluetooth settings and PIN';

  @override
  String get settingsSearchNetworkConfigTitle => 'Network config';

  @override
  String get settingsSearchNetworkConfigSubtitle => 'WiFi and network settings';

  @override
  String get settingsSearchPowerConfigTitle => 'Power config';

  @override
  String get settingsSearchPowerConfigSubtitle =>
      'Power saving and sleep settings';

  @override
  String get settingsSearchImportChannelTitle => 'Import channel via QR';

  @override
  String get settingsSearchImportChannelSubtitle =>
      'Scan a Meshtastic channel QR code';

  @override
  String get settingsSearchSocialmeshSubtitle => 'Meshtastic companion app';

  @override
  String get settingsSearchHelpSupportSubtitle =>
      'FAQ, troubleshooting, and contact info';

  @override
  String get settingsSearchTermsSubtitle => 'Legal terms and conditions';

  @override
  String get settingsSearchPrivacySubtitle => 'How we handle your data';

  @override
  String get scannerPairingInvalidatedError =>
      'Your phone removed the stored pairing info for this device. Return to Settings > Bluetooth, forget \"Meshtastic_XXXX\", and try again.';

  @override
  String get scannerGattConnectionFailed =>
      'Connection failed. This can happen if the device was previously paired with another app. Go to Settings > Bluetooth, find the Meshtastic device, tap \"Forget\", then try again.';

  @override
  String get scannerConnectionTimedOut =>
      'Connection timed out. The device may be out of range, powered off, or connected to another phone.';

  @override
  String get scannerDeviceDisconnectedUnexpectedly =>
      'The device disconnected unexpectedly. It may have gone out of range or lost power.';
}
