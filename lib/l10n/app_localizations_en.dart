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

  @override
  String get drawerAdminSectionHeader => 'ADMIN';

  @override
  String get drawerAdminDashboard => 'Admin Dashboard';

  @override
  String get drawerNodeNotConnected => 'Not Connected';

  @override
  String get drawerNodeOnline => 'Online';

  @override
  String get drawerNodeOffline => 'Offline';

  @override
  String get drawerBadgeNew => 'NEW';

  @override
  String get drawerBadgePro => 'PRO';

  @override
  String get drawerBadgeTryIt => 'TRY IT';

  @override
  String get drawerEnterpriseSectionHeader => 'ENTERPRISE';

  @override
  String get drawerEnterpriseIncidents => 'Incidents';

  @override
  String get drawerEnterpriseTasks => 'Tasks';

  @override
  String get drawerEnterpriseFieldReports => 'Field Reports';

  @override
  String get drawerEnterpriseReports => 'Reports';

  @override
  String get drawerEnterpriseExportDenied =>
      'Requires Supervisor or Admin role';

  @override
  String get drawerEnterpriseUserManagement => 'User Management';

  @override
  String get drawerEnterpriseDeviceManagement => 'Device Management';

  @override
  String get drawerEnterpriseOrgSettings => 'Org Settings';

  @override
  String get discoveryScanningNetwork => 'Scanning Network';

  @override
  String get discoverySearchingForNodes => 'Searching for nodes...';

  @override
  String discoveryNodesFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodes found',
      one: '1 node found',
    );
    return '$_temp0';
  }

  @override
  String get discoveryUnknownNode => 'Unknown Node';

  @override
  String get discoverySignalExcellent => 'Excellent';

  @override
  String get discoverySignalGood => 'Good';

  @override
  String get discoverySignalWeak => 'Weak';

  @override
  String get discoveryDiscoveredBadge => 'DISCOVERED';

  @override
  String get meshcoreShellMenuTooltip => 'Menu';

  @override
  String get meshcoreShellDeviceTooltip => 'Device';

  @override
  String get meshcoreShellNavContacts => 'Contacts';

  @override
  String get meshcoreShellNavChannels => 'Channels';

  @override
  String get meshcoreShellNavMap => 'Map';

  @override
  String get meshcoreShellNavTools => 'Tools';

  @override
  String get meshcoreShellDefaultDeviceName => 'MeshCore';

  @override
  String meshcoreShellDisconnectedFrom(String deviceName) {
    return 'Disconnected from $deviceName';
  }

  @override
  String get meshcoreShellReconnectButton => 'Reconnect';

  @override
  String get meshcoreShellDrawerSectionHeader => 'MESHCORE';

  @override
  String get meshcoreShellDrawerAddContact => 'Add Contact';

  @override
  String get meshcoreShellDrawerAddChannel => 'Add Channel';

  @override
  String get meshcoreShellDrawerDiscoverContacts => 'Discover Contacts';

  @override
  String get meshcoreShellDrawerMyContactCode => 'My Contact Code';

  @override
  String get meshcoreShellDrawerSettings => 'Settings';

  @override
  String get meshcoreShellDrawerDisconnect => 'Disconnect';

  @override
  String get meshcoreShellDefaultDeviceNameFull => 'MeshCore Device';

  @override
  String get meshcoreShellNoSavedDevice => 'No saved device to reconnect to';

  @override
  String meshcoreShellReconnecting(String deviceName) {
    return 'Reconnecting to $deviceName...';
  }

  @override
  String meshcoreShellConnectedTo(String deviceName) {
    return 'Connected to $deviceName';
  }

  @override
  String meshcoreShellReconnectFailed(String error) {
    return 'Reconnect failed: $error';
  }

  @override
  String get meshcoreShellAddContactHint => 'Use the + button to add a contact';

  @override
  String get meshcoreShellAddChannelHint =>
      'Use the menu to create or join a channel';

  @override
  String get meshcoreShellNotConnected => 'Not connected';

  @override
  String get meshcoreShellAdvertisementSent =>
      'Advertisement sent - listen for responses';

  @override
  String get meshcoreShellDeviceInfoNotAvailable => 'Device info not available';

  @override
  String get meshcoreShellUnnamedNode => 'Unnamed Node';

  @override
  String get meshcoreShellScanToAddContact => 'Scan to add as contact';

  @override
  String get meshcoreShellShareContactInfo =>
      'Share your contact code so others can message you';

  @override
  String get meshcoreShellDefaultInitials => 'MC';

  @override
  String get meshcoreShellStatusOnline => 'Online';

  @override
  String get meshcoreShellStatusOffline => 'Offline';

  @override
  String get meshcoreShellStatusConnected => 'Connected';

  @override
  String get meshcoreShellStatusConnecting => 'Connecting...';

  @override
  String get meshcoreShellStatusDisconnected => 'Disconnected';

  @override
  String get meshcoreShellSectionDeviceInfo => 'Device Information';

  @override
  String get meshcoreShellSectionQuickActions => 'Quick Actions';

  @override
  String get meshcoreShellSectionConnection => 'Connection';

  @override
  String get meshcoreShellAddContactSubtitle => 'Scan QR or enter contact code';

  @override
  String get meshcoreShellJoinChannel => 'Join Channel';

  @override
  String get meshcoreShellJoinChannelSubtitle =>
      'Scan QR or enter channel code';

  @override
  String get meshcoreShellJoinChannelHint => 'Use the menu to join a channel';

  @override
  String get meshcoreShellShareContactSubtitle => 'Share your contact info';

  @override
  String get meshcoreShellDiscoverSubtitle =>
      'Send advertisement to find nearby nodes';

  @override
  String get meshcoreShellAppSettings => 'App Settings';

  @override
  String get meshcoreShellAppSettingsSubtitle =>
      'Notifications, theme, preferences';

  @override
  String get meshcoreShellInfoProtocol => 'Protocol';

  @override
  String get meshcoreShellInfoProtocolValue => 'MeshCore';

  @override
  String get meshcoreShellInfoNodeName => 'Node Name';

  @override
  String get meshcoreShellUnknown => 'Unknown';

  @override
  String get meshcoreShellInfoNodeId => 'Node ID';

  @override
  String get meshcoreShellInfoPublicKey => 'Public Key';

  @override
  String get meshcoreShellInfoStatus => 'Status';

  @override
  String get meshcoreShellDisconnecting => 'Disconnecting...';

  @override
  String get meshcoreShellDisconnect => 'Disconnect';

  @override
  String get meshcoreShellDisconnectConfirmMessage =>
      'Are you sure you want to disconnect from this MeshCore device?';

  @override
  String get meshcoreShellAdvertisementSentListening =>
      'Advertisement sent - listening for responses';

  @override
  String get linkDeviceBannerLinkedSuccess => 'Device linked to your profile!';

  @override
  String linkDeviceBannerLinkError(String error) {
    return 'Failed to link: $error';
  }

  @override
  String get linkDeviceBannerTitle => 'Link this device to your profile';

  @override
  String get linkDeviceBannerSubtitle => 'Others can find and follow you';

  @override
  String get linkDeviceBannerLinkButton => 'Link';

  @override
  String nodesScreenTitle(int count) {
    return 'Nodes ($count)';
  }

  @override
  String get nodesScreenScanQrCodeTooltip => 'Scan QR Code';

  @override
  String get nodesScreenHelpMenu => 'Help';

  @override
  String get nodesScreenSettingsMenu => 'Settings';

  @override
  String get nodesScreenSearchHint => 'Find a node';

  @override
  String get nodesScreenFilterAll => 'All';

  @override
  String get nodesScreenFilterActive => 'Active';

  @override
  String get nodesScreenFilterFavorites => 'Favorites';

  @override
  String get nodesScreenFilterWithPosition => 'With Position';

  @override
  String get nodesScreenFilterInactive => 'Inactive';

  @override
  String get nodesScreenFilterNew => 'New';

  @override
  String get nodesScreenFilterRf => 'RF';

  @override
  String get nodesScreenFilterMqtt => 'MQTT';

  @override
  String get nodesScreenEmptyAll => 'No nodes discovered yet';

  @override
  String get nodesScreenEmptyFiltered => 'No nodes match this filter';

  @override
  String get nodesScreenShowAllButton => 'Show all nodes';

  @override
  String get nodesScreenSectionAetherFlights => 'Aether Flights Nearby';

  @override
  String get nodesScreenSectionDiscovering => 'Discovering';

  @override
  String get nodesScreenSectionYourDevice => 'Your Device';

  @override
  String get nodesScreenSectionFavorites => 'Favorites';

  @override
  String get nodesScreenSectionActive => 'Active';

  @override
  String get nodesScreenSectionSeenRecently => 'Seen Recently';

  @override
  String get nodesScreenSectionInactive => 'Inactive';

  @override
  String get nodesScreenSectionUnknown => 'Unknown';

  @override
  String get nodesScreenSectionSignalStrong => 'Strong (>0 dB)';

  @override
  String get nodesScreenSectionSignalMedium => 'Medium (-10 to 0 dB)';

  @override
  String get nodesScreenSectionSignalWeak => 'Weak (<-10 dB)';

  @override
  String get nodesScreenSectionCharging => 'Charging';

  @override
  String get nodesScreenSectionBatteryFull => 'Full (80-100%)';

  @override
  String get nodesScreenSectionBatteryGood => 'Good (50-80%)';

  @override
  String get nodesScreenSectionBatteryLow => 'Low (20-50%)';

  @override
  String get nodesScreenSectionBatteryCritical => 'Critical (<20%)';

  @override
  String get nodesScreenConnectedDevice => 'Connected Device';

  @override
  String get nodesScreenDisconnect => 'Disconnect';

  @override
  String get nodesScreenSortRecent => 'Recent';

  @override
  String get nodesScreenSortName => 'Name';

  @override
  String get nodesScreenSortSignal => 'Signal';

  @override
  String get nodesScreenSortBattery => 'Battery';

  @override
  String get nodesScreenSortMenuMostRecent => 'Most Recent';

  @override
  String get nodesScreenSortMenuNameAZ => 'Name (A-Z)';

  @override
  String get nodesScreenSortMenuSignalStrength => 'Signal Strength';

  @override
  String get nodesScreenSortMenuBatteryLevel => 'Battery Level';

  @override
  String nodesScreenDistanceMeters(String meters) {
    return '$meters m away';
  }

  @override
  String nodesScreenDistanceKilometers(String km) {
    return '$km km away';
  }

  @override
  String get nodesScreenYouBadge => 'YOU';

  @override
  String get nodesScreenThisDevice => 'This Device';

  @override
  String get nodesScreenGps => 'GPS';

  @override
  String get nodesScreenNoGps => 'No GPS';

  @override
  String get nodesScreenLogsLabel => 'Logs:';

  @override
  String get nodesScreenHopDirect => 'Direct';

  @override
  String nodesScreenHopCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hops',
      one: '1 hop',
    );
    return '$_temp0';
  }

  @override
  String get nodesScreenTransportMqtt => 'MQTT';

  @override
  String get nodesScreenTransportRf => 'RF';

  @override
  String get nodeDetailQrSubtitle => 'Scan to add this node';

  @override
  String nodeDetailQrInfoText(String nodeId) {
    return 'Node ID: $nodeId';
  }

  @override
  String nodeDetailRemovedFromFavorites(String name) {
    return '$name removed from favorites';
  }

  @override
  String nodeDetailAddedToFavorites(String name) {
    return '$name added to favorites';
  }

  @override
  String nodeDetailFavoriteError(String error) {
    return 'Failed to update favorite: $error';
  }

  @override
  String get nodeDetailMuteNotConnected =>
      'Cannot change mute status: Device not connected';

  @override
  String nodeDetailUnmuted(String name) {
    return '$name unmuted';
  }

  @override
  String nodeDetailMuted(String name) {
    return '$name muted';
  }

  @override
  String nodeDetailMuteError(String error) {
    return 'Failed to update mute status: $error';
  }

  @override
  String get nodeDetailTracerouteNotConnected =>
      'Cannot send traceroute: Device not connected';

  @override
  String nodeDetailTracerouteSent(String name) {
    return 'Traceroute sent to $name — check Traceroute History for results';
  }

  @override
  String nodeDetailTracerouteError(String error) {
    return 'Failed to send traceroute: $error';
  }

  @override
  String get nodeDetailRebootNotConnected =>
      'Cannot reboot: Device not connected';

  @override
  String get nodeDetailRebootTitle => 'Reboot Device';

  @override
  String get nodeDetailRebootMessage =>
      'This will reboot your Meshtastic device. The app will automatically reconnect once the device restarts.';

  @override
  String get nodeDetailRebootConfirm => 'Reboot';

  @override
  String get nodeDetailRebootingSnackbar => 'Device is rebooting...';

  @override
  String nodeDetailRebootError(String error) {
    return 'Failed to reboot: $error';
  }

  @override
  String get nodeDetailShutdownNotConnected =>
      'Cannot shutdown: Device not connected';

  @override
  String get nodeDetailShutdownTitle => 'Shutdown Device';

  @override
  String get nodeDetailShutdownMessage =>
      'This will turn off your Meshtastic device. You will need to physically power it back on to reconnect.';

  @override
  String get nodeDetailShutdownConfirm => 'Shutdown';

  @override
  String get nodeDetailShuttingDownSnackbar => 'Device is shutting down...';

  @override
  String nodeDetailShutdownError(String error) {
    return 'Failed to shutdown: $error';
  }

  @override
  String get nodeDetailRemoveTitle => 'Remove Node';

  @override
  String nodeDetailRemoveMessage(String name) {
    return 'Remove $name from the node database? This will remove the node from your local device.';
  }

  @override
  String get nodeDetailRemoveConfirm => 'Remove';

  @override
  String nodeDetailRemovedSnackbar(String name) {
    return '$name removed';
  }

  @override
  String nodeDetailRemoveError(String error) {
    return 'Failed to remove node: $error';
  }

  @override
  String get nodeDetailNoPositionData => 'Node has no position data';

  @override
  String nodeDetailFixedPositionSet(String name) {
    return 'Fixed position set to $name\'s location';
  }

  @override
  String nodeDetailFixedPositionError(String error) {
    return 'Failed to set fixed position: $error';
  }

  @override
  String nodeDetailUserInfoRequested(String name) {
    return 'User info requested from $name';
  }

  @override
  String nodeDetailUserInfoError(String error) {
    return 'Failed to request user info: $error';
  }

  @override
  String nodeDetailPositionRequested(String name) {
    return 'Position requested from $name';
  }

  @override
  String nodeDetailPositionError(String error) {
    return 'Failed to request position: $error';
  }

  @override
  String get nodeDetailLastHeardNever => 'Never';

  @override
  String get nodeDetailLastHeardJustNow => 'Just now';

  @override
  String nodeDetailLastHeardMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String nodeDetailLastHeardHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String nodeDetailLastHeardDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String get nodeDetailSignalUnknown => 'Unknown';

  @override
  String get nodeDetailSignalExcellent => 'Excellent';

  @override
  String get nodeDetailSignalGood => 'Good';

  @override
  String get nodeDetailSignalFair => 'Fair';

  @override
  String get nodeDetailSignalWeak => 'Weak';

  @override
  String get nodeDetailSignalVeryWeak => 'Very Weak';

  @override
  String get nodeDetailYouBadge => 'YOU';

  @override
  String get nodeDetailPkiBadge => 'PKI';

  @override
  String get nodeDetailNoPkiBadge => 'No PKI';

  @override
  String get nodeDetailMutedBadge => 'Muted';

  @override
  String get nodeDetailFavoriteBadge => 'Favorite';

  @override
  String get nodeDetailBatteryCharging => 'Charging';

  @override
  String nodeDetailBatteryPercent(int level) {
    return '$level%';
  }

  @override
  String nodeDetailDistanceMeters(String meters) {
    return '$meters m';
  }

  @override
  String nodeDetailDistanceKilometers(String km) {
    return '$km km';
  }

  @override
  String get nodeDetailSectionIdentity => 'Identity';

  @override
  String get nodeDetailLabelUserId => 'User ID';

  @override
  String get nodeDetailLabelHardware => 'Hardware';

  @override
  String get nodeDetailLabelFirmware => 'Firmware';

  @override
  String get nodeDetailLabelEncryption => 'Encryption';

  @override
  String get nodeDetailValuePkiEnabled => 'PKI Enabled';

  @override
  String get nodeDetailValueNoPublicKey => 'No Public Key';

  @override
  String get nodeDetailLabelStatus => 'Status';

  @override
  String get nodeDetailSectionRadio => 'Radio';

  @override
  String get nodeDetailLabelRssi => 'RSSI';

  @override
  String nodeDetailValueRssi(int rssi) {
    return '$rssi dBm';
  }

  @override
  String get nodeDetailLabelSnr => 'SNR';

  @override
  String nodeDetailValueSnr(String snr) {
    return '$snr dB';
  }

  @override
  String get nodeDetailLabelNoiseFloor => 'Noise Floor';

  @override
  String nodeDetailValueNoiseFloor(int noiseFloor) {
    return '$noiseFloor dBm';
  }

  @override
  String get nodeDetailLabelDistance => 'Distance';

  @override
  String get nodeDetailLabelPosition => 'Position';

  @override
  String get nodeDetailLabelAltitude => 'Altitude';

  @override
  String nodeDetailValueAltitude(int altitude) {
    return '$altitude m';
  }

  @override
  String get nodeDetailSectionDeviceMetrics => 'Device Metrics';

  @override
  String get nodeDetailLabelBattery => 'Battery';

  @override
  String get nodeDetailLabelVoltage => 'Voltage';

  @override
  String nodeDetailValueVoltage(String voltage) {
    return '$voltage V';
  }

  @override
  String get nodeDetailLabelChannelUtil => 'Channel Util';

  @override
  String nodeDetailValuePercent(String value) {
    return '$value%';
  }

  @override
  String get nodeDetailLabelAirUtilTx => 'Air Util TX';

  @override
  String get nodeDetailLabelUptime => 'Uptime';

  @override
  String get nodeDetailSectionNetwork => 'Network';

  @override
  String get nodeDetailLabelPacketsTx => 'Packets TX';

  @override
  String get nodeDetailLabelPacketsRx => 'Packets RX';

  @override
  String get nodeDetailLabelBadPackets => 'Bad Packets';

  @override
  String get nodeDetailLabelOnlineNodes => 'Online Nodes';

  @override
  String get nodeDetailLabelTotalNodes => 'Total Nodes';

  @override
  String get nodeDetailLabelTxDropped => 'TX Dropped';

  @override
  String get nodeDetailSectionTraffic => 'Traffic Management';

  @override
  String get nodeDetailLabelInspected => 'Inspected';

  @override
  String get nodeDetailLabelPositionDedup => 'Position Dedup';

  @override
  String get nodeDetailLabelCacheHits => 'Cache Hits';

  @override
  String get nodeDetailLabelRateLimitDrops => 'Rate Limit Drops';

  @override
  String get nodeDetailLabelUnknownDrops => 'Unknown Drops';

  @override
  String get nodeDetailLabelHopExhausted => 'Hop Exhausted';

  @override
  String get nodeDetailLabelHopsPreserved => 'Hops Preserved';

  @override
  String get nodeDetailRebootButton => 'Reboot';

  @override
  String get nodeDetailShutdownButton => 'Shutdown';

  @override
  String get nodeDetailRemoveFromFavoritesTooltip => 'Remove from favorites';

  @override
  String get nodeDetailAddToFavoritesTooltip => 'Add to favorites';

  @override
  String get nodeDetailUnmuteTooltip => 'Unmute node';

  @override
  String get nodeDetailMuteTooltip => 'Mute node';

  @override
  String get nodeDetailMessageButton => 'Message';

  @override
  String get nodeDetailAppBarTitle => 'Node Details';

  @override
  String get nodeDetailSigilCardTooltip => 'Sigil Card';

  @override
  String get nodeDetailMenuQrCode => 'QR Code';

  @override
  String get nodeDetailMenuShowOnMap => 'Show on Map';

  @override
  String get nodeDetailMenuTracerouteHistory => 'Traceroute History';

  @override
  String get nodeDetailMenuRequestUserInfo => 'Request User Info';

  @override
  String get nodeDetailMenuExchangePositions => 'Exchange Positions';

  @override
  String get nodeDetailMenuSetFixedPosition => 'Set as Fixed Position';

  @override
  String get nodeDetailMenuAdminSettings => 'Admin Settings';

  @override
  String get nodeDetailMenuAdminSubtitle => 'Configure this node remotely';

  @override
  String get nodeDetailMenuRemoveNode => 'Remove Node';

  @override
  String nodeDetailLastHeardTimestamp(String timestamp) {
    return 'Last heard $timestamp';
  }

  @override
  String nodeDetailTracerouteCooldownTooltip(int seconds) {
    return 'Traceroute cooldown: ${seconds}s';
  }

  @override
  String get nodeDetailTracerouteTooltip => 'Traceroute';

  @override
  String get deviceConfigRoleClient => 'Client';

  @override
  String get deviceConfigRoleClientDesc =>
      'Default role. Mesh packets are routed through this node. Can send and receive messages.';

  @override
  String get deviceConfigRoleClientMute => 'Client Mute';

  @override
  String get deviceConfigRoleClientMuteDesc =>
      'Same as client but will not transmit any messages from itself. Useful for monitoring.';

  @override
  String get deviceConfigRoleClientHidden => 'Client Hidden';

  @override
  String get deviceConfigRoleClientHiddenDesc =>
      'Acts as client but hides from the node list. Still routes traffic.';

  @override
  String get deviceConfigRoleClientBase => 'Client Base';

  @override
  String get deviceConfigRoleClientBaseDesc =>
      'Base station for favorited nodes. Routes their packets like a router, others as client.';

  @override
  String get deviceConfigRoleRouter => 'Router';

  @override
  String get deviceConfigRoleRouterDesc =>
      'Routes mesh packets between nodes. Screen and Bluetooth disabled to conserve power.';

  @override
  String get deviceConfigRoleRouterLate => 'Router Late';

  @override
  String get deviceConfigRoleRouterLateDesc =>
      'Rebroadcasts all packets after other routers. Extends coverage without consuming priority hops.';

  @override
  String get deviceConfigRoleTracker => 'Tracker';

  @override
  String get deviceConfigRoleTrackerDesc =>
      'Optimized for GPS tracking. Sends position updates at defined intervals.';

  @override
  String get deviceConfigRoleSensor => 'Sensor';

  @override
  String get deviceConfigRoleSensorDesc =>
      'Designed for remote sensing. Reports telemetry data at defined intervals.';

  @override
  String get deviceConfigRoleTak => 'TAK';

  @override
  String get deviceConfigRoleTakDesc =>
      'Team Awareness Kit integration. Bridges Meshtastic and TAK systems.';

  @override
  String get deviceConfigRoleTakTracker => 'TAK Tracker';

  @override
  String get deviceConfigRoleTakTrackerDesc =>
      'Combination of TAK and Tracker modes.';

  @override
  String get deviceConfigRoleLostAndFound => 'Lost and Found';

  @override
  String get deviceConfigRoleLostAndFoundDesc =>
      'Optimized for finding lost devices. Sends periodic beacons.';

  @override
  String get deviceConfigRebroadcastAll => 'All';

  @override
  String get deviceConfigRebroadcastAllDesc =>
      'Rebroadcast any observed message. Default behavior.';

  @override
  String get deviceConfigRebroadcastAllSkipDecoding => 'All (Skip Decoding)';

  @override
  String get deviceConfigRebroadcastAllSkipDecodingDesc =>
      'Rebroadcast all messages without decoding. Faster, less CPU.';

  @override
  String get deviceConfigRebroadcastLocalOnly => 'Local Only';

  @override
  String get deviceConfigRebroadcastLocalOnlyDesc =>
      'Only rebroadcast messages from local senders. Good for isolated networks.';

  @override
  String get deviceConfigRebroadcastKnownOnly => 'Known Only';

  @override
  String get deviceConfigRebroadcastKnownOnlyDesc =>
      'Only rebroadcast messages from nodes in the node database.';

  @override
  String get deviceConfigRebroadcastCorePortnumsOnly =>
      'Core Port Numbers Only';

  @override
  String get deviceConfigRebroadcastCorePortnumsOnlyDesc =>
      'Rebroadcast only core Meshtastic packets (position, telemetry, etc).';

  @override
  String get deviceConfigRebroadcastNone => 'None';

  @override
  String get deviceConfigRebroadcastNoneDesc =>
      'Do not rebroadcast any messages. Node only receives.';

  @override
  String get deviceConfigBuzzerAllEnabled => 'All Enabled';

  @override
  String get deviceConfigBuzzerAllEnabledDesc =>
      'Buzzer sounds for all feedback including buttons and alerts.';

  @override
  String get deviceConfigBuzzerNotificationsOnly => 'Notifications Only';

  @override
  String get deviceConfigBuzzerNotificationsOnlyDesc =>
      'Buzzer only for notifications and alerts, not button presses.';

  @override
  String get deviceConfigBuzzerDirectMsgOnly => 'Direct Messages Only';

  @override
  String get deviceConfigBuzzerDirectMsgOnlyDesc =>
      'Buzzer only for direct messages and alerts.';

  @override
  String get deviceConfigBuzzerSystemOnly => 'System Only';

  @override
  String get deviceConfigBuzzerSystemOnlyDesc =>
      'Button presses, startup, shutdown sounds only. No alerts.';

  @override
  String get deviceConfigBuzzerDisabled => 'Disabled';

  @override
  String get deviceConfigBuzzerDisabledDesc =>
      'All buzzer audio feedback is disabled.';

  @override
  String get deviceConfigBroadcastThreeHours => 'Three Hours';

  @override
  String get deviceConfigBroadcastFourHours => 'Four Hours';

  @override
  String get deviceConfigBroadcastFiveHours => 'Five Hours';

  @override
  String get deviceConfigBroadcastSixHours => 'Six Hours';

  @override
  String get deviceConfigBroadcastTwelveHours => 'Twelve Hours';

  @override
  String get deviceConfigBroadcastEighteenHours => 'Eighteen Hours';

  @override
  String get deviceConfigBroadcastTwentyFourHours => 'Twenty Four Hours';

  @override
  String get deviceConfigBroadcastThirtySixHours => 'Thirty Six Hours';

  @override
  String get deviceConfigBroadcastFortyEightHours => 'Forty Eight Hours';

  @override
  String get deviceConfigBroadcastSeventyTwoHours => 'Seventy Two Hours';

  @override
  String get deviceConfigBroadcastNever => 'Never';

  @override
  String get deviceConfigTitleRemote => 'Device Config (Remote)';

  @override
  String get deviceConfigTitle => 'Device Config';

  @override
  String get deviceConfigSave => 'Save';

  @override
  String get deviceConfigSaveChangesTitle => 'Save Changes?';

  @override
  String get deviceConfigSaveChangesMessage =>
      'Saving device configuration will cause the device to reboot. You will be briefly disconnected while the device restarts.';

  @override
  String get deviceConfigSaveAndReboot => 'Save & Reboot';

  @override
  String get deviceConfigSavedRemote => 'Configuration sent to remote node';

  @override
  String get deviceConfigSavedLocal => 'Configuration saved - device rebooting';

  @override
  String deviceConfigSaveError(String error) {
    return 'Error saving config: $error';
  }

  @override
  String get deviceConfigLongName => 'Long Name';

  @override
  String get deviceConfigLongNameSubtitle => 'Display name visible on the mesh';

  @override
  String get deviceConfigLongNameHint => 'Enter display name';

  @override
  String get deviceConfigShortName => 'Short Name';

  @override
  String deviceConfigShortNameSubtitle(int maxLength) {
    return 'Max $maxLength characters (A-Z, 0-9)';
  }

  @override
  String get deviceConfigShortNameHint => 'e.g. FUZZ';

  @override
  String get deviceConfigNameHelpText =>
      'Your device name is broadcast to the mesh and visible to other nodes.';

  @override
  String get deviceConfigSectionUserFlags => 'User Flags';

  @override
  String get deviceConfigSectionDeviceInfo => 'Device Info';

  @override
  String get deviceConfigSectionDeviceRole => 'Device Role';

  @override
  String get deviceConfigSectionRebroadcastMode => 'Rebroadcast Mode';

  @override
  String get deviceConfigSectionNodeInfoBroadcast => 'Node Info Broadcast';

  @override
  String get deviceConfigSectionButtonInput => 'Button & Input';

  @override
  String get deviceConfigSectionBuzzer => 'Buzzer';

  @override
  String get deviceConfigSectionLed => 'LED';

  @override
  String get deviceConfigSectionSerial => 'Serial';

  @override
  String get deviceConfigSectionTimezone => 'Timezone';

  @override
  String get deviceConfigSectionGpio => 'GPIO (Advanced)';

  @override
  String get deviceConfigSectionDangerZone => 'Danger Zone';

  @override
  String get deviceConfigBleName => 'BLE Name';

  @override
  String get deviceConfigHardware => 'Hardware';

  @override
  String get deviceConfigUserId => 'User ID';

  @override
  String get deviceConfigNodeNumber => 'Node Number';

  @override
  String get deviceConfigUnknown => 'Unknown';

  @override
  String get deviceConfigBroadcastInterval => 'Broadcast Interval';

  @override
  String get deviceConfigBroadcastIntervalSubtitle =>
      'How often to broadcast node info to the mesh';

  @override
  String get deviceConfigDoubleTapAsButton => 'Double Tap as Button';

  @override
  String get deviceConfigDoubleTapAsButtonSubtitle =>
      'Treat accelerometer double-tap as button press';

  @override
  String get deviceConfigDisableTripleClick => 'Disable Triple Click';

  @override
  String get deviceConfigDisableTripleClickSubtitle =>
      'Disable triple-click to toggle GPS';

  @override
  String get deviceConfigDisableLedHeartbeat => 'Disable LED Heartbeat';

  @override
  String get deviceConfigDisableLedHeartbeatSubtitle =>
      'Turn off the blinking status LED';

  @override
  String get deviceConfigSerialConsole => 'Serial Console';

  @override
  String get deviceConfigSerialConsoleSubtitle =>
      'Enable serial port for debugging';

  @override
  String get deviceConfigPosixTimezone => 'POSIX Timezone';

  @override
  String get deviceConfigPosixTimezoneExample => 'e.g. EST5EDT,M3.2.0,M11.1.0';

  @override
  String get deviceConfigPosixTimezoneHint => 'Leave empty for UTC';

  @override
  String get deviceConfigGpioWarning =>
      'Only change these if you know your hardware requires custom GPIO pins.';

  @override
  String get deviceConfigButtonGpio => 'Button GPIO';

  @override
  String get deviceConfigBuzzerGpio => 'Buzzer GPIO';

  @override
  String get deviceConfigUnmessagable => 'Unmessagable';

  @override
  String get deviceConfigUnmessagableSubtitle =>
      'Mark as infrastructure node that won\'t respond to messages';

  @override
  String get deviceConfigLicensedOperator => 'Licensed Operator (Ham)';

  @override
  String get deviceConfigLicensedOperatorSubtitle =>
      'Sets call sign, overrides frequency/power, disables encryption';

  @override
  String get deviceConfigHamModeInfo =>
      'Ham mode uses your long name as call sign (max 8 chars), broadcasts node info every 10 minutes, overrides frequency, duty cycle, and TX power, and disables encryption.';

  @override
  String get deviceConfigHamModeWarning =>
      'HAM nodes cannot relay encrypted traffic. Other non-HAM nodes in your mesh will not be able to route encrypted messages through this node, creating a relay gap in the network.';

  @override
  String get deviceConfigFrequencyOverride => 'Frequency Override (MHz)';

  @override
  String get deviceConfigFrequencyOverrideHint => '0.0 (use default)';

  @override
  String get deviceConfigTxPower => 'TX Power';

  @override
  String deviceConfigTxPowerValue(int power) {
    return '$power dBm';
  }

  @override
  String get deviceConfigRemoteAdminTitle => 'Remote Administration';

  @override
  String deviceConfigRemoteAdminConfiguring(String nodeName) {
    return 'Configuring: $nodeName';
  }

  @override
  String get deviceConfigRebootWarning =>
      'Changes to device configuration will cause the device to reboot.';

  @override
  String get deviceConfigResetNodeDb => 'Reset Node Database';

  @override
  String get deviceConfigResetNodeDbSubtitle =>
      'Clear all stored node information';

  @override
  String get deviceConfigFactoryReset => 'Factory Reset';

  @override
  String get deviceConfigFactoryResetSubtitle =>
      'Reset device to factory defaults';

  @override
  String get deviceConfigResetNodeDbDialogTitle => 'Reset Node Database';

  @override
  String get deviceConfigResetNodeDbDialogMessage =>
      'This will clear all stored node information from the device. The mesh network will need to rediscover all nodes.\n\nAre you sure you want to continue?';

  @override
  String get deviceConfigResetNodeDbDialogConfirm => 'Reset';

  @override
  String get deviceConfigResetNodeDbSuccess => 'Node database reset initiated';

  @override
  String deviceConfigResetNodeDbError(String error) {
    return 'Failed to reset: $error';
  }

  @override
  String get deviceConfigFactoryResetDialogTitle => 'Factory Reset';

  @override
  String get deviceConfigFactoryResetDialogMessage =>
      'This will reset ALL device settings to factory defaults, including channels, configuration, and stored data.\n\nThis action cannot be undone!';

  @override
  String get deviceConfigFactoryResetDialogConfirm => 'Factory Reset';

  @override
  String get deviceConfigFactoryResetSuccess =>
      'Factory reset initiated - device will restart';

  @override
  String deviceConfigFactoryResetError(String error) {
    return 'Failed to reset: $error';
  }

  @override
  String get deviceSheetNoDevice => 'No Device';

  @override
  String get deviceSheetReconnecting => 'Reconnecting...';

  @override
  String get deviceSheetConnecting => 'Connecting...';

  @override
  String get deviceSheetConnected => 'Connected';

  @override
  String get deviceSheetDisconnecting => 'Disconnecting...';

  @override
  String get deviceSheetError => 'Error';

  @override
  String get deviceSheetDisconnected => 'Disconnected';

  @override
  String get deviceSheetSectionConnectionDetails => 'Connection Details';

  @override
  String get deviceSheetSectionQuickActions => 'Quick Actions';

  @override
  String get deviceSheetSectionDeveloperTools => 'Developer Tools';

  @override
  String get deviceSheetActionDeviceConfig => 'Device Config';

  @override
  String get deviceSheetActionDeviceConfigSubtitle =>
      'Configure device role and settings';

  @override
  String get deviceSheetActionDeviceManagement => 'Device Management';

  @override
  String get deviceSheetActionDeviceManagementSubtitle =>
      'Radio, display, power, and position settings';

  @override
  String get deviceSheetActionScanQr => 'Scan QR Code';

  @override
  String get deviceSheetActionScanQrSubtitle =>
      'Import nodes, channels, or automations';

  @override
  String get deviceSheetActionAppSettings => 'App Settings';

  @override
  String get deviceSheetActionAppSettingsSubtitle =>
      'Notifications, theme, preferences';

  @override
  String get deviceSheetActionResetNodeDb => 'Reset Node Database';

  @override
  String get deviceSheetActionResetNodeDbSubtitle =>
      'Clear all learned nodes from device';

  @override
  String get deviceSheetDisconnectingButton => 'Disconnecting...';

  @override
  String get deviceSheetDisconnectButton => 'Disconnect';

  @override
  String get deviceSheetScanForDevices => 'Scan for Devices';

  @override
  String get deviceSheetDisconnectDialogTitle => 'Disconnect';

  @override
  String get deviceSheetDisconnectDialogMessage =>
      'Are you sure you want to disconnect from this device?';

  @override
  String get deviceSheetDisconnectDialogConfirm => 'Disconnect';

  @override
  String get deviceSheetResetNodeDbDialogTitle => 'Reset Node Database';

  @override
  String get deviceSheetResetNodeDbDialogMessage =>
      'This will clear all learned nodes from the device and app. The device will need to rediscover nodes on the mesh.\n\nAre you sure you want to continue?';

  @override
  String get deviceSheetResetNodeDbDialogConfirm => 'Reset';

  @override
  String get deviceSheetResetNodeDbSuccess =>
      'Node database reset successfully';

  @override
  String deviceSheetResetNodeDbError(String error) {
    return 'Failed to reset node database: $error';
  }

  @override
  String get deviceSheetProtocol => 'Protocol';

  @override
  String get deviceSheetNodeName => 'Node Name';

  @override
  String get deviceSheetDeviceName => 'Device Name';

  @override
  String get deviceSheetUnknown => 'Unknown';

  @override
  String get deviceSheetFirmware => 'Firmware';

  @override
  String get deviceSheetNodeId => 'Node ID';

  @override
  String get deviceSheetStatus => 'Status';

  @override
  String get deviceSheetConnectionType => 'Connection Type';

  @override
  String get deviceSheetBluetoothLe => 'Bluetooth LE';

  @override
  String get deviceSheetUsb => 'USB';

  @override
  String get deviceSheetAddress => 'Address';

  @override
  String get deviceSheetSignalStrength => 'Signal Strength';

  @override
  String deviceSheetSignalStrengthValue(String rssi) {
    return '$rssi dBm';
  }

  @override
  String get deviceSheetBattery => 'Battery';

  @override
  String get deviceSheetCharging => 'Charging';

  @override
  String deviceSheetBatteryPercent(String percent) {
    return '$percent%';
  }

  @override
  String get deviceSheetInfoCardConnecting => 'Connecting...';

  @override
  String get deviceSheetInfoCardConnected => 'Connected';

  @override
  String get deviceSheetInfoCardDisconnecting => 'Disconnecting...';

  @override
  String get deviceSheetInfoCardConnectionError => 'Connection Error';

  @override
  String get deviceSheetInfoCardDisconnected => 'Disconnected';

  @override
  String get deviceSheetRefreshingBattery => 'Refreshing battery...';

  @override
  String deviceSheetBatteryRefreshResult(String percent, String millivolts) {
    return '$percent%$millivolts';
  }

  @override
  String get deviceSheetBatteryRefreshFailed => 'Failed';

  @override
  String get deviceSheetBatteryRefreshIdle => 'Fetch battery from device';

  @override
  String get deviceSheetRefreshBattery => 'Refresh Battery';

  @override
  String get regionSelectionTitleInitial => 'Select Your Region';

  @override
  String get regionSelectionTitleChange => 'Change Region';

  @override
  String get regionSelectionBannerTitle => 'Important: Select Your Region';

  @override
  String get regionSelectionBannerSubtitle =>
      'Choose the correct frequency for your location to comply with local regulations.';

  @override
  String get regionSelectionSearchHint => 'Search regions...';

  @override
  String get regionSelectionApplying => 'Applying...';

  @override
  String get regionSelectionContinue => 'Continue';

  @override
  String get regionSelectionSave => 'Save';

  @override
  String get regionSelectionCurrentBadge => 'CURRENT';

  @override
  String get regionSelectionApplyDialogTitle => 'Apply Region';

  @override
  String get regionSelectionApplyDialogMessageInitial =>
      'Your device will reboot to apply the region settings. This may take up to 30 seconds.\n\nThe app will automatically reconnect when ready.';

  @override
  String get regionSelectionApplyDialogMessageChange =>
      'Changing the region will cause your device to reboot. This may take up to 30 seconds.\n\nYou will be briefly disconnected while the device restarts.';

  @override
  String get regionSelectionApplyDialogConfirm => 'Continue';

  @override
  String get regionSelectionDeviceDisconnected =>
      'Device disconnected. Please reconnect and try again.';

  @override
  String get regionSelectionReconnectTimeout =>
      'Reconnect timed out. Please try again.';

  @override
  String get regionSelectionPairingInvalidation =>
      'Your phone removed the stored pairing info for this device.\nGo to Settings > Bluetooth, forget the Meshtastic device, and try again.';

  @override
  String regionSelectionSetRegionError(String error) {
    return 'Failed to set region: $error';
  }

  @override
  String get regionSelectionOpenBluetoothSettingsError =>
      'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.';

  @override
  String get regionSelectionPairingHintMessage =>
      'Bluetooth pairing was removed. Forget \"Meshtastic_XXXX\" in Settings > Bluetooth and reconnect to continue.';

  @override
  String get regionSelectionBluetoothSettings => 'Bluetooth Settings';

  @override
  String get regionSelectionViewScanner => 'View Scanner';

  @override
  String get regionSelectionRegionUs => 'United States';

  @override
  String get regionSelectionRegionUsFreq => '915 MHz';

  @override
  String get regionSelectionRegionUsDesc => 'US, Canada, Mexico';

  @override
  String get regionSelectionRegionEu868 => 'Europe 868';

  @override
  String get regionSelectionRegionEu868Freq => '868 MHz';

  @override
  String get regionSelectionRegionEu868Desc => 'EU, UK, and most of Europe';

  @override
  String get regionSelectionRegionEu433 => 'Europe 433';

  @override
  String get regionSelectionRegionEu433Freq => '433 MHz';

  @override
  String get regionSelectionRegionEu433Desc => 'EU alternate frequency';

  @override
  String get regionSelectionRegionAnz => 'Australia/NZ';

  @override
  String get regionSelectionRegionAnzFreq => '915 MHz';

  @override
  String get regionSelectionRegionAnzDesc => 'Australia and New Zealand';

  @override
  String get regionSelectionRegionCn => 'China';

  @override
  String get regionSelectionRegionCnFreq => '470 MHz';

  @override
  String get regionSelectionRegionCnDesc => 'China';

  @override
  String get regionSelectionRegionJp => 'Japan';

  @override
  String get regionSelectionRegionJpFreq => '920 MHz';

  @override
  String get regionSelectionRegionJpDesc => 'Japan';

  @override
  String get regionSelectionRegionKr => 'Korea';

  @override
  String get regionSelectionRegionKrFreq => '920 MHz';

  @override
  String get regionSelectionRegionKrDesc => 'South Korea';

  @override
  String get regionSelectionRegionTw => 'Taiwan';

  @override
  String get regionSelectionRegionTwFreq => '923 MHz';

  @override
  String get regionSelectionRegionTwDesc => 'Taiwan';

  @override
  String get regionSelectionRegionRu => 'Russia';

  @override
  String get regionSelectionRegionRuFreq => '868 MHz';

  @override
  String get regionSelectionRegionRuDesc => 'Russia';

  @override
  String get regionSelectionRegionIn => 'India';

  @override
  String get regionSelectionRegionInFreq => '865 MHz';

  @override
  String get regionSelectionRegionInDesc => 'India';

  @override
  String get regionSelectionRegionNz865 => 'New Zealand 865';

  @override
  String get regionSelectionRegionNz865Freq => '865 MHz';

  @override
  String get regionSelectionRegionNz865Desc => 'New Zealand alternate';

  @override
  String get regionSelectionRegionTh => 'Thailand';

  @override
  String get regionSelectionRegionThFreq => '920 MHz';

  @override
  String get regionSelectionRegionThDesc => 'Thailand';

  @override
  String get regionSelectionRegionUa433 => 'Ukraine 433';

  @override
  String get regionSelectionRegionUa433Freq => '433 MHz';

  @override
  String get regionSelectionRegionUa433Desc => 'Ukraine';

  @override
  String get regionSelectionRegionUa868 => 'Ukraine 868';

  @override
  String get regionSelectionRegionUa868Freq => '868 MHz';

  @override
  String get regionSelectionRegionUa868Desc => 'Ukraine';

  @override
  String get regionSelectionRegionMy433 => 'Malaysia 433';

  @override
  String get regionSelectionRegionMy433Freq => '433 MHz';

  @override
  String get regionSelectionRegionMy433Desc => 'Malaysia';

  @override
  String get regionSelectionRegionMy919 => 'Malaysia 919';

  @override
  String get regionSelectionRegionMy919Freq => '919 MHz';

  @override
  String get regionSelectionRegionMy919Desc => 'Malaysia';

  @override
  String get regionSelectionRegionSg923 => 'Singapore';

  @override
  String get regionSelectionRegionSg923Freq => '923 MHz';

  @override
  String get regionSelectionRegionSg923Desc => 'Singapore';

  @override
  String get regionSelectionRegionLora24 => '2.4 GHz';

  @override
  String get regionSelectionRegionLora24Freq => '2.4 GHz';

  @override
  String get regionSelectionRegionLora24Desc => 'Worldwide 2.4GHz band';

  @override
  String get gpsStatusTitle => 'GPS Status';

  @override
  String get gpsStatusSectionPosition => 'Position';

  @override
  String get gpsStatusSectionMotion => 'Motion';

  @override
  String get gpsStatusSectionSatellites => 'Satellites';

  @override
  String get gpsStatusSectionLastUpdate => 'Last Update';

  @override
  String get gpsStatusLatitude => 'Latitude';

  @override
  String gpsStatusLatitudeValue(String value) {
    return '$value°';
  }

  @override
  String get gpsStatusLongitude => 'Longitude';

  @override
  String gpsStatusLongitudeValue(String value) {
    return '$value°';
  }

  @override
  String get gpsStatusAltitude => 'Altitude';

  @override
  String gpsStatusAltitudeValue(String meters) {
    return '${meters}m';
  }

  @override
  String get gpsStatusAccuracy => 'Accuracy';

  @override
  String gpsStatusAccuracyValue(String meters) {
    return '±${meters}m';
  }

  @override
  String get gpsStatusPrecisionBits => 'Precision Bits';

  @override
  String get gpsStatusUnknown => 'Unknown';

  @override
  String get gpsStatusGroundSpeed => 'Ground Speed';

  @override
  String gpsStatusGroundSpeedValue(String mps, String kmh) {
    return '$mps m/s ($kmh km/h)';
  }

  @override
  String get gpsStatusGroundTrack => 'Ground Track';

  @override
  String gpsStatusGroundTrackValue(String degrees, String direction) {
    return '$degrees° $direction';
  }

  @override
  String get gpsStatusOpenInMaps => 'Open in Maps';

  @override
  String get gpsStatusNoGpsFix => 'No GPS Fix';

  @override
  String get gpsStatusNoGpsFixMessage =>
      'The device has not acquired a GPS position yet. Make sure the device has a clear view of the sky.';

  @override
  String get gpsStatusSatellitesInView => 'Satellites in View';

  @override
  String get gpsStatusSatNoFix => 'No Fix';

  @override
  String get gpsStatusSatPoor => 'Poor';

  @override
  String get gpsStatusSatFair => 'Fair';

  @override
  String get gpsStatusSatGood => 'Good';

  @override
  String get gpsStatusFixAcquired => 'GPS Fix Acquired';

  @override
  String get gpsStatusAcquiring => 'Acquiring GPS...';

  @override
  String gpsStatusSatellitesCount(int count) {
    return '$count satellites in view';
  }

  @override
  String get gpsStatusSearchingSatellites => 'Searching for satellites...';

  @override
  String get gpsStatusActiveBadge => 'ACTIVE';

  @override
  String gpsStatusTodayAt(String time) {
    return 'Today at $time';
  }

  @override
  String gpsStatusDateAt(String date, String time) {
    return '$date $time';
  }

  @override
  String gpsStatusSecondsAgo(int count) {
    return '$count seconds ago';
  }

  @override
  String gpsStatusMinutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String gpsStatusHoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String gpsStatusDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get gpsStatusCardinalN => 'N';

  @override
  String get gpsStatusCardinalNE => 'NE';

  @override
  String get gpsStatusCardinalE => 'E';

  @override
  String get gpsStatusCardinalSE => 'SE';

  @override
  String get gpsStatusCardinalS => 'S';

  @override
  String get gpsStatusCardinalSW => 'SW';

  @override
  String get gpsStatusCardinalW => 'W';

  @override
  String get gpsStatusCardinalNW => 'NW';

  @override
  String get serialConfigTitle => 'Serial Config';

  @override
  String get serialConfigSave => 'Save';

  @override
  String get serialConfigSectionGeneral => 'General';

  @override
  String get serialConfigSectionBaudRate => 'Baud Rate';

  @override
  String get serialConfigSectionTimeout => 'Timeout';

  @override
  String get serialConfigSectionSerialMode => 'Serial Mode';

  @override
  String get serialConfigEnabled => 'Serial Enabled';

  @override
  String get serialConfigEnabledSubtitle => 'Enable serial port communication';

  @override
  String get serialConfigEcho => 'Echo';

  @override
  String get serialConfigEchoSubtitle =>
      'Echo sent packets back to the serial port';

  @override
  String get serialConfigRxdGpio => 'RXD GPIO Pin';

  @override
  String get serialConfigRxdGpioSubtitle => 'Receive data GPIO pin number';

  @override
  String get serialConfigTxdGpio => 'TXD GPIO Pin';

  @override
  String get serialConfigTxdGpioSubtitle => 'Transmit data GPIO pin number';

  @override
  String get serialConfigOverrideConsole => 'Override Console Serial';

  @override
  String get serialConfigOverrideConsoleSubtitle =>
      'Use serial module instead of console';

  @override
  String get serialConfigBaudRate => 'Baud Rate';

  @override
  String get serialConfigBaudRateSubtitle => 'Serial communication speed';

  @override
  String get serialConfigTimeout => 'Timeout';

  @override
  String serialConfigTimeoutValue(int seconds) {
    return '$seconds seconds';
  }

  @override
  String get serialConfigModeSimpleDesc =>
      'Simple serial output for basic terminal usage';

  @override
  String get serialConfigModeProtoDesc =>
      'Protobuf binary protocol for programmatic access';

  @override
  String get serialConfigModeTextmsgDesc =>
      'Text message mode for SMS-style communication';

  @override
  String get serialConfigModeNmeaDesc =>
      'NMEA GPS sentence output for GPS applications';

  @override
  String get serialConfigModeCaltopoDesc =>
      'CalTopo format for mapping applications';

  @override
  String get serialConfigGpioUnset => 'Unset';

  @override
  String serialConfigGpioPin(int pin) {
    return 'Pin $pin';
  }

  @override
  String get serialConfigSaved => 'Serial configuration saved';

  @override
  String serialConfigSaveError(String error) {
    return 'Error saving config: $error';
  }

  @override
  String get firmwareUpdateTitle => 'Firmware Update';

  @override
  String get firmwareUpdateSectionCurrentVersion => 'Current Version';

  @override
  String get firmwareUpdateSectionAvailableUpdate => 'Available Update';

  @override
  String get firmwareUpdateSectionHowToUpdate => 'How to Update';

  @override
  String get firmwareUpdateInstalledFirmware => 'Installed Firmware';

  @override
  String get firmwareUpdateUnknown => 'Unknown';

  @override
  String get firmwareUpdateHardware => 'Hardware';

  @override
  String get firmwareUpdateNodeId => 'Node ID';

  @override
  String get firmwareUpdateUptime => 'Uptime';

  @override
  String get firmwareUpdateWifi => 'WiFi';

  @override
  String get firmwareUpdateBluetooth => 'Bluetooth';

  @override
  String get firmwareUpdateSupported => 'Supported';

  @override
  String get firmwareUpdateAvailable => 'Update Available';

  @override
  String get firmwareUpdateUpToDate => 'Up to Date';

  @override
  String firmwareUpdateLatestVersion(String version) {
    return 'Latest: $version';
  }

  @override
  String get firmwareUpdateNewBadge => 'NEW';

  @override
  String get firmwareUpdateDownload => 'Download Update';

  @override
  String get firmwareUpdateReleaseNotes => 'Release Notes';

  @override
  String get firmwareUpdateChecking => 'Checking for updates...';

  @override
  String get firmwareUpdateCheckFailed => 'Failed to check for updates';

  @override
  String get firmwareUpdateUnableToCheck => 'Unable to check for updates';

  @override
  String get firmwareUpdateVisitWebsite =>
      'Visit the Meshtastic website for the latest firmware.';

  @override
  String get firmwareUpdateStep1 =>
      'Download the firmware file for your device';

  @override
  String get firmwareUpdateStep2 => 'Connect your device via USB';

  @override
  String get firmwareUpdateStep3 =>
      'Use the Meshtastic Web Flasher or CLI to flash';

  @override
  String get firmwareUpdateStep4 => 'Wait for device to reboot and reconnect';

  @override
  String get firmwareUpdateOpenWebFlasher => 'Open Web Flasher';

  @override
  String get firmwareUpdateBackupWarningTitle => 'Backup Your Settings';

  @override
  String get firmwareUpdateBackupWarningSubtitle =>
      'Firmware updates may reset your device configuration. Consider exporting your settings before updating.';

  @override
  String get telemetryConfigTitle => 'Telemetry';

  @override
  String get telemetryConfigSave => 'Save';

  @override
  String get telemetryConfigSectionDeviceMetrics => 'Device Metrics';

  @override
  String get telemetryConfigSectionEnvironmentMetrics => 'Environment Metrics';

  @override
  String get telemetryConfigSectionAirQuality => 'Air Quality';

  @override
  String get telemetryConfigSectionPowerMetrics => 'Power Metrics';

  @override
  String get telemetryConfigDeviceMetricsDesc =>
      'Battery level, voltage, channel utilization, air util TX';

  @override
  String get telemetryConfigEnvironmentMetricsDesc =>
      'Temperature, humidity, barometric pressure, gas resistance';

  @override
  String get telemetryConfigAirQualityDesc =>
      'PM1.0, PM2.5, PM10, particle counts, CO2';

  @override
  String get telemetryConfigPowerMetricsDesc =>
      'Voltage and current for channels 1-3';

  @override
  String get telemetryConfigDisplayOnScreen => 'Display on Screen';

  @override
  String get telemetryConfigDisplayOnScreenSubtitle =>
      'Show environment data on device screen';

  @override
  String get telemetryConfigDisplayFahrenheit => 'Display Fahrenheit';

  @override
  String get telemetryConfigDisplayFahrenheitSubtitle =>
      'Show temperature in Fahrenheit instead of Celsius';

  @override
  String get telemetryConfigEnabled => 'Enabled';

  @override
  String get telemetryConfigUpdateInterval => 'Update Interval';

  @override
  String get telemetryConfigMinutes => ' minutes';

  @override
  String get telemetryConfigAirtimeWarning =>
      'Telemetry data is shared with all nodes on the mesh network. Shorter intervals increase airtime usage.';

  @override
  String get telemetryConfigSaved => 'Telemetry config saved';

  @override
  String telemetryConfigSaveError(String error) {
    return 'Failed to save: $error';
  }

  @override
  String get ambientLightingTitle => 'Ambient Lighting';

  @override
  String get ambientLightingSave => 'Save';

  @override
  String get ambientLightingLedEnabled => 'LED Enabled';

  @override
  String get ambientLightingLedEnabledSubtitle =>
      'Turn ambient lighting on or off';

  @override
  String get ambientLightingPresetColors => 'Preset Colors';

  @override
  String get ambientLightingCustomColor => 'Custom Color';

  @override
  String get ambientLightingRed => 'Red';

  @override
  String get ambientLightingGreen => 'Green';

  @override
  String get ambientLightingBlue => 'Blue';

  @override
  String get ambientLightingBrightness => 'LED Brightness';

  @override
  String get ambientLightingCurrent => 'Current';

  @override
  String ambientLightingCurrentValue(int milliamps) {
    return '$milliamps mA';
  }

  @override
  String get ambientLightingCurrentSubtitle => 'LED drive current (brightness)';

  @override
  String get ambientLightingDeviceSupportInfo =>
      'Ambient lighting is only available on devices with LED support (RAK WisBlock, T-Beam, etc.)';

  @override
  String get ambientLightingSaved => 'Ambient lighting saved';

  @override
  String ambientLightingSaveError(String error) {
    return 'Failed to save: $error';
  }

  @override
  String get paxCounterTitle => 'PAX Counter';

  @override
  String get paxCounterSave => 'Save';

  @override
  String get paxCounterCardTitle => 'PAX Counter';

  @override
  String get paxCounterCardSubtitle =>
      'Counts nearby WiFi and Bluetooth devices';

  @override
  String get paxCounterEnable => 'Enable PAX Counter';

  @override
  String get paxCounterEnableSubtitle =>
      'Count nearby devices and report to mesh';

  @override
  String get paxCounterUpdateInterval => 'Update Interval';

  @override
  String paxCounterIntervalMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get paxCounterMinLabel => '1 min';

  @override
  String get paxCounterMaxLabel => '60 min';

  @override
  String get paxCounterAboutTitle => 'About PAX Counter';

  @override
  String get paxCounterAboutSubtitle =>
      'PAX Counter passively listens for WiFi and Bluetooth probe requests from nearby devices. It does not store MAC addresses or any personal data.';

  @override
  String get paxCounterSaved => 'PAX counter config saved';

  @override
  String paxCounterSaveError(String error) {
    return 'Failed to save: $error';
  }

  @override
  String get meshcoreConsoleTitle => 'MeshCore Console';

  @override
  String get meshcoreConsoleDevBadge => 'DEV';

  @override
  String meshcoreConsoleFramesCaptured(int count) {
    return '$count frames captured';
  }

  @override
  String get meshcoreConsoleRefresh => 'Refresh';

  @override
  String get meshcoreConsoleCopyHex => 'Copy Hex';

  @override
  String get meshcoreConsoleClear => 'Clear';

  @override
  String get meshcoreConsoleNoFrames => 'No frames captured yet';

  @override
  String get meshcoreConsoleHexCopied => 'Hex log copied to clipboard';

  @override
  String get meshcoreConsoleCaptureCleared => 'Capture cleared';

  @override
  String get shopModelCategoryNodes => 'Nodes';

  @override
  String get shopModelCategoryNodesDescription => 'Complete Meshtastic devices';

  @override
  String get shopModelCategoryModules => 'Modules';

  @override
  String get shopModelCategoryModulesDescription => 'Add-on modules and boards';

  @override
  String get shopModelCategoryAntennas => 'Antennas';

  @override
  String get shopModelCategoryAntennasDescription =>
      'Antennas and RF accessories';

  @override
  String get shopModelCategoryEnclosures => 'Enclosures';

  @override
  String get shopModelCategoryEnclosuresDescription => 'Cases and enclosures';

  @override
  String get shopModelCategoryAccessories => 'Accessories';

  @override
  String get shopModelCategoryAccessoriesDescription =>
      'Cables, batteries, and more';

  @override
  String get shopModelCategoryKits => 'Kits';

  @override
  String get shopModelCategoryKitsDescription => 'DIY kits and bundles';

  @override
  String get shopModelCategorySolar => 'Solar';

  @override
  String get shopModelCategorySolarDescription =>
      'Solar panels and power solutions';

  @override
  String get shopModelBandUs915 => 'US 915MHz';

  @override
  String get shopModelBandUs915Range => '902-928 MHz';

  @override
  String get shopModelBandEu868 => 'EU 868MHz';

  @override
  String get shopModelBandEu868Range => '863-870 MHz';

  @override
  String get shopModelBandCn470 => 'CN 470MHz';

  @override
  String get shopModelBandCn470Range => '470-510 MHz';

  @override
  String get shopModelBandJp920 => 'JP 920MHz';

  @override
  String get shopModelBandJp920Range => '920-925 MHz';

  @override
  String get shopModelBandKr920 => 'KR 920MHz';

  @override
  String get shopModelBandKr920Range => '920-923 MHz';

  @override
  String get shopModelBandAu915 => 'AU 915MHz';

  @override
  String get shopModelBandAu915Range => '915-928 MHz';

  @override
  String get shopModelBandIn865 => 'IN 865MHz';

  @override
  String get shopModelBandIn865Range => '865-867 MHz';

  @override
  String get shopModelBandMulti => 'Multi-band';

  @override
  String get shopModelBandMultiRange => 'Multiple frequencies';

  @override
  String shopModelPriceFrom(String price) {
    return 'From \$$price';
  }

  @override
  String get lilygoModelPriceUnavailable => 'Price unavailable';

  @override
  String get deviceShopTitle => 'Device Shop';

  @override
  String get deviceShopFavoritesTooltip => 'Favorites';

  @override
  String get deviceShopHelpTooltip => 'Help';

  @override
  String get deviceShopSearchHint => 'Search devices, modules, antennas...';

  @override
  String get deviceShopMarketplaceInfoTitle => 'Marketplace Information';

  @override
  String get deviceShopMarketplaceDisclaimer =>
      'Purchases are completed on the seller\'s official store. Socialmesh does not handle payment, shipping, warranty, or returns.';

  @override
  String get deviceShopRecentSearches => 'Recent Searches';

  @override
  String get deviceShopClear => 'Clear';

  @override
  String get deviceShopTrending => 'Trending';

  @override
  String get deviceShopBrowseByCategory => 'Browse by Category';

  @override
  String deviceShopNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get deviceShopTryDifferentKeywords => 'Try different keywords';

  @override
  String get deviceShopErrorLoadingProducts => 'Error loading products';

  @override
  String get deviceShopCategories => 'Categories';

  @override
  String get deviceShopOfficialPartners => 'Official Partners';

  @override
  String get deviceShopNewArrivals => 'New Arrivals';

  @override
  String get deviceShopPopularDevices => 'Popular Devices';

  @override
  String get deviceShopBecomeSeller => 'Become a Seller';

  @override
  String get deviceShopSellYourDevices => 'Sell your Meshtastic devices';

  @override
  String get deviceShopBecomeSellerBody =>
      'Are you a manufacturer or distributor of Meshtastic-compatible devices? Join our marketplace to reach mesh radio enthusiasts worldwide.';

  @override
  String get deviceShopContactUs => 'Contact Us';

  @override
  String get deviceShopSupportEmail => 'support@socialmesh.app';

  @override
  String get deviceShopOnSale => 'On Sale';

  @override
  String get deviceShopSeeAll => 'See All';

  @override
  String get deviceShopOutOfStock => 'OUT OF STOCK';

  @override
  String get deviceShopUnableToLoad => 'Unable to load products';

  @override
  String get deviceShopNoInternet => 'No internet connection';

  @override
  String get deviceShopTryAgain => 'Try again in a moment';

  @override
  String get deviceShopConnectToBrowse => 'Connect to browse devices';

  @override
  String get deviceShopRetry => 'Retry';

  @override
  String get deviceShopFeatured => 'Featured';

  @override
  String get productDetailTitle => 'Product';

  @override
  String get productDetailErrorLoading => 'Error loading product';

  @override
  String get productDetailGoBack => 'Go Back';

  @override
  String get productDetailNotFound => 'Product not found';

  @override
  String get productDetailSignInFavorites => 'Sign in to save favorites';

  @override
  String productDetailBySeller(String seller) {
    return 'by $seller';
  }

  @override
  String productDetailReviewCount(int count) {
    return '($count reviews)';
  }

  @override
  String productDetailSoldCount(int count) {
    return '$count sold';
  }

  @override
  String productDetailInStockCount(int quantity) {
    return 'In Stock ($quantity available)';
  }

  @override
  String get productDetailOutOfStock => 'Out of Stock';

  @override
  String get productDetailDescription => 'Description';

  @override
  String get productDetailShowLess => 'Show Less';

  @override
  String get productDetailReadMore => 'Read More';

  @override
  String productDetailSelectedPrice(String price) {
    return 'Selected: \$$price';
  }

  @override
  String get productDetailTechSpecs => 'Technical Specifications';

  @override
  String get productDetailVendorVerified => 'Vendor Verified';

  @override
  String productDetailVerifiedOn(String date) {
    return 'Verified on $date';
  }

  @override
  String get productDetailChipset => 'Chipset';

  @override
  String get productDetailLoraChip => 'LoRa Chip';

  @override
  String get productDetailFrequencyBands => 'Frequency Bands';

  @override
  String get productDetailBattery => 'Battery';

  @override
  String get productDetailDimensions => 'Dimensions';

  @override
  String get productDetailWeight => 'Weight';

  @override
  String get productDetailHardwareVersion => 'Hardware Version';

  @override
  String get productDetailFirmware => 'Firmware';

  @override
  String get productDetailGps => 'GPS';

  @override
  String get productDetailDisplay => 'Display';

  @override
  String get productDetailBluetooth => 'Bluetooth';

  @override
  String get productDetailWifi => 'WiFi';

  @override
  String get productDetailMeshtasticCompatible => 'Meshtastic Compatible';

  @override
  String get productDetailFeatures => 'Features';

  @override
  String get productDetailIncludedAccessories => 'Included Accessories';

  @override
  String get productDetailShipping => 'Shipping';

  @override
  String productDetailShippingCost(String cost) {
    return 'Shipping: \$$cost';
  }

  @override
  String get productDetailFreeShipping => 'Free Shipping';

  @override
  String productDetailEstimatedDelivery(int days) {
    return 'Estimated $days days';
  }

  @override
  String productDetailShipsTo(String countries) {
    return 'Ships to: $countries';
  }

  @override
  String get productDetailPurchaseDisclaimer =>
      'Purchases completed on seller\'s official store';

  @override
  String get productDetailTotal => 'Total';

  @override
  String get productDetailEdit => 'Edit';

  @override
  String get productDetailBuyNow => 'Buy Now';

  @override
  String get productDetailOutOfStockButton => 'Out of Stock';

  @override
  String get productDetailPurchaseTitle => 'Purchase';

  @override
  String get productDetailContactToPurchase =>
      'Contact the seller to purchase this product.';

  @override
  String get productDetailCancel => 'Cancel';

  @override
  String get productDetailContactSeller => 'Contact Seller';

  @override
  String get productDetailUnableToLoadPage => 'Unable to load page';

  @override
  String get productDetailWebviewOffline =>
      'This content requires an internet connection. Please check your connection and try again.';

  @override
  String get productDetailRetry => 'Retry';

  @override
  String get productDetailReviews => 'Reviews';

  @override
  String get productDetailWriteReview => 'Write Review';

  @override
  String get productDetailUnableToLoadReviews => 'Unable to load reviews';

  @override
  String get productDetailNoReviews => 'No reviews yet';

  @override
  String get productDetailBeFirstReviewer =>
      'Be the first to review this product!';

  @override
  String get productDetailReviewVerified => 'Verified';

  @override
  String get productDetailSellerResponse => 'Seller Response';

  @override
  String get productDetailToday => 'Today';

  @override
  String get productDetailYesterday => 'Yesterday';

  @override
  String productDetailDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String productDetailWeeksAgo(int count) {
    return '$count weeks ago';
  }

  @override
  String productDetailMonthsAgo(int count) {
    return '$count months ago';
  }

  @override
  String productDetailYearsAgo(int count) {
    return '$count years ago';
  }

  @override
  String get productDetailWriteReviewTitle => 'Write a Review';

  @override
  String productDetailReviewPrivacyNotice(String userName) {
    return 'Your review will be public and posted as \"$userName\". Reviews are moderated before appearing on the product page.';
  }

  @override
  String get productDetailAnonymous => 'Anonymous';

  @override
  String get productDetailYourRating => 'Your Rating';

  @override
  String get productDetailReviewTitleLabel => 'Title (optional)';

  @override
  String get productDetailYourReview => 'Your Review *';

  @override
  String get productDetailReviewHint =>
      'Share your experience with this product...';

  @override
  String get productDetailReviewValidation =>
      'Please write a review description';

  @override
  String get productDetailSubmitReview => 'Submit Review';

  @override
  String get productDetailReviewSubmitted =>
      'Review submitted for moderation. Thank you!';

  @override
  String productDetailImageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String productDetailDiscountBadge(int percent) {
    return '-$percent% OFF';
  }

  @override
  String get adminProductsTitle => 'Manage Products';

  @override
  String get adminProductsHideInactive => 'Hide inactive';

  @override
  String get adminProductsShowInactive => 'Show inactive';

  @override
  String get adminProductsAddTooltip => 'Add Product';

  @override
  String get adminProductsSearchHint => 'Search products...';

  @override
  String get adminProductsFilterTooltip => 'Filter by category';

  @override
  String get adminProductsAllCategories => 'All Categories';

  @override
  String get adminProductsNotFound => 'No products found';

  @override
  String get adminProductsDeleteTitle => 'Delete Product';

  @override
  String adminProductsDeleteMessage(String name) {
    return 'Are you sure you want to permanently delete \"$name\"?\n\nThis action cannot be undone.';
  }

  @override
  String get adminProductsDelete => 'Delete';

  @override
  String get adminProductsDeleted => 'Product deleted';

  @override
  String get adminProductsInactiveBadge => 'INACTIVE';

  @override
  String get adminProductsFeaturedBadge => 'FEATURED';

  @override
  String get adminProductsEdit => 'Edit';

  @override
  String get adminProductsDeactivate => 'Deactivate';

  @override
  String get adminProductsActivate => 'Activate';

  @override
  String get adminProductsDeleteMenu => 'Delete';

  @override
  String get adminProductsEditTitle => 'Edit Product';

  @override
  String get adminProductsAddTitle => 'Add Product';

  @override
  String get adminProductsDeleteTooltip => 'Delete';

  @override
  String get adminProductsImagesSection => 'Product Images';

  @override
  String get adminProductsBasicInfoSection => 'Basic Information';

  @override
  String get adminProductsNameLabel => 'Product Name *';

  @override
  String get adminProductsNameHint => 'e.g., T-Beam Supreme';

  @override
  String get adminProductsRequired => 'Required';

  @override
  String get adminProductsShortDescLabel => 'Short Description';

  @override
  String get adminProductsShortDescHint => 'Brief summary (max 150 chars)';

  @override
  String get adminProductsFullDescLabel => 'Full Description *';

  @override
  String get adminProductsFullDescHint => 'Detailed product description';

  @override
  String get adminProductsCategorySellerSection => 'Category & Seller';

  @override
  String get adminProductsCategoryLabel => 'Category *';

  @override
  String get adminProductsSellerLabel => 'Seller *';

  @override
  String get adminProductsSelectSeller => 'Select seller';

  @override
  String adminProductsErrorLoadingSellers(String error) {
    return 'Error loading sellers: $error';
  }

  @override
  String get adminProductsPricingSection => 'Pricing';

  @override
  String get adminProductsPriceLabel => 'Price (USD) *';

  @override
  String get adminProductsInvalid => 'Invalid';

  @override
  String get adminProductsComparePriceLabel => 'Compare at Price';

  @override
  String get adminProductsComparePriceHint => 'Original price for sale';

  @override
  String get adminProductsPurchaseLinkSection => 'Purchase Link';

  @override
  String get adminProductsPurchaseUrlLabel => 'Purchase URL';

  @override
  String get adminProductsTechSpecsSection => 'Technical Specifications';

  @override
  String get adminProductsChipsetLabel => 'Chipset';

  @override
  String get adminProductsChipsetHint => 'e.g., ESP32-S3';

  @override
  String get adminProductsLoraChipLabel => 'LoRa Chip';

  @override
  String get adminProductsLoraChipHint => 'e.g., SX1262';

  @override
  String get adminProductsBatteryLabel => 'Battery Capacity';

  @override
  String get adminProductsBatteryHint => 'e.g., 4000mAh';

  @override
  String get adminProductsWeightLabel => 'Weight';

  @override
  String get adminProductsWeightHint => 'e.g., 50g';

  @override
  String get adminProductsGps => 'GPS';

  @override
  String get adminProductsWifi => 'WiFi';

  @override
  String get adminProductsBluetooth => 'Bluetooth';

  @override
  String get adminProductsDisplay => 'Display';

  @override
  String get adminProductsFrequencyBandsSection => 'Frequency Bands';

  @override
  String get adminProductsPhysicalSpecsSection => 'Physical Specifications';

  @override
  String get adminProductsDimensionsLabel => 'Dimensions';

  @override
  String get adminProductsDimensionsHint => 'e.g., 100x50x25mm';

  @override
  String get adminProductsTagsSection => 'Tags';

  @override
  String get adminProductsTagsLabel => 'Tags';

  @override
  String get adminProductsTagsHint => 'meshtastic, lora, gps (comma separated)';

  @override
  String get adminProductsStockSection => 'Stock & Status';

  @override
  String get adminProductsStockLabel => 'Stock Quantity';

  @override
  String get adminProductsStockHint => 'Leave empty for unlimited';

  @override
  String get adminProductsInStock => 'In Stock';

  @override
  String get adminProductsFeatured => 'Featured';

  @override
  String get adminProductsFeaturedSubtitle =>
      'Show in featured products section';

  @override
  String get adminProductsFeaturedOrderLabel => 'Featured Order';

  @override
  String get adminProductsFeaturedOrderHint =>
      'Lower numbers appear first (0 = top)';

  @override
  String get adminProductsFeaturedOrderHelper =>
      'Controls display order in featured section';

  @override
  String get adminProductsActive => 'Active';

  @override
  String get adminProductsActiveSubtitle => 'Product is visible in the shop';

  @override
  String get adminProductsVendorVerificationSection => 'Vendor Verification';

  @override
  String get adminProductsVendorVerifiedTitle => 'Vendor Verified Specs';

  @override
  String get adminProductsVendorVerifiedSubtitle =>
      'Specifications have been verified by the vendor';

  @override
  String get adminProductsVendorUnverifiedSubtitle =>
      'Mark when vendor confirms all specs are accurate';

  @override
  String get adminProductsSaveChanges => 'Save Changes';

  @override
  String get adminProductsCreate => 'Create Product';

  @override
  String get adminProductsMainImage => 'Main';

  @override
  String get adminProductsUploading => 'Uploading...';

  @override
  String get adminProductsAddImage => 'Add Image';

  @override
  String get adminProductsImageRequired => 'At least one image is required';

  @override
  String get adminProductsImageWarning => 'Please add at least one image';

  @override
  String get adminProductsSelectSellerWarning => 'Please select a seller';

  @override
  String get adminProductsUpdated => 'Product updated';

  @override
  String get adminProductsCreated => 'Product created';

  @override
  String get adminProductsDeleteConfirmTitle => 'Delete Product';

  @override
  String get adminProductsDeleteConfirmMessage =>
      'Are you sure you want to permanently delete this product?';

  @override
  String get adminProductsDeletedSuccess => 'Product deleted';

  @override
  String get adminSellersTitle => 'Manage Sellers';

  @override
  String get adminSellersHideInactive => 'Hide inactive';

  @override
  String get adminSellersShowInactive => 'Show inactive';

  @override
  String get adminSellersAddTooltip => 'Add Seller';

  @override
  String get adminSellersSearchHint => 'Search sellers...';

  @override
  String get adminSellersNotFound => 'No sellers found';

  @override
  String get adminSellersInactiveBadge => 'INACTIVE';

  @override
  String get adminSellersPartnerBadge => 'PARTNER';

  @override
  String get adminSellersVerifiedBadge => 'VERIFIED';

  @override
  String get adminSellersEdit => 'Edit';

  @override
  String get adminSellersDeactivate => 'Deactivate';

  @override
  String get adminSellersActivate => 'Activate';

  @override
  String get adminSellersEditTitle => 'Edit Seller';

  @override
  String get adminSellersAddTitle => 'Add Seller';

  @override
  String get adminSellersDeleteTooltip => 'Delete Seller';

  @override
  String get adminSellersLogoSection => 'Seller Logo';

  @override
  String get adminSellersBasicInfoSection => 'Basic Information';

  @override
  String get adminSellersNameLabel => 'Seller Name *';

  @override
  String get adminSellersNameHint => 'e.g., LilyGO, RAK Wireless';

  @override
  String get adminSellersDescriptionLabel => 'Description';

  @override
  String get adminSellersDescriptionHint => 'Brief description of the seller';

  @override
  String get adminSellersContactInfoSection => 'Contact Information';

  @override
  String get adminSellersWebsiteLabel => 'Website URL *';

  @override
  String get adminSellersEmailLabel => 'Contact Email';

  @override
  String get adminSellersEmailHint => 'support@example.com';

  @override
  String get adminSellersShippingSection => 'Shipping Countries';

  @override
  String get adminSellersCountriesLabel => 'Countries';

  @override
  String get adminSellersCountriesHint => 'US, CA, UK, DE (comma separated)';

  @override
  String get adminSellersDiscountSection => 'Partner Discount Code';

  @override
  String get adminSellersStatusSection => 'Status & Verification';

  @override
  String get adminSellersVerifiedToggle => 'Verified';

  @override
  String get adminSellersVerifiedSubtitle =>
      'Seller identity has been verified';

  @override
  String get adminSellersOfficialPartner => 'Official Partner';

  @override
  String get adminSellersOfficialPartnerSubtitle =>
      'Display as official Meshtastic partner';

  @override
  String get adminSellersActive => 'Active';

  @override
  String get adminSellersActiveSubtitle => 'Seller is visible in the shop';

  @override
  String get adminSellersSaveChanges => 'Save Changes';

  @override
  String get adminSellersCreate => 'Create Seller';

  @override
  String get adminSellersDangerZone => 'Danger Zone';

  @override
  String get adminSellersDeleteTitle => 'Delete Seller';

  @override
  String get adminSellersDeleteDescription =>
      'Permanently delete this seller and deactivate all their products. This action cannot be undone.';

  @override
  String get adminSellersDeletePermanently => 'Delete Seller Permanently';

  @override
  String get adminSellersDiscountCodeLabel => 'Discount Code';

  @override
  String get adminSellersDiscountCodeHint => 'e.g., MESH10';

  @override
  String get adminSellersDiscountDisplayLabel => 'Display Label';

  @override
  String get adminSellersDiscountDisplayHint =>
      'e.g., 10% off for Socialmesh users';

  @override
  String get adminSellersDiscountExpiryLabel => 'Expiry Date (optional)';

  @override
  String get adminSellersDiscountNoExpiry => 'No expiry';

  @override
  String get adminSellersDiscountTermsLabel => 'Terms & Conditions';

  @override
  String get adminSellersDiscountTermsHint =>
      'e.g., Cannot be combined with other offers';

  @override
  String get adminSellersClearDiscount => 'Clear Discount Code';

  @override
  String get adminSellersDiscountExpired => 'Discount code has expired';

  @override
  String get adminSellersUploading => 'Uploading...';

  @override
  String get adminSellersUploadLogo => 'Upload Logo';

  @override
  String get adminSellersRemoveLogo => 'Remove';

  @override
  String get adminSellersUpdated => 'Seller updated';

  @override
  String get adminSellersCreated => 'Seller created';

  @override
  String get adminSellersDeleteDialogTitle => 'Delete Seller';

  @override
  String adminSellersDeleteDialogMessage(String name) {
    return 'Are you sure you want to permanently delete \"$name\"?';
  }

  @override
  String adminSellersDeleteProductWarning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count products will be deactivated.',
      one: '1 product will be deactivated.',
    );
    return '$_temp0';
  }

  @override
  String get adminSellersDeleteUndoWarning => 'This action cannot be undone.';

  @override
  String get adminSellersCancel => 'Cancel';

  @override
  String get adminSellersDeleteConfirm => 'Delete';

  @override
  String get adminSellersDeleted => 'Seller deleted';

  @override
  String get sellerProfileTitle => 'Seller';

  @override
  String get sellerProfileErrorLoading => 'Error loading seller';

  @override
  String get sellerProfileGoBack => 'Go Back';

  @override
  String get sellerProfileNotFound => 'Seller not found';

  @override
  String get sellerProfileSearchHint => 'Search products...';

  @override
  String sellerProfileProductsCount(int count) {
    return 'Products ($count)';
  }

  @override
  String get sellerProfileUnableToLoad => 'Unable to load products';

  @override
  String get sellerProfileNoProducts => 'No products listed yet';

  @override
  String sellerProfileNoSearchResults(String query) {
    return 'No products match \"$query\"';
  }

  @override
  String get sellerProfileOfficialPartner => 'Official Partner';

  @override
  String sellerProfileReviewCount(int count) {
    return '$count reviews';
  }

  @override
  String get sellerProfileProductsStat => 'Products';

  @override
  String get sellerProfileSalesStat => 'Sales';

  @override
  String get sellerProfileFoundedStat => 'Founded';

  @override
  String get sellerProfileAbout => 'About';

  @override
  String get sellerProfileContactShipping => 'Contact & Shipping';

  @override
  String get sellerProfileWebsite => 'Website';

  @override
  String get sellerProfileEmail => 'Email';

  @override
  String get sellerProfileShipsTo => 'Ships to';

  @override
  String get sellerProfilePartnerDiscount => 'Partner Discount';

  @override
  String get sellerProfileDiscountExclusive =>
      'Exclusive discount code for Socialmesh users';

  @override
  String get sellerProfileRevealCode => 'Reveal Code';

  @override
  String get sellerProfileCodeCopied => 'Code copied to clipboard';

  @override
  String get sellerProfileApplyCodeHint =>
      'Apply this code at checkout on the seller\'s store';

  @override
  String get shopAdminDashboardAccessDenied => 'Access Denied';

  @override
  String get shopAdminDashboardAccessRequired => 'Admin Access Required';

  @override
  String get shopAdminDashboardNoPermission =>
      'You do not have permission to access this area.';

  @override
  String get shopAdminDashboardTitle => 'Shop Admin';

  @override
  String get shopAdminDashboardError => 'Error';

  @override
  String get shopAdminDashboardRefresh => 'Refresh';

  @override
  String get shopAdminDashboardQuickActions => 'Quick Actions';

  @override
  String get shopAdminDashboardManagement => 'Management';

  @override
  String get shopAdminDashboardTotalProducts => 'Total Products';

  @override
  String shopAdminDashboardActiveCount(int count) {
    return '$count active';
  }

  @override
  String get shopAdminDashboardTotalSellers => 'Total Sellers';

  @override
  String get shopAdminDashboardTotalSales => 'Total Sales';

  @override
  String get shopAdminDashboardTotalViews => 'Total Views';

  @override
  String get shopAdminDashboardReviews => 'Reviews';

  @override
  String get shopAdminDashboardEstRevenue => 'Est. Revenue';

  @override
  String get shopAdminDashboardOutOfStock => 'Out of Stock';

  @override
  String get shopAdminDashboardInactive => 'Inactive';

  @override
  String get shopAdminDashboardAddProduct => 'Add Product';

  @override
  String get shopAdminDashboardAddSeller => 'Add Seller';

  @override
  String get shopAdminDashboardProducts => 'Products';

  @override
  String get shopAdminDashboardProductsSubtitle =>
      'Manage all product listings';

  @override
  String get shopAdminDashboardSellers => 'Sellers';

  @override
  String get shopAdminDashboardSellersSubtitle =>
      'Manage seller profiles and partnerships';

  @override
  String get shopAdminDashboardFeatured => 'Featured Products';

  @override
  String get shopAdminDashboardFeaturedSubtitle =>
      'Manage featured product display order';

  @override
  String get shopAdminDashboardReviewsMgmt => 'Reviews';

  @override
  String get shopAdminDashboardReviewsSubtitle => 'Moderate product reviews';

  @override
  String get reviewModerationTitle => 'Review Management';

  @override
  String get reviewModerationPending => 'Pending';

  @override
  String get reviewModerationAllReviews => 'All Reviews';

  @override
  String get reviewModerationErrorLoading => 'Error loading reviews';

  @override
  String get reviewModerationAllCaughtUp => 'All caught up!';

  @override
  String get reviewModerationNoReviews => 'No reviews yet';

  @override
  String get reviewModerationNoPending => 'No pending reviews to moderate';

  @override
  String get reviewModerationNoDatabase => 'No reviews in database';

  @override
  String get reviewModerationApproved => 'Review approved';

  @override
  String get reviewModerationRejectTitle => 'Reject Review';

  @override
  String get reviewModerationRejectReasonLabel => 'Reason for rejection';

  @override
  String get reviewModerationRejectReasonHint =>
      'e.g., Inappropriate content, spam, etc.';

  @override
  String get reviewModerationCancel => 'Cancel';

  @override
  String get reviewModerationReject => 'Reject';

  @override
  String get reviewModerationRejected => 'Review rejected';

  @override
  String get reviewModerationDeleteTitle => 'Delete Review';

  @override
  String get reviewModerationDeleteMessage =>
      'Are you sure you want to permanently delete this review?';

  @override
  String get reviewModerationDelete => 'Delete';

  @override
  String get reviewModerationDeleted => 'Review deleted';

  @override
  String get reviewModerationAnonymous => 'Anonymous';

  @override
  String get reviewModerationVerified => 'Verified';

  @override
  String get reviewModerationApprove => 'Approve';

  @override
  String get reviewModerationLegacy => 'Legacy (no status)';

  @override
  String get categoryProductsFilter => 'Filter';

  @override
  String get categoryProductsSortPopular => 'Most Popular';

  @override
  String get categoryProductsSortNewest => 'Newest First';

  @override
  String get categoryProductsSortPriceLow => 'Price: Low to High';

  @override
  String get categoryProductsSortPriceHigh => 'Price: High to Low';

  @override
  String get categoryProductsSortRating => 'Highest Rated';

  @override
  String get categoryProductsErrorLoading => 'Error loading products';

  @override
  String get categoryProductsRetry => 'Retry';

  @override
  String get categoryProductsNotFound => 'No products found';

  @override
  String get categoryProductsTryFilters => 'Try adjusting your filters';

  @override
  String get categoryProductsClearFilters => 'Clear Filters';

  @override
  String categoryProductsResultCount(int count) {
    return '$count products';
  }

  @override
  String get categoryProductsFiltersTitle => 'Filters';

  @override
  String get categoryProductsReset => 'Reset';

  @override
  String get categoryProductsInStockOnly => 'In Stock Only';

  @override
  String get categoryProductsPriceRange => 'Price Range';

  @override
  String get categoryProductsFrequencyBands => 'Frequency Bands';

  @override
  String get categoryProductsApplyFilters => 'Apply Filters';

  @override
  String get categoryProductsOutOfStock => 'OUT OF STOCK';

  @override
  String get featuredProductsTitle => 'Featured Products';

  @override
  String get featuredProductsSave => 'Save';

  @override
  String get featuredProductsReorderInfo =>
      'Drag and drop products to reorder. Products at the top will appear first in the featured section.';

  @override
  String get featuredProductsEmpty => 'No featured products';

  @override
  String get featuredProductsEmptySubtitle =>
      'Mark products as featured to manage their order here';

  @override
  String get featuredProductsUnsavedChanges => 'You have unsaved changes';

  @override
  String get featuredProductsDiscard => 'Discard';

  @override
  String get featuredProductsOrderUpdated => 'Featured order updated';

  @override
  String get featuredProductsRemoveTitle => 'Remove from Featured';

  @override
  String featuredProductsRemoveMessage(String name) {
    return 'Remove \"$name\" from featured products?';
  }

  @override
  String get featuredProductsRemove => 'Remove';

  @override
  String get featuredProductsRemoved => 'Removed from featured';

  @override
  String get featuredProductsRemoveTooltip => 'Remove from featured';

  @override
  String get searchProductsHint => 'Search devices, modules, antennas...';

  @override
  String get searchProductsRecentSearches => 'Recent Searches';

  @override
  String get searchProductsClear => 'Clear';

  @override
  String get searchProductsTrending => 'Trending';

  @override
  String get searchProductsBrowseByCategory => 'Browse by Category';

  @override
  String get searchProductsSearchFailed => 'Search failed';

  @override
  String get searchProductsRetry => 'Retry';

  @override
  String searchProductsNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get searchProductsTryDifferent =>
      'Try different keywords or browse categories';

  @override
  String searchProductsResultCount(int count, String query) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results for \"$query\"',
      one: '1 result for \"$query\"',
    );
    return '$_temp0';
  }

  @override
  String get searchProductsOutOfStock => 'Out of Stock';

  @override
  String get shopFavoritesTitle => 'Favorites';

  @override
  String get shopFavoritesSignIn => 'Sign in to save favorites';

  @override
  String get shopFavoritesSignInSubtitle =>
      'Your favorite devices will appear here';

  @override
  String get shopFavoritesErrorLoading => 'Error loading favorites';

  @override
  String get shopFavoritesRetry => 'Retry';

  @override
  String get shopFavoritesEmpty => 'No favorites yet';

  @override
  String get shopFavoritesEmptySubtitle =>
      'Tap the heart icon on products to save them';

  @override
  String get shopFavoritesUnableToLoad => 'Unable to load product';

  @override
  String get shopFavoritesProductRemoved => 'Product no longer available';

  @override
  String get shopFavoritesInStock => 'In Stock';

  @override
  String get shopFavoritesOutOfStock => 'Out of Stock';

  @override
  String get channelsSearchHint => 'Search channels';

  @override
  String get channelsFilterAll => 'All';

  @override
  String get channelsFilterPrimary => 'Primary';

  @override
  String get channelsFilterEncrypted => 'Encrypted';

  @override
  String get channelsFilterPosition => 'Position';

  @override
  String get channelsFilterMqtt => 'MQTT';

  @override
  String channelsNoMatch(String query) {
    return 'No channels match \"$query\"';
  }

  @override
  String get channelsEmpty => 'No channels configured';

  @override
  String get channelsEmptySubtitle =>
      'Channels are still being loaded from device\nor use the icons above to add channels';

  @override
  String get channelsClearSearch => 'Clear search';

  @override
  String channelsScreenTitle(int count) {
    return 'Channels ($count)';
  }

  @override
  String get channelsMenuAddChannel => 'Add Channel';

  @override
  String get channelsMenuScanQrCode => 'Scan QR Code';

  @override
  String get channelsMenuSettings => 'Settings';

  @override
  String get channelsMenuHelp => 'Help';

  @override
  String get channelsPrimaryChannelName => 'Primary Channel';

  @override
  String channelsDefaultChannelName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelsTileEncrypted => 'Encrypted';

  @override
  String get channelsTileNoEncryption => 'No encryption';

  @override
  String get channelsTilePrimaryBadge => 'PRIMARY';

  @override
  String get channelsUnreadOverflow => '99+';

  @override
  String get channelFormKeySizeNone => 'No Encryption';

  @override
  String get channelFormKeySizeDefault => 'Default (Simple)';

  @override
  String get channelFormKeySizeAes128 => 'AES-128';

  @override
  String get channelFormKeySizeAes256 => 'AES-256';

  @override
  String get channelFormInvalidBase64 => 'Invalid base64 encoding';

  @override
  String channelFormInvalidKeySize(int byteCount) {
    return 'Invalid key size ($byteCount bytes). Use 1, 16, or 32 bytes.';
  }

  @override
  String get channelFormKeyEmpty => 'Key cannot be empty';

  @override
  String get channelFormDeviceNotConnected =>
      'Cannot save channel: Device not connected';

  @override
  String get channelFormMaxChannelsReached => 'Maximum 8 channels allowed';

  @override
  String get channelFormDeviceNotReady =>
      'Device not ready - please wait for connection';

  @override
  String channelFormDefaultName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelFormUpdatedSnackbar => 'Channel updated';

  @override
  String get channelFormCreatedSnackbar => 'Channel created';

  @override
  String channelFormError(String error) {
    return 'Error: $error';
  }

  @override
  String get channelFormEditTitle => 'Edit Channel';

  @override
  String get channelFormNewTitle => 'New Channel';

  @override
  String get channelFormSaveButton => 'Save';

  @override
  String get channelFormEncryptionLabel => 'Encryption';

  @override
  String get channelFormPositionLabel => 'Position';

  @override
  String get channelFormMqttLabel => 'MQTT';

  @override
  String get channelFormNameTitle => 'Channel Name';

  @override
  String get channelFormNameMaxHint => 'Max 11 characters';

  @override
  String get channelFormNameHint => 'Enter channel name (no spaces)';

  @override
  String get channelFormKeySizeNoneDesc => 'Messages sent in plaintext';

  @override
  String get channelFormKeySizeDefaultDesc => '1-byte simple key (AQ==)';

  @override
  String channelFormKeySizeBitDesc(int bits) {
    return '$bits-bit encryption key';
  }

  @override
  String get channelFormPositionEnabledTitle => 'Positions Enabled';

  @override
  String get channelFormPositionEnabledSubtitle =>
      'Share position on this channel';

  @override
  String get channelFormUplinkTitle => 'Uplink Enabled';

  @override
  String get channelFormUplinkSubtitle => 'Forward messages to MQTT server';

  @override
  String get channelFormDownlinkTitle => 'Downlink Enabled';

  @override
  String get channelFormDownlinkSubtitle => 'Receive messages from MQTT server';

  @override
  String get channelFormMqttWarning =>
      'Most devices have very limited processing power and RAM. Bridging a busy channel like LongFast via the default MQTT server can flood the device with 15-25 packets per second, causing it to stop responding. Consider using a private broker or a quieter channel.';

  @override
  String get channelFormPrecision12 => 'Within 5.8 km';

  @override
  String get channelFormPrecision13 => 'Within 2.9 km';

  @override
  String get channelFormPrecision14 => 'Within 1.5 km';

  @override
  String get channelFormPrecision15 => 'Within 700 m';

  @override
  String get channelFormPrecision32 => 'Precise location';

  @override
  String get channelFormPrecisionUnknown => 'Unknown';

  @override
  String get channelFormPreciseLocationTitle => 'Precise Location';

  @override
  String get channelFormPreciseLocationSubtitle =>
      'Share exact GPS coordinates';

  @override
  String get channelFormApproxLocationTitle => 'Approximate Location';

  @override
  String get channelFormPrimaryChannelTitle => 'Primary Channel';

  @override
  String get channelFormPrimaryChannelNote =>
      'This is the main channel for device communication. Changes may affect connectivity.';

  @override
  String get channelWizardStepNameTitle => 'Channel Name';

  @override
  String get channelWizardStepNameContent =>
      'Choose a memorable name for your channel.\n\n• Names are limited to 12 characters\n• Only letters and numbers allowed\n• The name is visible to anyone who joins\n• Pick something descriptive like \"Family\" or \"Hiking\"';

  @override
  String get channelWizardStepPrivacyTitle => 'Privacy Level';

  @override
  String get channelWizardStepPrivacyContent =>
      'Select how secure your channel should be.\n\n• OPEN: No encryption - anyone can read messages\n• SHARED: Uses the default Meshtastic key - not private\n• PRIVATE (Recommended): Unique AES-128 key - secure\n• MAXIMUM: AES-256 encryption - highest security\n\nHigher security requires sharing your channel key with others.';

  @override
  String get channelWizardStepOptionsTitle => 'Advanced Options';

  @override
  String get channelWizardStepOptionsContent =>
      'Configure optional channel settings.\n\n• Position Sharing: Allow location sharing on this channel\n• MQTT Uplink: Send messages to the internet (requires MQTT setup)\n• MQTT Downlink: Receive messages from the internet\n• Encryption Key: Auto-generated, but you can paste a custom key\n\nMost users can skip these advanced options.';

  @override
  String get channelWizardStepReviewTitle => 'Review & Create';

  @override
  String get channelWizardStepReviewContent =>
      'Review your channel settings before creating.\n\n• Verify the name and privacy level are correct\n• After creation, share the QR code with others\n• Others scan the QR code to join your channel\n• You can also copy the URL to share via text';

  @override
  String get channelWizardKeySizeNone => 'None';

  @override
  String get channelWizardKeySizeNoneDesc =>
      'No encryption - messages are sent in plain text';

  @override
  String get channelWizardKeySizeDefault => 'Default';

  @override
  String get channelWizardKeySizeDefaultDesc =>
      'Simple shared key - compatible but not secure';

  @override
  String get channelWizardKeySizeAes128 => 'AES-128';

  @override
  String get channelWizardKeySizeAes128Desc =>
      'Strong encryption - recommended for most uses';

  @override
  String get channelWizardKeySizeAes256 => 'AES-256';

  @override
  String get channelWizardKeySizeAes256Desc =>
      'Maximum encryption - highest security';

  @override
  String get channelWizardPrivacyOpenTitle => 'Open Channel';

  @override
  String get channelWizardPrivacySharedTitle => 'Shared Channel';

  @override
  String get channelWizardPrivacyPrivateTitle => 'Private Channel';

  @override
  String get channelWizardPrivacyMaxTitle => 'Maximum Security';

  @override
  String get channelWizardPrivacyOpenDesc =>
      'No encryption. Anyone with a compatible radio can read your messages. Use only for public broadcasts.';

  @override
  String get channelWizardPrivacySharedDesc =>
      'Uses the well-known default key. Other Meshtastic users may be able to read messages. Good for community channels.';

  @override
  String get channelWizardPrivacyPrivateDesc =>
      'AES-128 encryption with a random key. Only people you share the QR code with can join. Recommended for most uses.';

  @override
  String get channelWizardPrivacyMaxDesc =>
      'AES-256 encryption for maximum security. Ideal for sensitive communications. Slightly higher battery usage.';

  @override
  String get channelWizardRadioComplianceLink => 'View Radio Compliance Rules';

  @override
  String get channelWizardDeviceNotConnected =>
      'Cannot save channel: Device not connected';

  @override
  String channelWizardCreateFailed(String error) {
    return 'Failed to create channel: $error';
  }

  @override
  String get channelWizardScreenTitle => 'Create Channel';

  @override
  String get channelWizardHelpTooltip => 'Help';

  @override
  String get channelWizardNameHeading => 'Name Your Channel';

  @override
  String get channelWizardNameSubtitle =>
      'Choose a name that helps you identify this channel. It will be visible to anyone who joins.';

  @override
  String get channelWizardNameLabel => 'Channel Name';

  @override
  String get channelWizardNameHint => 'e.g., Family, Friends, Hiking';

  @override
  String get channelWizardNameBannerInfo =>
      'Channel names are limited to 12 alphanumeric characters.';

  @override
  String get channelWizardPrivacyHeading => 'Choose Privacy Level';

  @override
  String get channelWizardPrivacySubtitle =>
      'Select how secure you want this channel to be. Higher security uses stronger encryption.';

  @override
  String get channelWizardCompatOpen =>
      'Compatible with all devices. No key exchange needed.';

  @override
  String get channelWizardCompatShared =>
      'Uses the default Meshtastic key. Other users with default settings may intercept messages.';

  @override
  String get channelWizardCompatPrivate =>
      'Recommended. Share the QR code securely with people you want to communicate with.';

  @override
  String get channelWizardCompatMax =>
      'Highest security. Ensure all participants support AES-256 encryption.';

  @override
  String get channelWizardOptionsHeading => 'Advanced Options';

  @override
  String get channelWizardOptionsSubtitle =>
      'Configure optional channel settings.';

  @override
  String get channelWizardPositionTitle => 'Position Enabled';

  @override
  String get channelWizardPositionSubtitle =>
      'Share your position on this channel.';

  @override
  String get channelWizardMqttHeader => 'MQTT Settings';

  @override
  String get channelWizardUplinkTitle => 'Uplink Enabled';

  @override
  String get channelWizardUplinkSubtitle =>
      'Send messages from this channel to MQTT when connected to the internet.';

  @override
  String get channelWizardDownlinkTitle => 'Downlink Enabled';

  @override
  String get channelWizardDownlinkSubtitle =>
      'Receive messages from MQTT and broadcast them on this channel.';

  @override
  String get channelWizardMqttWarning =>
      'MQTT must be configured on your device for uplink/downlink to work.';

  @override
  String get channelWizardMqttFloodWarning =>
      'Most devices have very limited processing power and RAM. Bridging a busy channel like LongFast via the default MQTT server can flood the device with 15-25 packets per second, causing it to stop responding. Consider using a private broker or a quieter channel.';

  @override
  String get channelWizardCreating => 'Creating channel...';

  @override
  String get channelWizardCreatedHeading => 'Channel Created!';

  @override
  String get channelWizardCreatedSubtitle =>
      'Share this QR code with others to let them join.';

  @override
  String get channelWizardSummaryName => 'Name';

  @override
  String get channelWizardSummaryPrivacy => 'Privacy';

  @override
  String get channelWizardSummaryEncryption => 'Encryption';

  @override
  String get channelWizardUrlCopied => 'Channel URL copied to clipboard';

  @override
  String get channelWizardCopyUrlButton => 'Copy URL';

  @override
  String get channelWizardDoneButton => 'Done';

  @override
  String get channelWizardReviewHeading => 'Review & Create';

  @override
  String get channelWizardReviewSubtitle =>
      'Review your channel settings before creating.';

  @override
  String get channelWizardReviewName => 'Name';

  @override
  String get channelWizardReviewPrivacyLevel => 'Privacy Level';

  @override
  String get channelWizardReviewEncryption => 'Encryption';

  @override
  String get channelWizardReviewKeySize => 'Key Size';

  @override
  String get channelWizardNoKey => 'No key';

  @override
  String get channelWizardDefaultKey => 'Default key';

  @override
  String channelWizardKeyBits(int bits) {
    return '$bits bits';
  }

  @override
  String get channelWizardEncryptionKeyLabel => 'Encryption Key';

  @override
  String get channelWizardReviewMqttUplink => 'MQTT Uplink';

  @override
  String get channelWizardEnabled => 'Enabled';

  @override
  String get channelWizardDisabled => 'Disabled';

  @override
  String get channelWizardReviewMqttDownlink => 'MQTT Downlink';

  @override
  String get channelWizardReviewPositionSharing => 'Position Sharing';

  @override
  String get channelWizardBackButton => 'Back';

  @override
  String get channelWizardCreateButton => 'Create Channel';

  @override
  String get channelWizardContinueButton => 'Continue';

  @override
  String channelOptionsDefaultName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelOptionsEdit => 'Edit Channel';

  @override
  String get channelOptionsViewKey => 'View Encryption Key';

  @override
  String get channelOptionsShare => 'Share Channel';

  @override
  String get channelOptionsInviteLink => 'Share Invite Link';

  @override
  String get channelOptionsDelete => 'Delete Channel';

  @override
  String get channelOptionsEncrypted => 'Encrypted';

  @override
  String get channelOptionsNoEncryption => 'No encryption';

  @override
  String get channelOptionsDeleteNotConnected =>
      'Cannot delete channel: Device not connected';

  @override
  String get channelOptionsDeleteTitle => 'Delete Channel';

  @override
  String channelOptionsDeleteConfirm(String name) {
    return 'Delete channel \"$name\"?';
  }

  @override
  String get channelOptionsDeleteButton => 'Delete';

  @override
  String channelOptionsDeleteFailed(String error) {
    return 'Failed to delete channel: $error';
  }

  @override
  String get channelOptionsKeyTitle => 'Encryption Key';

  @override
  String channelOptionsKeySubtitle(int keyBits, int keyBytes) {
    return '$keyBits-bit · $keyBytes bytes · Base64';
  }

  @override
  String get channelOptionsHideButton => 'Hide';

  @override
  String get channelOptionsShowButton => 'Show';

  @override
  String get channelOptionsKeyCopied => 'Key copied to clipboard';

  @override
  String get channelOptionsCopyButton => 'Copy';

  @override
  String get channelShareSignInRequired => 'Sign in to share channels';

  @override
  String get channelShareSignInAction => 'Sign In';

  @override
  String channelShareDefaultName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelShareTitle => 'Share Channel';

  @override
  String get channelShareQrInfo =>
      'Scan this QR code in Socialmesh to import this channel';

  @override
  String channelShareSubject(String channelName) {
    return 'Socialmesh Channel: $channelName';
  }

  @override
  String get channelShareMessage => 'Join my channel on Socialmesh!';

  @override
  String get channelShareCreatingInvite => 'Creating invite link...';

  @override
  String get channelShareInviteCopied => 'Invite link copied to clipboard';

  @override
  String get channelShareInviteFailed => 'Failed to create invite link';

  @override
  String get routesScreenTitle => 'Routes';

  @override
  String get routesStartRoute => 'Start Route';

  @override
  String get routesImportGpx => 'Import GPX';

  @override
  String get routesEmptyTitle => 'No Routes Yet';

  @override
  String get routesEmptyDescription =>
      'Record your first route or import a GPX file';

  @override
  String get routesDeleteConfirmTitle => 'Delete Route?';

  @override
  String routesDeleteConfirmMessage(String name) {
    return 'Are you sure you want to delete \"$name\"? This cannot be undone.';
  }

  @override
  String get routesDeleteConfirmAction => 'Delete';

  @override
  String routesShareText(String name) {
    return 'Route: $name';
  }

  @override
  String routesExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get routesFileReadFailed => 'Failed to read file';

  @override
  String routesImportSuccess(String name) {
    return 'Imported: $name';
  }

  @override
  String get routesInvalidGpxFile => 'Invalid GPX file';

  @override
  String routesImportFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get routesRecordingLabel => 'Recording';

  @override
  String routesPointCount(int count) {
    return '$count points';
  }

  @override
  String routesDistanceDuration(String distance, String duration) {
    return '$distance • $duration';
  }

  @override
  String get routesCancelRecording => 'Cancel';

  @override
  String get routesStopRecording => 'Stop';

  @override
  String routesDistanceMeters(String meters) {
    return '${meters}m';
  }

  @override
  String routesDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String routesDurationSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String routesDurationMinutesSeconds(int minutes, int seconds) {
    return '${minutes}m ${seconds}s';
  }

  @override
  String routesDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get routesExportGpx => 'Export GPX';

  @override
  String get routesDeleteAction => 'Delete';

  @override
  String routesElevationGain(String meters) {
    return '${meters}m ↑';
  }

  @override
  String routesPointsShort(int count) {
    return '$count pts';
  }

  @override
  String routesCardDurationMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String routesCardDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get routesNewRouteTitle => 'New Route';

  @override
  String get routesNewRouteSubtitle => 'Start recording your GPS track';

  @override
  String get routesRouteNameLabel => 'Route Name';

  @override
  String get routesRouteNameHint => 'Morning hike';

  @override
  String get routesNotesLabel => 'Notes (optional)';

  @override
  String get routesNotesHint => 'Trail conditions, weather, etc.';

  @override
  String get routesColorLabel => 'Color';

  @override
  String get routesCancel => 'Cancel';

  @override
  String get routesStart => 'Start';

  @override
  String get routeDetailNoGpsPoints => 'No GPS Points';

  @override
  String get routeDetailDistanceLabel => 'Distance';

  @override
  String get routeDetailDurationLabel => 'Duration';

  @override
  String get routeDetailNoData => '--';

  @override
  String get routeDetailElevationLabel => 'Elevation';

  @override
  String routeDetailElevationValue(String meters) {
    return '${meters}m';
  }

  @override
  String get routeDetailPointsLabel => 'Points';

  @override
  String get routeDetailStorageUnavailable => 'Storage not available';

  @override
  String routeDetailShareText(String name) {
    return 'Route: $name';
  }

  @override
  String routeDetailExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String routeDetailDistanceMeters(String meters) {
    return '${meters}m';
  }

  @override
  String routeDetailDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String routeDetailDurationMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String routeDetailDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get routeDetailYouBadge => 'You';

  @override
  String get routeDetailCenterOnNodeTooltip => 'Center on node';

  @override
  String get globeScreenTitle => 'Mesh Globe';

  @override
  String get globeHideConnections => 'Hide connections';

  @override
  String get globeShowConnections => 'Show connections';

  @override
  String get globeResetView => 'Reset view';

  @override
  String get globeHelp => 'Help';

  @override
  String get globeSelectNode => 'Select Node';

  @override
  String globeNodeCount(int count) {
    return '$count nodes';
  }

  @override
  String get globeEmptyTitle => 'No nodes with GPS';

  @override
  String get globeEmptyDescription =>
      'Nodes with position data will appear here';

  @override
  String get reachabilityScreenTitle => 'Reachability';

  @override
  String get reachabilityBetaBadge => 'BETA';

  @override
  String get reachabilityAboutTooltip => 'About Reachability';

  @override
  String get reachabilityAboutTitle => 'About Reachability';

  @override
  String get reachabilityGotIt => 'Got it';

  @override
  String get reachabilityWhatIsThisTitle => 'What is this?';

  @override
  String get reachabilityWhatIsThisContent =>
      'This screen shows a probabilistic estimate of how likely your messages will reach each node. It is NOT a guarantee of delivery.';

  @override
  String get reachabilityScoringModelTitle => 'Scoring Model';

  @override
  String get reachabilityScoringModelContent =>
      'Opportunistic Mesh Reach Likelihood Model (v1) — BETA\n\nA heuristic scoring model that estimates likelihood of reaching a node based on observed RF metrics and packet history. This score represents likelihood, not reachability. Meshtastic forwards packets opportunistically without routing. A high score does not guarantee delivery.';

  @override
  String get reachabilityHowCalculatedTitle => 'How is it calculated?';

  @override
  String get reachabilityHowCalculatedContent =>
      'The likelihood score combines several factors:\n• Freshness: How recently we heard from the node\n• Path Depth: Number of hops observed\n• Signal Quality: RSSI and SNR when available\n• Observation Pattern: Direct vs relayed packets\n• ACK History: DM acknowledgement success rate';

  @override
  String get reachabilityLevelsMeanTitle => 'What the levels mean';

  @override
  String get reachabilityLevelsMeanContent =>
      '• High: Strong recent indicators, but not guaranteed\n• Medium: Moderate confidence based on available data\n• Low: Weak or stale indicators, delivery unlikely';

  @override
  String get reachabilityLimitationsTitle => 'Important limitations';

  @override
  String get reachabilityLimitationsContent =>
      '• Meshtastic has no true routing tables\n• No end-to-end acknowledgements exist\n• Forwarding is opportunistic\n• Mesh topology changes constantly\n• All estimates based on passive observation only';

  @override
  String get reachabilitySearchHint => 'Search nodes';

  @override
  String get reachabilityDisclaimerBanner =>
      'Likelihood estimates only. Delivery is never guaranteed in a mesh network.';

  @override
  String get reachabilityLevelHigh => 'High';

  @override
  String get reachabilityLevelMedium => 'Medium';

  @override
  String get reachabilityLevelLow => 'Low';

  @override
  String get reachabilityEmptyTitle => 'No nodes discovered yet';

  @override
  String get reachabilityEmptyDescription =>
      'Nodes will appear as they\'re observed\non the mesh network.';

  @override
  String reachabilityScorePercent(String percentage) {
    return '$percentage%';
  }

  @override
  String get mapFilterAll => 'All';

  @override
  String get mapFilterActive => 'Active';

  @override
  String get mapFilterInactive => 'Inactive';

  @override
  String get mapFilterWithGps => 'With GPS';

  @override
  String get mapFilterInRange => 'In Range';

  @override
  String mapDistanceMeters(String meters) {
    return '${meters}m';
  }

  @override
  String mapDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String mapDistanceKilometersRound(String km) {
    return '${km}km';
  }

  @override
  String mapDistanceMetersFormal(String meters) {
    return '$meters m';
  }

  @override
  String mapDistanceKilometersPrecise(String km) {
    return '$km km';
  }

  @override
  String mapDistanceKilometersFormal(String km) {
    return '$km km';
  }

  @override
  String mapWaypointDefaultLabel(int number) {
    return 'WP $number';
  }

  @override
  String get mapCoordinatesCopied => 'Coordinates copied to clipboard';

  @override
  String get mapLocationTitle => 'Location';

  @override
  String get mapScreenTitle => 'Mesh Map';

  @override
  String get mapFilterNodesTooltip => 'Filter nodes';

  @override
  String get mapStyleTooltip => 'Map style';

  @override
  String get mapRefreshing => 'Refreshing...';

  @override
  String get mapRefreshPositions => 'Refresh positions';

  @override
  String get mapHideHeatmap => 'Hide heatmap';

  @override
  String get mapShowHeatmap => 'Show heatmap';

  @override
  String get mapHideConnectionLines => 'Hide connection lines';

  @override
  String get mapShowConnectionLines => 'Show connection lines';

  @override
  String get mapMaxDistance => 'Max Distance';

  @override
  String get mapDistance1Km => '1 km';

  @override
  String get mapDistance5Km => '5 km';

  @override
  String get mapDistance10Km => '10 km';

  @override
  String get mapDistance25Km => '25 km';

  @override
  String get mapDistanceAll => 'All';

  @override
  String get mapHideRangeCircles => 'Hide range circles';

  @override
  String get mapShowRangeCircles => 'Show range circles';

  @override
  String get mapHidePositionHistory => 'Hide position history';

  @override
  String get mapShowPositionHistory => 'Show position history';

  @override
  String get mapExitMeasureMode => 'Exit measure mode';

  @override
  String get mapMeasureDistance => 'Measure distance';

  @override
  String get mapGlobeView => '3D Globe View';

  @override
  String get mapHideTakEntities => 'Hide TAK entities';

  @override
  String get mapShowTakEntities => 'Show TAK entities';

  @override
  String get mapSaDashboard => 'SA Dashboard';

  @override
  String get mapHelp => 'Help';

  @override
  String get mapSettings => 'Settings';

  @override
  String get mapMeasureTapPointA => 'Tap node or map for point A';

  @override
  String get mapMeasureTapPointB => 'Tap node or map for point B';

  @override
  String get mapMeasureMarkerA => 'A';

  @override
  String get mapMeasureMarkerB => 'B';

  @override
  String mapShareDistanceLabel(String distance) {
    return 'Distance: $distance';
  }

  @override
  String mapNodeCount(String count) {
    return '$count nodes';
  }

  @override
  String mapTakEntityCount(int count) {
    return '• $count entities';
  }

  @override
  String get mapDropWaypoint => 'Drop Waypoint';

  @override
  String get mapShareLocation => 'Share Location';

  @override
  String get mapCopyCoordinates => 'Copy Coordinates';

  @override
  String get mapShare => 'Share';

  @override
  String get mapDelete => 'Delete';

  @override
  String get mapEmptyTitle => 'No Nodes with GPS';

  @override
  String mapEmptyBodyWithNodes(int totalNodes) {
    return '$totalNodes nodes discovered but none have\nreported GPS position yet.';
  }

  @override
  String get mapEmptyBodyNoNodes =>
      'Nodes will appear on the map once they\nreport their GPS position.';

  @override
  String get mapRequesting => 'Requesting...';

  @override
  String get mapRequestPositions => 'Request Positions';

  @override
  String get mapPositionBroadcastHint =>
      'Position broadcasts can take up to 15 minutes.\nTap to request immediately.';

  @override
  String get mapEntitiesTitle => 'Entities';

  @override
  String get mapNodesTitle => 'Nodes';

  @override
  String get mapSearchEntitiesHint => 'Search entities...';

  @override
  String get mapSearchNodesHint => 'Search nodes...';

  @override
  String get mapNoEntities => 'No entities';

  @override
  String get mapNoMatchingEntities => 'No matching entities';

  @override
  String get mapSearchHint => 'Try a different search term';

  @override
  String get mapYouBadge => 'YOU';

  @override
  String get mapLastKnown => '• Last known';

  @override
  String get mapFilterNodesTitle => 'Filter Nodes';

  @override
  String get mapMeasurementActions => 'Measurement Actions';

  @override
  String get mapLosAnalysis => 'LOS Analysis';

  @override
  String get mapLosAnalysisSubtitle => 'Earth curvature + Fresnel zone check';

  @override
  String get mapShareMeasurement => 'Share Measurement';

  @override
  String get mapShareMeasurementSubtitle => 'Share via system share sheet';

  @override
  String get mapCopySummary => 'Copy Summary';

  @override
  String get mapMeasurementCopied => 'Measurement copied to clipboard';

  @override
  String get mapCopyBothCoordinates => 'Both A and B coordinates';

  @override
  String get mapOpenMidpointInMaps => 'Open Midpoint in Maps';

  @override
  String get mapOpenInExternalApp => 'Open in external map app';

  @override
  String get mapSwapAB => 'Swap A ↔ B';

  @override
  String get mapReverseDirection => 'Reverse measurement direction';

  @override
  String get mapRfLinkBudget => 'RF Link Budget';

  @override
  String mapEstimatedPathLoss(String pathLoss) {
    return 'Estimated path loss: $pathLoss dB (free-space)';
  }

  @override
  String mapRfLinkBudgetClipboard(
    String distance,
    String frequency,
    String pathLoss,
    String linkMargin,
  ) {
    return 'RF Link Budget (free-space path loss)\nDistance: $distance\nFrequency: $frequency\nPath Loss: $pathLoss\nLink Margin: $linkMargin';
  }

  @override
  String get mapLinkBudgetCopied => 'Link budget copied to clipboard';

  @override
  String get mapNewMeasurement => 'New measurement';

  @override
  String get mapExitMeasureModeTooltip => 'Exit measure mode';

  @override
  String get mapLongPressForActions => 'Long-press for actions';

  @override
  String mapLosVerdict(String verdict) {
    return 'LOS: $verdict';
  }

  @override
  String mapLosBulgeAndFresnel(String bulge, String fresnel) {
    return 'Bulge: ${bulge}m · F1: ${fresnel}m';
  }

  @override
  String get mapTakStale => 'Stale';

  @override
  String get mapTakActive => 'Active';

  @override
  String get mapTakTracked => 'Tracked';

  @override
  String get mapTakTrack => 'Track';

  @override
  String get mapNavigateToTooltip => 'Navigate to';

  @override
  String get mapCopyCoordinatesTooltip => 'Copy coordinates';

  @override
  String get mapDismissTooltip => 'Dismiss';

  @override
  String get mapTakStaleBadge => 'STALE';

  @override
  String get mapTakActiveBadge => 'ACTIVE';

  @override
  String mapAgeSeconds(String seconds) {
    return '${seconds}s ago';
  }

  @override
  String mapAgeMinutes(String minutes) {
    return '${minutes}m ago';
  }

  @override
  String mapAgeHours(String hours) {
    return '${hours}h ago';
  }

  @override
  String get worldMeshTitle => 'World Map';

  @override
  String get worldMeshFavoritesTooltip => 'Favorites';

  @override
  String get worldMeshMapStyleDark => 'Dark Map';

  @override
  String get worldMeshMapStyleSatellite => 'Satellite';

  @override
  String get worldMeshMapStyleLight => 'Light Map';

  @override
  String get worldMeshMapStyleTerrain => 'Terrain';

  @override
  String get worldMeshRefresh => 'Refresh';

  @override
  String get worldMeshHelp => 'Help';

  @override
  String get worldMeshSearchHint => 'Find a node';

  @override
  String get worldMeshFilterTooltip => 'Filter nodes';

  @override
  String worldMeshSearchResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nodes found',
      one: '1 node found',
    );
    return '$_temp0';
  }

  @override
  String get worldMeshLegendActive => 'Active (<1h)';

  @override
  String get worldMeshLegendIdle => 'Idle (1-24h)';

  @override
  String get worldMeshLegendOffline => 'Offline (>24h)';

  @override
  String get worldMeshErrorTitle => 'Unable to load mesh map';

  @override
  String get worldMeshRetry => 'Retry';

  @override
  String get worldMeshMeasurePointA => 'A';

  @override
  String get worldMeshMeasurePointB => 'B';

  @override
  String get worldMeshMeasureTapA => 'Tap node or map for point A';

  @override
  String get worldMeshMeasureTapB => 'Tap node or map for point B';

  @override
  String get worldMeshLoadingNodeInfo => 'Loading node info...';

  @override
  String get worldMeshStatsFiltered => 'filtered';

  @override
  String get worldMeshStatsVisible => 'visible';

  @override
  String get worldMeshStatsTotal => 'total';

  @override
  String get worldMeshRefreshing => 'Refreshing world mesh data...';

  @override
  String get worldMeshTimeJustNow => 'just now';

  @override
  String worldMeshTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String worldMeshTimeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get worldMeshScrollForMore => 'Scroll for more...';

  @override
  String get worldMeshBadgeActive => 'ACTIVE';

  @override
  String get worldMeshRemoveFromFavorites => 'Remove from favorites';

  @override
  String get worldMeshAddToFavorites => 'Add to favorites';

  @override
  String get worldMeshRemovedFromFavorites => 'Removed from favorites';

  @override
  String get worldMeshAddedToFavorites => 'Added to favorites';

  @override
  String get worldMeshCopyId => 'Copy ID';

  @override
  String get worldMeshFocus => 'Focus';

  @override
  String get worldMeshNodeIdCopied => 'Node ID copied';

  @override
  String get worldMeshSectionDevice => 'Device';

  @override
  String get worldMeshInfoHardware => 'Hardware';

  @override
  String get worldMeshInfoRole => 'Role';

  @override
  String get worldMeshInfoFirmware => 'Firmware';

  @override
  String get worldMeshInfoRegion => 'Region';

  @override
  String get worldMeshInfoModem => 'Modem';

  @override
  String get worldMeshInfoLocalNodes => 'Local Nodes';

  @override
  String get worldMeshSectionPosition => 'Position';

  @override
  String get worldMeshInfoCoordinates => 'Coordinates';

  @override
  String get worldMeshInfoAltitude => 'Altitude';

  @override
  String get worldMeshInfoPrecision => 'Precision';

  @override
  String get worldMeshSectionDeviceMetrics => 'Device Metrics';

  @override
  String worldMeshUptimeLabel(String uptime) {
    return 'Uptime: $uptime';
  }

  @override
  String get worldMeshSectionEnvironment => 'Environment';

  @override
  String worldMeshSectionNeighbors(int count) {
    return 'Neighbors ($count)';
  }

  @override
  String worldMeshSectionSeenBy(int count) {
    return 'Seen By ($count gateways)';
  }

  @override
  String worldMeshMoreGateways(int count) {
    return ' +$count more';
  }

  @override
  String worldMeshLastSeen(String time) {
    return 'Last seen: $time';
  }

  @override
  String get worldMeshMeasurementActions => 'Measurement Actions';

  @override
  String get worldMeshLosAnalysis => 'LOS Analysis';

  @override
  String get worldMeshLosSubtitle => 'Earth curvature + Fresnel zone check';

  @override
  String get worldMeshCopySummary => 'Copy Summary';

  @override
  String get worldMeshMeasurementCopied => 'Measurement copied to clipboard';

  @override
  String get worldMeshCopyCoordinates => 'Copy Coordinates';

  @override
  String get worldMeshCopyCoordinatesSubtitle => 'Both A and B coordinates';

  @override
  String get worldMeshCoordinatesCopied => 'Coordinates copied to clipboard';

  @override
  String get worldMeshOpenMidpointInMaps => 'Open Midpoint in Maps';

  @override
  String get worldMeshOpenMidpointSubtitle => 'Open in external map app';

  @override
  String get worldMeshSwapAB => 'Swap A ↔ B';

  @override
  String get worldMeshSwapSubtitle => 'Reverse measurement direction';

  @override
  String get worldMeshRfLinkBudget => 'RF Link Budget';

  @override
  String worldMeshFsplSubtitle(String db) {
    return 'FSPL: $db dB';
  }

  @override
  String worldMeshRfLinkBudgetClipboard(
    String distance,
    String frequency,
    String pathLoss,
    String linkMargin,
  ) {
    return 'RF Link Budget (free-space path loss)\nDistance: $distance\nFrequency: $frequency\nPath Loss: $pathLoss\nLink Margin: $linkMargin';
  }

  @override
  String get worldMeshLinkBudgetCopied => 'Link budget copied to clipboard';

  @override
  String get worldMeshLongPressHint => 'Long-press for actions';

  @override
  String get worldMeshNewMeasurement => 'New measurement';

  @override
  String get worldMeshExitMeasureMode => 'Exit measure mode';

  @override
  String worldMeshLosVerdict(String verdict) {
    return 'LOS: $verdict';
  }

  @override
  String worldMeshLosBulgeAndFresnel(String bulge, String fresnel) {
    return 'Bulge: ${bulge}m · F1: ${fresnel}m';
  }

  @override
  String get nodeAnalyticsDataUpdated => 'Node data updated';

  @override
  String get nodeAnalyticsNodeNotFound => 'Node not found in mesh';

  @override
  String nodeAnalyticsRefreshFailed(String error) {
    return 'Failed to refresh: $error';
  }

  @override
  String get nodeAnalyticsRemovedFromFavorites => 'Removed from favorites';

  @override
  String get nodeAnalyticsAddedToFavorites => 'Added to favorites';

  @override
  String get nodeAnalyticsLiveWatchEnabled =>
      'Live watching enabled (updates every 30s)';

  @override
  String get nodeAnalyticsLiveWatchDisabled => 'Live watching disabled';

  @override
  String get nodeAnalyticsClearHistoryTitle => 'Clear History';

  @override
  String get nodeAnalyticsClearHistoryMessage =>
      'This will delete all historical data for this node. This action cannot be undone.';

  @override
  String get nodeAnalyticsClearConfirm => 'Clear';

  @override
  String get nodeAnalyticsHistoryCleared => 'History cleared';

  @override
  String get nodeAnalyticsShareNodeTitle => 'Share Node';

  @override
  String get nodeAnalyticsShareLink => 'Share Link';

  @override
  String get nodeAnalyticsShareLinkSubtitle =>
      'Rich preview in iMessage, Slack, etc.';

  @override
  String get nodeAnalyticsShareDetails => 'Share Details';

  @override
  String get nodeAnalyticsShareDetailsSubtitle => 'Full technical info as text';

  @override
  String get nodeAnalyticsSignInToShare => 'Sign in to share nodes';

  @override
  String get nodeAnalyticsSignIn => 'Sign In';

  @override
  String nodeAnalyticsShareText(String name, String url) {
    return 'Check out $name on Socialmesh!\n$url';
  }

  @override
  String nodeAnalyticsShareSubject(String name) {
    return 'Mesh Node: $name';
  }

  @override
  String nodeAnalyticsShareFailed(String error) {
    return 'Failed to share node: $error';
  }

  @override
  String nodeAnalyticsShareDetailHeader(String name) {
    return '🛰️ Mesh Node: $name';
  }

  @override
  String nodeAnalyticsShareDetailId(String nodeId) {
    return 'ID: !$nodeId';
  }

  @override
  String nodeAnalyticsShareDetailRole(String role) {
    return 'Role: $role';
  }

  @override
  String nodeAnalyticsShareDetailHardware(String hardware) {
    return 'Hardware: $hardware';
  }

  @override
  String get nodeAnalyticsShareDetailBatteryCharging => 'Battery: Charging';

  @override
  String nodeAnalyticsShareDetailBatteryLevel(String level) {
    return 'Battery: $level%';
  }

  @override
  String nodeAnalyticsShareDetailLocation(String location) {
    return 'Location: $location';
  }

  @override
  String nodeAnalyticsShareDetailStatus(String status) {
    return 'Status: $status';
  }

  @override
  String nodeAnalyticsShareDetailNeighbors(String count) {
    return 'Neighbors: $count';
  }

  @override
  String nodeAnalyticsShareDetailGateways(String count) {
    return 'Gateways: $count';
  }

  @override
  String get nodeAnalyticsNoHistoryToExport => 'No history data to export';

  @override
  String get nodeAnalyticsExportHistoryTitle => 'Export History';

  @override
  String nodeAnalyticsExportRecordCount(int count) {
    return '$count records';
  }

  @override
  String get nodeAnalyticsExportJson => 'JSON';

  @override
  String get nodeAnalyticsExportCsv => 'CSV';

  @override
  String nodeAnalyticsExportJsonSubject(String name) {
    return 'Node $name History (JSON)';
  }

  @override
  String get nodeAnalyticsJsonShared => 'JSON data shared';

  @override
  String nodeAnalyticsExportCsvSubject(String name) {
    return 'Node $name History (CSV)';
  }

  @override
  String get nodeAnalyticsCsvShared => 'CSV data shared';

  @override
  String get nodeAnalyticsShareTooltip => 'Share node info';

  @override
  String get nodeAnalyticsStopWatching => 'Stop watching';

  @override
  String get nodeAnalyticsWatchLive => 'Watch live';

  @override
  String get nodeAnalyticsRemoveFavoriteTooltip => 'Remove from favorites';

  @override
  String get nodeAnalyticsAddFavoriteTooltip => 'Add to favorites';

  @override
  String get nodeAnalyticsSectionDeviceInfo => 'Device Info';

  @override
  String get nodeAnalyticsSectionDeviceMetrics => 'Device Metrics';

  @override
  String get nodeAnalyticsSectionNetwork => 'Network';

  @override
  String get nodeAnalyticsSectionTrends => 'Trends';

  @override
  String get nodeAnalyticsBadgeLive => 'LIVE';

  @override
  String get nodeAnalyticsNodeIdCopied => 'Node ID copied';

  @override
  String get nodeAnalyticsShowOnMap => 'Show on Map';

  @override
  String get nodeAnalyticsRefreshing => 'Refreshing...';

  @override
  String get nodeAnalyticsRefreshNow => 'Refresh Now';

  @override
  String get nodeAnalyticsExport => 'Export';

  @override
  String get nodeAnalyticsClear => 'Clear';

  @override
  String get nodeAnalyticsLongName => 'Long Name';

  @override
  String get nodeAnalyticsShortName => 'Short Name';

  @override
  String get nodeAnalyticsRole => 'Role';

  @override
  String get nodeAnalyticsHardware => 'Hardware';

  @override
  String get nodeAnalyticsLatitude => 'Latitude';

  @override
  String get nodeAnalyticsLongitude => 'Longitude';

  @override
  String nodeAnalyticsAltitude(String meters) {
    return '${meters}m';
  }

  @override
  String get nodeAnalyticsBattery => 'Battery';

  @override
  String get nodeAnalyticsCharging => 'Charging';

  @override
  String get nodeAnalyticsUnknown => 'Unknown';

  @override
  String get nodeAnalyticsVoltage => 'Voltage';

  @override
  String get nodeAnalyticsChannelUtilization => 'Channel Utilization';

  @override
  String get nodeAnalyticsAirTimeTx => 'Air Time TX';

  @override
  String get nodeAnalyticsUptime => 'Uptime';

  @override
  String nodeAnalyticsDirectNeighbors(int count) {
    return 'Direct Neighbors ($count)';
  }

  @override
  String get nodeAnalyticsNoNeighborData => 'No neighbor data available';

  @override
  String nodeAnalyticsSeenByGateways(int count) {
    return 'Seen by Gateways ($count)';
  }

  @override
  String get nodeAnalyticsNoGatewayData => 'No gateway data available';

  @override
  String get nodeAnalyticsNoHistoryYet => 'No historical data yet';

  @override
  String get nodeAnalyticsVisitAgain =>
      'Visit this node again to build history';

  @override
  String get nodeAnalyticsRecords => 'Records';

  @override
  String get nodeAnalyticsUptimeStat => 'Uptime';

  @override
  String get nodeAnalyticsAvgBattery => 'Avg Battery';

  @override
  String get nodeAnalyticsFirstSeen => 'First seen';

  @override
  String get nodeAnalyticsLastUpdate => 'Last update';

  @override
  String nodeAnalyticsTimeDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String nodeAnalyticsTimeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String nodeAnalyticsTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get nodeAnalyticsTimeJustNow => 'Just now';

  @override
  String get nodeAnalyticsSectionHistory => 'History';

  @override
  String get worldMeshFilterTitle => 'Filter Nodes';

  @override
  String get worldMeshFilterClearAll => 'Clear All';

  @override
  String worldMeshFilterNodeCount(int filteredCount, int totalCount) {
    return '$filteredCount of $totalCount nodes';
  }

  @override
  String worldMeshFilterActiveCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count filters',
      one: '1 filter',
    );
    return '$_temp0';
  }

  @override
  String get worldMeshFilterStatus => 'Status';

  @override
  String get worldMeshFilterHardwareModel => 'Hardware Model';

  @override
  String get worldMeshFilterModemPreset => 'Modem Preset';

  @override
  String get worldMeshFilterRegion => 'Region';

  @override
  String get worldMeshFilterNodeRole => 'Node Role';

  @override
  String get worldMeshFilterFirmwareVersion => 'Firmware Version';

  @override
  String get worldMeshFilterEnvironmentSensors => 'Environment Sensors';

  @override
  String worldMeshFilterNodesWithSensors(int count) {
    return '$count nodes with sensors';
  }

  @override
  String get worldMeshFilterBatteryInfo => 'Battery Info';

  @override
  String worldMeshFilterNodesWithBattery(int count) {
    return '$count nodes with battery data';
  }

  @override
  String get worldMeshFilterStatusActive => 'Active (≤2m)';

  @override
  String get worldMeshFilterStatusFading => 'Fading (2-10m)';

  @override
  String get worldMeshFilterStatusInactive => 'Inactive (10-60m)';

  @override
  String get worldMeshFilterStatusUnknown => 'Unknown (>60m)';

  @override
  String get worldMeshFilterNoOptions => 'No options available';

  @override
  String get worldMeshFilterAny => 'Any';

  @override
  String get worldMeshFilterYes => 'Yes';

  @override
  String get worldMeshFilterNo => 'No';

  @override
  String get favoritesTitle => 'Favorite Nodes';

  @override
  String get favoritesErrorLoading => 'Error loading favorites';

  @override
  String get favoritesRetry => 'Retry';

  @override
  String get favoritesSelectFirst => 'Select first node';

  @override
  String get favoritesSelectSecond => 'Select second node';

  @override
  String get favoritesCancelCompare => 'Cancel compare';

  @override
  String get favoritesCompareNodes => 'Compare nodes';

  @override
  String get favoritesEmptyTitle => 'No Favorites Yet';

  @override
  String get favoritesEmptyDescription =>
      'Tap the star icon on any node to add it to your favorites for quick access.';

  @override
  String get favoritesDelete => 'Delete';

  @override
  String get favoritesRemoveTitle => 'Remove Favorite?';

  @override
  String favoritesRemoveMessage(String name) {
    return 'Remove $name from your favorites?';
  }

  @override
  String get favoritesRemoveConfirm => 'Remove';

  @override
  String get favoritesNotInMesh => 'Not in mesh';

  @override
  String get favoritesNodeNotInMesh =>
      'Node not currently in mesh. Check back later.';

  @override
  String get favoritesCannotCompare => 'Cannot compare nodes not in mesh';

  @override
  String get favoritesCharging => 'Charging';

  @override
  String get favoritesRemoveTooltip => 'Remove from favorites';

  @override
  String get nodeComparisonTitle => 'Compare Nodes';

  @override
  String get nodeComparisonVs => 'VS';

  @override
  String get nodeComparisonNodeIdCopied => 'Node ID copied';

  @override
  String get nodeComparisonSectionStatus => 'Status';

  @override
  String get nodeComparisonSectionDeviceInfo => 'Device Info';

  @override
  String get nodeComparisonSectionMetrics => 'Metrics';

  @override
  String get nodeComparisonSectionNetwork => 'Network';

  @override
  String get nodeComparisonRowStatus => 'Status';

  @override
  String get nodeComparisonRowRole => 'Role';

  @override
  String get nodeComparisonRowHardware => 'Hardware';

  @override
  String get nodeComparisonUnknown => 'Unknown';

  @override
  String get nodeComparisonRowFirmware => 'Firmware';

  @override
  String get nodeComparisonNoData => '--';

  @override
  String get nodeComparisonRowRegion => 'Region';

  @override
  String get nodeComparisonRowBattery => 'Battery';

  @override
  String get nodeComparisonCharging => 'Charging';

  @override
  String get nodeComparisonRowVoltage => 'Voltage';

  @override
  String get nodeComparisonRowChannelUtil => 'Channel Util';

  @override
  String get nodeComparisonRowAirTimeTx => 'Air Time TX';

  @override
  String get nodeComparisonRowUptime => 'Uptime';

  @override
  String get nodeComparisonRowNeighbors => 'Neighbors';

  @override
  String get nodeComparisonRowGateways => 'Gateways';

  @override
  String get nodeComparisonRowHasLocation => 'Has Location';

  @override
  String get nodeComparisonYes => 'Yes';

  @override
  String get nodeComparisonNo => 'No';

  @override
  String get worldMeshFilterCatStatus => 'Status';

  @override
  String get worldMeshFilterCatHardware => 'Hardware';

  @override
  String get worldMeshFilterCatModemPreset => 'Modem Preset';

  @override
  String get worldMeshFilterCatRegion => 'Region';

  @override
  String get worldMeshFilterCatRole => 'Role';

  @override
  String get worldMeshFilterCatFirmware => 'Firmware';

  @override
  String get worldMeshFilterCatEnvSensors => 'Environment Sensors';

  @override
  String get worldMeshFilterCatBatteryInfo => 'Battery Info';

  @override
  String get nodeIntelligenceTitle => 'Mesh Intelligence';

  @override
  String get nodeIntelligenceDerivedBadge => 'DERIVED';

  @override
  String get nodeIntelligenceTapHint => 'Tap for deep analytics';

  @override
  String get nodeIntelligenceHealth => 'Health';

  @override
  String get nodeIntelligenceConnectivity => 'Connectivity';

  @override
  String nodeIntelligenceNeighborCount(int count) {
    return '$count neighbors';
  }

  @override
  String nodeIntelligenceGatewayCount(int count) {
    return '$count gateways';
  }

  @override
  String get nodeIntelligenceChannelUtil => 'Channel Utilization';

  @override
  String get nodeIntelligenceMobilityInfra => 'Infrastructure';

  @override
  String get nodeIntelligenceMobilityMobile => 'Mobile';

  @override
  String get nodeIntelligenceMobilityTracker => 'Tracker';

  @override
  String get nodeIntelligenceMobilityElevated => 'Elevated';

  @override
  String get nodeIntelligenceMobilityStationary => 'Stationary';

  @override
  String get nodeIntelligenceUnknown => 'Unknown';

  @override
  String get nodeIntelligenceActivityHot => 'Hot';

  @override
  String get nodeIntelligenceActivityActive => 'Active';

  @override
  String get nodeIntelligenceActivityQuiet => 'Quiet';

  @override
  String get nodeIntelligenceActivityCold => 'Cold';

  @override
  String get nodeHistoryNeedMoreData => 'Need more data for charts';

  @override
  String nodeHistoryDataPointCount(int current, int required) {
    return '$current/$required data points';
  }

  @override
  String nodeHistoryNoMetricData(String metric) {
    return 'No $metric data';
  }

  @override
  String get nodeHistoryMetricBattery => 'Battery';

  @override
  String get nodeHistoryMetricConnectivity => 'Connectivity';

  @override
  String get nodeHistoryMetricChannelUtil => 'Channel Util';
}
