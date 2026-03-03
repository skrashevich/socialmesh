// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get adminProductsActivate => 'Activate';

  @override
  String get adminProductsActive => 'Active';

  @override
  String get adminProductsActiveSubtitle => 'Product is visible in the shop';

  @override
  String get adminProductsAddImage => 'Add Image';

  @override
  String get adminProductsAddTitle => 'Add Product';

  @override
  String get adminProductsAddTooltip => 'Add Product';

  @override
  String get adminProductsAllCategories => 'All Categories';

  @override
  String get adminProductsBasicInfoSection => 'Basic Information';

  @override
  String get adminProductsBatteryHint => 'e.g., 4000mAh';

  @override
  String get adminProductsBatteryLabel => 'Battery Capacity';

  @override
  String get adminProductsBluetooth => 'Bluetooth';

  @override
  String get adminProductsCategoryLabel => 'Category *';

  @override
  String get adminProductsCategorySellerSection => 'Category & Seller';

  @override
  String get adminProductsChipsetHint => 'e.g., ESP32-S3';

  @override
  String get adminProductsChipsetLabel => 'Chipset';

  @override
  String get adminProductsComparePriceHint => 'Original price for sale';

  @override
  String get adminProductsComparePriceLabel => 'Compare at Price';

  @override
  String get adminProductsCreate => 'Create Product';

  @override
  String get adminProductsCreated => 'Product created';

  @override
  String get adminProductsDeactivate => 'Deactivate';

  @override
  String get adminProductsDelete => 'Delete';

  @override
  String get adminProductsDeleteConfirmMessage =>
      'Are you sure you want to permanently delete this product?';

  @override
  String get adminProductsDeleteConfirmTitle => 'Delete Product';

  @override
  String get adminProductsDeleteMenu => 'Delete';

  @override
  String adminProductsDeleteMessage(String name) {
    return 'Are you sure you want to permanently delete \"$name\"?\n\nThis action cannot be undone.';
  }

  @override
  String get adminProductsDeleteTitle => 'Delete Product';

  @override
  String get adminProductsDeleteTooltip => 'Delete';

  @override
  String get adminProductsDeleted => 'Product deleted';

  @override
  String get adminProductsDeletedSuccess => 'Product deleted';

  @override
  String get adminProductsDimensionsHint => 'e.g., 100x50x25mm';

  @override
  String get adminProductsDimensionsLabel => 'Dimensions';

  @override
  String get adminProductsDisplay => 'Display';

  @override
  String get adminProductsEdit => 'Edit';

  @override
  String get adminProductsEditTitle => 'Edit Product';

  @override
  String adminProductsErrorLoadingSellers(String error) {
    return 'Error loading sellers: $error';
  }

  @override
  String get adminProductsFeatured => 'Featured';

  @override
  String get adminProductsFeaturedBadge => 'FEATURED';

  @override
  String get adminProductsFeaturedOrderHelper =>
      'Controls display order in featured section';

  @override
  String get adminProductsFeaturedOrderHint =>
      'Lower numbers appear first (0 = top)';

  @override
  String get adminProductsFeaturedOrderLabel => 'Featured Order';

  @override
  String get adminProductsFeaturedSubtitle =>
      'Show in featured products section';

  @override
  String get adminProductsFilterTooltip => 'Filter by category';

  @override
  String get adminProductsFrequencyBandsSection => 'Frequency Bands';

  @override
  String get adminProductsFullDescHint => 'Detailed product description';

  @override
  String get adminProductsFullDescLabel => 'Full Description *';

  @override
  String get adminProductsGps => 'GPS';

  @override
  String get adminProductsHideInactive => 'Hide inactive';

  @override
  String get adminProductsImageRequired => 'At least one image is required';

  @override
  String get adminProductsImageWarning => 'Please add at least one image';

  @override
  String get adminProductsImagesSection => 'Product Images';

  @override
  String get adminProductsInStock => 'In Stock';

  @override
  String get adminProductsInactiveBadge => 'INACTIVE';

  @override
  String get adminProductsInvalid => 'Invalid';

  @override
  String get adminProductsLoraChipHint => 'e.g., SX1262';

  @override
  String get adminProductsLoraChipLabel => 'LoRa Chip';

  @override
  String get adminProductsMainImage => 'Main';

  @override
  String get adminProductsNameHint => 'e.g., T-Beam Supreme';

  @override
  String get adminProductsNameLabel => 'Product Name *';

  @override
  String get adminProductsNotFound => 'No products found';

  @override
  String get adminProductsPhysicalSpecsSection => 'Physical Specifications';

  @override
  String get adminProductsPriceLabel => 'Price (USD) *';

  @override
  String get adminProductsPricingSection => 'Pricing';

  @override
  String get adminProductsPurchaseLinkSection => 'Purchase Link';

  @override
  String get adminProductsPurchaseUrlLabel => 'Purchase URL';

  @override
  String get adminProductsRequired => 'Required';

  @override
  String get adminProductsSaveChanges => 'Save Changes';

  @override
  String get adminProductsSearchHint => 'Search products...';

  @override
  String get adminProductsSelectSeller => 'Select seller';

  @override
  String get adminProductsSelectSellerWarning => 'Please select a seller';

  @override
  String get adminProductsSellerLabel => 'Seller *';

  @override
  String get adminProductsShortDescHint => 'Brief summary (max 150 chars)';

  @override
  String get adminProductsShortDescLabel => 'Short Description';

  @override
  String get adminProductsShowInactive => 'Show inactive';

  @override
  String get adminProductsStockHint => 'Leave empty for unlimited';

  @override
  String get adminProductsStockLabel => 'Stock Quantity';

  @override
  String get adminProductsStockSection => 'Stock & Status';

  @override
  String get adminProductsTagsHint => 'meshtastic, lora, gps (comma separated)';

  @override
  String get adminProductsTagsLabel => 'Tags';

  @override
  String get adminProductsTagsSection => 'Tags';

  @override
  String get adminProductsTechSpecsSection => 'Technical Specifications';

  @override
  String get adminProductsTitle => 'Manage Products';

  @override
  String get adminProductsUpdated => 'Product updated';

  @override
  String get adminProductsUploading => 'Uploading...';

  @override
  String get adminProductsVendorUnverifiedSubtitle =>
      'Mark when vendor confirms all specs are accurate';

  @override
  String get adminProductsVendorVerificationSection => 'Vendor Verification';

  @override
  String get adminProductsVendorVerifiedSubtitle =>
      'Specifications have been verified by the vendor';

  @override
  String get adminProductsVendorVerifiedTitle => 'Vendor Verified Specs';

  @override
  String get adminProductsWeightHint => 'e.g., 50g';

  @override
  String get adminProductsWeightLabel => 'Weight';

  @override
  String get adminProductsWifi => 'WiFi';

  @override
  String get adminSellersActivate => 'Activate';

  @override
  String get adminSellersActive => 'Active';

  @override
  String get adminSellersActiveSubtitle => 'Seller is visible in the shop';

  @override
  String get adminSellersAddTitle => 'Add Seller';

  @override
  String get adminSellersAddTooltip => 'Add Seller';

  @override
  String get adminSellersBasicInfoSection => 'Basic Information';

  @override
  String get adminSellersCancel => 'Cancel';

  @override
  String get adminSellersClearDiscount => 'Clear Discount Code';

  @override
  String get adminSellersContactInfoSection => 'Contact Information';

  @override
  String get adminSellersCountriesHint => 'US, CA, UK, DE (comma separated)';

  @override
  String get adminSellersCountriesLabel => 'Countries';

  @override
  String get adminSellersCreate => 'Create Seller';

  @override
  String get adminSellersCreated => 'Seller created';

  @override
  String get adminSellersDangerZone => 'Danger Zone';

  @override
  String get adminSellersDeactivate => 'Deactivate';

  @override
  String get adminSellersDeleteConfirm => 'Delete';

  @override
  String get adminSellersDeleteDescription =>
      'Permanently delete this seller and deactivate all their products. This action cannot be undone.';

  @override
  String adminSellersDeleteDialogMessage(String name) {
    return 'Are you sure you want to permanently delete \"$name\"?';
  }

  @override
  String get adminSellersDeleteDialogTitle => 'Delete Seller';

  @override
  String get adminSellersDeletePermanently => 'Delete Seller Permanently';

  @override
  String adminSellersDeleteProductWarning(int productCount) {
    return 'This seller has $productCount products. Deleting the seller will also delete all their products.';
  }

  @override
  String get adminSellersDeleteTitle => 'Delete Seller';

  @override
  String get adminSellersDeleteTooltip => 'Delete Seller';

  @override
  String get adminSellersDeleteUndoWarning => 'This action cannot be undone.';

  @override
  String get adminSellersDeleted => 'Seller deleted';

  @override
  String get adminSellersDescriptionHint => 'Brief description of the seller';

  @override
  String get adminSellersDescriptionLabel => 'Description';

  @override
  String get adminSellersDiscountCodeHint => 'e.g., MESH10';

  @override
  String get adminSellersDiscountCodeLabel => 'Discount Code';

  @override
  String get adminSellersDiscountDisplayHint =>
      'e.g., 10% off for Socialmesh users';

  @override
  String get adminSellersDiscountDisplayLabel => 'Display Label';

  @override
  String get adminSellersDiscountExpired => 'Discount code has expired';

  @override
  String get adminSellersDiscountExpiryLabel => 'Expiry Date (optional)';

  @override
  String get adminSellersDiscountNoExpiry => 'No expiry';

  @override
  String get adminSellersDiscountSection => 'Partner Discount Code';

  @override
  String get adminSellersDiscountTermsHint =>
      'e.g., Cannot be combined with other offers';

  @override
  String get adminSellersDiscountTermsLabel => 'Terms & Conditions';

  @override
  String get adminSellersEdit => 'Edit';

  @override
  String get adminSellersEditTitle => 'Edit Seller';

  @override
  String get adminSellersEmailHint => 'support@example.com';

  @override
  String get adminSellersEmailLabel => 'Contact Email';

  @override
  String get adminSellersHideInactive => 'Hide inactive';

  @override
  String get adminSellersInactiveBadge => 'INACTIVE';

  @override
  String get adminSellersLogoSection => 'Seller Logo';

  @override
  String get adminSellersNameHint => 'e.g., LilyGO, RAK Wireless';

  @override
  String get adminSellersNameLabel => 'Seller Name *';

  @override
  String get adminSellersNotFound => 'No sellers found';

  @override
  String get adminSellersOfficialPartner => 'Official Partner';

  @override
  String get adminSellersOfficialPartnerSubtitle =>
      'Display as official Meshtastic partner';

  @override
  String get adminSellersPartnerBadge => 'PARTNER';

  @override
  String get adminSellersRemoveLogo => 'Remove';

  @override
  String get adminSellersSaveChanges => 'Save Changes';

  @override
  String get adminSellersSearchHint => 'Search sellers...';

  @override
  String get adminSellersShippingSection => 'Shipping Countries';

  @override
  String get adminSellersShowInactive => 'Show inactive';

  @override
  String get adminSellersStatusSection => 'Status & Verification';

  @override
  String get adminSellersTitle => 'Manage Sellers';

  @override
  String get adminSellersUpdated => 'Seller updated';

  @override
  String get adminSellersUploadLogo => 'Upload Logo';

  @override
  String get adminSellersUploading => 'Uploading...';

  @override
  String get adminSellersVerifiedBadge => 'VERIFIED';

  @override
  String get adminSellersVerifiedSubtitle =>
      'Seller identity has been verified';

  @override
  String get adminSellersVerifiedToggle => 'Verified';

  @override
  String get adminSellersWebsiteLabel => 'Website URL *';

  @override
  String get aetherDetailAltitude => 'Altitude';

  @override
  String get aetherDetailArrival => 'Arrival';

  @override
  String get aetherDetailBeFirstReport => 'Be the first to report this flight!';

  @override
  String get aetherDetailCoverageRadius => 'Coverage Radius';

  @override
  String get aetherDetailDeparture => 'Departure';

  @override
  String aetherDetailDistanceAway(int distance) {
    return '$distance km away';
  }

  @override
  String get aetherDetailFlightDetails => 'Flight Details';

  @override
  String get aetherDetailGroundSpeed => 'Ground Speed';

  @override
  String get aetherDetailHeading => 'Heading';

  @override
  String get aetherDetailLivePosition => 'Live Position';

  @override
  String get aetherDetailNoReports => 'No receptions reported yet';

  @override
  String get aetherDetailNode => 'Node';

  @override
  String get aetherDetailNotes => 'Notes';

  @override
  String get aetherDetailOperator => 'Operator';

  @override
  String get aetherDetailPositionUnavailable => 'Position data unavailable';

  @override
  String get aetherDetailReceptions => 'Receptions';

  @override
  String aetherDetailReceptionsValue(int count) {
    return '$count reported';
  }

  @override
  String get aetherDetailRefreshTooltip => 'Refresh position';

  @override
  String get aetherDetailReportButton => 'I Received This Flight!';

  @override
  String get aetherDetailReportsError => 'Error loading reports';

  @override
  String get aetherDetailReportsTitle => 'Reception Reports';

  @override
  String get aetherDetailShareCopied => 'Flight link copied to clipboard';

  @override
  String aetherDetailShareError(String error) {
    return 'Could not share flight: $error';
  }

  @override
  String get aetherDetailShareTooltip => 'Share flight';

  @override
  String get aetherDetailUnknownNode => 'Unknown node';

  @override
  String aetherDetailUpdated(String time) {
    return 'Updated $time';
  }

  @override
  String get aetherDuplicateReport => 'You have already reported this flight';

  @override
  String get aetherEmptyActionSchedule => 'Schedule Flight';

  @override
  String get aetherEmptyActiveSubtitle =>
      'No Meshtastic nodes currently in the air.\nBe the first to schedule one!';

  @override
  String get aetherEmptyActiveTitle => 'No Active Flights';

  @override
  String get aetherEmptyAllSubtitle =>
      'No flights scheduled yet.\nBe the first to share your journey!';

  @override
  String get aetherEmptyAllTitle => 'No Flights Found';

  @override
  String get aetherEmptyMyFlightsSubtitle =>
      'You haven\'t scheduled any flights yet.\nTap the button above to add one!';

  @override
  String get aetherEmptyMyFlightsTitle => 'No Flights Scheduled';

  @override
  String aetherEmptySearchSubtitle(String query) {
    return 'No results match \"$query\".\nTry a different search term.';
  }

  @override
  String get aetherEmptyTagline1 =>
      'No flights scheduled yet.\nBe the first to share your airborne journey!';

  @override
  String get aetherEmptyTagline2 =>
      'Track Meshtastic nodes at altitude.\nSee how far your signal reaches from the sky.';

  @override
  String get aetherEmptyTagline3 =>
      'Compete on the leaderboard.\nLongest range contacts earn top spots.';

  @override
  String get aetherEmptyTagline4 =>
      'Schedule your next flight.\nShare your departure and arrival airports.';

  @override
  String get aetherEmptyTitleKeyword => 'flights';

  @override
  String get aetherEmptyTitlePrefix => 'No ';

  @override
  String get aetherEmptyTitleSuffix => ' in the air';

  @override
  String get aetherEmptyUpcomingSubtitle =>
      'No flights scheduled yet.\nPlan your next airborne test!';

  @override
  String get aetherEmptyUpcomingTitle => 'No Upcoming Flights';

  @override
  String get aetherFilterActive => 'Active';

  @override
  String get aetherFilterAll => 'All';

  @override
  String get aetherFilterMyFlights => 'My Flights';

  @override
  String get aetherFilterUpcoming => 'Upcoming';

  @override
  String aetherFlightReceptionCount(int count, String s) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count reception$_temp0';
  }

  @override
  String get aetherFormEnterFlightNumber => 'Enter flight number';

  @override
  String get aetherFormInvalidFlightFormat =>
      'Invalid format (e.g., UA123, EXS49MY)';

  @override
  String get aetherFormRequired => 'Required';

  @override
  String get aetherFormUnknownAirport => 'Unknown airport';

  @override
  String get aetherFormUseLetterCode => 'Use 3-4 letter code';

  @override
  String get aetherInfoGroundStations =>
      'Ground stations watch for your signal';

  @override
  String get aetherInfoLoraRange => 'At 35,000ft, LoRa can reach 400+ km!';

  @override
  String get aetherInfoReceptions => 'Report receptions & set range records!';

  @override
  String get aetherInfoSchedule => 'Schedule your flight with your node';

  @override
  String get aetherInfoTagline => 'Track Meshtastic nodes at altitude!';

  @override
  String get aetherInfoTitle => 'Aether';

  @override
  String get aetherLeaderboardEmpty => 'Leaderboard Empty';

  @override
  String get aetherLeaderboardEmptySubtitle =>
      'Be the first to report a reception from a sky node and claim the top spot!';

  @override
  String get aetherLeaderboardError => 'Error Loading Leaderboard';

  @override
  String get aetherLeaderboardErrorSubtitle => 'Pull to refresh and try again.';

  @override
  String get aetherLeaderboardSubtitle =>
      'Global rankings by reception distance';

  @override
  String get aetherLeaderboardTitle => 'Distance Leaderboard';

  @override
  String get aetherLeaderboardTooltip => 'Leaderboard';

  @override
  String get aetherMatchInFlight => 'IN FLIGHT';

  @override
  String get aetherMatchReportCta => 'Tap to report your reception';

  @override
  String get aetherMenuAbout => 'About Aether';

  @override
  String get aetherMenuHelp => 'Help';

  @override
  String get aetherMenuSettings => 'Settings';

  @override
  String aetherNodeAlreadyHasFlight(
    String nodeName,
    String flightNumber,
    String status,
  ) {
    return '$nodeName already has a flight ($flightNumber — $status)';
  }

  @override
  String get aetherOpenSkyFlightActive => 'Flight is currently active';

  @override
  String get aetherOpenSkyFlightNotFound =>
      'Flight not found in historical departures';

  @override
  String get aetherOpenSkyFlightNotInAir => 'Flight not currently in the air';

  @override
  String get aetherOpenSkyFlightPending =>
      'Flight is scheduled for the future. Will validate when active.';

  @override
  String get aetherOpenSkyFlightVerified =>
      'Flight verified in historical data';

  @override
  String get aetherOverlayDetected => 'DETECTED';

  @override
  String get aetherOverlayReport => 'Report';

  @override
  String aetherPickerAirportCount(int count) {
    return '$count airports';
  }

  @override
  String get aetherPickerArrivalTitle => 'Arrival Airport';

  @override
  String get aetherPickerDepartureTitle => 'Departure Airport';

  @override
  String get aetherPickerManualEntry => 'You can still type the code manually';

  @override
  String get aetherPickerNoResults => 'No airports found';

  @override
  String aetherPickerResultCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
    );
    return '$_temp0';
  }

  @override
  String get aetherPickerSearchHint => 'Search by code, city, or name';

  @override
  String get aetherPickerTitle => 'Select Airport';

  @override
  String get aetherReportAddNotes => 'Add Notes';

  @override
  String get aetherReportDuplicate => 'You have already reported this flight';

  @override
  String get aetherReportEstimatedDistance => 'Estimated distance ';

  @override
  String get aetherReportFlightEnded => 'This flight has ended';

  @override
  String get aetherReportLocationDetected => 'Location auto-detected';

  @override
  String get aetherReportLocationUnavailable => 'Location unavailable';

  @override
  String get aetherReportNodeNotDetected =>
      'Flight node not detected in your mesh network';

  @override
  String get aetherReportNotOnMesh =>
      'This flight\'s node is not in your mesh network. You can only report a reception when the node is visible to your device.';

  @override
  String get aetherReportNotesHint => 'Equipment, antenna, location details...';

  @override
  String get aetherReportNotesLabel => 'Notes';

  @override
  String get aetherReportRemoveNotes => 'Remove';

  @override
  String get aetherReportRssiLabel => 'RSSI ';

  @override
  String get aetherReportSnrLabel => 'SNR ';

  @override
  String get aetherReportSubmit => 'Submit Report';

  @override
  String aetherReportSubtitle(String flightNumber) {
    return 'I received flight $flightNumber on my node!';
  }

  @override
  String get aetherReportSuccess => 'Reception reported!';

  @override
  String get aetherReportTitle => 'Report Reception';

  @override
  String get aetherScheduleAlreadyValidatedTooltip => 'Already validated';

  @override
  String get aetherScheduleArrivalBeforeDeparture =>
      'Arrival must be after departure';

  @override
  String get aetherScheduleArrivalDateTitle => 'Arrival Date';

  @override
  String get aetherScheduleArrivalTimeTitle => 'Arrival Time';

  @override
  String get aetherScheduleBrowseTooltip => 'Browse airports';

  @override
  String get aetherScheduleButton => 'Schedule Flight';

  @override
  String get aetherScheduleConnectDevice =>
      'Connect your Meshtastic device first';

  @override
  String get aetherScheduleConnectToSchedule => 'Connect to schedule a flight';

  @override
  String get aetherScheduleDateLabel => 'Date';

  @override
  String get aetherScheduleDepartureDateTitle => 'Departure Date';

  @override
  String get aetherScheduleDepartureInPast => 'Departure time is in the past';

  @override
  String get aetherScheduleDepartureTimeTitle => 'Departure Time';

  @override
  String get aetherScheduleDepartureTooFar =>
      'Departure cannot be more than a year from now';

  @override
  String aetherScheduleDurationTooLong(int hours, int minutes) {
    return 'Flight duration exceeds 24 hours (${hours}h ${minutes}m)';
  }

  @override
  String get aetherScheduleDurationTooShort =>
      'Flight duration must be at least 5 minutes';

  @override
  String aetherScheduleError(String error) {
    return 'Error: $error';
  }

  @override
  String get aetherScheduleFlightNumberHint => 'UA123';

  @override
  String get aetherScheduleFlightNumberLabel => 'Flight Number';

  @override
  String get aetherScheduleFlightOnGround =>
      'Flight is currently on the ground';

  @override
  String aetherScheduleFlightSelectedAlt(int altitude) {
    return 'Flight selected! $altitude ft';
  }

  @override
  String get aetherScheduleFlightTooltip => 'Schedule Flight';

  @override
  String get aetherScheduleFromHint => 'LAX';

  @override
  String get aetherScheduleFromLabel => 'From';

  @override
  String get aetherScheduleInFlight => 'In Flight';

  @override
  String aetherScheduleIncompleteMessage(String fields) {
    return 'Could not auto-fill $fields from OpenSky Network. Please enter these details manually below.';
  }

  @override
  String get aetherScheduleIncompleteTitle => 'Incomplete Flight Data';

  @override
  String get aetherScheduleIntroBanner =>
      'Schedule your flight and share it on aether.socialmesh.app so the community can try to receive your signal!';

  @override
  String get aetherScheduleLiveFlightData => 'Live Flight Data';

  @override
  String get aetherScheduleLoadingFlights =>
      'Loading flights, please try again';

  @override
  String get aetherScheduleNoDeviceConnected => 'No Device Connected';

  @override
  String aetherScheduleNodeHasActiveFlight(
    String nodeName,
    String flightNumber,
  ) {
    return '$nodeName already has an active flight ($flightNumber)';
  }

  @override
  String get aetherScheduleNotesHint =>
      'Window seat, left side. Running at 20dBm.';

  @override
  String get aetherScheduleNotesLabel => 'Notes';

  @override
  String get aetherScheduleOnGround => 'On Ground';

  @override
  String get aetherScheduleOnGroundChip => 'On ground';

  @override
  String get aetherScheduleResponsibilityTooltip => 'Your Responsibility';

  @override
  String aetherScheduleRouteExceedsRange(int distance) {
    return '$distance — exceeds maximum aircraft range';
  }

  @override
  String aetherScheduleRouteFound(String route) {
    return 'Route found: $route';
  }

  @override
  String get aetherScheduleRouteSameAirport => 'Same airport';

  @override
  String aetherScheduleRouteTooClose(
    String departure,
    String arrival,
    int distance,
  ) {
    return '$departure and $arrival are $distance km apart — too close for a commercial flight';
  }

  @override
  String get aetherScheduleSameAirport =>
      'Departure and arrival cannot be the same airport';

  @override
  String get aetherScheduleSearchButton => 'Search';

  @override
  String get aetherScheduleSearchTooltip => 'Search flights';

  @override
  String get aetherScheduleSectionArrival => 'Arrival Time (Optional)';

  @override
  String get aetherScheduleSectionDeparture => 'Departure Time';

  @override
  String get aetherScheduleSectionFlight => 'Flight Information';

  @override
  String get aetherScheduleSectionNotes => 'Additional Notes (Optional)';

  @override
  String get aetherScheduleSelect => 'Select';

  @override
  String get aetherScheduleSelectDepartureTime =>
      'Please select departure date and time';

  @override
  String get aetherScheduleSignInRequired => 'Sign in to schedule a flight';

  @override
  String get aetherScheduleSuccessInFlight => 'Flight in flight!';

  @override
  String get aetherScheduleSuccessScheduled => 'Flight scheduled!';

  @override
  String get aetherScheduleSwapTooltip => 'Swap airports';

  @override
  String get aetherScheduleTimeLabel => 'Time';

  @override
  String get aetherScheduleTip1 => 'Get a window seat if possible';

  @override
  String get aetherScheduleTip2 => 'Keep node near the window during flight';

  @override
  String get aetherScheduleTip3 => 'Higher TX power = longer range';

  @override
  String get aetherScheduleTip4 => 'Let others know your frequency/region';

  @override
  String get aetherScheduleTipsTitle => 'Tips for best reception';

  @override
  String get aetherScheduleTitle => 'Schedule Flight';

  @override
  String get aetherScheduleToHint => 'JFK';

  @override
  String get aetherScheduleToLabel => 'To';

  @override
  String aetherScheduleTooClose(
    String departure,
    String arrival,
    int distance,
  ) {
    return '$departure and $arrival are only $distance km apart — no commercial routes exist';
  }

  @override
  String aetherScheduleTooFar(String departure, String arrival, int distance) {
    return '$departure to $arrival is $distance — exceeds maximum aircraft range';
  }

  @override
  String get aetherScheduleValidateFlightTooltip => 'Validate flight';

  @override
  String get aetherScreenTitle => 'Aether';

  @override
  String get aetherSearchEmptySubtitle =>
      'Try a different flight number or check\nif the flight is currently airborne';

  @override
  String get aetherSearchEmptyTitle => 'No active flights found';

  @override
  String get aetherSearchError => 'Search failed. Please try again.';

  @override
  String get aetherSearchFlightNumberHint => 'Flight number (e.g. UA123)';

  @override
  String get aetherSearchHint => 'Search flights, airports, nodes...';

  @override
  String get aetherSearchIdleSubtitle =>
      'Type a callsign and press Search\nto find flights currently in the air';

  @override
  String get aetherSearchIdleTitle => 'Search for active flights';

  @override
  String get aetherSearchOnGround => 'On ground';

  @override
  String get aetherSearchRetry => 'Retry';

  @override
  String aetherSearchRouteFrom(String airport) {
    return 'From $airport · En route';
  }

  @override
  String aetherSearchRouteTo(String airport) {
    return 'To $airport';
  }

  @override
  String get aetherSearchTitle => 'Search Flights';

  @override
  String get aetherSearchTooltip => 'Search';

  @override
  String aetherShareText(
    Object flightNumber,
    Object departure,
    Object arrival,
    Object url,
  ) {
    return '$flightNumber $departure → $arrival\nTrack this Meshtastic flight on Aether:\n$url';
  }

  @override
  String get aetherSignInRequired => 'Sign In Required';

  @override
  String get aetherSignInRequiredSubtitle =>
      'Sign in to view and manage your scheduled flights.';

  @override
  String get aetherStatsActive => 'Active';

  @override
  String get aetherStatsRecord => 'Record';

  @override
  String get aetherStatsReports => 'Reports';

  @override
  String get aetherStatsScheduled => 'Scheduled';

  @override
  String get aetherStatusCompleted => 'Completed';

  @override
  String get aetherStatusInFlight => 'In Flight';

  @override
  String get aetherStatusScheduled => 'Scheduled';

  @override
  String get aetherStatusUpcoming => 'Upcoming';

  @override
  String get aetherValidationActive => 'Flight is currently active!';

  @override
  String aetherValidationActiveAlt(int altitude) {
    return 'Flight is currently active! $altitude ft';
  }

  @override
  String get aetherValidationEnterFlightFirst => 'Enter a flight number first';

  @override
  String get aetherValidationFailed => 'Failed to validate flight';

  @override
  String get aetherValidationInvalidFormat => 'Invalid flight number format';

  @override
  String get aetherValidationRateLimited =>
      'Rate limited. Try again in a few minutes.';

  @override
  String get aetherValidationVerified => 'Flight verified in OpenSky records';

  @override
  String get ambientLightingBlue => 'Blue';

  @override
  String get ambientLightingBrightness => 'LED Brightness';

  @override
  String get ambientLightingCurrent => 'Current';

  @override
  String get ambientLightingCurrentSubtitle => 'LED drive current (brightness)';

  @override
  String ambientLightingCurrentValue(int milliamps) {
    return '$milliamps mA';
  }

  @override
  String get ambientLightingCustomColor => 'Custom Color';

  @override
  String get ambientLightingDeviceSupportInfo =>
      'Ambient lighting is only available on devices with LED support (RAK WisBlock, T-Beam, etc.)';

  @override
  String get ambientLightingGreen => 'Green';

  @override
  String get ambientLightingLedEnabled => 'LED Enabled';

  @override
  String get ambientLightingLedEnabledSubtitle =>
      'Turn ambient lighting on or off';

  @override
  String get ambientLightingPresetColors => 'Preset Colors';

  @override
  String get ambientLightingRed => 'Red';

  @override
  String get ambientLightingSave => 'Save';

  @override
  String ambientLightingSaveError(String error) {
    return 'Failed to save: $error';
  }

  @override
  String get ambientLightingSaved => 'Ambient lighting saved';

  @override
  String get ambientLightingTitle => 'Ambient Lighting';

  @override
  String get appTitle => 'Socialmesh';

  @override
  String get automationActionBodyLabel => 'Body';

  @override
  String get automationActionChangeType => 'Change Action Type';

  @override
  String automationActionChannelIndex(int index) {
    return 'Channel $index';
  }

  @override
  String get automationActionChannelMessage => 'Channel message';

  @override
  String automationActionChannelsCount(int count) {
    return '$count channels';
  }

  @override
  String get automationActionCustomSound => 'Custom sound (optional)';

  @override
  String get automationActionDefaultChannel => 'Default channel';

  @override
  String get automationActionDirectMessage => 'Direct message';

  @override
  String get automationActionDone => 'Done';

  @override
  String get automationActionGlyphPattern => 'Glyph pattern (Nothing Phone)';

  @override
  String get automationActionGotIt => 'Got it';

  @override
  String get automationActionIftttEventName => 'IFTTT Event Name';

  @override
  String get automationActionIftttHelp =>
      'Uses your IFTTT Webhook key from Settings';

  @override
  String get automationActionIftttHint => 'e.g., meshtastic_alert';

  @override
  String get automationActionLogEvent => 'Log to history';

  @override
  String get automationActionMessageLabel => 'Message';

  @override
  String get automationActionNoChannels => 'No channels available';

  @override
  String get automationActionNoSoundsFound => 'No sounds found';

  @override
  String get automationActionPlaySound => 'Play alert sound';

  @override
  String get automationActionPlaysAfter => 'Plays after notification';

  @override
  String get automationActionPreview => 'Preview';

  @override
  String get automationActionPrimary => 'Primary';

  @override
  String get automationActionPushNotification => 'Push notification';

  @override
  String get automationActionRtttlRingtone => 'RTTTL ringtone';

  @override
  String get automationActionSearchResults => 'SEARCH RESULTS';

  @override
  String get automationActionSearchSounds => 'Search sounds...';

  @override
  String get automationActionSelectChannel => 'Select channel';

  @override
  String get automationActionSelectChannelTitle => 'Select Channel';

  @override
  String get automationActionSelectNodePlaceholder => 'Select node';

  @override
  String get automationActionSelectSound => 'Select a sound';

  @override
  String get automationActionSendMessage => 'Send message to node';

  @override
  String get automationActionSendToChannel => 'Send to channel';

  @override
  String get automationActionShortcutDataInfo =>
      'Event data (node name, battery, location, etc.) will be passed as JSON input to your shortcut.';

  @override
  String get automationActionShortcutHelpTitle => 'Using Shortcuts';

  @override
  String get automationActionShortcutIosNote =>
      'Note: Shortcuts app will briefly open when triggered. This is an iOS limitation.';

  @override
  String get automationActionShortcutKeyBattery => 'Battery % (if available)';

  @override
  String get automationActionShortcutKeyLatitude =>
      'GPS latitude (if available)';

  @override
  String get automationActionShortcutKeyLongitude =>
      'GPS longitude (if available)';

  @override
  String get automationActionShortcutKeyMessage =>
      'Message text (if applicable)';

  @override
  String get automationActionShortcutKeyNodeName => 'Name of the node';

  @override
  String get automationActionShortcutKeyNodeNum => 'Node number';

  @override
  String get automationActionShortcutKeyTimestamp => 'Event timestamp';

  @override
  String get automationActionShortcutKeyTrigger =>
      'Trigger type (nodeOffline, etc.)';

  @override
  String get automationActionShortcutKeysTitle =>
      'Available keys in the dictionary:';

  @override
  String get automationActionShortcutNameHint => 'Enter exact shortcut name';

  @override
  String get automationActionShortcutNameLabel => 'Shortcut Name';

  @override
  String get automationActionShortcutSetup => 'Setting up your shortcut:';

  @override
  String get automationActionShortcutStep1 =>
      'Add \"Get Dictionary from\" action\nSelect \"Shortcut Input\"';

  @override
  String get automationActionShortcutStep2 =>
      'Add \"Get Value for\" action\nSet key (e.g., node_name) and select \"Dictionary\"';

  @override
  String get automationActionShortcutStep3 =>
      'Use the extracted value in your actions\n(e.g., Send Message, Show Notification)';

  @override
  String get automationActionSoundSection => 'SOUND';

  @override
  String automationActionSoundsCount(int count) {
    return '$count sounds';
  }

  @override
  String get automationActionSuggestions => 'SUGGESTIONS';

  @override
  String get automationActionSystemDefault => 'System default';

  @override
  String get automationActionTapToChoose => 'Tap to choose';

  @override
  String get automationActionTitleLabel => 'Title';

  @override
  String get automationActionTo => 'TO';

  @override
  String get automationActionTriggerShortcut => 'Run iOS Shortcut';

  @override
  String get automationActionTriggerWebhook => 'Trigger webhook (IFTTT)';

  @override
  String get automationActionUpdateWidget => 'Update home widget';

  @override
  String get automationActionVariableHint => 'Tap variables below to insert';

  @override
  String get automationActionVibrate => 'Vibrate device';

  @override
  String automationCardActionCount(int count, String s) {
    return '$count action$s';
  }

  @override
  String automationCardDaysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String automationCardHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String get automationCardJustNow => 'Just now';

  @override
  String automationCardMinutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String automationCardRunsCount(int count) {
    return '$count runs';
  }

  @override
  String automationCardWeeksAgo(int count) {
    return '${count}w ago';
  }

  @override
  String get automationCategoryBattery => 'Battery';

  @override
  String get automationCategoryLocation => 'Location';

  @override
  String get automationCategoryManual => 'Manual';

  @override
  String get automationCategoryMessages => 'Messages';

  @override
  String get automationCategoryNodeStatus => 'Node Status';

  @override
  String get automationCategorySensors => 'Sensors';

  @override
  String get automationCategorySignal => 'Signal';

  @override
  String get automationCategoryTime => 'Time';

  @override
  String get automationConditionBatteryAbove => 'Battery above threshold';

  @override
  String get automationConditionBatteryBelow => 'Battery below threshold';

  @override
  String get automationConditionDayOfWeek => 'On specific days';

  @override
  String get automationConditionNodeOffline => 'Node is inactive';

  @override
  String get automationConditionNodeOnline => 'Node is active';

  @override
  String get automationConditionOutsideGeofence => 'Outside geofence';

  @override
  String get automationConditionTimeRange => 'During time range';

  @override
  String get automationConditionWithinGeofence => 'Within geofence';

  @override
  String get automationDebugBatteryNotMet => 'Battery threshold not met';

  @override
  String get automationDebugChannelMismatch => 'Channel filter mismatch';

  @override
  String get automationDebugConditionFailed => 'Condition failed';

  @override
  String get automationDebugDisabled => 'Disabled';

  @override
  String get automationDebugKeywordNotMatched => 'Keyword not matched';

  @override
  String get automationDebugNodeFilterMismatch => 'Node filter mismatch';

  @override
  String get automationDebugSignalNotMet => 'Signal threshold not met';

  @override
  String get automationDebugThrottled => 'Throttled';

  @override
  String get automationDebugTriggerMismatch => 'Trigger type mismatch';

  @override
  String get automationDefaultMsgManual => 'Automation triggered manually';

  @override
  String get automationEditorAddAction => 'Add Action';

  @override
  String get automationEditorCreateAutomation => 'Create Automation';

  @override
  String get automationEditorCreated => 'Automation created';

  @override
  String get automationEditorDeleteError => 'Failed to delete automation';

  @override
  String get automationEditorDeleteTooltip => 'Delete';

  @override
  String automationEditorDescBatteryLow(String threshold) {
    return 'Triggered when battery drops below $threshold%';
  }

  @override
  String automationEditorDescSilent(int minutes) {
    return 'Alert if no activity from node for $minutes minutes';
  }

  @override
  String get automationEditorDescriptionHint => 'What does this automation do?';

  @override
  String get automationEditorDescriptionLabel => 'Description (optional)';

  @override
  String automationEditorInvalidVars(String vars) {
    return 'Invalid variables: $vars';
  }

  @override
  String get automationEditorNameHint => 'e.g., Low Battery Alert';

  @override
  String get automationEditorNameLabel => 'Name';

  @override
  String get automationEditorNoActions => 'No actions configured';

  @override
  String get automationEditorNoActionsHint => 'Tap \"+ Add Action\" to add one';

  @override
  String get automationEditorSaveChanges => 'Save Changes';

  @override
  String get automationEditorSaveError => 'Failed to save automation';

  @override
  String get automationEditorSaving => 'Saving...';

  @override
  String automationEditorStepNumber(int number) {
    return 'Step $number';
  }

  @override
  String get automationEditorThen => 'THEN';

  @override
  String get automationEditorThen2 => 'then...';

  @override
  String get automationEditorThenDo => 'then do...';

  @override
  String get automationEditorTitleEdit => 'Edit Automation';

  @override
  String get automationEditorTitleNew => 'New Automation';

  @override
  String get automationEditorUpdated => 'Automation updated';

  @override
  String get automationEditorValidateActions =>
      'Please add at least one action';

  @override
  String get automationEditorValidateName =>
      'Please enter a name for this automation';

  @override
  String get automationEditorWhen => 'WHEN';

  @override
  String get automationEngineAutomationTriggered => 'Automation triggered.';

  @override
  String get automationFlowAddNode => 'Add Node';

  @override
  String get automationFlowCompilationIssues => 'Compilation Issues';

  @override
  String get automationFlowCreate => 'Create';

  @override
  String get automationFlowCreated => 'Automation created';

  @override
  String get automationFlowDiscard => 'Discard';

  @override
  String get automationFlowDiscardMessage =>
      'You have unsaved changes in the flow editor. Discard them and go back?';

  @override
  String get automationFlowDiscardTitle => 'Discard Changes?';

  @override
  String get automationFlowEditTitle => 'Edit Flow';

  @override
  String get automationFlowErrors => 'Errors';

  @override
  String get automationFlowKeepEditing => 'Keep Editing';

  @override
  String get automationFlowNameHint => 'Flow name...';

  @override
  String get automationFlowNewTitle => 'New Flow';

  @override
  String get automationFlowNoCompilation =>
      'No automations could be compiled from this graph';

  @override
  String automationFlowNodesCount(int count) {
    return '$count nodes';
  }

  @override
  String get automationFlowSave => 'Save';

  @override
  String get automationFlowSaveError => 'Failed to save automation';

  @override
  String get automationFlowToolbarAdd => 'Add';

  @override
  String automationFlowToolbarDelete(int count) {
    return 'Delete ($count)';
  }

  @override
  String get automationFlowToolbarFit => 'Fit';

  @override
  String get automationFlowToolbarRedo => 'Redo';

  @override
  String get automationFlowToolbarUndo => 'Undo';

  @override
  String get automationFlowUpdated => 'Automation updated';

  @override
  String get automationFlowValidateName =>
      'Please enter a name for this automation';

  @override
  String get automationFlowValidationTooltip => 'Validation issues';

  @override
  String get automationFlowWarnings => 'Warnings';

  @override
  String automationImportActionsCount(int count) {
    return 'Actions ($count)';
  }

  @override
  String get automationImportButton => 'Import';

  @override
  String automationImportConditionsCount(int count) {
    return 'Conditions ($count)';
  }

  @override
  String automationImportConditionsText(int count) {
    return '$count conditions';
  }

  @override
  String get automationImportEditFirst => 'Edit First';

  @override
  String automationImportError(String error) {
    return 'Failed to import: $error';
  }

  @override
  String automationImportFailed(String error) {
    return 'Failed to import automation: $error';
  }

  @override
  String get automationImportFailedTitle => 'Import Failed';

  @override
  String get automationImportGoBack => 'Go Back';

  @override
  String get automationImportNoData => 'No automation data provided';

  @override
  String get automationImportNotFound =>
      'Automation not found or has been deleted';

  @override
  String get automationImportSuccess => 'Automation imported successfully';

  @override
  String get automationImportTitle => 'Import Automation';

  @override
  String get automationImportTrigger => 'Trigger';

  @override
  String get automationImportView => 'View';

  @override
  String get automationImportWarning =>
      'This automation will be imported as disabled. Review and enable it when ready.';

  @override
  String get automationNotificationFallbackBody =>
      'An automation was triggered.';

  @override
  String get automationNotificationFallbackTitle => 'Alert';

  @override
  String get automationScreenAcceptableUse => 'Acceptable Use';

  @override
  String get automationScreenAddAutomation => 'Add Automation';

  @override
  String get automationScreenClear => 'Clear';

  @override
  String get automationScreenCreateFromScratch => 'Create from Scratch';

  @override
  String get automationScreenCreateFromScratchSubtitle =>
      'Build a custom automation with full control over triggers and actions';

  @override
  String get automationScreenCreatedFromTemplate =>
      'Automation created from template';

  @override
  String automationScreenDaysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String get automationScreenDelete => 'Delete';

  @override
  String automationScreenDeleteMessage(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get automationScreenDeleteTitle => 'Delete Automation';

  @override
  String get automationScreenEmptyDescription =>
      'Create automations to trigger actions automatically when events occur on your mesh network.';

  @override
  String get automationScreenEmptyTitle => 'Automate Your Mesh';

  @override
  String get automationScreenExecutionLog => 'Execution Log';

  @override
  String get automationScreenHelp => 'Help';

  @override
  String automationScreenHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String get automationScreenJustNow => 'Just now';

  @override
  String get automationScreenLoadError => 'Failed to load automations';

  @override
  String automationScreenMinutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String get automationScreenNewTooltip => 'New Automation';

  @override
  String get automationScreenNoExecutions => 'No executions yet';

  @override
  String get automationScreenQuickStartSubtitle =>
      'One-tap setup for common use cases';

  @override
  String get automationScreenQuickStartTemplates => 'Quick Start Templates';

  @override
  String get automationScreenRetry => 'Retry';

  @override
  String get automationScreenScanQrCode => 'Scan QR Code';

  @override
  String get automationScreenStartWithTrigger => 'Start with a Trigger';

  @override
  String get automationScreenStartWithTriggerSubtitle =>
      'Choose what event starts your automation';

  @override
  String get automationScreenStatActive => 'Active';

  @override
  String get automationScreenStatExecutions => 'Executions';

  @override
  String get automationScreenStatTotal => 'Total';

  @override
  String get automationScreenTitle => 'Automations';

  @override
  String automationScreenRunning(String name) {
    return 'Running \"$name\"...';
  }

  @override
  String automationScreenRunSuccess(String name) {
    return 'Ran \"$name\" successfully';
  }

  @override
  String automationScreenRunFailed(String error) {
    return 'Failed to run: $error';
  }

  @override
  String automationScreenDeleting(String name) {
    return 'Deleting \"$name\"...';
  }

  @override
  String automationScreenDeleted(String name) {
    return 'Deleted \"$name\"';
  }

  @override
  String get automationShareMessage =>
      'Check out this automation on Socialmesh!';

  @override
  String get automationShareScanInfo =>
      'Scan this QR code in Socialmesh to import this automation';

  @override
  String get automationShareSignIn => 'Sign in to share automations';

  @override
  String get automationShareSignInAction => 'Sign In';

  @override
  String automationShareSubject(String name) {
    return 'Socialmesh Automation: $name';
  }

  @override
  String get automationShareTitle => 'Share Automation';

  @override
  String get automationTemplateDeadManDesc =>
      'Alert if no activity from node for 30 minutes';

  @override
  String get automationTemplateDeadManName => 'Dead Man\'s Switch';

  @override
  String get automationTemplateDeadManSwitchDesc =>
      'Alert if node silent too long';

  @override
  String get automationTemplateDefaultName => 'New Automation';

  @override
  String get automationTemplateGeofenceExitDesc =>
      'Alert when a node leaves a designated area';

  @override
  String get automationTemplateGeofenceExitFullDesc =>
      'Alert when leaving a designated area';

  @override
  String get automationTemplateGeofenceExitName => 'Geofence Exit Alert';

  @override
  String get automationTemplateLowBatteryDesc =>
      'Notify when a node battery drops below 20%';

  @override
  String get automationTemplateLowBatteryName => 'Low Battery Alert';

  @override
  String get automationTemplateLowBatteryShortDesc =>
      'Notify when battery drops below 20%';

  @override
  String get automationTemplateNodeOfflineDesc =>
      'Notify when a node goes offline';

  @override
  String get automationTemplateNodeOfflineName => 'Node Offline Alert';

  @override
  String get automationTemplateNotifDeadManTitle => 'Node Silent';

  @override
  String get automationTemplateNotifGeofenceTitle => 'Left Area';

  @override
  String get automationTemplateNotifNodeOfflineTitle => 'Node Offline';

  @override
  String get automationTemplateNotifSosTitle => 'Emergency Alert';

  @override
  String get automationTemplateSosDesc =>
      'Auto-reply when receiving SOS message';

  @override
  String get automationTemplateSosName => 'SOS Auto-Response';

  @override
  String get automationTemplateSosResponseDesc => 'Alert on emergency messages';

  @override
  String get automationTriggerAnyChannel => 'Any channel';

  @override
  String get automationTriggerAnyNode => 'Any node';

  @override
  String get automationTriggerBatteryFull => 'Battery fully charged';

  @override
  String get automationTriggerBatteryLow => 'Battery drops below threshold';

  @override
  String get automationTriggerBatteryThreshold => 'Battery threshold';

  @override
  String get automationTriggerChannelActivity => 'Activity on channel';

  @override
  String get automationTriggerChannelHelp =>
      'Leave empty to trigger for any channel activity';

  @override
  String automationTriggerChannelIndex(int index) {
    return 'Channel $index';
  }

  @override
  String get automationTriggerChannelLabel => 'Channel (optional)';

  @override
  String get automationTriggerDaily => 'Daily';

  @override
  String get automationTriggerDayFri => 'Fri';

  @override
  String get automationTriggerDayMon => 'Mon';

  @override
  String get automationTriggerDaySat => 'Sat';

  @override
  String get automationTriggerDaySun => 'Sun';

  @override
  String get automationTriggerDayThu => 'Thu';

  @override
  String get automationTriggerDayTue => 'Tue';

  @override
  String get automationTriggerDayWed => 'Wed';

  @override
  String get automationTriggerDays => 'Days';

  @override
  String get automationTriggerDescBatteryFull =>
      'Triggered when battery is fully charged';

  @override
  String get automationTriggerDescBatteryLow =>
      'Triggered when battery drops below threshold';

  @override
  String get automationTriggerDescChannelActivity =>
      'Triggered when activity on channel';

  @override
  String get automationTriggerDescDetectionSensor =>
      'Triggered when detection sensor activates';

  @override
  String get automationTriggerDescGeofenceEnter =>
      'Triggered when node enters geofence area';

  @override
  String get automationTriggerDescGeofenceExit =>
      'Triggered when node exits geofence area';

  @override
  String get automationTriggerDescManual =>
      'Triggered manually via Shortcuts or UI';

  @override
  String get automationTriggerDescMessageContains =>
      'Triggered when message contains keyword';

  @override
  String get automationTriggerDescMessageReceived =>
      'Triggered when any message is received';

  @override
  String get automationTriggerDescNodeOffline =>
      'Triggered when a node is not heard for a while';

  @override
  String get automationTriggerDescNodeOnline =>
      'Triggered when a node is heard recently';

  @override
  String get automationTriggerDescNodeSilent =>
      'Triggered when node is silent for duration';

  @override
  String get automationTriggerDescPositionChanged =>
      'Triggered when node position changes';

  @override
  String get automationTriggerDescScheduled => 'Triggered at scheduled time';

  @override
  String get automationTriggerDescSignalWeak =>
      'Triggered when signal strength drops';

  @override
  String get automationTriggerDetectionSensor => 'Detection sensor triggered';

  @override
  String automationTriggerEveryHours(int hours, String s) {
    return 'Every $hours hour$s';
  }

  @override
  String automationTriggerEveryHoursMinutes(int hours, String s, int minutes) {
    return 'Every $hours hour$s $minutes minutes';
  }

  @override
  String automationTriggerEveryMinutes(int count) {
    return 'Every $count minutes';
  }

  @override
  String get automationTriggerGeofenceCenter => 'Geofence Center';

  @override
  String get automationTriggerGeofenceEnter => 'Enters geofence area';

  @override
  String get automationTriggerGeofenceExit => 'Exits geofence area';

  @override
  String get automationTriggerInterval => 'Interval';

  @override
  String get automationTriggerKeywordHint => 'e.g., SOS, help, emergency';

  @override
  String get automationTriggerKeywordLabel => 'Keyword to match';

  @override
  String get automationTriggerLatitude => 'Latitude';

  @override
  String get automationTriggerLongitude => 'Longitude';

  @override
  String get automationTriggerManual => 'Manual trigger';

  @override
  String get automationTriggerManualDescription =>
      'This automation can be triggered manually from:\n• The Automations screen (tap the play button)\n• Siri Shortcuts\n• Widgets';

  @override
  String get automationTriggerManualTitle => 'Manual Trigger';

  @override
  String get automationTriggerMessageContains => 'Message contains keyword';

  @override
  String get automationTriggerMessageReceived => 'Message received';

  @override
  String get automationTriggerNodeFilterHelp =>
      'Leave empty to trigger for any node';

  @override
  String get automationTriggerNodeFilterLabel => 'Filter by node (optional)';

  @override
  String get automationTriggerNodeOffline => 'Node becomes inactive';

  @override
  String get automationTriggerNodeOnline => 'Node becomes active';

  @override
  String get automationTriggerNodeSilent => 'Node silent for duration';

  @override
  String get automationTriggerPickOnMap => 'Pick on Map';

  @override
  String get automationTriggerPositionChanged => 'Position updated';

  @override
  String get automationTriggerRadius => 'Radius';

  @override
  String get automationTriggerRepeatEvery => 'Repeat every';

  @override
  String get automationTriggerScheduleType => 'Schedule Type';

  @override
  String get automationTriggerScheduled => 'Scheduled time';

  @override
  String get automationTriggerSelectNode => 'Select Node';

  @override
  String get automationTriggerSelectTrigger => 'Select Trigger';

  @override
  String get automationTriggerSensorAny => 'Any';

  @override
  String get automationTriggerSensorClear => 'Clear';

  @override
  String get automationTriggerSensorDetected => 'Detected';

  @override
  String get automationTriggerSensorNameHelp =>
      'Leave empty to trigger for any sensor';

  @override
  String get automationTriggerSensorNameHint => 'e.g., Motion, Door, Window';

  @override
  String get automationTriggerSensorNameLabel =>
      'Sensor name filter (optional)';

  @override
  String get automationTriggerSensorState => 'Trigger when sensor is';

  @override
  String get automationTriggerSignalThreshold => 'Signal threshold (SNR)';

  @override
  String get automationTriggerSignalWeak => 'Signal strength drops';

  @override
  String get automationTriggerSilentDuration => 'Silent duration';

  @override
  String get automationTriggerTime => 'Time';

  @override
  String get automationTriggerWeekly => 'Weekly';

  @override
  String get automationValidateGeofence => 'Please select a geofence location';

  @override
  String get automationValidateKeyword => 'Please enter a keyword to match';

  @override
  String get automationValidateMessage => 'Please enter a message to send';

  @override
  String get automationValidateSchedule => 'Please set a schedule time';

  @override
  String get automationValidateShortcutName => 'Please enter a Shortcut name';

  @override
  String get automationValidateTargetNode => 'Please select a target node';

  @override
  String get automationValidateWebhookEvent =>
      'Please enter a webhook event name';

  @override
  String get automationVariableAllVariables => 'All variables';

  @override
  String get automationVariableDeleteHint =>
      'Tap a variable to select it, then backspace to remove';

  @override
  String get automationVariableDescBattery => 'Current battery percentage';

  @override
  String get automationVariableDescChannelName => 'Channel name';

  @override
  String get automationVariableDescKeyword => 'Matched keyword';

  @override
  String get automationVariableDescLocation => 'GPS coordinates (lat, lon)';

  @override
  String get automationVariableDescMessage => 'Message content';

  @override
  String get automationVariableDescNodeName => 'Name of the triggering node';

  @override
  String get automationVariableDescNodeNum => 'Node number in hex (e.g. a1b2)';

  @override
  String get automationVariableDescSensorName => 'Detection sensor name';

  @override
  String get automationVariableDescSensorState =>
      'Sensor state (detected / clear)';

  @override
  String get automationVariableDescSignalThreshold =>
      'Signal threshold in dB (SNR)';

  @override
  String get automationVariableDescSilentDuration => 'Silent duration setting';

  @override
  String get automationVariableDescThreshold => 'Configured trigger threshold';

  @override
  String get automationVariableDescTime => 'Current timestamp (ISO 8601)';

  @override
  String get automationVariableDescZoneRadius => 'Geofence radius in meters';

  @override
  String get automationVariableNoMatch => 'No matching variables';

  @override
  String get automationVariablePickerTitle => 'Insert Variable';

  @override
  String get automationVariableSearchHint => 'Search variables...';

  @override
  String get automationVariableSectionTrigger => 'Trigger context';

  @override
  String get automationVariableSectionUniversal => 'Universal';

  @override
  String get categoryProductsApplyFilters => 'Apply Filters';

  @override
  String get categoryProductsClearFilters => 'Clear Filters';

  @override
  String get categoryProductsErrorLoading => 'Error loading products';

  @override
  String get categoryProductsFilter => 'Filter';

  @override
  String get categoryProductsFiltersTitle => 'Filters';

  @override
  String get categoryProductsFrequencyBands => 'Frequency Bands';

  @override
  String get categoryProductsInStockOnly => 'In Stock Only';

  @override
  String get categoryProductsNotFound => 'No products found';

  @override
  String get categoryProductsOutOfStock => 'OUT OF STOCK';

  @override
  String get categoryProductsPriceRange => 'Price Range';

  @override
  String get categoryProductsReset => 'Reset';

  @override
  String categoryProductsResultCount(int count) {
    return '$count products';
  }

  @override
  String get categoryProductsRetry => 'Retry';

  @override
  String get categoryProductsSortNewest => 'Newest First';

  @override
  String get categoryProductsSortPopular => 'Most Popular';

  @override
  String get categoryProductsSortPriceHigh => 'Price: High to Low';

  @override
  String get categoryProductsSortPriceLow => 'Price: Low to High';

  @override
  String get categoryProductsSortRating => 'Highest Rated';

  @override
  String get categoryProductsTryFilters => 'Try adjusting your filters';

  @override
  String get channelFormApproxLocationTitle => 'Approximate Location';

  @override
  String get channelFormCreatedSnackbar => 'Channel created';

  @override
  String channelFormDefaultName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelFormDeviceNotConnected =>
      'Cannot save channel: Device not connected';

  @override
  String get channelFormDeviceNotReady =>
      'Device not ready - please wait for connection';

  @override
  String get channelFormDownlinkSubtitle => 'Receive messages from MQTT server';

  @override
  String get channelFormDownlinkTitle => 'Downlink Enabled';

  @override
  String get channelFormEditTitle => 'Edit Channel';

  @override
  String get channelFormEncryptionLabel => 'Encryption';

  @override
  String channelFormError(String error) {
    return 'Error: $error';
  }

  @override
  String get channelFormInvalidBase64 => 'Invalid base64 encoding';

  @override
  String channelFormInvalidKeySize(int byteCount) {
    return 'Invalid key size ($byteCount bytes). Use 1, 16, or 32 bytes.';
  }

  @override
  String get channelFormKeyEmpty => 'Key cannot be empty';

  @override
  String get channelFormKeySizeAes128 => 'AES-128';

  @override
  String get channelFormKeySizeAes256 => 'AES-256';

  @override
  String channelFormKeySizeBitDesc(int bits) {
    return '$bits-bit encryption key';
  }

  @override
  String get channelFormKeySizeDefault => 'Default (Simple)';

  @override
  String get channelFormKeySizeDefaultDesc => '1-byte simple key (AQ==)';

  @override
  String get channelFormKeySizeNone => 'No Encryption';

  @override
  String get channelFormKeySizeNoneDesc => 'Messages sent in plaintext';

  @override
  String get channelFormMaxChannelsReached => 'Maximum 8 channels allowed';

  @override
  String get channelFormMqttLabel => 'MQTT';

  @override
  String get channelFormMqttWarning =>
      'Most devices have very limited processing power and RAM. Bridging a busy channel like LongFast via the default MQTT server can flood the device with 15-25 packets per second, causing it to stop responding. Consider using a private broker or a quieter channel.';

  @override
  String get channelFormNameHint => 'Enter channel name (no spaces)';

  @override
  String get channelFormNameMaxHint => 'Max 11 characters';

  @override
  String get channelFormNameTitle => 'Channel Name';

  @override
  String get channelFormNewTitle => 'New Channel';

  @override
  String get channelFormPositionEnabledSubtitle =>
      'Share position on this channel';

  @override
  String get channelFormPositionEnabledTitle => 'Positions Enabled';

  @override
  String get channelFormPositionLabel => 'Position';

  @override
  String get channelFormPreciseLocationSubtitle =>
      'Share exact GPS coordinates';

  @override
  String get channelFormPreciseLocationTitle => 'Precise Location';

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
  String get channelFormPrimaryChannelNote =>
      'This is the main channel for device communication. Changes may affect connectivity.';

  @override
  String get channelFormPrimaryChannelTitle => 'Primary Channel';

  @override
  String get channelFormSaveButton => 'Save';

  @override
  String get channelFormUpdatedSnackbar => 'Channel updated';

  @override
  String get channelFormUplinkSubtitle => 'Forward messages to MQTT server';

  @override
  String get channelFormUplinkTitle => 'Uplink Enabled';

  @override
  String get channelOptionsCopyButton => 'Copy';

  @override
  String channelOptionsDefaultName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelOptionsDelete => 'Delete Channel';

  @override
  String get channelOptionsDeleteButton => 'Delete';

  @override
  String channelOptionsDeleteConfirm(String name) {
    return 'Delete channel \"$name\"?';
  }

  @override
  String channelOptionsDeleteFailed(String error) {
    return 'Failed to delete channel: $error';
  }

  @override
  String get channelOptionsDeleteNotConnected =>
      'Cannot delete channel: Device not connected';

  @override
  String get channelOptionsDeleteTitle => 'Delete Channel';

  @override
  String get channelOptionsEdit => 'Edit Channel';

  @override
  String get channelOptionsEncrypted => 'Encrypted';

  @override
  String get channelOptionsHideButton => 'Hide';

  @override
  String get channelOptionsInviteLink => 'Share Invite Link';

  @override
  String get channelOptionsKeyCopied => 'Key copied to clipboard';

  @override
  String channelOptionsKeySubtitle(int keyBits, int keyBytes) {
    return '$keyBits-bit · $keyBytes bytes · Base64';
  }

  @override
  String get channelOptionsKeyTitle => 'Encryption Key';

  @override
  String get channelOptionsNoEncryption => 'No encryption';

  @override
  String get channelOptionsShare => 'Share Channel';

  @override
  String get channelOptionsShowButton => 'Show';

  @override
  String get channelOptionsViewKey => 'View Encryption Key';

  @override
  String get channelShareCreatingInvite => 'Creating invite link...';

  @override
  String channelShareDefaultName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelShareInviteCopied => 'Invite link copied to clipboard';

  @override
  String get channelShareInviteFailed => 'Failed to create invite link';

  @override
  String get channelShareMessage => 'Join my channel on Socialmesh!';

  @override
  String get channelShareQrInfo =>
      'Scan this QR code in Socialmesh to import this channel';

  @override
  String get channelShareSignInAction => 'Sign In';

  @override
  String get channelShareSignInRequired => 'Sign in to share channels';

  @override
  String channelShareSubject(String channelName) {
    return 'Socialmesh Channel: $channelName';
  }

  @override
  String get channelShareTitle => 'Share Channel';

  @override
  String get channelWizardBackButton => 'Back';

  @override
  String get channelWizardCompatMax =>
      'Highest security. Ensure all participants support AES-256 encryption.';

  @override
  String get channelWizardCompatOpen =>
      'Compatible with all devices. No key exchange needed.';

  @override
  String get channelWizardCompatPrivate =>
      'Recommended. Share the QR code securely with people you want to communicate with.';

  @override
  String get channelWizardCompatShared =>
      'Uses the default Meshtastic key. Other users with default settings may intercept messages.';

  @override
  String get channelWizardContinueButton => 'Continue';

  @override
  String get channelWizardCopyUrlButton => 'Copy URL';

  @override
  String get channelWizardCreateButton => 'Create Channel';

  @override
  String channelWizardCreateFailed(String error) {
    return 'Failed to create channel: $error';
  }

  @override
  String get channelWizardCreatedHeading => 'Channel Created!';

  @override
  String get channelWizardCreatedSubtitle =>
      'Share this QR code with others to let them join.';

  @override
  String get channelWizardCreating => 'Creating channel...';

  @override
  String get channelWizardDefaultKey => 'Default key';

  @override
  String get channelWizardDeviceNotConnected =>
      'Cannot save channel: Device not connected';

  @override
  String get channelWizardDisabled => 'Disabled';

  @override
  String get channelWizardDoneButton => 'Done';

  @override
  String get channelWizardDownlinkSubtitle =>
      'Receive messages from MQTT and broadcast them on this channel.';

  @override
  String get channelWizardDownlinkTitle => 'Downlink Enabled';

  @override
  String get channelWizardEnabled => 'Enabled';

  @override
  String get channelWizardEncryptionKeyLabel => 'Encryption Key';

  @override
  String get channelWizardHelpTooltip => 'Help';

  @override
  String channelWizardKeyBits(int bits) {
    return '$bits bits';
  }

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
  String get channelWizardKeySizeDefault => 'Default';

  @override
  String get channelWizardKeySizeDefaultDesc =>
      'Simple shared key - compatible but not secure';

  @override
  String get channelWizardKeySizeNone => 'None';

  @override
  String get channelWizardKeySizeNoneDesc =>
      'No encryption - messages are sent in plain text';

  @override
  String get channelWizardMqttFloodWarning =>
      'Most devices have very limited processing power and RAM. Bridging a busy channel like LongFast via the default MQTT server can flood the device with 15-25 packets per second, causing it to stop responding. Consider using a private broker or a quieter channel.';

  @override
  String get channelWizardMqttHeader => 'MQTT Settings';

  @override
  String get channelWizardMqttWarning =>
      'MQTT must be configured on your device for uplink/downlink to work.';

  @override
  String get channelWizardNameBannerInfo =>
      'Channel names are limited to 12 alphanumeric characters.';

  @override
  String get channelWizardNameHeading => 'Name Your Channel';

  @override
  String get channelWizardNameHint => 'e.g., Family, Friends, Hiking';

  @override
  String get channelWizardNameLabel => 'Channel Name';

  @override
  String get channelWizardNameSubtitle =>
      'Choose a name that helps you identify this channel. It will be visible to anyone who joins.';

  @override
  String get channelWizardNoKey => 'No key';

  @override
  String get channelWizardOptionsHeading => 'Advanced Options';

  @override
  String get channelWizardOptionsSubtitle =>
      'Configure optional channel settings.';

  @override
  String get channelWizardPositionSubtitle =>
      'Share your position on this channel.';

  @override
  String get channelWizardPositionTitle => 'Position Enabled';

  @override
  String get channelWizardPrivacyHeading => 'Choose Privacy Level';

  @override
  String get channelWizardPrivacyMaxDesc =>
      'AES-256 encryption for maximum security. Ideal for sensitive communications. Slightly higher battery usage.';

  @override
  String get channelWizardPrivacyMaxTitle => 'Maximum Security';

  @override
  String get channelWizardPrivacyOpenDesc =>
      'No encryption. Anyone with a compatible radio can read your messages. Use only for public broadcasts.';

  @override
  String get channelWizardPrivacyOpenTitle => 'Open Channel';

  @override
  String get channelWizardPrivacyPrivateDesc =>
      'AES-128 encryption with a random key. Only people you share the QR code with can join. Recommended for most uses.';

  @override
  String get channelWizardPrivacyPrivateTitle => 'Private Channel';

  @override
  String get channelWizardPrivacySharedDesc =>
      'Uses the well-known default key. Other Meshtastic users may be able to read messages. Good for community channels.';

  @override
  String get channelWizardPrivacySharedTitle => 'Shared Channel';

  @override
  String get channelWizardPrivacySubtitle =>
      'Select how secure you want this channel to be. Higher security uses stronger encryption.';

  @override
  String get channelWizardRadioComplianceLink => 'View Radio Compliance Rules';

  @override
  String get channelWizardReviewEncryption => 'Encryption';

  @override
  String get channelWizardReviewHeading => 'Review & Create';

  @override
  String get channelWizardReviewKeySize => 'Key Size';

  @override
  String get channelWizardReviewMqttDownlink => 'MQTT Downlink';

  @override
  String get channelWizardReviewMqttUplink => 'MQTT Uplink';

  @override
  String get channelWizardReviewName => 'Name';

  @override
  String get channelWizardReviewPositionSharing => 'Position Sharing';

  @override
  String get channelWizardReviewPrivacyLevel => 'Privacy Level';

  @override
  String get channelWizardReviewSubtitle =>
      'Review your channel settings before creating.';

  @override
  String get channelWizardScreenTitle => 'Create Channel';

  @override
  String get channelWizardStepNameContent =>
      'Choose a memorable name for your channel.\n\n• Names are limited to 12 characters\n• Only letters and numbers allowed\n• The name is visible to anyone who joins\n• Pick something descriptive like \"Family\" or \"Hiking\"';

  @override
  String get channelWizardStepNameTitle => 'Channel Name';

  @override
  String get channelWizardStepOptionsContent =>
      'Configure optional channel settings.\n\n• Position Sharing: Allow location sharing on this channel\n• MQTT Uplink: Send messages to the internet (requires MQTT setup)\n• MQTT Downlink: Receive messages from the internet\n• Encryption Key: Auto-generated, but you can paste a custom key\n\nMost users can skip these advanced options.';

  @override
  String get channelWizardStepOptionsTitle => 'Advanced Options';

  @override
  String get channelWizardStepPrivacyContent =>
      'Select how secure your channel should be.\n\n• OPEN: No encryption - anyone can read messages\n• SHARED: Uses the default Meshtastic key - not private\n• PRIVATE (Recommended): Unique AES-128 key - secure\n• MAXIMUM: AES-256 encryption - highest security\n\nHigher security requires sharing your channel key with others.';

  @override
  String get channelWizardStepPrivacyTitle => 'Privacy Level';

  @override
  String get channelWizardStepReviewContent =>
      'Review your channel settings before creating.\n\n• Verify the name and privacy level are correct\n• After creation, share the QR code with others\n• Others scan the QR code to join your channel\n• You can also copy the URL to share via text';

  @override
  String get channelWizardStepReviewTitle => 'Review & Create';

  @override
  String get channelWizardSummaryEncryption => 'Encryption';

  @override
  String get channelWizardSummaryName => 'Name';

  @override
  String get channelWizardSummaryPrivacy => 'Privacy';

  @override
  String get channelWizardUplinkSubtitle =>
      'Send messages from this channel to MQTT when connected to the internet.';

  @override
  String get channelWizardUplinkTitle => 'Uplink Enabled';

  @override
  String get channelWizardUrlCopied => 'Channel URL copied to clipboard';

  @override
  String get channelsClearSearch => 'Clear search';

  @override
  String channelsDefaultChannelName(int index) {
    return 'Channel $index';
  }

  @override
  String get channelsEmpty => 'No channels configured';

  @override
  String get channelsEmptySubtitle =>
      'Channels are still being loaded from device\nor use the icons above to add channels';

  @override
  String get channelsFilterAll => 'All';

  @override
  String get channelsFilterEncrypted => 'Encrypted';

  @override
  String get channelsFilterMqtt => 'MQTT';

  @override
  String get channelsFilterPosition => 'Position';

  @override
  String get channelsFilterPrimary => 'Primary';

  @override
  String get channelsMenuAddChannel => 'Add Channel';

  @override
  String get channelsMenuHelp => 'Help';

  @override
  String get channelsMenuScanQrCode => 'Scan QR Code';

  @override
  String get channelsMenuSettings => 'Settings';

  @override
  String channelsNoMatch(String query) {
    return 'No channels match \"$query\"';
  }

  @override
  String get channelsPrimaryChannelName => 'Primary Channel';

  @override
  String channelsScreenTitle(int count) {
    return 'Channels ($count)';
  }

  @override
  String get channelsSearchHint => 'Search channels';

  @override
  String get channelsTileEncrypted => 'Encrypted';

  @override
  String get channelsTileNoEncryption => 'No encryption';

  @override
  String get channelsTilePrimaryBadge => 'PRIMARY';

  @override
  String get channelsUnreadOverflow => '99+';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonDone => 'Done';

  @override
  String commonErrorWithDetails(String error) {
    return 'Error: $error';
  }

  @override
  String get commonGoBack => 'Go Back';

  @override
  String get commonOk => 'OK';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonSave => 'Save';

  @override
  String get deviceConfigBleName => 'BLE Name';

  @override
  String get deviceConfigBroadcastEighteenHours => 'Eighteen Hours';

  @override
  String get deviceConfigBroadcastFiveHours => 'Five Hours';

  @override
  String get deviceConfigBroadcastFortyEightHours => 'Forty Eight Hours';

  @override
  String get deviceConfigBroadcastFourHours => 'Four Hours';

  @override
  String get deviceConfigBroadcastInterval => 'Broadcast Interval';

  @override
  String get deviceConfigBroadcastIntervalSubtitle =>
      'How often to broadcast node info to the mesh';

  @override
  String get deviceConfigBroadcastNever => 'Never';

  @override
  String get deviceConfigBroadcastSeventyTwoHours => 'Seventy Two Hours';

  @override
  String get deviceConfigBroadcastSixHours => 'Six Hours';

  @override
  String get deviceConfigBroadcastThirtySixHours => 'Thirty Six Hours';

  @override
  String get deviceConfigBroadcastThreeHours => 'Three Hours';

  @override
  String get deviceConfigBroadcastTwelveHours => 'Twelve Hours';

  @override
  String get deviceConfigBroadcastTwentyFourHours => 'Twenty Four Hours';

  @override
  String get deviceConfigButtonGpio => 'Button GPIO';

  @override
  String get deviceConfigBuzzerAllEnabled => 'All Enabled';

  @override
  String get deviceConfigBuzzerAllEnabledDesc =>
      'Buzzer sounds for all feedback including buttons and alerts.';

  @override
  String get deviceConfigBuzzerDirectMsgOnly => 'Direct Messages Only';

  @override
  String get deviceConfigBuzzerDirectMsgOnlyDesc =>
      'Buzzer only for direct messages and alerts.';

  @override
  String get deviceConfigBuzzerDisabled => 'Disabled';

  @override
  String get deviceConfigBuzzerDisabledDesc =>
      'All buzzer audio feedback is disabled.';

  @override
  String get deviceConfigBuzzerGpio => 'Buzzer GPIO';

  @override
  String get deviceConfigBuzzerNotificationsOnly => 'Notifications Only';

  @override
  String get deviceConfigBuzzerNotificationsOnlyDesc =>
      'Buzzer only for notifications and alerts, not button presses.';

  @override
  String get deviceConfigBuzzerSystemOnly => 'System Only';

  @override
  String get deviceConfigBuzzerSystemOnlyDesc =>
      'Button presses, startup, shutdown sounds only. No alerts.';

  @override
  String get deviceConfigDisableLedHeartbeat => 'Disable LED Heartbeat';

  @override
  String get deviceConfigDisableLedHeartbeatSubtitle =>
      'Turn off the blinking status LED';

  @override
  String get deviceConfigDisableTripleClick => 'Disable Triple Click';

  @override
  String get deviceConfigDisableTripleClickSubtitle =>
      'Disable triple-click to toggle GPS';

  @override
  String get deviceConfigDoubleTapAsButton => 'Double Tap as Button';

  @override
  String get deviceConfigDoubleTapAsButtonSubtitle =>
      'Treat accelerometer double-tap as button press';

  @override
  String get deviceConfigFactoryReset => 'Factory Reset';

  @override
  String get deviceConfigFactoryResetDialogConfirm => 'Factory Reset';

  @override
  String get deviceConfigFactoryResetDialogMessage =>
      'This will reset ALL device settings to factory defaults, including channels, configuration, and stored data.\n\nThis action cannot be undone!';

  @override
  String get deviceConfigFactoryResetDialogTitle => 'Factory Reset';

  @override
  String deviceConfigFactoryResetError(String error) {
    return 'Failed to reset: $error';
  }

  @override
  String get deviceConfigFactoryResetSubtitle =>
      'Reset device to factory defaults';

  @override
  String get deviceConfigFactoryResetSuccess =>
      'Factory reset initiated - device will restart';

  @override
  String get deviceConfigFrequencyOverride => 'Frequency Override (MHz)';

  @override
  String get deviceConfigFrequencyOverrideHint => '0.0 (use default)';

  @override
  String get deviceConfigGpioWarning =>
      'Only change these if you know your hardware requires custom GPIO pins.';

  @override
  String get deviceConfigHamModeInfo =>
      'Ham mode uses your long name as call sign (max 8 chars), broadcasts node info every 10 minutes, overrides frequency, duty cycle, and TX power, and disables encryption.';

  @override
  String get deviceConfigHamModeWarning =>
      'HAM nodes cannot relay encrypted traffic. Other non-HAM nodes in your mesh will not be able to route encrypted messages through this node, creating a relay gap in the network.';

  @override
  String get deviceConfigHardware => 'Hardware';

  @override
  String get deviceConfigLicensedOperator => 'Licensed Operator (Ham)';

  @override
  String get deviceConfigLicensedOperatorSubtitle =>
      'Sets call sign, overrides frequency/power, disables encryption';

  @override
  String get deviceConfigLongName => 'Long Name';

  @override
  String get deviceConfigLongNameHint => 'Enter display name';

  @override
  String get deviceConfigLongNameSubtitle => 'Display name visible on the mesh';

  @override
  String get deviceConfigNameHelpText =>
      'Your device name is broadcast to the mesh and visible to other nodes.';

  @override
  String get deviceConfigNodeNumber => 'Node Number';

  @override
  String get deviceConfigPosixTimezone => 'POSIX Timezone';

  @override
  String get deviceConfigPosixTimezoneExample => 'e.g. EST5EDT,M3.2.0,M11.1.0';

  @override
  String get deviceConfigPosixTimezoneHint => 'Leave empty for UTC';

  @override
  String get deviceConfigRebootWarning =>
      'Changes to device configuration will cause the device to reboot.';

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
  String get deviceConfigRebroadcastCorePortnumsOnly =>
      'Core Port Numbers Only';

  @override
  String get deviceConfigRebroadcastCorePortnumsOnlyDesc =>
      'Rebroadcast only core Meshtastic packets (position, telemetry, etc).';

  @override
  String get deviceConfigRebroadcastKnownOnly => 'Known Only';

  @override
  String get deviceConfigRebroadcastKnownOnlyDesc =>
      'Only rebroadcast messages from nodes in the node database.';

  @override
  String get deviceConfigRebroadcastLocalOnly => 'Local Only';

  @override
  String get deviceConfigRebroadcastLocalOnlyDesc =>
      'Only rebroadcast messages from local senders. Good for isolated networks.';

  @override
  String get deviceConfigRebroadcastNone => 'None';

  @override
  String get deviceConfigRebroadcastNoneDesc =>
      'Do not rebroadcast any messages. Node only receives.';

  @override
  String deviceConfigRemoteAdminConfiguring(String nodeName) {
    return 'Configuring: $nodeName';
  }

  @override
  String get deviceConfigRemoteAdminTitle => 'Remote Administration';

  @override
  String get deviceConfigResetNodeDb => 'Reset Node Database';

  @override
  String get deviceConfigResetNodeDbDialogConfirm => 'Reset';

  @override
  String get deviceConfigResetNodeDbDialogMessage =>
      'This will clear all stored node information from the device. The mesh network will need to rediscover all nodes.\n\nAre you sure you want to continue?';

  @override
  String get deviceConfigResetNodeDbDialogTitle => 'Reset Node Database';

  @override
  String deviceConfigResetNodeDbError(String error) {
    return 'Failed to reset: $error';
  }

  @override
  String get deviceConfigResetNodeDbSubtitle =>
      'Clear all stored node information';

  @override
  String get deviceConfigResetNodeDbSuccess => 'Node database reset initiated';

  @override
  String get deviceConfigRoleClient => 'Client';

  @override
  String get deviceConfigRoleClientBase => 'Client Base';

  @override
  String get deviceConfigRoleClientBaseDesc =>
      'Base station for favorited nodes. Routes their packets like a router, others as client.';

  @override
  String get deviceConfigRoleClientDesc =>
      'Default role. Mesh packets are routed through this node. Can send and receive messages.';

  @override
  String get deviceConfigRoleClientHidden => 'Client Hidden';

  @override
  String get deviceConfigRoleClientHiddenDesc =>
      'Acts as client but hides from the node list. Still routes traffic.';

  @override
  String get deviceConfigRoleClientMute => 'Client Mute';

  @override
  String get deviceConfigRoleClientMuteDesc =>
      'Same as client but will not transmit any messages from itself. Useful for monitoring.';

  @override
  String get deviceConfigRoleLostAndFound => 'Lost and Found';

  @override
  String get deviceConfigRoleLostAndFoundDesc =>
      'Optimized for finding lost devices. Sends periodic beacons.';

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
  String get deviceConfigRoleTracker => 'Tracker';

  @override
  String get deviceConfigRoleTrackerDesc =>
      'Optimized for GPS tracking. Sends position updates at defined intervals.';

  @override
  String get deviceConfigSave => 'Save';

  @override
  String get deviceConfigSaveAndReboot => 'Save & Reboot';

  @override
  String get deviceConfigSaveChangesMessage =>
      'Saving device configuration will cause the device to reboot. You will be briefly disconnected while the device restarts.';

  @override
  String get deviceConfigSaveChangesTitle => 'Save Changes?';

  @override
  String deviceConfigSaveError(String error) {
    return 'Error saving config: $error';
  }

  @override
  String get deviceConfigSavedLocal => 'Configuration saved - device rebooting';

  @override
  String get deviceConfigSavedRemote => 'Configuration sent to remote node';

  @override
  String get deviceConfigSectionButtonInput => 'Button & Input';

  @override
  String get deviceConfigSectionBuzzer => 'Buzzer';

  @override
  String get deviceConfigSectionDangerZone => 'Danger Zone';

  @override
  String get deviceConfigSectionDeviceInfo => 'Device Info';

  @override
  String get deviceConfigSectionDeviceRole => 'Device Role';

  @override
  String get deviceConfigSectionGpio => 'GPIO (Advanced)';

  @override
  String get deviceConfigSectionLed => 'LED';

  @override
  String get deviceConfigSectionNodeInfoBroadcast => 'Node Info Broadcast';

  @override
  String get deviceConfigSectionRebroadcastMode => 'Rebroadcast Mode';

  @override
  String get deviceConfigSectionSerial => 'Serial';

  @override
  String get deviceConfigSectionTimezone => 'Timezone';

  @override
  String get deviceConfigSectionUserFlags => 'User Flags';

  @override
  String get deviceConfigSerialConsole => 'Serial Console';

  @override
  String get deviceConfigSerialConsoleSubtitle =>
      'Enable serial port for debugging';

  @override
  String get deviceConfigShortName => 'Short Name';

  @override
  String get deviceConfigShortNameHint => 'e.g. FUZZ';

  @override
  String deviceConfigShortNameSubtitle(int maxLength) {
    return 'Max $maxLength characters (A-Z, 0-9)';
  }

  @override
  String get deviceConfigTitle => 'Device Config';

  @override
  String get deviceConfigTitleRemote => 'Device Config (Remote)';

  @override
  String get deviceConfigTxPower => 'TX Power';

  @override
  String deviceConfigTxPowerValue(int power) {
    return '$power dBm';
  }

  @override
  String get deviceConfigUnknown => 'Unknown';

  @override
  String get deviceConfigUnmessagable => 'Unmessagable';

  @override
  String get deviceConfigUnmessagableSubtitle =>
      'Mark as infrastructure node that won\'t respond to messages';

  @override
  String get deviceConfigUserId => 'User ID';

  @override
  String get deviceSheetActionAppSettings => 'App Settings';

  @override
  String get deviceSheetActionAppSettingsSubtitle =>
      'Notifications, theme, preferences';

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
  String get deviceSheetActionResetNodeDb => 'Reset Node Database';

  @override
  String get deviceSheetActionResetNodeDbSubtitle =>
      'Clear all learned nodes from device';

  @override
  String get deviceSheetActionScanQr => 'Scan QR Code';

  @override
  String get deviceSheetActionScanQrSubtitle =>
      'Import nodes, channels, or automations';

  @override
  String get deviceSheetAddress => 'Address';

  @override
  String get deviceSheetBattery => 'Battery';

  @override
  String deviceSheetBatteryPercent(String percent) {
    return '$percent%';
  }

  @override
  String get deviceSheetBatteryRefreshFailed => 'Failed';

  @override
  String get deviceSheetBatteryRefreshIdle => 'Fetch battery from device';

  @override
  String deviceSheetBatteryRefreshResult(String percent, String millivolts) {
    return '$percent%$millivolts';
  }

  @override
  String get deviceSheetBluetoothLe => 'Bluetooth LE';

  @override
  String get deviceSheetCharging => 'Charging';

  @override
  String get deviceSheetConnected => 'Connected';

  @override
  String get deviceSheetConnecting => 'Connecting...';

  @override
  String get deviceSheetConnectionType => 'Connection Type';

  @override
  String get deviceSheetDeviceName => 'Device Name';

  @override
  String get deviceSheetDisconnectButton => 'Disconnect';

  @override
  String get deviceSheetDisconnectDialogConfirm => 'Disconnect';

  @override
  String get deviceSheetDisconnectDialogMessage =>
      'Are you sure you want to disconnect from this device?';

  @override
  String get deviceSheetDisconnectDialogTitle => 'Disconnect';

  @override
  String get deviceSheetDisconnected => 'Disconnected';

  @override
  String get deviceSheetDisconnecting => 'Disconnecting...';

  @override
  String get deviceSheetDisconnectingButton => 'Disconnecting...';

  @override
  String get deviceSheetError => 'Error';

  @override
  String get deviceSheetFirmware => 'Firmware';

  @override
  String get deviceSheetInfoCardConnected => 'Connected';

  @override
  String get deviceSheetInfoCardConnecting => 'Connecting...';

  @override
  String get deviceSheetInfoCardConnectionError => 'Connection Error';

  @override
  String get deviceSheetInfoCardDisconnected => 'Disconnected';

  @override
  String get deviceSheetInfoCardDisconnecting => 'Disconnecting...';

  @override
  String get deviceSheetNoDevice => 'No Device';

  @override
  String get deviceSheetNodeId => 'Node ID';

  @override
  String get deviceSheetNodeName => 'Node Name';

  @override
  String get deviceSheetProtocol => 'Protocol';

  @override
  String get deviceSheetReconnecting => 'Reconnecting...';

  @override
  String get deviceSheetRefreshBattery => 'Refresh Battery';

  @override
  String get deviceSheetRefreshingBattery => 'Refreshing battery...';

  @override
  String get deviceSheetResetNodeDbDialogConfirm => 'Reset';

  @override
  String get deviceSheetResetNodeDbDialogMessage =>
      'This will clear all learned nodes from the device and app. The device will need to rediscover nodes on the mesh.\n\nAre you sure you want to continue?';

  @override
  String get deviceSheetResetNodeDbDialogTitle => 'Reset Node Database';

  @override
  String deviceSheetResetNodeDbError(String error) {
    return 'Failed to reset node database: $error';
  }

  @override
  String get deviceSheetResetNodeDbSuccess =>
      'Node database reset successfully';

  @override
  String get deviceSheetScanForDevices => 'Scan for Devices';

  @override
  String get deviceSheetSectionConnectionDetails => 'Connection Details';

  @override
  String get deviceSheetSectionDeveloperTools => 'Developer Tools';

  @override
  String get deviceSheetSectionQuickActions => 'Quick Actions';

  @override
  String get deviceSheetSignalStrength => 'Signal Strength';

  @override
  String deviceSheetSignalStrengthValue(String rssi) {
    return '$rssi dBm';
  }

  @override
  String get deviceSheetStatus => 'Status';

  @override
  String get deviceSheetUnknown => 'Unknown';

  @override
  String get deviceSheetUsb => 'USB';

  @override
  String get deviceShopBecomeSeller => 'Become a Seller';

  @override
  String get deviceShopBecomeSellerBody =>
      'Are you a manufacturer or distributor of Meshtastic-compatible devices? Join our marketplace to reach mesh radio enthusiasts worldwide.';

  @override
  String get deviceShopBrowseByCategory => 'Browse by Category';

  @override
  String get deviceShopCategories => 'Categories';

  @override
  String get deviceShopClear => 'Clear';

  @override
  String get deviceShopConnectToBrowse => 'Connect to browse devices';

  @override
  String get deviceShopContactUs => 'Contact Us';

  @override
  String get deviceShopErrorLoadingProducts => 'Error loading products';

  @override
  String get deviceShopFavoritesTooltip => 'Favorites';

  @override
  String get deviceShopFeatured => 'Featured';

  @override
  String get deviceShopHelpTooltip => 'Help';

  @override
  String get deviceShopMarketplaceDisclaimer =>
      'Purchases are completed on the seller\'s official store. Socialmesh does not handle payment, shipping, warranty, or returns.';

  @override
  String get deviceShopMarketplaceInfoTitle => 'Marketplace Information';

  @override
  String get deviceShopNewArrivals => 'New Arrivals';

  @override
  String get deviceShopNoInternet => 'No internet connection';

  @override
  String deviceShopNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get deviceShopOfficialPartners => 'Official Partners';

  @override
  String get deviceShopOnSale => 'On Sale';

  @override
  String get deviceShopOutOfStock => 'OUT OF STOCK';

  @override
  String get deviceShopPopularDevices => 'Popular Devices';

  @override
  String get deviceShopRecentSearches => 'Recent Searches';

  @override
  String get deviceShopRetry => 'Retry';

  @override
  String get deviceShopSearchHint => 'Search devices, modules, antennas...';

  @override
  String get deviceShopSeeAll => 'See All';

  @override
  String get deviceShopSellYourDevices => 'Sell your Meshtastic devices';

  @override
  String get deviceShopSupportEmail => 'support@socialmesh.app';

  @override
  String get deviceShopTitle => 'Device Shop';

  @override
  String get deviceShopTrending => 'Trending';

  @override
  String get deviceShopTryAgain => 'Try again in a moment';

  @override
  String get deviceShopTryDifferentKeywords => 'Try different keywords';

  @override
  String get deviceShopUnableToLoad => 'Unable to load products';

  @override
  String get discoveryDiscoveredBadge => 'DISCOVERED';

  @override
  String discoveryNodesFound(int count) {
    return '$count nodes found';
  }

  @override
  String get discoveryScanningNetwork => 'Scanning Network';

  @override
  String get discoverySearchingForNodes => 'Searching for nodes...';

  @override
  String get discoverySignalExcellent => 'Excellent';

  @override
  String get discoverySignalGood => 'Good';

  @override
  String get discoverySignalWeak => 'Weak';

  @override
  String get discoveryUnknownNode => 'Unknown Node';

  @override
  String get drawerAdminDashboard => 'Admin Dashboard';

  @override
  String get drawerAdminSectionHeader => 'ADMIN';

  @override
  String get drawerBadgeNew => 'NEW';

  @override
  String get drawerBadgePro => 'PRO';

  @override
  String get drawerBadgeTryIt => 'TRY IT';

  @override
  String get drawerEnterpriseDeviceManagement => 'Device Management';

  @override
  String get drawerEnterpriseExportDenied =>
      'Requires Supervisor or Admin role';

  @override
  String get drawerEnterpriseFieldReports => 'Field Reports';

  @override
  String get drawerEnterpriseIncidents => 'Incidents';

  @override
  String get drawerEnterpriseOrgSettings => 'Org Settings';

  @override
  String get drawerEnterpriseReports => 'Reports';

  @override
  String get drawerEnterpriseSectionHeader => 'ENTERPRISE';

  @override
  String get drawerEnterpriseTasks => 'Tasks';

  @override
  String get drawerEnterpriseUserManagement => 'User Management';

  @override
  String get drawerNodeNotConnected => 'Not Connected';

  @override
  String get drawerNodeOffline => 'Offline';

  @override
  String get drawerNodeOnline => 'Online';

  @override
  String get explorerTitleCartographer => 'Cartographer';

  @override
  String get explorerTitleCartographerDescription =>
      'Mapping the invisible infrastructure';

  @override
  String get explorerTitleExplorer => 'Explorer';

  @override
  String get explorerTitleExplorerDescription =>
      'Actively discovering the network';

  @override
  String get explorerTitleLongRangeRecordHolder => 'Long-Range Record Holder';

  @override
  String get explorerTitleLongRangeRecordHolderDescription =>
      'Pushing the limits of range';

  @override
  String get explorerTitleMeshCartographer => 'Mesh Cartographer';

  @override
  String get explorerTitleMeshCartographerDescription =>
      'Charting regions and routes';

  @override
  String get explorerTitleMeshVeteran => 'Mesh Veteran';

  @override
  String get explorerTitleMeshVeteranDescription =>
      'Deep knowledge of the mesh';

  @override
  String get explorerTitleNewcomer => 'Newcomer';

  @override
  String get explorerTitleNewcomerDescription => 'Beginning the mesh journey';

  @override
  String get explorerTitleObserver => 'Observer';

  @override
  String get explorerTitleObserverDescription =>
      'Building awareness of the mesh';

  @override
  String get explorerTitleSignalHunter => 'Signal Hunter';

  @override
  String get explorerTitleSignalHunterDescription =>
      'Seeking signals across the spectrum';

  @override
  String get favoritesCancelCompare => 'Cancel compare';

  @override
  String get favoritesCannotCompare => 'Cannot compare nodes not in mesh';

  @override
  String get favoritesCharging => 'Charging';

  @override
  String get favoritesCompareNodes => 'Compare nodes';

  @override
  String get favoritesDelete => 'Delete';

  @override
  String get favoritesEmptyDescription =>
      'Tap the star icon on any node to add it to your favorites for quick access.';

  @override
  String get favoritesEmptyTitle => 'No Favorites Yet';

  @override
  String get favoritesErrorLoading => 'Error loading favorites';

  @override
  String get favoritesNodeNotInMesh =>
      'Node not currently in mesh. Check back later.';

  @override
  String get favoritesNotInMesh => 'Not in mesh';

  @override
  String get favoritesRemoveConfirm => 'Remove';

  @override
  String favoritesRemoveMessage(String name) {
    return 'Remove $name from your favorites?';
  }

  @override
  String get favoritesRemoveTitle => 'Remove Favorite?';

  @override
  String get favoritesRemoveTooltip => 'Remove from favorites';

  @override
  String get favoritesRetry => 'Retry';

  @override
  String get favoritesSelectFirst => 'Select first node';

  @override
  String get favoritesSelectSecond => 'Select second node';

  @override
  String get favoritesTitle => 'Favorite Nodes';

  @override
  String get featuredProductsDiscard => 'Discard';

  @override
  String get featuredProductsEmpty => 'No featured products';

  @override
  String get featuredProductsEmptySubtitle =>
      'Mark products as featured to manage their order here';

  @override
  String get featuredProductsOrderUpdated => 'Featured order updated';

  @override
  String get featuredProductsRemove => 'Remove';

  @override
  String featuredProductsRemoveMessage(String name) {
    return 'Remove \"$name\" from featured products?';
  }

  @override
  String get featuredProductsRemoveTitle => 'Remove from Featured';

  @override
  String get featuredProductsRemoveTooltip => 'Remove from featured';

  @override
  String get featuredProductsRemoved => 'Removed from featured';

  @override
  String get featuredProductsReorderInfo =>
      'Drag and drop products to reorder. Products at the top will appear first in the featured section.';

  @override
  String get featuredProductsSave => 'Save';

  @override
  String get featuredProductsTitle => 'Featured Products';

  @override
  String get featuredProductsUnsavedChanges => 'You have unsaved changes';

  @override
  String get firmwareUpdateAvailable => 'Update Available';

  @override
  String get firmwareUpdateBackupWarningSubtitle =>
      'Firmware updates may reset your device configuration. Consider exporting your settings before updating.';

  @override
  String get firmwareUpdateBackupWarningTitle => 'Backup Your Settings';

  @override
  String get firmwareUpdateBluetooth => 'Bluetooth';

  @override
  String get firmwareUpdateCheckFailed => 'Failed to check for updates';

  @override
  String get firmwareUpdateChecking => 'Checking for updates...';

  @override
  String get firmwareUpdateDownload => 'Download Update';

  @override
  String get firmwareUpdateHardware => 'Hardware';

  @override
  String get firmwareUpdateInstalledFirmware => 'Installed Firmware';

  @override
  String firmwareUpdateLatestVersion(String version) {
    return 'Latest: $version';
  }

  @override
  String get firmwareUpdateNewBadge => 'NEW';

  @override
  String get firmwareUpdateNodeId => 'Node ID';

  @override
  String get firmwareUpdateOpenWebFlasher => 'Open Web Flasher';

  @override
  String get firmwareUpdateReleaseNotes => 'Release Notes';

  @override
  String get firmwareUpdateSectionAvailableUpdate => 'Available Update';

  @override
  String get firmwareUpdateSectionCurrentVersion => 'Current Version';

  @override
  String get firmwareUpdateSectionHowToUpdate => 'How to Update';

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
  String get firmwareUpdateSupported => 'Supported';

  @override
  String get firmwareUpdateTitle => 'Firmware Update';

  @override
  String get firmwareUpdateUnableToCheck => 'Unable to check for updates';

  @override
  String get firmwareUpdateUnknown => 'Unknown';

  @override
  String get firmwareUpdateUpToDate => 'Up to Date';

  @override
  String get firmwareUpdateUptime => 'Uptime';

  @override
  String get firmwareUpdateVisitWebsite =>
      'Visit the Meshtastic website for the latest firmware.';

  @override
  String get firmwareUpdateWifi => 'WiFi';

  @override
  String get globeEmptyDescription =>
      'Nodes with position data will appear here';

  @override
  String get globeEmptyTitle => 'No nodes with GPS';

  @override
  String get globeHelp => 'Help';

  @override
  String get globeHideConnections => 'Hide connections';

  @override
  String globeNodeCount(int count) {
    return '$count nodes';
  }

  @override
  String get globeResetView => 'Reset view';

  @override
  String get globeScreenTitle => 'Mesh Globe';

  @override
  String get globeSelectNode => 'Select Node';

  @override
  String get globeShowConnections => 'Show connections';

  @override
  String get gpsStatusAccuracy => 'Accuracy';

  @override
  String gpsStatusAccuracyValue(String meters) {
    return '±${meters}m';
  }

  @override
  String get gpsStatusAcquiring => 'Acquiring GPS...';

  @override
  String get gpsStatusActiveBadge => 'ACTIVE';

  @override
  String get gpsStatusAltitude => 'Altitude';

  @override
  String gpsStatusAltitudeValue(String meters) {
    return '${meters}m';
  }

  @override
  String get gpsStatusCardinalE => 'E';

  @override
  String get gpsStatusCardinalN => 'N';

  @override
  String get gpsStatusCardinalNE => 'NE';

  @override
  String get gpsStatusCardinalNW => 'NW';

  @override
  String get gpsStatusCardinalS => 'S';

  @override
  String get gpsStatusCardinalSE => 'SE';

  @override
  String get gpsStatusCardinalSW => 'SW';

  @override
  String get gpsStatusCardinalW => 'W';

  @override
  String gpsStatusDateAt(String date, String time) {
    return '$date $time';
  }

  @override
  String gpsStatusDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get gpsStatusFixAcquired => 'GPS Fix Acquired';

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
  String gpsStatusHoursAgo(int count) {
    return '$count hours ago';
  }

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
  String gpsStatusMinutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String get gpsStatusNoGpsFix => 'No GPS Fix';

  @override
  String get gpsStatusNoGpsFixMessage =>
      'The device has not acquired a GPS position yet. Make sure the device has a clear view of the sky.';

  @override
  String get gpsStatusOpenInMaps => 'Open in Maps';

  @override
  String get gpsStatusPrecisionBits => 'Precision Bits';

  @override
  String get gpsStatusSatFair => 'Fair';

  @override
  String get gpsStatusSatGood => 'Good';

  @override
  String get gpsStatusSatNoFix => 'No Fix';

  @override
  String get gpsStatusSatPoor => 'Poor';

  @override
  String gpsStatusSatellitesCount(int count) {
    return '$count satellites in view';
  }

  @override
  String get gpsStatusSatellitesInView => 'Satellites in View';

  @override
  String get gpsStatusSearchingSatellites => 'Searching for satellites...';

  @override
  String gpsStatusSecondsAgo(int count) {
    return '$count seconds ago';
  }

  @override
  String get gpsStatusSectionLastUpdate => 'Last Update';

  @override
  String get gpsStatusSectionMotion => 'Motion';

  @override
  String get gpsStatusSectionPosition => 'Position';

  @override
  String get gpsStatusSectionSatellites => 'Satellites';

  @override
  String get gpsStatusTitle => 'GPS Status';

  @override
  String gpsStatusTodayAt(String time) {
    return 'Today at $time';
  }

  @override
  String get gpsStatusUnknown => 'Unknown';

  @override
  String get helpArticleLoadFailed => 'Failed to load article';

  @override
  String helpArticleMinRead(int minutes) {
    return '$minutes min read';
  }

  @override
  String get helpCenterArticleRead => 'Read';

  @override
  String get helpCenterArticleUnread => 'Unread';

  @override
  String get helpCenterArticlesRead => 'articles read';

  @override
  String get helpCenterComeBackToRefresh =>
      'Come back anytime to refresh your knowledge.';

  @override
  String get helpCenterCompleted => 'Completed';

  @override
  String get helpCenterContentBeingPrepared =>
      'Help content is being prepared. Check back soon.';

  @override
  String get helpCenterFilterAll => 'All';

  @override
  String helpCenterFindThisIn(String screenName) {
    return 'Find this in: $screenName';
  }

  @override
  String get helpCenterHapticFeedbackSubtitle =>
      'Vibrate during typewriter text effect';

  @override
  String get helpCenterHapticFeedbackTitle => 'Haptic Feedback';

  @override
  String get helpCenterHelpPreferences => 'HELP PREFERENCES';

  @override
  String get helpCenterInteractiveTours => 'Interactive Tours';

  @override
  String get helpCenterLearnHowItWorks => 'Learn how Meshtastic works';

  @override
  String get helpCenterLoadFailed => 'Failed to load help content';

  @override
  String get helpCenterMarkAsComplete => 'Mark as Complete';

  @override
  String get helpCenterNoArticlesAvailable => 'No articles available';

  @override
  String get helpCenterNoArticlesInCategory => 'No articles in this category';

  @override
  String get helpCenterNoArticlesMatchSearch =>
      'No articles match your search.\nTry different keywords.';

  @override
  String get helpCenterReadEverything => 'You’ve read everything!';

  @override
  String get helpCenterResetAllProgress => 'Reset All Progress';

  @override
  String get helpCenterResetProgressLabel => 'Reset';

  @override
  String get helpCenterResetProgressMessage =>
      'This will mark all articles as unread and reset interactive tour progress. You can start fresh.';

  @override
  String get helpCenterResetProgressTitle => 'Reset Help Progress?';

  @override
  String get helpCenterScreenAether => 'Aether';

  @override
  String get helpCenterScreenAutomations => 'Automations';

  @override
  String get helpCenterScreenChannels => 'Channels';

  @override
  String get helpCenterScreenCreateSignal => 'Create Signal';

  @override
  String get helpCenterScreenDeviceShop => 'Device Shop';

  @override
  String get helpCenterScreenGlobe => 'Globe';

  @override
  String get helpCenterScreenMap => 'Map';

  @override
  String get helpCenterScreenMesh3d => 'Mesh 3D';

  @override
  String get helpCenterScreenMeshHealth => 'Mesh Health';

  @override
  String get helpCenterScreenMessages => 'Messages';

  @override
  String get helpCenterScreenNodeDex => 'NodeDex';

  @override
  String get helpCenterScreenNodes => 'Nodes';

  @override
  String get helpCenterScreenPresence => 'Presence';

  @override
  String get helpCenterScreenProfile => 'Profile';

  @override
  String get helpCenterScreenRadioConfig => 'Radio Config';

  @override
  String get helpCenterScreenReachability => 'Reachability';

  @override
  String get helpCenterScreenRegionSelection => 'Region Selection';

  @override
  String get helpCenterScreenRoutes => 'Routes';

  @override
  String get helpCenterScreenScanner => 'Scanner';

  @override
  String get helpCenterScreenSettings => 'Settings';

  @override
  String get helpCenterScreenSignalFeed => 'Signal Feed';

  @override
  String get helpCenterScreenTakGateway => 'TAK Gateway';

  @override
  String get helpCenterScreenTimeline => 'Timeline';

  @override
  String get helpCenterScreenTraceRouteLog => 'Trace Route Log';

  @override
  String get helpCenterScreenWidgetBuilder => 'Widget Builder';

  @override
  String get helpCenterScreenWidgetDashboard => 'Widget Dashboard';

  @override
  String get helpCenterScreenWidgetMarketplace => 'Widget Marketplace';

  @override
  String get helpCenterScreenWorldMesh => 'World Mesh';

  @override
  String get helpCenterSearchByTitle =>
      'Search by article title\nor description.';

  @override
  String get helpCenterSearchHint => 'Search articles';

  @override
  String get helpCenterShowHelpHintsSubtitle =>
      'Display pulsing help buttons on screens';

  @override
  String get helpCenterShowHelpHintsTitle => 'Show Help Hints';

  @override
  String get helpCenterTapToLearn =>
      'Tap an article to learn about mesh networking, radio settings, and more.';

  @override
  String get helpCenterTitle => 'Help Center';

  @override
  String helpCenterToursCompletedCount(int completed, int total) {
    return '$completed / $total completed';
  }

  @override
  String get helpCenterToursDescription =>
      'Step-by-step walkthroughs for app features. These tours guide you through each screen with Ico.';

  @override
  String get helpCenterTryDifferentCategory =>
      'Try selecting a different category from the filter chips above.';

  @override
  String get incidentActionAssign => 'Assign';

  @override
  String get incidentActionCancel => 'Cancel';

  @override
  String get incidentActionClose => 'Close';

  @override
  String incidentActionDeniedTooltip(String roleHint) {
    return 'Requires $roleHint';
  }

  @override
  String get incidentActionEscalate => 'Escalate';

  @override
  String get incidentActionFailedSnackbar => 'Action failed';

  @override
  String get incidentActionResolve => 'Resolve';

  @override
  String get incidentActionSubmit => 'Submit';

  @override
  String incidentActionSuccessSnackbar(String action) {
    return 'Incident ${action}d';
  }

  @override
  String get incidentAssignCancelButton => 'Cancel';

  @override
  String get incidentAssignConfirmButton => 'Assign';

  @override
  String get incidentAssignSheetTitle => 'Assign Incident';

  @override
  String incidentAssignedLabel(String assigneeId) {
    return 'Assigned: $assigneeId';
  }

  @override
  String get incidentAssigneeHint => 'Enter user ID';

  @override
  String get incidentAssigneeLabel => 'Assignee User ID';

  @override
  String get incidentClassificationComms => 'Comms';

  @override
  String get incidentClassificationEnvironmental => 'Environmental';

  @override
  String get incidentClassificationLogistics => 'Logistics';

  @override
  String get incidentClassificationMedical => 'Medical';

  @override
  String get incidentClassificationOperational => 'Operational';

  @override
  String get incidentClassificationSafety => 'Safety';

  @override
  String get incidentClassificationSecurity => 'Security';

  @override
  String get incidentCreateButtonLabel => 'Create Incident';

  @override
  String get incidentCreateCaptureLocation => 'Capture Location';

  @override
  String get incidentCreateClassificationSection => 'Classification';

  @override
  String get incidentCreateDescriptionHint =>
      'Detailed description of the incident';

  @override
  String get incidentCreateDescriptionSection => 'Description (optional)';

  @override
  String incidentCreateError(String error) {
    return 'Error: $error';
  }

  @override
  String get incidentCreateFailed => 'Failed to create';

  @override
  String get incidentCreateGettingLocation => 'Getting location...';

  @override
  String get incidentCreateLocationError => 'Could not get location';

  @override
  String incidentCreateLocationException(String error) {
    return 'Location error: $error';
  }

  @override
  String get incidentCreateLocationSection => 'Location (optional)';

  @override
  String get incidentCreatePrioritySection => 'Priority';

  @override
  String get incidentCreateRemoveLocation => 'Remove';

  @override
  String get incidentCreateScreenTitle => 'Create Incident';

  @override
  String get incidentCreateSubmitButton => 'Create Incident';

  @override
  String get incidentCreateSubmitting => 'Creating...';

  @override
  String get incidentCreateTitleHint => 'Brief incident title';

  @override
  String get incidentCreateTitleRequired => 'Title is required';

  @override
  String get incidentCreateTitleSection => 'Title';

  @override
  String get incidentCreateTooltip => 'Create incident';

  @override
  String get incidentCreatedSuccess => 'Incident created';

  @override
  String incidentDetailError(String error) {
    return 'Error: $error';
  }

  @override
  String get incidentDetailTitle => 'Incident Detail';

  @override
  String get incidentDetailTitleLoading => 'Incident';

  @override
  String get incidentEmptyStateDescription =>
      'Incidents track operational events from creation through resolution. Create one to get started.';

  @override
  String get incidentEmptyStateTitle => 'No incidents';

  @override
  String get incidentFilterAssignedToMe => 'Assigned to me';

  @override
  String get incidentFilterStateAssigned => 'Assigned';

  @override
  String get incidentFilterStateCancelled => 'Cancelled';

  @override
  String get incidentFilterStateClosed => 'Closed';

  @override
  String get incidentFilterStateDraft => 'Draft';

  @override
  String get incidentFilterStateEscalated => 'Escalated';

  @override
  String get incidentFilterStateOpen => 'Open';

  @override
  String get incidentFilterStateResolved => 'Resolved';

  @override
  String incidentListLoadError(String error) {
    return 'Failed to load incidents:\n$error';
  }

  @override
  String get incidentListTitle => 'Incidents';

  @override
  String get incidentNotFound => 'Incident not found';

  @override
  String get incidentNoteContinueButton => 'Continue';

  @override
  String get incidentNoteHint => 'Optional note for this transition';

  @override
  String get incidentNoteLabel => 'Note';

  @override
  String incidentNoteSheetTitle(String action) {
    return '$action Note (optional)';
  }

  @override
  String get incidentNoteSkipButton => 'Skip';

  @override
  String get incidentPriorityFlash => 'Flash';

  @override
  String get incidentPriorityImmediate => 'Immediate';

  @override
  String get incidentPriorityPriority => 'Priority';

  @override
  String get incidentPriorityRoutine => 'Routine';

  @override
  String get incidentProviderNotAuthenticated => 'Not authenticated';

  @override
  String get incidentRoleHintAssignedOperator => 'Assigned Operator';

  @override
  String get incidentRoleHintOperatorOrAbove => 'Operator or above';

  @override
  String get incidentRoleHintSupervisorOrAdmin => 'Supervisor or Admin';

  @override
  String get incidentStateMachineAssigneeRequired =>
      'assigneeId is required when transitioning to assigned';

  @override
  String get incidentStateMachineCannotTransitionToDraft =>
      'Cannot transition to draft';

  @override
  String incidentStateMachineCreateDenied(String roleName) {
    return 'createIncident denied for role $roleName';
  }

  @override
  String incidentStateMachineInvalidTransition(
    String fromState,
    String toState,
  ) {
    return '$fromState -> $toState is not a valid transition';
  }

  @override
  String incidentStateMachinePermissionDenied(
    String permissionName,
    String roleName,
  ) {
    return '$permissionName denied for role $roleName';
  }

  @override
  String incidentStateMachineTerminalState(String stateName) {
    return 'Cannot transition from $stateName: terminal state: $stateName';
  }

  @override
  String incidentTerminalStateMessage(String state) {
    return 'This incident is $state — no further actions available.';
  }

  @override
  String get incidentTimelineEmpty => 'No transition history';

  @override
  String get incidentTimelineFinalState =>
      'Final state — no further transitions';

  @override
  String get incidentTimelineSuperseded => 'superseded';

  @override
  String get incidentTimelineUnknownRole => 'unknown';

  @override
  String get incidentTransitionHistoryHeader => 'Transition History';

  @override
  String get incidentTransitionNoteCreated => 'Incident created';

  @override
  String incidentTransitionsLoadError(String error) {
    return 'Failed to load transitions: $error';
  }

  @override
  String get lilygoModelPriceUnavailable => 'Price unavailable';

  @override
  String get linkDeviceBannerLinkButton => 'Link';

  @override
  String linkDeviceBannerLinkError(String error) {
    return 'Failed to link: $error';
  }

  @override
  String get linkDeviceBannerLinkedSuccess => 'Device linked to your profile!';

  @override
  String get linkDeviceBannerSubtitle => 'Others can find and follow you';

  @override
  String get linkDeviceBannerTitle => 'Link this device to your profile';

  @override
  String mapAgeHours(String hours) {
    return '${hours}h ago';
  }

  @override
  String mapAgeMinutes(String minutes) {
    return '${minutes}m ago';
  }

  @override
  String mapAgeSeconds(String seconds) {
    return '${seconds}s ago';
  }

  @override
  String get mapCoordinatesCopied => 'Coordinates copied to clipboard';

  @override
  String get mapCopyBothCoordinates => 'Both A and B coordinates';

  @override
  String get mapCopyCoordinates => 'Copy Coordinates';

  @override
  String get mapCopyCoordinatesTooltip => 'Copy coordinates';

  @override
  String get mapCopySummary => 'Copy Summary';

  @override
  String get mapDelete => 'Delete';

  @override
  String get mapDismissTooltip => 'Dismiss';

  @override
  String get mapDistance10Km => '10 km';

  @override
  String get mapDistance1Km => '1 km';

  @override
  String get mapDistance25Km => '25 km';

  @override
  String get mapDistance5Km => '5 km';

  @override
  String get mapDistanceAll => 'All';

  @override
  String mapDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String mapDistanceKilometersFormal(String km) {
    return '$km km';
  }

  @override
  String mapDistanceKilometersPrecise(String km) {
    return '$km km';
  }

  @override
  String mapDistanceKilometersRound(String km) {
    return '${km}km';
  }

  @override
  String mapDistanceMeters(String meters) {
    return '${meters}m';
  }

  @override
  String mapDistanceMetersFormal(String meters) {
    return '$meters m';
  }

  @override
  String get mapDropWaypoint => 'Drop Waypoint';

  @override
  String get mapEmptyBodyNoNodes =>
      'Nodes will appear on the map once they\nreport their GPS position.';

  @override
  String mapEmptyBodyWithNodes(int totalNodes) {
    return '$totalNodes nodes discovered but none have\nreported GPS position yet.';
  }

  @override
  String get mapEmptyTitle => 'No Nodes with GPS';

  @override
  String get mapEntitiesTitle => 'Entities';

  @override
  String mapEstimatedPathLoss(String pathLoss) {
    return 'Estimated path loss: $pathLoss dB (free-space)';
  }

  @override
  String get mapExitMeasureMode => 'Exit measure mode';

  @override
  String get mapExitMeasureModeTooltip => 'Exit measure mode';

  @override
  String get mapFilterActive => 'Active';

  @override
  String get mapFilterAll => 'All';

  @override
  String get mapFilterInRange => 'In Range';

  @override
  String get mapFilterInactive => 'Inactive';

  @override
  String get mapFilterNodesTitle => 'Filter Nodes';

  @override
  String get mapFilterNodesTooltip => 'Filter nodes';

  @override
  String get mapFilterWithGps => 'With GPS';

  @override
  String get mapGlobeView => '3D Globe View';

  @override
  String get mapHelp => 'Help';

  @override
  String get mapHideConnectionLines => 'Hide connection lines';

  @override
  String get mapHideHeatmap => 'Hide heatmap';

  @override
  String get mapHidePositionHistory => 'Hide position history';

  @override
  String get mapHideRangeCircles => 'Hide range circles';

  @override
  String get mapHideTakEntities => 'Hide TAK entities';

  @override
  String get mapLastKnown => '• Last known';

  @override
  String get mapLinkBudgetCopied => 'Link budget copied to clipboard';

  @override
  String get mapLocationTitle => 'Location';

  @override
  String get mapLongPressForActions => 'Long-press for actions';

  @override
  String get mapLosAnalysis => 'LOS Analysis';

  @override
  String get mapLosAnalysisSubtitle => 'Earth curvature + Fresnel zone check';

  @override
  String mapLosBulgeAndFresnel(String bulge, String fresnel) {
    return 'Bulge: ${bulge}m · F1: ${fresnel}m';
  }

  @override
  String mapLosVerdict(String verdict) {
    return 'LOS: $verdict';
  }

  @override
  String get mapMaxDistance => 'Max Distance';

  @override
  String get mapMeasureDistance => 'Measure distance';

  @override
  String get mapMeasureMarkerA => 'A';

  @override
  String get mapMeasureMarkerB => 'B';

  @override
  String get mapMeasureTapPointA => 'Tap node or map for point A';

  @override
  String get mapMeasureTapPointB => 'Tap node or map for point B';

  @override
  String get mapMeasurementActions => 'Measurement Actions';

  @override
  String get mapMeasurementCopied => 'Measurement copied to clipboard';

  @override
  String get mapNavigateToTooltip => 'Navigate to';

  @override
  String get mapNewMeasurement => 'New measurement';

  @override
  String get mapNoEntities => 'No entities';

  @override
  String get mapNoMatchingEntities => 'No matching entities';

  @override
  String mapNodeCount(String count) {
    return '$count nodes';
  }

  @override
  String get mapNodesTitle => 'Nodes';

  @override
  String get mapOpenInExternalApp => 'Open in external map app';

  @override
  String get mapOpenMidpointInMaps => 'Open Midpoint in Maps';

  @override
  String get mapPositionBroadcastHint =>
      'Position broadcasts can take up to 15 minutes.\nTap to request immediately.';

  @override
  String get mapRefreshPositions => 'Refresh positions';

  @override
  String get mapRefreshing => 'Refreshing...';

  @override
  String get mapRequestPositions => 'Request Positions';

  @override
  String get mapRequesting => 'Requesting...';

  @override
  String get mapReverseDirection => 'Reverse measurement direction';

  @override
  String get mapRfLinkBudget => 'RF Link Budget';

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
  String get mapSaDashboard => 'SA Dashboard';

  @override
  String get mapScreenTitle => 'Mesh Map';

  @override
  String get mapSearchEntitiesHint => 'Search entities...';

  @override
  String get mapSearchHint => 'Try a different search term';

  @override
  String get mapSearchNodesHint => 'Search nodes...';

  @override
  String get mapSettings => 'Settings';

  @override
  String get mapShare => 'Share';

  @override
  String mapShareDistanceLabel(String distance) {
    return 'Distance: $distance';
  }

  @override
  String get mapShareLocation => 'Share Location';

  @override
  String get mapShareMeasurement => 'Share Measurement';

  @override
  String get mapShareMeasurementSubtitle => 'Share via system share sheet';

  @override
  String get mapShowConnectionLines => 'Show connection lines';

  @override
  String get mapShowHeatmap => 'Show heatmap';

  @override
  String get mapShowPositionHistory => 'Show position history';

  @override
  String get mapShowRangeCircles => 'Show range circles';

  @override
  String get mapShowTakEntities => 'Show TAK entities';

  @override
  String get mapStyleTooltip => 'Map style';

  @override
  String get mapSwapAB => 'Swap A ↔ B';

  @override
  String get mapTakActive => 'Active';

  @override
  String get mapTakActiveBadge => 'ACTIVE';

  @override
  String mapTakEntityCount(int count) {
    return '• $count entities';
  }

  @override
  String get mapTakStale => 'Stale';

  @override
  String get mapTakStaleBadge => 'STALE';

  @override
  String get mapTakTrack => 'Track';

  @override
  String get mapTakTracked => 'Tracked';

  @override
  String mapWaypointDefaultLabel(int number) {
    return 'WP $number';
  }

  @override
  String get mapYouBadge => 'YOU';

  @override
  String get meshcoreConsoleCaptureCleared => 'Capture cleared';

  @override
  String get meshcoreConsoleClear => 'Clear';

  @override
  String get meshcoreConsoleCopyHex => 'Copy Hex';

  @override
  String get meshcoreConsoleDevBadge => 'DEV';

  @override
  String meshcoreConsoleFramesCaptured(int count) {
    return '$count frames captured';
  }

  @override
  String get meshcoreConsoleHexCopied => 'Hex log copied to clipboard';

  @override
  String get meshcoreConsoleNoFrames => 'No frames captured yet';

  @override
  String get meshcoreConsoleRefresh => 'Refresh';

  @override
  String get meshcoreConsoleTitle => 'MeshCore Console';

  @override
  String get meshcoreShellAddChannelHint =>
      'Use the menu to create or join a channel';

  @override
  String get meshcoreShellAddContactHint => 'Use the + button to add a contact';

  @override
  String get meshcoreShellAddContactSubtitle => 'Scan QR or enter contact code';

  @override
  String get meshcoreShellAdvertisementSent =>
      'Advertisement sent - listen for responses';

  @override
  String get meshcoreShellAdvertisementSentListening =>
      'Advertisement sent - listening for responses';

  @override
  String get meshcoreShellAppSettings => 'App Settings';

  @override
  String get meshcoreShellAppSettingsSubtitle =>
      'Notifications, theme, preferences';

  @override
  String meshcoreShellConnectedTo(String deviceName) {
    return 'Connected to $deviceName';
  }

  @override
  String get meshcoreShellDefaultDeviceName => 'MeshCore';

  @override
  String get meshcoreShellDefaultDeviceNameFull => 'MeshCore Device';

  @override
  String get meshcoreShellDefaultInitials => 'MC';

  @override
  String get meshcoreShellDeviceInfoNotAvailable => 'Device info not available';

  @override
  String get meshcoreShellDeviceTooltip => 'Device';

  @override
  String get meshcoreShellDisconnect => 'Disconnect';

  @override
  String get meshcoreShellDisconnectConfirmMessage =>
      'Are you sure you want to disconnect from this MeshCore device?';

  @override
  String meshcoreShellDisconnectedFrom(String deviceName) {
    return 'Disconnected from $deviceName';
  }

  @override
  String get meshcoreShellDisconnecting => 'Disconnecting...';

  @override
  String get meshcoreShellDiscoverSubtitle =>
      'Send advertisement to find nearby nodes';

  @override
  String get meshcoreShellDrawerAddChannel => 'Add Channel';

  @override
  String get meshcoreShellDrawerAddContact => 'Add Contact';

  @override
  String get meshcoreShellDrawerDisconnect => 'Disconnect';

  @override
  String get meshcoreShellDrawerDiscoverContacts => 'Discover Contacts';

  @override
  String get meshcoreShellDrawerMyContactCode => 'My Contact Code';

  @override
  String get meshcoreShellDrawerSectionHeader => 'MESHCORE';

  @override
  String get meshcoreShellDrawerSettings => 'Settings';

  @override
  String get meshcoreShellInfoNodeId => 'Node ID';

  @override
  String get meshcoreShellInfoNodeName => 'Node Name';

  @override
  String get meshcoreShellInfoProtocol => 'Protocol';

  @override
  String get meshcoreShellInfoProtocolValue => 'MeshCore';

  @override
  String get meshcoreShellInfoPublicKey => 'Public Key';

  @override
  String get meshcoreShellInfoStatus => 'Status';

  @override
  String get meshcoreShellJoinChannel => 'Join Channel';

  @override
  String get meshcoreShellJoinChannelHint => 'Use the menu to join a channel';

  @override
  String get meshcoreShellJoinChannelSubtitle =>
      'Scan QR or enter channel code';

  @override
  String get meshcoreShellMenuTooltip => 'Menu';

  @override
  String get meshcoreShellNavChannels => 'Channels';

  @override
  String get meshcoreShellNavContacts => 'Contacts';

  @override
  String get meshcoreShellNavMap => 'Map';

  @override
  String get meshcoreShellNavTools => 'Tools';

  @override
  String get meshcoreShellNoSavedDevice => 'No saved device to reconnect to';

  @override
  String get meshcoreShellNotConnected => 'Not connected';

  @override
  String get meshcoreShellReconnectButton => 'Reconnect';

  @override
  String meshcoreShellReconnectFailed(String error) {
    return 'Reconnect failed: $error';
  }

  @override
  String meshcoreShellReconnecting(String deviceName) {
    return 'Reconnecting to $deviceName...';
  }

  @override
  String get meshcoreShellScanToAddContact => 'Scan to add as contact';

  @override
  String get meshcoreShellSectionConnection => 'Connection';

  @override
  String get meshcoreShellSectionDeviceInfo => 'Device Information';

  @override
  String get meshcoreShellSectionQuickActions => 'Quick Actions';

  @override
  String get meshcoreShellShareContactInfo =>
      'Share your contact code so others can message you';

  @override
  String get meshcoreShellShareContactSubtitle => 'Share your contact info';

  @override
  String get meshcoreShellStatusConnected => 'Connected';

  @override
  String get meshcoreShellStatusConnecting => 'Connecting...';

  @override
  String get meshcoreShellStatusDisconnected => 'Disconnected';

  @override
  String get meshcoreShellStatusOffline => 'Offline';

  @override
  String get meshcoreShellStatusOnline => 'Online';

  @override
  String get meshcoreShellUnknown => 'Unknown';

  @override
  String get meshcoreShellUnnamedNode => 'Unnamed Node';

  @override
  String get messageContextMenuCopy => 'Copy';

  @override
  String get messageContextMenuMessageCopied => 'Message copied';

  @override
  String get messageContextMenuMessageDetails => 'Message Details';

  @override
  String get messageContextMenuNoRecents => 'No Recents';

  @override
  String get messageContextMenuReply => 'Reply';

  @override
  String get messageContextMenuSearchEmoji => 'Search emoji…';

  @override
  String get messageContextMenuStatusDelivered => 'Delivered ✔️';

  @override
  String messageContextMenuStatusFailed(String error) {
    return 'Failed: $error';
  }

  @override
  String get messageContextMenuStatusSending => 'Sending…';

  @override
  String get messageContextMenuStatusSent => 'Sent';

  @override
  String get messageContextMenuTapbackFailed => 'Failed to send tapback';

  @override
  String get messageContextMenuTapbackSent => 'Tapback sent';

  @override
  String get messagesAddChannelNotConnected =>
      'Connect to a device to add channels';

  @override
  String get messagesChannelsTab => 'Channels';

  @override
  String get messagesContactsTab => 'Contacts';

  @override
  String get messagesContainerTitle => 'Messages';

  @override
  String get messagesScanChannelNotConnected =>
      'Connect to a device to scan channels';

  @override
  String get messagingAddChannel => 'Add channel';

  @override
  String get messagingAdvancedResetNodeDatabase =>
      'Advanced: Reset Node Database';

  @override
  String get messagingChannelSettings => 'Channel Settings';

  @override
  String get messagingChannelSubtitle => 'Channel';

  @override
  String get messagingClearSearch => 'Clear search';

  @override
  String get messagingCloseSearch => 'Close Search';

  @override
  String get messagingConfigureQuickResponses =>
      'Configure quick responses in Settings';

  @override
  String get messagingContactsDiscoveredHint =>
      'Discovered nodes will appear here';

  @override
  String get messagingContactsTitle => 'Contacts';

  @override
  String messagingContactsTitleWithCount(int count) {
    return 'Contacts ($count)';
  }

  @override
  String get messagingDeleteMessageConfirmation =>
      'Are you sure you want to delete this message? This only removes it locally.';

  @override
  String get messagingDeleteMessageTitle => 'Delete Message';

  @override
  String get messagingDirectMessageSubtitle => 'Direct Message';

  @override
  String messagingEncryptionKeyIssueSubtitle(String name) {
    return 'Direct message to $name failed';
  }

  @override
  String get messagingEncryptionKeyIssueTitle => 'Encryption Key Issue';

  @override
  String get messagingEncryptionKeyWarning =>
      'The encryption keys may be out of sync. This can happen when a node has been reset or rolled out of the mesh database.';

  @override
  String get messagingFailedToSend => 'Failed to send';

  @override
  String get messagingFilterActive => 'Active';

  @override
  String get messagingFilterAll => 'All';

  @override
  String get messagingFilterFavorites => 'Favorites';

  @override
  String get messagingFilterMessaged => 'Messaged';

  @override
  String get messagingFilterUnread => 'Unread';

  @override
  String get messagingFindMessageHint => 'Find a message';

  @override
  String get messagingHelp => 'Help';

  @override
  String get messagingMessageDeleted => 'Message deleted';

  @override
  String get messagingMessageHint => 'Message…';

  @override
  String get messagingMessageQueuedOffline =>
      'Message queued - will send when connected';

  @override
  String messagingNoContactsMatchSearch(String query) {
    return 'No contacts match \"$query\"';
  }

  @override
  String get messagingNoContactsYet => 'No contacts yet';

  @override
  String messagingNoFilteredContacts(String filter) {
    return 'No $filter contacts';
  }

  @override
  String get messagingNoMessagesInChannel => 'No messages in this channel';

  @override
  String get messagingNoMessagesMatchSearch => 'No messages match your search';

  @override
  String get messagingNoQuickResponsesConfigured =>
      'No quick responses configured.\nAdd some in Settings → Quick responses.';

  @override
  String get messagingOriginalMessage => 'Original message';

  @override
  String get messagingQuickResponses => 'Quick Responses';

  @override
  String messagingReplyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get messagingRequestUserInfo => 'Request User Info';

  @override
  String messagingRequestUserInfoFailed(String error) {
    return 'Failed to request info: $error';
  }

  @override
  String messagingRequestUserInfoSuccess(String name) {
    return 'Requested fresh info from $name';
  }

  @override
  String get messagingRetryMessage => 'Retry Message';

  @override
  String get messagingScanQrCode => 'Scan QR code';

  @override
  String get messagingSearchContactsHint => 'Search contacts';

  @override
  String get messagingSearchMessages => 'Search Messages';

  @override
  String get messagingSectionActive => 'Active';

  @override
  String get messagingSectionFavorites => 'Favorites';

  @override
  String get messagingSectionInactive => 'Inactive';

  @override
  String get messagingSectionUnread => 'Unread';

  @override
  String get messagingSettings => 'Settings';

  @override
  String get messagingSourceAutomation => 'Automation';

  @override
  String get messagingSourceNotification => 'Notification';

  @override
  String get messagingSourceShortcut => 'Shortcut';

  @override
  String get messagingSourceTapback => 'Tapback';

  @override
  String get messagingStartConversation => 'Start the conversation';

  @override
  String get messagingUnknownNode => 'Unknown Node';

  @override
  String get navigationActivity => 'Activity';

  @override
  String get navigationAether => 'Aether';

  @override
  String get navigationAutomations => 'Automations';

  @override
  String get navigationDashboard => 'Dashboard';

  @override
  String get navigationDeviceLogs => 'Device Logs';

  @override
  String get navigationDeviceTooltip => 'Device';

  @override
  String get navigationFileTransfers => 'File Transfers';

  @override
  String get navigationFirmwareErrorTitle => 'Meshtastic Device Error';

  @override
  String navigationFirmwareMessage(String message) {
    return 'Firmware: $message';
  }

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
  String get navigationGuestName => 'Guest';

  @override
  String get navigationHelpSupport => 'Help & Support';

  @override
  String get navigationIftttIntegration => 'IFTTT Integration';

  @override
  String get navigationMap => 'Map';

  @override
  String get navigationMenuTooltip => 'Menu';

  @override
  String get navigationMesh3dView => '3D Mesh View';

  @override
  String get navigationMeshHealth => 'Mesh Health';

  @override
  String get navigationMessages => 'Messages';

  @override
  String get navigationNodeDex => 'NodeDex';

  @override
  String get navigationNodes => 'Nodes';

  @override
  String get navigationNotSignedIn => 'Not signed in';

  @override
  String get navigationOffline => 'Offline';

  @override
  String get navigationPresence => 'Presence';

  @override
  String get navigationReachability => 'Reachability';

  @override
  String get navigationRingtonePack => 'Ringtone Pack';

  @override
  String get navigationRoutes => 'Routes';

  @override
  String get navigationSectionAccount => 'ACCOUNT';

  @override
  String get navigationSectionMesh => 'MESH';

  @override
  String get navigationSectionPremium => 'PREMIUM';

  @override
  String get navigationSectionSocial => 'SOCIAL';

  @override
  String get navigationSignals => 'Signals';

  @override
  String get navigationSocial => 'Social';

  @override
  String get navigationSyncError => 'Sync error';

  @override
  String get navigationSynced => 'Synced';

  @override
  String get navigationSyncing => 'Syncing...';

  @override
  String get navigationTakGateway => 'TAK Gateway';

  @override
  String get navigationTakMap => 'TAK Map';

  @override
  String get navigationThemePack => 'Theme Pack';

  @override
  String get navigationTimeline => 'Timeline';

  @override
  String get navigationViewProfile => 'View Profile';

  @override
  String get navigationWidgets => 'Widgets';

  @override
  String get navigationWorldMap => 'World Map';

  @override
  String get nodeAnalyticsAddFavoriteTooltip => 'Add to favorites';

  @override
  String get nodeAnalyticsAddedToFavorites => 'Added to favorites';

  @override
  String get nodeAnalyticsAirTimeTx => 'Air Time TX';

  @override
  String nodeAnalyticsAltitude(String meters) {
    return '${meters}m';
  }

  @override
  String get nodeAnalyticsAvgBattery => 'Avg Battery';

  @override
  String get nodeAnalyticsBadgeLive => 'LIVE';

  @override
  String get nodeAnalyticsBattery => 'Battery';

  @override
  String get nodeAnalyticsChannelUtilization => 'Channel Utilization';

  @override
  String get nodeAnalyticsCharging => 'Charging';

  @override
  String get nodeAnalyticsClear => 'Clear';

  @override
  String get nodeAnalyticsClearConfirm => 'Clear';

  @override
  String get nodeAnalyticsClearHistoryMessage =>
      'This will delete all historical data for this node. This action cannot be undone.';

  @override
  String get nodeAnalyticsClearHistoryTitle => 'Clear History';

  @override
  String get nodeAnalyticsCsvShared => 'CSV data shared';

  @override
  String get nodeAnalyticsDataUpdated => 'Node data updated';

  @override
  String nodeAnalyticsDirectNeighbors(int count) {
    return 'Direct Neighbors ($count)';
  }

  @override
  String get nodeAnalyticsExport => 'Export';

  @override
  String get nodeAnalyticsExportCsv => 'CSV';

  @override
  String nodeAnalyticsExportCsvSubject(String name) {
    return 'Node $name History (CSV)';
  }

  @override
  String get nodeAnalyticsExportHistoryTitle => 'Export History';

  @override
  String get nodeAnalyticsExportJson => 'JSON';

  @override
  String nodeAnalyticsExportJsonSubject(String name) {
    return 'Node $name History (JSON)';
  }

  @override
  String nodeAnalyticsExportRecordCount(int count) {
    return '$count records';
  }

  @override
  String get nodeAnalyticsFirstSeen => 'First seen';

  @override
  String get nodeAnalyticsHardware => 'Hardware';

  @override
  String get nodeAnalyticsHistoryCleared => 'History cleared';

  @override
  String get nodeAnalyticsJsonShared => 'JSON data shared';

  @override
  String get nodeAnalyticsLastUpdate => 'Last update';

  @override
  String get nodeAnalyticsLatitude => 'Latitude';

  @override
  String get nodeAnalyticsLiveWatchDisabled => 'Live watching disabled';

  @override
  String get nodeAnalyticsLiveWatchEnabled =>
      'Live watching enabled (updates every 30s)';

  @override
  String get nodeAnalyticsLongName => 'Long Name';

  @override
  String get nodeAnalyticsLongitude => 'Longitude';

  @override
  String get nodeAnalyticsNoGatewayData => 'No gateway data available';

  @override
  String get nodeAnalyticsNoHistoryToExport => 'No history data to export';

  @override
  String get nodeAnalyticsNoHistoryYet => 'No historical data yet';

  @override
  String get nodeAnalyticsNoNeighborData => 'No neighbor data available';

  @override
  String get nodeAnalyticsNodeIdCopied => 'Node ID copied';

  @override
  String get nodeAnalyticsNodeNotFound => 'Node not found in mesh';

  @override
  String get nodeAnalyticsRecords => 'Records';

  @override
  String nodeAnalyticsRefreshFailed(String error) {
    return 'Failed to refresh: $error';
  }

  @override
  String get nodeAnalyticsRefreshNow => 'Refresh Now';

  @override
  String get nodeAnalyticsRefreshing => 'Refreshing...';

  @override
  String get nodeAnalyticsRemoveFavoriteTooltip => 'Remove from favorites';

  @override
  String get nodeAnalyticsRemovedFromFavorites => 'Removed from favorites';

  @override
  String get nodeAnalyticsRole => 'Role';

  @override
  String get nodeAnalyticsSectionDeviceInfo => 'Device Info';

  @override
  String get nodeAnalyticsSectionDeviceMetrics => 'Device Metrics';

  @override
  String get nodeAnalyticsSectionHistory => 'History';

  @override
  String get nodeAnalyticsSectionNetwork => 'Network';

  @override
  String get nodeAnalyticsSectionTrends => 'Trends';

  @override
  String nodeAnalyticsSeenByGateways(int count) {
    return 'Seen by Gateways ($count)';
  }

  @override
  String get nodeAnalyticsShareDetailBatteryCharging => 'Battery: Charging';

  @override
  String nodeAnalyticsShareDetailBatteryLevel(String level) {
    return 'Battery: $level%';
  }

  @override
  String nodeAnalyticsShareDetailGateways(String count) {
    return 'Gateways: $count';
  }

  @override
  String nodeAnalyticsShareDetailHardware(String hardware) {
    return 'Hardware: $hardware';
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
  String nodeAnalyticsShareDetailLocation(String location) {
    return 'Location: $location';
  }

  @override
  String nodeAnalyticsShareDetailNeighbors(String count) {
    return 'Neighbors: $count';
  }

  @override
  String nodeAnalyticsShareDetailRole(String role) {
    return 'Role: $role';
  }

  @override
  String nodeAnalyticsShareDetailStatus(String status) {
    return 'Status: $status';
  }

  @override
  String get nodeAnalyticsShareDetails => 'Share Details';

  @override
  String get nodeAnalyticsShareDetailsSubtitle => 'Full technical info as text';

  @override
  String nodeAnalyticsShareFailed(String error) {
    return 'Failed to share node: $error';
  }

  @override
  String get nodeAnalyticsShareLink => 'Share Link';

  @override
  String get nodeAnalyticsShareLinkSubtitle =>
      'Rich preview in iMessage, Slack, etc.';

  @override
  String get nodeAnalyticsShareNodeTitle => 'Share Node';

  @override
  String nodeAnalyticsShareSubject(String name) {
    return 'Mesh Node: $name';
  }

  @override
  String nodeAnalyticsShareText(String name, String url) {
    return 'Check out $name on Socialmesh!\n$url';
  }

  @override
  String get nodeAnalyticsShareTooltip => 'Share node info';

  @override
  String get nodeAnalyticsShortName => 'Short Name';

  @override
  String get nodeAnalyticsShowOnMap => 'Show on Map';

  @override
  String get nodeAnalyticsSignIn => 'Sign In';

  @override
  String get nodeAnalyticsSignInToShare => 'Sign in to share nodes';

  @override
  String get nodeAnalyticsStopWatching => 'Stop watching';

  @override
  String nodeAnalyticsTimeDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String nodeAnalyticsTimeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get nodeAnalyticsTimeJustNow => 'Just now';

  @override
  String nodeAnalyticsTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get nodeAnalyticsUnknown => 'Unknown';

  @override
  String get nodeAnalyticsUptime => 'Uptime';

  @override
  String get nodeAnalyticsUptimeStat => 'Uptime';

  @override
  String get nodeAnalyticsVisitAgain =>
      'Visit this node again to build history';

  @override
  String get nodeAnalyticsVoltage => 'Voltage';

  @override
  String get nodeAnalyticsWatchLive => 'Watch live';

  @override
  String get nodeComparisonCharging => 'Charging';

  @override
  String get nodeComparisonNo => 'No';

  @override
  String get nodeComparisonNoData => '--';

  @override
  String get nodeComparisonNodeIdCopied => 'Node ID copied';

  @override
  String get nodeComparisonRowAirTimeTx => 'Air Time TX';

  @override
  String get nodeComparisonRowBattery => 'Battery';

  @override
  String get nodeComparisonRowChannelUtil => 'Channel Util';

  @override
  String get nodeComparisonRowFirmware => 'Firmware';

  @override
  String get nodeComparisonRowGateways => 'Gateways';

  @override
  String get nodeComparisonRowHardware => 'Hardware';

  @override
  String get nodeComparisonRowHasLocation => 'Has Location';

  @override
  String get nodeComparisonRowNeighbors => 'Neighbors';

  @override
  String get nodeComparisonRowRegion => 'Region';

  @override
  String get nodeComparisonRowRole => 'Role';

  @override
  String get nodeComparisonRowStatus => 'Status';

  @override
  String get nodeComparisonRowUptime => 'Uptime';

  @override
  String get nodeComparisonRowVoltage => 'Voltage';

  @override
  String get nodeComparisonSectionDeviceInfo => 'Device Info';

  @override
  String get nodeComparisonSectionMetrics => 'Metrics';

  @override
  String get nodeComparisonSectionNetwork => 'Network';

  @override
  String get nodeComparisonSectionStatus => 'Status';

  @override
  String get nodeComparisonTitle => 'Compare Nodes';

  @override
  String get nodeComparisonUnknown => 'Unknown';

  @override
  String get nodeComparisonVs => 'VS';

  @override
  String get nodeComparisonYes => 'Yes';

  @override
  String get nodeDetailAddToFavoritesTooltip => 'Add to favorites';

  @override
  String nodeDetailAddedToFavorites(String name) {
    return '$name added to favorites';
  }

  @override
  String get nodeDetailAppBarTitle => 'Node Details';

  @override
  String get nodeDetailBatteryCharging => 'Charging';

  @override
  String nodeDetailBatteryPercent(int level) {
    return '$level%';
  }

  @override
  String nodeDetailDistanceKilometers(String km) {
    return '$km km';
  }

  @override
  String nodeDetailDistanceMeters(String meters) {
    return '$meters m';
  }

  @override
  String get nodeDetailFavoriteBadge => 'Favorite';

  @override
  String nodeDetailFavoriteError(String error) {
    return 'Failed to update favorite: $error';
  }

  @override
  String nodeDetailFixedPositionError(String error) {
    return 'Failed to set fixed position: $error';
  }

  @override
  String nodeDetailFixedPositionSet(String name) {
    return 'Fixed position set to $name\'s location';
  }

  @override
  String get nodeDetailLabelAirUtilTx => 'Air Util TX';

  @override
  String get nodeDetailLabelAltitude => 'Altitude';

  @override
  String get nodeDetailLabelBadPackets => 'Bad Packets';

  @override
  String get nodeDetailLabelBattery => 'Battery';

  @override
  String get nodeDetailLabelCacheHits => 'Cache Hits';

  @override
  String get nodeDetailLabelChannelUtil => 'Channel Util';

  @override
  String get nodeDetailLabelDistance => 'Distance';

  @override
  String get nodeDetailLabelEncryption => 'Encryption';

  @override
  String get nodeDetailLabelFirmware => 'Firmware';

  @override
  String get nodeDetailLabelHardware => 'Hardware';

  @override
  String get nodeDetailLabelHopExhausted => 'Hop Exhausted';

  @override
  String get nodeDetailLabelHopsPreserved => 'Hops Preserved';

  @override
  String get nodeDetailLabelInspected => 'Inspected';

  @override
  String get nodeDetailLabelNoiseFloor => 'Noise Floor';

  @override
  String get nodeDetailLabelOnlineNodes => 'Online Nodes';

  @override
  String get nodeDetailLabelPacketsRx => 'Packets RX';

  @override
  String get nodeDetailLabelPacketsTx => 'Packets TX';

  @override
  String get nodeDetailLabelPosition => 'Position';

  @override
  String get nodeDetailLabelPositionDedup => 'Position Dedup';

  @override
  String get nodeDetailLabelRateLimitDrops => 'Rate Limit Drops';

  @override
  String get nodeDetailLabelRssi => 'RSSI';

  @override
  String get nodeDetailLabelSnr => 'SNR';

  @override
  String get nodeDetailLabelStatus => 'Status';

  @override
  String get nodeDetailLabelTotalNodes => 'Total Nodes';

  @override
  String get nodeDetailLabelTxDropped => 'TX Dropped';

  @override
  String get nodeDetailLabelUnknownDrops => 'Unknown Drops';

  @override
  String get nodeDetailLabelUptime => 'Uptime';

  @override
  String get nodeDetailLabelUserId => 'User ID';

  @override
  String get nodeDetailLabelVoltage => 'Voltage';

  @override
  String nodeDetailLastHeardDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String nodeDetailLastHeardHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get nodeDetailLastHeardJustNow => 'Just now';

  @override
  String nodeDetailLastHeardMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get nodeDetailLastHeardNever => 'Never';

  @override
  String nodeDetailLastHeardTimestamp(String timestamp) {
    return 'Last heard $timestamp';
  }

  @override
  String get nodeDetailMenuAdminSettings => 'Admin Settings';

  @override
  String get nodeDetailMenuAdminSubtitle => 'Configure this node remotely';

  @override
  String get nodeDetailMenuExchangePositions => 'Exchange Positions';

  @override
  String get nodeDetailMenuQrCode => 'QR Code';

  @override
  String get nodeDetailMenuRemoveNode => 'Remove Node';

  @override
  String get nodeDetailMenuRequestUserInfo => 'Request User Info';

  @override
  String get nodeDetailMenuSetFixedPosition => 'Set as Fixed Position';

  @override
  String get nodeDetailMenuShowOnMap => 'Show on Map';

  @override
  String get nodeDetailMenuTracerouteHistory => 'Traceroute History';

  @override
  String get nodeDetailMessageButton => 'Message';

  @override
  String nodeDetailMuteError(String error) {
    return 'Failed to update mute status: $error';
  }

  @override
  String get nodeDetailMuteNotConnected =>
      'Cannot change mute status: Device not connected';

  @override
  String get nodeDetailMuteTooltip => 'Mute node';

  @override
  String nodeDetailMuted(String name) {
    return '$name muted';
  }

  @override
  String get nodeDetailMutedBadge => 'Muted';

  @override
  String get nodeDetailNoPkiBadge => 'No PKI';

  @override
  String get nodeDetailNoPositionData => 'Node has no position data';

  @override
  String get nodeDetailPkiBadge => 'PKI';

  @override
  String nodeDetailPositionError(String error) {
    return 'Failed to request position: $error';
  }

  @override
  String nodeDetailPositionRequested(String name) {
    return 'Position requested from $name';
  }

  @override
  String nodeDetailQrInfoText(String nodeId) {
    return 'Node ID: $nodeId';
  }

  @override
  String get nodeDetailQrSubtitle => 'Scan to add this node';

  @override
  String get nodeDetailRebootButton => 'Reboot';

  @override
  String get nodeDetailRebootConfirm => 'Reboot';

  @override
  String nodeDetailRebootError(String error) {
    return 'Failed to reboot: $error';
  }

  @override
  String get nodeDetailRebootMessage =>
      'This will reboot your Meshtastic device. The app will automatically reconnect once the device restarts.';

  @override
  String get nodeDetailRebootNotConnected =>
      'Cannot reboot: Device not connected';

  @override
  String get nodeDetailRebootTitle => 'Reboot Device';

  @override
  String get nodeDetailRebootingSnackbar => 'Device is rebooting...';

  @override
  String get nodeDetailRemoveConfirm => 'Remove';

  @override
  String nodeDetailRemoveError(String error) {
    return 'Failed to remove node: $error';
  }

  @override
  String get nodeDetailRemoveFromFavoritesTooltip => 'Remove from favorites';

  @override
  String nodeDetailRemoveMessage(String name) {
    return 'Remove $name from the node database? This will remove the node from your local device.';
  }

  @override
  String get nodeDetailRemoveTitle => 'Remove Node';

  @override
  String nodeDetailRemovedFromFavorites(String name) {
    return '$name removed from favorites';
  }

  @override
  String nodeDetailRemovedSnackbar(String name) {
    return '$name removed';
  }

  @override
  String get nodeDetailSectionDeviceMetrics => 'Device Metrics';

  @override
  String get nodeDetailSectionIdentity => 'Identity';

  @override
  String get nodeDetailSectionNetwork => 'Network';

  @override
  String get nodeDetailSectionRadio => 'Radio';

  @override
  String get nodeDetailSectionTraffic => 'Traffic Management';

  @override
  String get nodeDetailShutdownButton => 'Shutdown';

  @override
  String get nodeDetailShutdownConfirm => 'Shutdown';

  @override
  String nodeDetailShutdownError(String error) {
    return 'Failed to shutdown: $error';
  }

  @override
  String get nodeDetailShutdownMessage =>
      'This will turn off your Meshtastic device. You will need to physically power it back on to reconnect.';

  @override
  String get nodeDetailShutdownNotConnected =>
      'Cannot shutdown: Device not connected';

  @override
  String get nodeDetailShutdownTitle => 'Shutdown Device';

  @override
  String get nodeDetailShuttingDownSnackbar => 'Device is shutting down...';

  @override
  String get nodeDetailSigilCardTooltip => 'Sigil Card';

  @override
  String get nodeDetailSignalExcellent => 'Excellent';

  @override
  String get nodeDetailSignalFair => 'Fair';

  @override
  String get nodeDetailSignalGood => 'Good';

  @override
  String get nodeDetailSignalUnknown => 'Unknown';

  @override
  String get nodeDetailSignalVeryWeak => 'Very Weak';

  @override
  String get nodeDetailSignalWeak => 'Weak';

  @override
  String nodeDetailTracerouteCooldownTooltip(int seconds) {
    return 'Traceroute cooldown: ${seconds}s';
  }

  @override
  String nodeDetailTracerouteError(String error) {
    return 'Failed to send traceroute: $error';
  }

  @override
  String get nodeDetailTracerouteNotConnected =>
      'Cannot send traceroute: Device not connected';

  @override
  String nodeDetailTracerouteSent(String name) {
    return 'Traceroute sent to $name — check Traceroute History for results';
  }

  @override
  String get nodeDetailTracerouteTooltip => 'Traceroute';

  @override
  String get nodeDetailUnmuteTooltip => 'Unmute node';

  @override
  String nodeDetailUnmuted(String name) {
    return '$name unmuted';
  }

  @override
  String nodeDetailUserInfoError(String error) {
    return 'Failed to request user info: $error';
  }

  @override
  String nodeDetailUserInfoRequested(String name) {
    return 'User info requested from $name';
  }

  @override
  String nodeDetailValueAltitude(int altitude) {
    return '$altitude m';
  }

  @override
  String get nodeDetailValueNoPublicKey => 'No Public Key';

  @override
  String nodeDetailValueNoiseFloor(int noiseFloor) {
    return '$noiseFloor dBm';
  }

  @override
  String nodeDetailValuePercent(String value) {
    return '$value%';
  }

  @override
  String get nodeDetailValuePkiEnabled => 'PKI Enabled';

  @override
  String nodeDetailValueRssi(int rssi) {
    return '$rssi dBm';
  }

  @override
  String nodeDetailValueSnr(String snr) {
    return '$snr dB';
  }

  @override
  String nodeDetailValueVoltage(String voltage) {
    return '$voltage V';
  }

  @override
  String get nodeDetailYouBadge => 'YOU';

  @override
  String nodeHistoryDataPointCount(int current, int required) {
    return '$current/$required data points';
  }

  @override
  String get nodeHistoryMetricBattery => 'Battery';

  @override
  String get nodeHistoryMetricChannelUtil => 'Channel Util';

  @override
  String get nodeHistoryMetricConnectivity => 'Connectivity';

  @override
  String get nodeHistoryNeedMoreData => 'Need more data for charts';

  @override
  String nodeHistoryNoMetricData(String metric) {
    return 'No $metric data';
  }

  @override
  String get nodeIntelligenceActivityActive => 'Active';

  @override
  String get nodeIntelligenceActivityCold => 'Cold';

  @override
  String get nodeIntelligenceActivityHot => 'Hot';

  @override
  String get nodeIntelligenceActivityQuiet => 'Quiet';

  @override
  String get nodeIntelligenceChannelUtil => 'Channel Utilization';

  @override
  String get nodeIntelligenceConnectivity => 'Connectivity';

  @override
  String get nodeIntelligenceDerivedBadge => 'DERIVED';

  @override
  String nodeIntelligenceGatewayCount(int count) {
    return '$count gateways';
  }

  @override
  String get nodeIntelligenceHealth => 'Health';

  @override
  String get nodeIntelligenceMobilityElevated => 'Elevated';

  @override
  String get nodeIntelligenceMobilityInfra => 'Infrastructure';

  @override
  String get nodeIntelligenceMobilityMobile => 'Mobile';

  @override
  String get nodeIntelligenceMobilityStationary => 'Stationary';

  @override
  String get nodeIntelligenceMobilityTracker => 'Tracker';

  @override
  String nodeIntelligenceNeighborCount(int count) {
    return '$count neighbors';
  }

  @override
  String get nodeIntelligenceTapHint => 'Tap for deep analytics';

  @override
  String get nodeIntelligenceTitle => 'Mesh Intelligence';

  @override
  String get nodeIntelligenceUnknown => 'Unknown';

  @override
  String nodedexActiveDaysOf14(int count) {
    return '$count/14 days';
  }

  @override
  String get nodedexActiveNow => 'active now';

  @override
  String get nodedexActivityTimelineTitle => 'Activity Timeline';

  @override
  String get nodedexAddToAppleWallet => 'Add to Apple Wallet';

  @override
  String get nodedexAdditionalTraits => 'Additional Traits';

  @override
  String nodedexAgeDiscoveredDaysAgo(int days) {
    return 'discovered ${days}d ago';
  }

  @override
  String nodedexAgeDiscoveredMonthsAgo(int months) {
    return 'discovered ${months}mo ago';
  }

  @override
  String nodedexAgeDiscoveredWeeksAgo(int weeks) {
    return 'discovered ${weeks}w ago';
  }

  @override
  String nodedexAgeDiscoveredYearsAgo(int years) {
    return 'discovered ${years}y ago';
  }

  @override
  String get nodedexAgeDiscoveredYesterday => 'discovered yesterday';

  @override
  String get nodedexAgeNewToday => 'new today';

  @override
  String get nodedexAirUtilTxLabel => 'Air Util TX';

  @override
  String get nodedexBatteryLabel => 'Battery';

  @override
  String get nodedexBestRssi => 'Best RSSI';

  @override
  String get nodedexBestSnr => 'Best SNR';

  @override
  String get nodedexBestSnrStatLabel => 'Best SNR';

  @override
  String nodedexBusiestDay(String day) {
    return 'Busiest $day';
  }

  @override
  String get nodedexCardBrandSocialmesh => 'SOCIALMESH';

  @override
  String get nodedexCardDeviceFirmware => 'FIRMWARE';

  @override
  String get nodedexCardDeviceHardware => 'HARDWARE';

  @override
  String get nodedexCardDeviceRole => 'ROLE';

  @override
  String get nodedexCardRarity100plus => '100+ encounters';

  @override
  String get nodedexCardRarity20to49 => '20 - 49 encounters';

  @override
  String get nodedexCardRarity50to99 => '50 - 99 encounters';

  @override
  String get nodedexCardRarity5to19 => '5 - 19 encounters';

  @override
  String get nodedexCardRarityEpic => 'EPIC';

  @override
  String get nodedexCardRarityInfoDescription =>
      'A card\'s rarity reflects how often you\'ve encountered this node on the mesh. The more you cross paths, the rarer the card becomes.';

  @override
  String get nodedexCardRarityInfoTitle => 'Card Rarity';

  @override
  String get nodedexCardRarityLegendary => 'LEGENDARY';

  @override
  String get nodedexCardRarityRare => 'RARE';

  @override
  String get nodedexCardRarityStandard => 'STANDARD';

  @override
  String get nodedexCardRarityUncommon => 'UNCOMMON';

  @override
  String get nodedexCardRarityUnder5 => 'Under 5 encounters';

  @override
  String get nodedexChannelUtilLabel => 'Channel Util';

  @override
  String get nodedexClassificationChange => 'Change';

  @override
  String get nodedexClassificationClassify => 'Classify';

  @override
  String get nodedexClassificationLabel => 'CLASSIFICATION';

  @override
  String get nodedexClassificationTitle => 'Classification';

  @override
  String get nodedexClassifyNodeDescription =>
      'Assign a personal classification to this node. This is only visible to you.';

  @override
  String get nodedexClassifyNodeTitle => 'Classify Node';

  @override
  String get nodedexClearFilter => 'Clear';

  @override
  String get nodedexCloseGallerySemanticLabel => 'Close gallery';

  @override
  String get nodedexCoSeenCompactLabel => 'Co-seen';

  @override
  String get nodedexCoSeenDescription =>
      'Nodes frequently seen in the same session';

  @override
  String nodedexCoSeenLinksCount(int count) {
    return '$count links';
  }

  @override
  String get nodedexCoSeenLinksTitle => 'Co-Seen Links';

  @override
  String get nodedexCoSeenRelationshipDetails => 'Co-seen relationship details';

  @override
  String nodedexCollectedCount(int count) {
    return '$count collected';
  }

  @override
  String get nodedexConfidenceLabel => 'Confidence';

  @override
  String nodedexConfidenceTooltip(int percentage) {
    return 'Confidence: $percentage%';
  }

  @override
  String get nodedexConstellationCloseSearch => 'Close search';

  @override
  String get nodedexConstellationEmptySubtitle =>
      'Discover more nodes to see how they connect.\nNodes seen together form constellation links.';

  @override
  String get nodedexConstellationEmptyTitle => 'No Constellation Yet';

  @override
  String nodedexConstellationLinkCount(int count) {
    return '$count links';
  }

  @override
  String get nodedexConstellationLinkTitle => 'Constellation Link';

  @override
  String nodedexConstellationNodeCount(int count) {
    return '$count nodes';
  }

  @override
  String get nodedexConstellationProfile => 'Profile';

  @override
  String get nodedexConstellationSearchHint => 'Search by name or node ID…';

  @override
  String get nodedexConstellationSearchNodes => 'Search nodes';

  @override
  String get nodedexConstellationTitle => 'Constellation';

  @override
  String get nodedexDayFri => 'Fri';

  @override
  String get nodedexDayFriday => 'Friday';

  @override
  String get nodedexDayMon => 'Mon';

  @override
  String get nodedexDayMonday => 'Monday';

  @override
  String get nodedexDaySat => 'Sat';

  @override
  String get nodedexDaySaturday => 'Saturday';

  @override
  String get nodedexDaySun => 'Sun';

  @override
  String get nodedexDaySunday => 'Sunday';

  @override
  String get nodedexDayThu => 'Thu';

  @override
  String get nodedexDayThursday => 'Thursday';

  @override
  String get nodedexDayTue => 'Tue';

  @override
  String get nodedexDayTuesday => 'Tuesday';

  @override
  String get nodedexDayWed => 'Wed';

  @override
  String get nodedexDayWednesday => 'Wednesday';

  @override
  String get nodedexDaysCompactLabel => 'Days';

  @override
  String get nodedexDefaultStampLabel => 'Trace';

  @override
  String get nodedexDefaultSummaryText => 'Keep observing to build a profile';

  @override
  String get nodedexDensityAll => 'All';

  @override
  String get nodedexDensityDense => 'Dense';

  @override
  String get nodedexDensityNormal => 'Normal';

  @override
  String get nodedexDensitySparse => 'Sparse';

  @override
  String get nodedexDensityStars => 'Stars';

  @override
  String get nodedexDetailNotFoundSubtitle =>
      'This node has not been discovered yet.';

  @override
  String get nodedexDetailNotFoundTitle => 'Node not found in NodeDex';

  @override
  String get nodedexDeviceTitle => 'Device';

  @override
  String get nodedexDiscoveryTitle => 'Discovery';

  @override
  String get nodedexDistanceUnknown => 'unknown range';

  @override
  String nodedexDurationDays(int days) {
    return '$days d';
  }

  @override
  String nodedexDurationHours(int hours) {
    return '$hours hr';
  }

  @override
  String nodedexDurationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String nodedexDurationMonths(int months) {
    return '$months mo';
  }

  @override
  String nodedexDurationMonthsDays(int months, int days) {
    return '$months mo $days d';
  }

  @override
  String nodedexDurationYears(int years) {
    return '$years yr';
  }

  @override
  String nodedexDurationYearsMonths(int years, int months) {
    return '$years yr $months mo';
  }

  @override
  String get nodedexEdgeDensityAll => 'All';

  @override
  String get nodedexEdgeDensityDense => 'Dense';

  @override
  String get nodedexEdgeDensityNormal => 'Normal';

  @override
  String get nodedexEdgeDensitySparse => 'Sparse';

  @override
  String nodedexEdgeDensityTooltip(String label) {
    return 'Edge density: $label';
  }

  @override
  String get nodedexEmptyAlbumDescription =>
      'Connect to a mesh device and discover nodes\nto start building your collection';

  @override
  String get nodedexEmptyAlbumHintMove => 'Move around';

  @override
  String get nodedexEmptyAlbumHintScan => 'Scan for devices';

  @override
  String get nodedexEmptyAlbumTitle => 'No cards yet';

  @override
  String get nodedexEmptyAllSubtitle =>
      'Connect to a Meshtastic device and nodes will appear here as they are discovered on the mesh.';

  @override
  String get nodedexEmptyAllTitle => 'No nodes discovered yet';

  @override
  String get nodedexEmptyBeaconsSubtitle =>
      'Beacons are nodes with very high activity and frequent encounters. They take time to classify.';

  @override
  String get nodedexEmptyBeaconsTitle => 'No beacons found';

  @override
  String get nodedexEmptyContactSubtitle =>
      'Nodes you classify as Contact will appear here. Long-press a node to assign this tag.';

  @override
  String get nodedexEmptyContactTitle => 'No contacts';

  @override
  String get nodedexEmptyFrequentPeerSubtitle =>
      'Nodes you classify as Frequent Peer will appear here. Long-press a node to assign this tag.';

  @override
  String get nodedexEmptyFrequentPeerTitle => 'No frequent peers';

  @override
  String get nodedexEmptyGalleryDescription =>
      'Discover nodes to fill your collection';

  @override
  String get nodedexEmptyGalleryTitle => 'No cards to display';

  @override
  String get nodedexEmptyGhostsSubtitle =>
      'Ghosts are nodes that appear rarely relative to how long they have been known.';

  @override
  String get nodedexEmptyGhostsTitle => 'No ghosts found';

  @override
  String get nodedexEmptyKnownRelaySubtitle =>
      'Nodes you classify as Known Relay will appear here. Long-press a node to assign this tag.';

  @override
  String get nodedexEmptyKnownRelayTitle => 'No known relays';

  @override
  String get nodedexEmptyRecentSubtitle =>
      'Nodes discovered in the last 24 hours will appear here.';

  @override
  String get nodedexEmptyRecentTitle => 'No recent discoveries';

  @override
  String get nodedexEmptyRelaysSubtitle =>
      'Relays are nodes with router roles and active traffic forwarding.';

  @override
  String get nodedexEmptyRelaysTitle => 'No relays found';

  @override
  String get nodedexEmptySentinelsSubtitle =>
      'Sentinels are long-lived, fixed-position nodes with reliable presence.';

  @override
  String get nodedexEmptySentinelsTitle => 'No sentinels found';

  @override
  String get nodedexEmptyTaggedSubtitle =>
      'Long-press a node in the list to assign a social tag like Contact, Trusted Node, or Known Relay.';

  @override
  String get nodedexEmptyTaggedTitle => 'No tagged nodes';

  @override
  String get nodedexEmptyTagline1 =>
      'No nodes discovered yet.\nConnect to a mesh device to start building your field journal.';

  @override
  String get nodedexEmptyTagline2 =>
      'NodeDex catalogs every node you encounter.\nEach one gets a unique procedural identity.';

  @override
  String get nodedexEmptyTagline3 =>
      'Discover wanderers, sentinels, and ghosts.\nPersonality traits emerge from behavior patterns.';

  @override
  String get nodedexEmptyTagline4 =>
      'Tag nodes as contacts or trusted relays.\nBuild your mesh community over time.';

  @override
  String get nodedexEmptyTitleKeyword => 'NodeDex';

  @override
  String get nodedexEmptyTitlePrefix => 'Your ';

  @override
  String get nodedexEmptyTitleSuffix => ' is empty';

  @override
  String get nodedexEmptyTrustedNodeSubtitle =>
      'Nodes you classify as Trusted Node will appear here. Long-press a node to assign this tag.';

  @override
  String get nodedexEmptyTrustedNodeTitle => 'No trusted nodes';

  @override
  String get nodedexEmptyWanderersSubtitle =>
      'Wanderers are nodes seen across multiple locations. They emerge over time as position data accumulates.';

  @override
  String get nodedexEmptyWanderersTitle => 'No wanderers found';

  @override
  String get nodedexEncounterActivityTitle => 'Encounter Activity';

  @override
  String nodedexEncounterCountLabel(int count) {
    return '$count encounters';
  }

  @override
  String get nodedexEncounterLogLabel => 'ENCOUNTER LOG';

  @override
  String nodedexEncountersCount(int count) {
    return '$count encounters';
  }

  @override
  String get nodedexEncountersLabel => 'Encounters';

  @override
  String get nodedexEncountersStatLabel => 'Encounters';

  @override
  String get nodedexEvidenceActiveLastHour => 'Active within the last hour';

  @override
  String nodedexEvidenceAirtimeTx(String percent) {
    return 'Airtime TX $percent%';
  }

  @override
  String nodedexEvidenceChannelUtilization(String percent) {
    return 'Channel utilization $percent%';
  }

  @override
  String nodedexEvidenceCoSeenWith(int count) {
    return 'Co-seen with $count nodes';
  }

  @override
  String nodedexEvidenceDistinctPositions(int count) {
    return 'Observed at $count distinct positions';
  }

  @override
  String nodedexEvidenceEncounterRate(String rate) {
    return '$rate encounters/day';
  }

  @override
  String nodedexEvidenceEncounterRateLow(String rate) {
    return 'Encounter rate $rate/day';
  }

  @override
  String nodedexEvidenceEncountersReliable(int count) {
    return '$count encounters (reliable)';
  }

  @override
  String nodedexEvidenceFewEncountersOverDays(int encounters, int days) {
    return 'Only $encounters encounters over $days days';
  }

  @override
  String get nodedexEvidenceFixedLocation => 'Fixed location';

  @override
  String get nodedexEvidenceFixedPosition => 'Fixed position (single location)';

  @override
  String get nodedexEvidenceHighEncounterCount => 'High encounter count (20+)';

  @override
  String get nodedexEvidenceInsufficientData => 'Insufficient data to classify';

  @override
  String nodedexEvidenceIrregularTiming(String cv) {
    return 'Irregular timing (CV $cv)';
  }

  @override
  String nodedexEvidenceKnownForDays(int days) {
    return 'Known for $days days';
  }

  @override
  String nodedexEvidenceLastSeenDaysAgo(int days) {
    return 'Last seen ${days}d ago';
  }

  @override
  String nodedexEvidenceMaxRange(String km) {
    return 'Max range ${km}km';
  }

  @override
  String nodedexEvidenceMessagesExchanged(int count) {
    return '$count messages exchanged';
  }

  @override
  String nodedexEvidenceMessagesPerEncounter(String ratio) {
    return '$ratio messages per encounter';
  }

  @override
  String get nodedexEvidenceMobileWithMessaging =>
      'Mobile with active messaging';

  @override
  String nodedexEvidenceModerateEncounterRate(String rate) {
    return 'Moderate encounter rate ($rate/day)';
  }

  @override
  String nodedexEvidencePersistentPresence(int days) {
    return 'Persistent presence ($days days)';
  }

  @override
  String nodedexEvidencePositionsObserved(int count) {
    return '$count positions observed';
  }

  @override
  String nodedexEvidenceRoleIs(String role) {
    return 'Role is $role';
  }

  @override
  String nodedexEvidenceSeenAcrossRegions(int count) {
    return 'Seen across $count regions';
  }

  @override
  String nodedexEvidenceSomewhatIrregularTiming(String cv) {
    return 'Somewhat irregular timing (CV $cv)';
  }

  @override
  String nodedexEvidenceTotalEncounters(int count) {
    return '$count total encounters';
  }

  @override
  String nodedexEvidenceUptime(int days) {
    return 'Uptime ${days}d';
  }

  @override
  String nodedexExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get nodedexExportNothingToExport =>
      'Nothing to export — NodeDex is empty';

  @override
  String get nodedexExportShareSubject => 'Socialmesh NodeDex Export';

  @override
  String nodedexFieldNoteAnchor0(int coSeen) {
    return 'Hub node. Co-seen with $coSeen other nodes.';
  }

  @override
  String get nodedexFieldNoteAnchor1 =>
      'Social center of local mesh. Many connections.';

  @override
  String nodedexFieldNoteAnchor2(int coSeen) {
    return 'Persistent hub. $coSeen nodes observed in proximity.';
  }

  @override
  String get nodedexFieldNoteAnchor3 =>
      'Anchor point for nearby nodes. Fixed and well-connected.';

  @override
  String get nodedexFieldNoteAnchor4 =>
      'Central to local topology. High co-seen density.';

  @override
  String get nodedexFieldNoteAnchor5 =>
      'Gravitational center. Other nodes cluster around this one.';

  @override
  String nodedexFieldNoteAnchor6(int coSeen) {
    return 'Infrastructure anchor. $coSeen peers linked.';
  }

  @override
  String get nodedexFieldNoteAnchor7 =>
      'Mesh nexus. Stable presence with broad connectivity.';

  @override
  String nodedexFieldNoteBeacon0(String rate) {
    return 'Steady signal. $rate sightings per day.';
  }

  @override
  String get nodedexFieldNoteBeacon1 =>
      'Persistent presence on the mesh. Always broadcasting.';

  @override
  String nodedexFieldNoteBeacon2(String lastSeen) {
    return 'Reliable and consistent. Last heard $lastSeen.';
  }

  @override
  String nodedexFieldNoteBeacon3(int encounters) {
    return 'High availability. $encounters encounters recorded.';
  }

  @override
  String get nodedexFieldNoteBeacon4 =>
      'Continuous operation confirmed. Signal rarely drops.';

  @override
  String get nodedexFieldNoteBeacon5 =>
      'Always-on presence. Dependable reference point.';

  @override
  String nodedexFieldNoteBeacon6(String rate) {
    return 'Broadcasting consistently. $rate daily observations.';
  }

  @override
  String get nodedexFieldNoteBeacon7 =>
      'Fixed rhythm. Predictable timing across sessions.';

  @override
  String nodedexFieldNoteCourier0(int messages, int encounters) {
    return 'High message volume. $messages messages across $encounters encounters.';
  }

  @override
  String get nodedexFieldNoteCourier1 =>
      'Data carrier. Message-to-encounter ratio elevated.';

  @override
  String get nodedexFieldNoteCourier2 =>
      'Active in message exchange. Courier behavior likely.';

  @override
  String nodedexFieldNoteCourier3(int messages) {
    return 'Carries data between mesh segments. $messages messages logged.';
  }

  @override
  String get nodedexFieldNoteCourier4 =>
      'Message density suggests deliberate data transport.';

  @override
  String nodedexFieldNoteCourier5(int messages) {
    return 'Communication-heavy node. $messages exchanges recorded.';
  }

  @override
  String get nodedexFieldNoteCourier6 =>
      'Frequent messenger. Moves data across the network.';

  @override
  String get nodedexFieldNoteCourier7 =>
      'Delivery pattern observed. Messages outpace encounters.';

  @override
  String get nodedexFieldNoteDrifter0 =>
      'Timing unpredictable. Appears and fades without pattern.';

  @override
  String get nodedexFieldNoteDrifter1 =>
      'Irregular intervals between sightings.';

  @override
  String get nodedexFieldNoteDrifter2 =>
      'No consistent schedule. Drift behavior confirmed.';

  @override
  String get nodedexFieldNoteDrifter3 =>
      'Appears sporadically but not rarely. Timing erratic.';

  @override
  String get nodedexFieldNoteDrifter4 =>
      'Signal comes and goes. No rhythm detected.';

  @override
  String get nodedexFieldNoteDrifter5 =>
      'Present but unreliable. Intervals vary widely.';

  @override
  String get nodedexFieldNoteDrifter6 =>
      'Observation timing scattered. No periodicity found.';

  @override
  String get nodedexFieldNoteDrifter7 =>
      'Intermittent but active. Schedule defies prediction.';

  @override
  String nodedexFieldNoteGhost0(String lastSeen) {
    return 'Rarely observed. Last confirmed sighting $lastSeen.';
  }

  @override
  String nodedexFieldNoteGhost1(int encounters, int age) {
    return 'Elusive. $encounters encounters over $age days.';
  }

  @override
  String get nodedexFieldNoteGhost2 =>
      'Signal appears briefly then vanishes. Pattern unknown.';

  @override
  String get nodedexFieldNoteGhost3 =>
      'Intermittent trace only. Insufficient data for profile.';

  @override
  String get nodedexFieldNoteGhost4 =>
      'Faint and sporadic. Presence cannot be relied upon.';

  @override
  String get nodedexFieldNoteGhost5 =>
      'Appears without warning. Disappears without trace.';

  @override
  String get nodedexFieldNoteGhost6 =>
      'Low encounter density. Behavior difficult to classify.';

  @override
  String get nodedexFieldNoteGhost7 =>
      'Detected at the margins. Observation window narrow.';

  @override
  String get nodedexFieldNoteLabel => 'Field Note';

  @override
  String get nodedexFieldNoteRelay0 =>
      'Forwarding traffic. Router role confirmed.';

  @override
  String get nodedexFieldNoteRelay1 =>
      'Active relay node. Channel utilization elevated.';

  @override
  String get nodedexFieldNoteRelay2 =>
      'Infrastructure role: traffic forwarding observed.';

  @override
  String get nodedexFieldNoteRelay3 =>
      'Router signature detected. High airtime usage.';

  @override
  String get nodedexFieldNoteRelay4 =>
      'Mesh backbone element. Facilitates connectivity.';

  @override
  String nodedexFieldNoteRelay5(int encounters) {
    return 'Relay behavior consistent across $encounters sessions.';
  }

  @override
  String get nodedexFieldNoteRelay6 =>
      'Traffic handler. Forwarding pattern stable.';

  @override
  String get nodedexFieldNoteRelay7 =>
      'Network infrastructure. Routing confirmed by role.';

  @override
  String nodedexFieldNoteSentinel0(int age) {
    return 'Fixed position. Monitoring for $age days.';
  }

  @override
  String get nodedexFieldNoteSentinel1 =>
      'Stationary installation. Signal consistent and strong.';

  @override
  String nodedexFieldNoteSentinel2(int encounters) {
    return 'Guardian presence. $encounters observations from one location.';
  }

  @override
  String nodedexFieldNoteSentinel3(String firstSeen) {
    return 'Long-lived post. First observed $firstSeen.';
  }

  @override
  String get nodedexFieldNoteSentinel4 =>
      'No position variance. Infrastructure signature confirmed.';

  @override
  String get nodedexFieldNoteSentinel5 =>
      'Holding position. Reliable since first contact.';

  @override
  String nodedexFieldNoteSentinel6(int snr) {
    return 'Static deployment. Best signal $snr dB SNR.';
  }

  @override
  String nodedexFieldNoteSentinel7(int age) {
    return 'Permanent fixture. Observed continuously for $age days.';
  }

  @override
  String get nodedexFieldNoteUnknown0 =>
      'Recently discovered. Observation in progress.';

  @override
  String get nodedexFieldNoteUnknown1 =>
      'New contact. Insufficient data for classification.';

  @override
  String nodedexFieldNoteUnknown2(String firstSeen) {
    return 'First logged $firstSeen. Awaiting further signals.';
  }

  @override
  String get nodedexFieldNoteUnknown3 =>
      'Identity recorded. Behavioral profile pending.';

  @override
  String get nodedexFieldNoteUnknown4 =>
      'Initial entry. More encounters needed for assessment.';

  @override
  String get nodedexFieldNoteUnknown5 =>
      'Cataloged. No behavioral pattern yet established.';

  @override
  String get nodedexFieldNoteUnknown6 =>
      'Signal acknowledged. Classification deferred.';

  @override
  String get nodedexFieldNoteUnknown7 => 'Entry created. Monitoring initiated.';

  @override
  String nodedexFieldNoteWanderer0(int regions) {
    return 'Recorded across $regions regions. No fixed bearing.';
  }

  @override
  String nodedexFieldNoteWanderer1(int positions) {
    return 'Passes through without settling. $positions positions logged.';
  }

  @override
  String nodedexFieldNoteWanderer2(int regions) {
    return 'Transient signal. Observed moving through $regions zones.';
  }

  @override
  String nodedexFieldNoteWanderer3(String distance) {
    return 'Migratory pattern suspected. Range up to $distance.';
  }

  @override
  String get nodedexFieldNoteWanderer4 =>
      'Appears at different coordinates each session.';

  @override
  String nodedexFieldNoteWanderer5(int regions) {
    return 'No anchor point detected. Drift confirmed across $regions regions.';
  }

  @override
  String nodedexFieldNoteWanderer6(int positions) {
    return 'Logged at $positions positions. Path unclear.';
  }

  @override
  String get nodedexFieldNoteWanderer7 =>
      'Signal origin shifts between sessions.';

  @override
  String nodedexFileTransferStarted(String filename) {
    return 'File transfer started: $filename';
  }

  @override
  String get nodedexFileTransfersTitle => 'File Transfers';

  @override
  String get nodedexFilterAll => 'All';

  @override
  String get nodedexFilterByDateHelp => 'Filter encounters by date';

  @override
  String get nodedexFilterRecent => 'Recent';

  @override
  String get nodedexFilterTagged => 'Tagged';

  @override
  String get nodedexFirmwareLabel => 'Firmware';

  @override
  String get nodedexFirstDiscovered => 'First Discovered';

  @override
  String get nodedexFirstSeenStatLabel => 'First Seen';

  @override
  String get nodedexFirstSighting => 'First Sighting';

  @override
  String get nodedexGalleryHint => 'Tap card to flip • Swipe to browse';

  @override
  String nodedexGalleryLinksCount(int count) {
    return '$count links';
  }

  @override
  String nodedexGalleryPositionCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get nodedexGotIt => 'Got it';

  @override
  String get nodedexGroupByLabel => 'GROUP BY';

  @override
  String get nodedexGroupByRarity => 'Rarity';

  @override
  String get nodedexGroupByRegion => 'Region';

  @override
  String get nodedexGroupByTrait => 'Trait';

  @override
  String get nodedexHardwareLabel => 'Hardware';

  @override
  String get nodedexHelpActivityTimeline => 'Activity Timeline';

  @override
  String get nodedexHelpClassification => 'Classification';

  @override
  String get nodedexHelpConstellationLinks => 'Constellation Links';

  @override
  String get nodedexHelpDeviceInfo => 'Device Info';

  @override
  String get nodedexHelpDiscoveryStats => 'Discovery Stats';

  @override
  String get nodedexHelpInfoDefault => 'Info';

  @override
  String get nodedexHelpNote => 'Note';

  @override
  String get nodedexHelpPersonalityTrait => 'Personality Trait';

  @override
  String get nodedexHelpRecentEncounters => 'Recent Encounters';

  @override
  String get nodedexHelpRegionHistory => 'Region History';

  @override
  String get nodedexHelpSigil => 'Sigil';

  @override
  String get nodedexHelpSignalRecords => 'Signal Records';

  @override
  String nodedexImportButtonLabelPlural(int count) {
    return 'Import $count entries';
  }

  @override
  String nodedexImportButtonLabelSingular(int count) {
    return 'Import $count entry';
  }

  @override
  String nodedexImportClassificationConflictPlural(int count) {
    return '$count classification conflicts';
  }

  @override
  String nodedexImportClassificationConflictSingular(int count) {
    return '$count classification conflict';
  }

  @override
  String get nodedexImportConflictingDataMessage =>
      'Some entries have conflicting data';

  @override
  String get nodedexImportConflictingEntriesLabel => 'Conflicting Entries';

  @override
  String get nodedexImportConflictsFallback =>
      'Conflicts detected in user-owned fields.';

  @override
  String nodedexImportConflictsResolveBelow(String details) {
    return '$details. Choose how to resolve below.';
  }

  @override
  String nodedexImportEntriesInFile(int count) {
    return '$count entries in file';
  }

  @override
  String nodedexImportFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get nodedexImportFailedToReadFile => 'Failed to read file';

  @override
  String get nodedexImportFieldClassification => 'Classification';

  @override
  String get nodedexImportFieldNote => 'Note';

  @override
  String get nodedexImportHideDetails => 'Hide details';

  @override
  String get nodedexImportImportLabel => 'Import';

  @override
  String get nodedexImportImportingLabel => 'Importing...';

  @override
  String get nodedexImportLocalLabel => 'Local';

  @override
  String get nodedexImportMergeStrategyLabel => 'Merge Strategy';

  @override
  String get nodedexImportNoValidEntries =>
      'No valid NodeDex entries found in file';

  @override
  String get nodedexImportNoneValue => 'None';

  @override
  String nodedexImportNoteConflictPlural(int count) {
    return '$count note conflicts';
  }

  @override
  String nodedexImportNoteConflictSingular(int count) {
    return '$count note conflict';
  }

  @override
  String get nodedexImportNothingNewToImport => 'Nothing new to import';

  @override
  String get nodedexImportNothingToImportDescription =>
      'The file contains no valid NodeDex entries.';

  @override
  String get nodedexImportNothingToImportTitle => 'Nothing to import';

  @override
  String get nodedexImportPreviewSubtitle => 'Review before applying';

  @override
  String get nodedexImportPreviewTitle => 'Import Preview';

  @override
  String get nodedexImportShowDetails => 'Show details';

  @override
  String get nodedexImportStrategyKeepLocalDescription =>
      'Your classifications and notes stay unchanged';

  @override
  String get nodedexImportStrategyKeepLocalTitle => 'Keep Local';

  @override
  String get nodedexImportStrategyPreferImportDescription =>
      'Use imported classifications and notes where different';

  @override
  String get nodedexImportStrategyPreferImportTitle => 'Prefer Import';

  @override
  String get nodedexImportStrategyReviewEachDescription =>
      'Decide per conflict which value to keep';

  @override
  String get nodedexImportStrategyReviewEachTitle => 'Review Each';

  @override
  String nodedexImportSuccessPlural(int count) {
    return 'Imported $count entries';
  }

  @override
  String nodedexImportSuccessSingular(int count) {
    return 'Imported $count entry';
  }

  @override
  String get nodedexImportSummaryConflicts => 'Conflicts';

  @override
  String get nodedexImportSummaryMerge => 'Merge';

  @override
  String get nodedexImportSummaryNew => 'New';

  @override
  String nodedexImportUnresolvedConflictsPlural(int count) {
    return '$count conflicts unresolved — using \"Keep Local\" as default';
  }

  @override
  String nodedexImportUnresolvedConflictsSingular(int count) {
    return '$count conflict unresolved — using \"Keep Local\" as default';
  }

  @override
  String get nodedexKnownFor => 'Known For';

  @override
  String nodedexKnownForDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String nodedexKnownForHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get nodedexKnownForOneDayAgo => '1 day ago';

  @override
  String get nodedexLastLogged => 'Last Logged';

  @override
  String nodedexLastReadings(int count) {
    return 'Last $count readings';
  }

  @override
  String nodedexLastRelative(String relative) {
    return 'last $relative';
  }

  @override
  String get nodedexLastSeen => 'Last Seen';

  @override
  String get nodedexLastSeenStatLabel => 'Last Seen';

  @override
  String get nodedexLegendFair => 'Fair';

  @override
  String get nodedexLegendNoData => 'No data';

  @override
  String get nodedexLegendStrong => 'Strong';

  @override
  String get nodedexLegendWeak => 'Weak';

  @override
  String nodedexLinkCountPlural(int count) {
    return '$count links';
  }

  @override
  String nodedexLinkCountSingular(int count) {
    return '$count link';
  }

  @override
  String get nodedexLinkStrengthLabel => 'Link Strength';

  @override
  String nodedexLinkedForDuration(String duration) {
    return 'Linked for $duration';
  }

  @override
  String get nodedexMaxDistanceStatLabel => 'Max Distance';

  @override
  String nodedexMaxRange(String distance) {
    return 'Max range: $distance';
  }

  @override
  String get nodedexMaxRangeLabel => 'Max Range';

  @override
  String get nodedexMessageActivity => 'Message Activity';

  @override
  String nodedexMessagesExchangedCoPresent(int count) {
    return '$count messages exchanged while co-present';
  }

  @override
  String get nodedexMessagesLabel => 'Messages';

  @override
  String get nodedexMessagesStatLabel => 'Messages';

  @override
  String nodedexMilestoneEncounterN(int count) {
    return 'Encounter #$count';
  }

  @override
  String get nodedexMilestoneFirstDiscovered => 'First discovered';

  @override
  String get nodedexNicknameHint => 'Nickname';

  @override
  String get nodedexNoClassification =>
      'No classification assigned. Tap \"Classify\" to add one.';

  @override
  String get nodedexNoEncountersOnDate => 'No encounters on this date';

  @override
  String get nodedexNoEncountersRecorded => 'No encounters recorded';

  @override
  String get nodedexNoNoteYet => 'No note yet. Tap \"Add Note\" to write one.';

  @override
  String get nodedexNoRelationshipDataDescription =>
      'These nodes have not been observed together.';

  @override
  String get nodedexNoRelationshipDataTitle => 'No relationship data';

  @override
  String nodedexNodeCountPlural(int count) {
    return '$count nodes';
  }

  @override
  String nodedexNodeCountSingular(int count) {
    return '$count node';
  }

  @override
  String get nodedexNoteAdd => 'Add Note';

  @override
  String get nodedexNoteCancel => 'Cancel';

  @override
  String get nodedexNoteEdit => 'Edit';

  @override
  String get nodedexNoteHint => 'Write a note about this node...';

  @override
  String get nodedexNoteSave => 'Save';

  @override
  String get nodedexNoteTitle => 'Note';

  @override
  String get nodedexObservationTimelineTitle => 'Observation Timeline';

  @override
  String nodedexObservedDate(String date) {
    return 'Observed $date';
  }

  @override
  String get nodedexPaletteColorPrimary => 'Primary';

  @override
  String get nodedexPaletteColorSecondary => 'Secondary';

  @override
  String get nodedexPaletteColorTertiary => 'Tertiary';

  @override
  String get nodedexPatinaAxisEncounters => 'Encounters';

  @override
  String get nodedexPatinaAxisEncountersDescription =>
      'Number of distinct observations';

  @override
  String get nodedexPatinaAxisReach => 'Reach';

  @override
  String get nodedexPatinaAxisReachDescription =>
      'Geographic spread across regions';

  @override
  String get nodedexPatinaAxisRecency => 'Recency';

  @override
  String get nodedexPatinaAxisRecencyDescription =>
      'How recently this node was active';

  @override
  String get nodedexPatinaAxisSignalDepth => 'Signal Depth';

  @override
  String get nodedexPatinaAxisSignalDepthDescription =>
      'Quality of signal records collected';

  @override
  String get nodedexPatinaAxisSocial => 'Social';

  @override
  String get nodedexPatinaAxisSocialDescription =>
      'Co-seen relationships and messages';

  @override
  String get nodedexPatinaAxisTenure => 'Tenure';

  @override
  String get nodedexPatinaAxisTenureDescription =>
      'How long this node has been known';

  @override
  String get nodedexPatinaBreakdownSubtitle =>
      'Accumulated history across six dimensions';

  @override
  String get nodedexPatinaBreakdownTitle => 'Patina Breakdown';

  @override
  String get nodedexPatinaEncounters => 'Encounters';

  @override
  String get nodedexPatinaLabel => 'PATINA';

  @override
  String get nodedexPatinaReach => 'Reach';

  @override
  String get nodedexPatinaRecency => 'Recency';

  @override
  String get nodedexPatinaSignal => 'Signal';

  @override
  String get nodedexPatinaSocial => 'Social';

  @override
  String get nodedexPatinaStampArchival => 'Archival';

  @override
  String get nodedexPatinaStampCanonical => 'Canonical';

  @override
  String get nodedexPatinaStampEtched => 'Etched';

  @override
  String get nodedexPatinaStampFaint => 'Faint';

  @override
  String get nodedexPatinaStampInked => 'Inked';

  @override
  String get nodedexPatinaStampLogged => 'Logged';

  @override
  String get nodedexPatinaStampNoted => 'Noted';

  @override
  String get nodedexPatinaStampTrace => 'Trace';

  @override
  String get nodedexPatinaTenure => 'Tenure';

  @override
  String get nodedexPerDay => '/day';

  @override
  String get nodedexPositionsLabel => 'Positions';

  @override
  String get nodedexPresenceActive => 'Active';

  @override
  String get nodedexPresenceFading => 'Fading';

  @override
  String get nodedexPresenceStale => 'Stale';

  @override
  String get nodedexPresenceUnknown => 'Unknown';

  @override
  String get nodedexProfileButton => 'Profile';

  @override
  String nodedexRarityCardsPageTitle(String rarityLabel) {
    return '$rarityLabel Cards';
  }

  @override
  String get nodedexRecentLabel => 'RECENT';

  @override
  String nodedexRegionEncounterCount(int count) {
    return '$count encounters';
  }

  @override
  String get nodedexRegionsCompactLabel => 'Regions';

  @override
  String get nodedexRegionsLabel => 'Regions';

  @override
  String get nodedexRelationshipTimeline => 'Relationship Timeline';

  @override
  String nodedexRelativeDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String nodedexRelativeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get nodedexRelativeJustNow => 'just now';

  @override
  String nodedexRelativeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String nodedexRelativeMonthsAgo(int months) {
    return '${months}mo ago';
  }

  @override
  String nodedexRelativeTimeDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String nodedexRelativeTimeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String nodedexRelativeTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get nodedexRelativeTimeMomentsAgo => 'moments ago';

  @override
  String nodedexRelativeTimeMonthsAgo(int months) {
    return '$months months ago';
  }

  @override
  String get nodedexRelativeTimeOneMonthAgo => '1 month ago';

  @override
  String get nodedexRelativeTimeYesterday => 'yesterday';

  @override
  String get nodedexRemoveClassification => 'Remove Classification';

  @override
  String get nodedexResetViewTooltip => 'Reset view';

  @override
  String get nodedexSearchHint => 'Find a node';

  @override
  String get nodedexSectionDiscoveredNodes => 'Discovered Nodes';

  @override
  String get nodedexSectionYourDevice => 'Your Device';

  @override
  String nodedexSeenTogetherCount(int count) {
    return 'Seen together $count times';
  }

  @override
  String nodedexSelectedLinksCount(int count) {
    return '$count links';
  }

  @override
  String get nodedexSendFile => 'Send file';

  @override
  String get nodedexSetNickname => 'Set nickname';

  @override
  String get nodedexSettingsTooltip => 'Settings';

  @override
  String nodedexShareCardCheckOut(String name) {
    return 'Check out the Sigil Card for $name on Socialmesh!';
  }

  @override
  String get nodedexShareCardImageFailed => 'Failed to capture card image';

  @override
  String get nodedexShareCouldNotShare => 'Could not share card';

  @override
  String get nodedexShareGetSocialmesh => 'Get Socialmesh:';

  @override
  String get nodedexShareSigilCard => 'Share Sigil Card';

  @override
  String nodedexSightingsPlural(int count) {
    return '$count sightings';
  }

  @override
  String nodedexSightingsSingular(int count) {
    return '$count sighting';
  }

  @override
  String get nodedexSigilCardTitle => 'Sigil Card';

  @override
  String get nodedexSignalRecordsTitle => 'Signal Records';

  @override
  String get nodedexSnrTrend => 'SNR TREND';

  @override
  String get nodedexSocialTagContactDescription =>
      'A person you communicate with';

  @override
  String get nodedexSocialTagFrequentPeerDescription =>
      'Regularly seen on the mesh';

  @override
  String get nodedexSocialTagKnownRelayDescription =>
      'A node that forwards traffic reliably';

  @override
  String get nodedexSocialTagTrustedNodeDescription =>
      'Verified infrastructure you trust';

  @override
  String get nodedexSortDiscovered => 'Discovered';

  @override
  String get nodedexSortEncounters => 'Encounters';

  @override
  String get nodedexSortFirstDiscovered => 'First Discovered';

  @override
  String get nodedexSortLastSeen => 'Last Seen';

  @override
  String get nodedexSortLongestRange => 'Longest Range';

  @override
  String get nodedexSortMostEncounters => 'Most Encounters';

  @override
  String get nodedexSortName => 'Name';

  @override
  String get nodedexSortRange => 'Range';

  @override
  String get nodedexStatCoSeen => 'Co-seen';

  @override
  String get nodedexStatDuration => 'Duration';

  @override
  String get nodedexStatFirstLink => 'First Link';

  @override
  String get nodedexStatLastSeen => 'Last Seen';

  @override
  String get nodedexStatMessages => 'Messages';

  @override
  String get nodedexStatsDays => 'DAYS';

  @override
  String get nodedexStatsEncounters => 'ENCOUNTERS';

  @override
  String get nodedexStatsNodes => 'NODES';

  @override
  String get nodedexStatsRegions => 'REGIONS';

  @override
  String nodedexStreakDays(int count) {
    return '$count-day streak';
  }

  @override
  String get nodedexStrengthEmerging => 'Emerging';

  @override
  String get nodedexStrengthModerate => 'Moderate';

  @override
  String get nodedexStrengthNew => 'New';

  @override
  String get nodedexStrengthStrong => 'Strong';

  @override
  String get nodedexStrengthVeryStrong => 'Very Strong';

  @override
  String get nodedexSummaryCardTitle => 'Summary';

  @override
  String nodedexSummaryEncountersRecorded(int count) {
    return '$count encounters recorded';
  }

  @override
  String get nodedexSummaryKeepObserving => 'Keep observing to build a profile';

  @override
  String nodedexSummaryMostActiveIn(String bucket) {
    return 'Most active in the $bucket';
  }

  @override
  String nodedexSummarySeenDaysOf14(int activeDays) {
    return 'Seen $activeDays of the last 14 days';
  }

  @override
  String nodedexSummarySpottedDaysOf14(int activeDays) {
    return 'Spotted on $activeDays of the last 14 days';
  }

  @override
  String nodedexSummaryUsuallyOnDay(String day) {
    return 'Usually on ${day}s';
  }

  @override
  String get nodedexSwitchToAlbumView => 'Switch to album view';

  @override
  String get nodedexSwitchToListView => 'Switch to list view';

  @override
  String get nodedexTagContact => 'Contact';

  @override
  String get nodedexTagFrequentPeer => 'Frequent Peer';

  @override
  String get nodedexTagKnownRelay => 'Known Relay';

  @override
  String get nodedexTagTrustedNode => 'Trusted Node';

  @override
  String get nodedexTapCardToFlipSemanticLabel => 'Tap card to flip';

  @override
  String get nodedexTapToFlip => 'TAP TO FLIP';

  @override
  String get nodedexTimeBucketDawn => 'Dawn';

  @override
  String get nodedexTimeBucketDawnRange => '5 AM – 11 AM';

  @override
  String get nodedexTimeBucketEvening => 'Evening';

  @override
  String get nodedexTimeBucketEveningRange => '5 PM – 11 PM';

  @override
  String get nodedexTimeBucketMidday => 'Midday';

  @override
  String get nodedexTimeBucketMiddayRange => '11 AM – 5 PM';

  @override
  String get nodedexTimeBucketNight => 'Night';

  @override
  String get nodedexTimeBucketNightRange => '11 PM – 5 AM';

  @override
  String nodedexTimelineChannel(String channel) {
    return 'Channel $channel';
  }

  @override
  String get nodedexTimelineCouldNotLoad => 'Could not load timeline';

  @override
  String nodedexTimelineEncounterBestSnr(int snr) {
    return ', best SNR ${snr}dB';
  }

  @override
  String nodedexTimelineEncounterClosest(String distance) {
    return ', closest $distance';
  }

  @override
  String nodedexTimelineEncounterSession(
    int count,
    String duration,
    String detail,
  ) {
    return '$count encounters over $duration$detail';
  }

  @override
  String get nodedexTimelineEncountered => 'Encountered';

  @override
  String nodedexTimelineEncounteredAtDistance(String distance) {
    return 'Encountered at $distance';
  }

  @override
  String nodedexTimelineEncounteredSnr(int snr) {
    return 'Encountered (SNR ${snr}dB)';
  }

  @override
  String get nodedexTimelineEventsAppearHere =>
      'Events will appear here as you interact with this node.';

  @override
  String get nodedexTimelineFirst => 'First';

  @override
  String nodedexTimelineHoursUnit(String hours) {
    return '$hours hr';
  }

  @override
  String get nodedexTimelineJustNow => 'Just now';

  @override
  String get nodedexTimelineLatest => 'Latest';

  @override
  String get nodedexTimelineLessThanOneMin => '<1 min';

  @override
  String nodedexTimelineMinutesUnit(int minutes) {
    return '$minutes min';
  }

  @override
  String get nodedexTimelineNoActivityYet => 'No activity yet';

  @override
  String nodedexTimelineReceived(String text) {
    return 'Received: $text';
  }

  @override
  String nodedexTimelineSent(String text) {
    return 'Sent: $text';
  }

  @override
  String nodedexTimelineSignal(String content) {
    return 'Signal: $content';
  }

  @override
  String get nodedexTitle => 'NodeDex';

  @override
  String nodedexTotalCount(int count) {
    return '$count total';
  }

  @override
  String get nodedexTraitAnchor => 'Anchor';

  @override
  String get nodedexTraitAnchorDescription =>
      'Persistent hub with many connections';

  @override
  String get nodedexTraitBeacon => 'Beacon';

  @override
  String get nodedexTraitBeaconDescription =>
      'Always active, high availability';

  @override
  String get nodedexTraitCollectionLabel => 'TRAIT COLLECTION';

  @override
  String get nodedexTraitCourier => 'Courier';

  @override
  String get nodedexTraitCourierDescription =>
      'Carries messages across the mesh';

  @override
  String get nodedexTraitDrifter => 'Drifter';

  @override
  String get nodedexTraitDrifterDescription =>
      'Irregular timing, fades in and out';

  @override
  String get nodedexTraitEvidenceNotFound => 'Node not found in NodeDex';

  @override
  String get nodedexTraitGhost => 'Ghost';

  @override
  String get nodedexTraitGhostDescription => 'Rarely seen, elusive presence';

  @override
  String nodedexTraitNodesPageTitle(String traitLabel) {
    return '$traitLabel Nodes';
  }

  @override
  String get nodedexTraitRelay => 'Relay';

  @override
  String get nodedexTraitRelayDescription =>
      'High throughput, forwards traffic';

  @override
  String get nodedexTraitSentinel => 'Sentinel';

  @override
  String get nodedexTraitSentinelDescription =>
      'Fixed position, long-lived guardian';

  @override
  String get nodedexTraitUnknown => 'Newcomer';

  @override
  String get nodedexTraitUnknownDescription => 'Recently discovered';

  @override
  String get nodedexTraitWanderer => 'Wanderer';

  @override
  String get nodedexTraitWandererDescription =>
      'Seen across multiple locations';

  @override
  String get nodedexTrustDescriptionEstablished =>
      'Deep history across all dimensions';

  @override
  String get nodedexTrustDescriptionFamiliar =>
      'Regular presence with some history';

  @override
  String get nodedexTrustDescriptionObserved => 'Seen a few times on the mesh';

  @override
  String get nodedexTrustDescriptionTrusted =>
      'Frequent, long-lived, communicative';

  @override
  String get nodedexTrustDescriptionUnknown => 'Not enough data to assess';

  @override
  String get nodedexTrustLevelEstablished => 'Established';

  @override
  String get nodedexTrustLevelFamiliar => 'Familiar';

  @override
  String get nodedexTrustLevelObserved => 'Observed';

  @override
  String get nodedexTrustLevelTrusted => 'Trusted';

  @override
  String get nodedexTrustLevelUnknown => 'Unknown';

  @override
  String get nodedexUnknownRegion => 'Unknown Region';

  @override
  String get nodedexUptimeLabel => 'Uptime';

  @override
  String get nodedexViewProfile => 'View profile';

  @override
  String get nodedexWalletCouldNotAdd => 'Could not add to Apple Wallet';

  @override
  String get nodedexWalletCouldNotOpen => 'Could not open Apple Wallet';

  @override
  String get nodedexWalletCouldNotPublish => 'Could not publish sigil card';

  @override
  String get nodesScreenConnectedDevice => 'Connected Device';

  @override
  String get nodesScreenDisconnect => 'Disconnect';

  @override
  String nodesScreenDistanceKilometers(String km) {
    return '$km km away';
  }

  @override
  String nodesScreenDistanceMeters(String meters) {
    return '$meters m away';
  }

  @override
  String get nodesScreenEmptyAll => 'No nodes discovered yet';

  @override
  String get nodesScreenEmptyFiltered => 'No nodes match this filter';

  @override
  String get nodesScreenFilterActive => 'Active';

  @override
  String get nodesScreenFilterAll => 'All';

  @override
  String get nodesScreenFilterFavorites => 'Favorites';

  @override
  String get nodesScreenFilterInactive => 'Inactive';

  @override
  String get nodesScreenFilterMqtt => 'MQTT';

  @override
  String get nodesScreenFilterNew => 'New';

  @override
  String get nodesScreenFilterRf => 'RF';

  @override
  String get nodesScreenFilterWithPosition => 'With Position';

  @override
  String get nodesScreenGps => 'GPS';

  @override
  String get nodesScreenHelpMenu => 'Help';

  @override
  String nodesScreenHopCount(int count) {
    return '$count hops';
  }

  @override
  String get nodesScreenHopDirect => 'Direct';

  @override
  String get nodesScreenLogsLabel => 'Logs:';

  @override
  String get nodesScreenNoGps => 'No GPS';

  @override
  String get nodesScreenScanQrCodeTooltip => 'Scan QR Code';

  @override
  String get nodesScreenSearchHint => 'Find a node';

  @override
  String get nodesScreenSectionActive => 'Active';

  @override
  String get nodesScreenSectionAetherFlights => 'Aether Flights Nearby';

  @override
  String get nodesScreenSectionBatteryCritical => 'Critical (<20%)';

  @override
  String get nodesScreenSectionBatteryFull => 'Full (80-100%)';

  @override
  String get nodesScreenSectionBatteryGood => 'Good (50-80%)';

  @override
  String get nodesScreenSectionBatteryLow => 'Low (20-50%)';

  @override
  String get nodesScreenSectionCharging => 'Charging';

  @override
  String get nodesScreenSectionDiscovering => 'Discovering';

  @override
  String get nodesScreenSectionFavorites => 'Favorites';

  @override
  String get nodesScreenSectionInactive => 'Inactive';

  @override
  String get nodesScreenSectionSeenRecently => 'Seen Recently';

  @override
  String get nodesScreenSectionSignalMedium => 'Medium (-10 to 0 dB)';

  @override
  String get nodesScreenSectionSignalStrong => 'Strong (>0 dB)';

  @override
  String get nodesScreenSectionSignalWeak => 'Weak (<-10 dB)';

  @override
  String get nodesScreenSectionUnknown => 'Unknown';

  @override
  String get nodesScreenSectionYourDevice => 'Your Device';

  @override
  String get nodesScreenSettingsMenu => 'Settings';

  @override
  String get nodesScreenShowAllButton => 'Show all nodes';

  @override
  String get nodesScreenSortBattery => 'Battery';

  @override
  String get nodesScreenSortMenuBatteryLevel => 'Battery Level';

  @override
  String get nodesScreenSortMenuMostRecent => 'Most Recent';

  @override
  String get nodesScreenSortMenuNameAZ => 'Name (A-Z)';

  @override
  String get nodesScreenSortMenuSignalStrength => 'Signal Strength';

  @override
  String get nodesScreenSortName => 'Name';

  @override
  String get nodesScreenSortRecent => 'Recent';

  @override
  String get nodesScreenSortSignal => 'Signal';

  @override
  String get nodesScreenThisDevice => 'This Device';

  @override
  String nodesScreenTitle(int count) {
    return 'Nodes ($count)';
  }

  @override
  String get nodesScreenTransportMqtt => 'MQTT';

  @override
  String get nodesScreenTransportRf => 'RF';

  @override
  String get nodesScreenYouBadge => 'YOU';

  @override
  String get paxCounterAboutSubtitle =>
      'PAX Counter passively listens for WiFi and Bluetooth probe requests from nearby devices. It does not store MAC addresses or any personal data.';

  @override
  String get paxCounterAboutTitle => 'About PAX Counter';

  @override
  String get paxCounterCardSubtitle =>
      'Counts nearby WiFi and Bluetooth devices';

  @override
  String get paxCounterCardTitle => 'PAX Counter';

  @override
  String get paxCounterEnable => 'Enable PAX Counter';

  @override
  String get paxCounterEnableSubtitle =>
      'Count nearby devices and report to mesh';

  @override
  String paxCounterIntervalMinutes(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get paxCounterMaxLabel => '60 min';

  @override
  String get paxCounterMinLabel => '1 min';

  @override
  String get paxCounterSave => 'Save';

  @override
  String paxCounterSaveError(String error) {
    return 'Failed to save: $error';
  }

  @override
  String get paxCounterSaved => 'PAX counter config saved';

  @override
  String get paxCounterTitle => 'PAX Counter';

  @override
  String get paxCounterUpdateInterval => 'Update Interval';

  @override
  String get presenceAllNodes => 'All Nodes';

  @override
  String get presenceBackNearby => 'Back nearby';

  @override
  String get presenceBroadcastInfo =>
      'Your intent and status are broadcast with your signals.';

  @override
  String get presenceClear => 'Clear';

  @override
  String get presenceEmptyTagline1 =>
      'No nodes discovered yet.\nConnect to a mesh device to see nearby presence.';

  @override
  String get presenceEmptyTagline2 =>
      'Presence shows who is active on your mesh.\nNodes appear as they broadcast.';

  @override
  String get presenceEmptyTagline3 =>
      'Watch nodes come and go in real time.\nActive, fading, and offline states.';

  @override
  String get presenceEmptyTagline4 =>
      'Familiar faces are highlighted.\nBuild your mesh community over time.';

  @override
  String get presenceEmptyTitleKeyword => 'presence';

  @override
  String get presenceEmptyTitlePrefix => 'No ';

  @override
  String get presenceEmptyTitleSuffix => ' detected';

  @override
  String get presenceFamiliarBadge => 'Familiar';

  @override
  String get presenceFilterActive => 'Active';

  @override
  String get presenceFilterAll => 'All';

  @override
  String get presenceFilterFading => 'Seen recently';

  @override
  String get presenceFilterFamiliar => 'Familiar';

  @override
  String get presenceFilterInactive => 'Inactive';

  @override
  String get presenceFilterUnknown => 'Unknown';

  @override
  String get presenceIntentLabel => 'Intent';

  @override
  String get presenceIntentUpdated => 'Presence intent updated';

  @override
  String get presenceLegendMedium => '2-10 min';

  @override
  String get presenceLegendShort => '< 2 min';

  @override
  String get presenceMyPresence => 'My Presence';

  @override
  String get presenceNoMatchFilter => 'No nodes match this filter';

  @override
  String get presenceNoMatchSearch => 'No nodes match your search';

  @override
  String presenceNodeCount(int count, String noun) {
    return '$count $noun';
  }

  @override
  String get presenceNodePlural => 'nodes';

  @override
  String get presenceNodeSingular => 'node';

  @override
  String get presenceQuietMesh =>
      'Mesh is quiet right now — nodes appear as they come online.';

  @override
  String get presenceRecentActivity => 'Recent Activity';

  @override
  String get presenceSave => 'Save';

  @override
  String get presenceSearchHint => 'Search nodes';

  @override
  String get presenceSectionActive => 'Active';

  @override
  String get presenceSectionInactive => 'Inactive';

  @override
  String get presenceSectionSeenRecently => 'Seen Recently';

  @override
  String get presenceSectionUnknown => 'Unknown';

  @override
  String get presenceSelectIntent => 'Select Intent';

  @override
  String get presenceSetStatus => 'Set Status';

  @override
  String get presenceShowAll => 'Show all nodes';

  @override
  String get presenceStatusHint => 'What are you up to?';

  @override
  String get presenceStatusLabel => 'Status';

  @override
  String get presenceStatusNotSet => 'Not set';

  @override
  String get presenceStatusUpdated => 'Status updated';

  @override
  String get presenceTitle => 'Presence';

  @override
  String get presenceTryDifferent => 'Try a different search or filter';

  @override
  String get presenceWillAppear =>
      'Nodes will appear here as they are discovered';

  @override
  String get productDetailAnonymous => 'Anonymous';

  @override
  String get productDetailBattery => 'Battery';

  @override
  String get productDetailBeFirstReviewer =>
      'Be the first to review this product!';

  @override
  String get productDetailBluetooth => 'Bluetooth';

  @override
  String get productDetailBuyNow => 'Buy Now';

  @override
  String productDetailBySeller(String seller) {
    return 'by $seller';
  }

  @override
  String get productDetailCancel => 'Cancel';

  @override
  String get productDetailChipset => 'Chipset';

  @override
  String get productDetailContactSeller => 'Contact Seller';

  @override
  String get productDetailContactToPurchase =>
      'Contact the seller to purchase this product.';

  @override
  String productDetailDaysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get productDetailDescription => 'Description';

  @override
  String get productDetailDimensions => 'Dimensions';

  @override
  String productDetailDiscountBadge(int percent) {
    return '-$percent% OFF';
  }

  @override
  String get productDetailDisplay => 'Display';

  @override
  String get productDetailEdit => 'Edit';

  @override
  String get productDetailErrorLoading => 'Error loading product';

  @override
  String productDetailEstimatedDelivery(int days) {
    return 'Estimated $days days';
  }

  @override
  String get productDetailFeatures => 'Features';

  @override
  String get productDetailFirmware => 'Firmware';

  @override
  String get productDetailFreeShipping => 'Free Shipping';

  @override
  String get productDetailFrequencyBands => 'Frequency Bands';

  @override
  String get productDetailGoBack => 'Go Back';

  @override
  String get productDetailGps => 'GPS';

  @override
  String get productDetailHardwareVersion => 'Hardware Version';

  @override
  String productDetailImageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String productDetailInStockCount(int quantity) {
    return 'In Stock ($quantity available)';
  }

  @override
  String get productDetailIncludedAccessories => 'Included Accessories';

  @override
  String get productDetailLoraChip => 'LoRa Chip';

  @override
  String get productDetailMeshtasticCompatible => 'Meshtastic Compatible';

  @override
  String productDetailMonthsAgo(int count) {
    return '$count months ago';
  }

  @override
  String get productDetailNoReviews => 'No reviews yet';

  @override
  String get productDetailNotFound => 'Product not found';

  @override
  String get productDetailOutOfStock => 'Out of Stock';

  @override
  String get productDetailOutOfStockButton => 'Out of Stock';

  @override
  String get productDetailPurchaseDisclaimer =>
      'Purchases completed on seller\'s official store';

  @override
  String get productDetailPurchaseTitle => 'Purchase';

  @override
  String get productDetailReadMore => 'Read More';

  @override
  String get productDetailRetry => 'Retry';

  @override
  String productDetailReviewCount(int count) {
    return '($count reviews)';
  }

  @override
  String get productDetailReviewHint =>
      'Share your experience with this product...';

  @override
  String productDetailReviewPrivacyNotice(String userName) {
    return 'Your review will be public and posted as \"$userName\". Reviews are moderated before appearing on the product page.';
  }

  @override
  String get productDetailReviewSubmitted =>
      'Review submitted for moderation. Thank you!';

  @override
  String get productDetailReviewTitleLabel => 'Title (optional)';

  @override
  String get productDetailReviewValidation =>
      'Please write a review description';

  @override
  String get productDetailReviewVerified => 'Verified';

  @override
  String get productDetailReviews => 'Reviews';

  @override
  String productDetailSelectedPrice(String price) {
    return 'Selected: \$$price';
  }

  @override
  String get productDetailSellerResponse => 'Seller Response';

  @override
  String get productDetailShipping => 'Shipping';

  @override
  String productDetailShippingCost(String cost) {
    return 'Shipping: \$$cost';
  }

  @override
  String productDetailShipsTo(String countries) {
    return 'Ships to: $countries';
  }

  @override
  String get productDetailShowLess => 'Show Less';

  @override
  String get productDetailSignInFavorites => 'Sign in to save favorites';

  @override
  String productDetailSoldCount(int count) {
    return '$count sold';
  }

  @override
  String get productDetailSubmitReview => 'Submit Review';

  @override
  String get productDetailTechSpecs => 'Technical Specifications';

  @override
  String get productDetailTitle => 'Product';

  @override
  String get productDetailToday => 'Today';

  @override
  String get productDetailTotal => 'Total';

  @override
  String get productDetailUnableToLoadPage => 'Unable to load page';

  @override
  String get productDetailUnableToLoadReviews => 'Unable to load reviews';

  @override
  String get productDetailVendorVerified => 'Vendor Verified';

  @override
  String productDetailVerifiedOn(String date) {
    return 'Verified on $date';
  }

  @override
  String get productDetailWebviewOffline =>
      'This content requires an internet connection. Please check your connection and try again.';

  @override
  String productDetailWeeksAgo(int count) {
    return '$count weeks ago';
  }

  @override
  String get productDetailWeight => 'Weight';

  @override
  String get productDetailWifi => 'WiFi';

  @override
  String get productDetailWriteReview => 'Write Review';

  @override
  String get productDetailWriteReviewTitle => 'Write a Review';

  @override
  String productDetailYearsAgo(int count) {
    return '$count years ago';
  }

  @override
  String get productDetailYesterday => 'Yesterday';

  @override
  String get productDetailYourRating => 'Your Rating';

  @override
  String get productDetailYourReview => 'Your Review *';

  @override
  String profileAvatarRemoveFailed(String error) {
    return 'Failed to remove avatar: $error';
  }

  @override
  String get profileAvatarRemoved => 'Avatar removed';

  @override
  String get profileAvatarRequiresInternet =>
      'Uploading avatars requires an internet connection.';

  @override
  String get profileAvatarUpdated => 'Avatar updated';

  @override
  String profileAvatarUploadFailed(String error) {
    return 'Failed to upload avatar: $error';
  }

  @override
  String profileBannerRemoveFailed(String error) {
    return 'Failed to remove banner: $error';
  }

  @override
  String get profileBannerRemoved => 'Banner removed';

  @override
  String get profileBannerRequiresInternet =>
      'Uploading banners requires an internet connection.';

  @override
  String get profileBannerUpdated => 'Banner updated';

  @override
  String profileBannerUploadFailed(String error) {
    return 'Failed to upload banner: $error';
  }

  @override
  String get profileBasicInfo => 'Basic Info';

  @override
  String get profileBioHint => 'Tell us about yourself';

  @override
  String get profileBioLabel => 'Bio';

  @override
  String get profileCallsignHint => 'Amateur radio callsign or identifier';

  @override
  String get profileCallsignInappropriate =>
      'Callsign cannot contain inappropriate content';

  @override
  String get profileCallsignLabel => 'Callsign';

  @override
  String get profileCallsignMax => 'Max 10 characters';

  @override
  String get profileCloudBackup => 'Cloud Backup';

  @override
  String get profileCloudStartingUp =>
      'Cloud services starting up — try again shortly';

  @override
  String get profileContinueApple => 'Continue with Apple';

  @override
  String get profileContinueGitHub => 'Continue with GitHub';

  @override
  String get profileContinueGoogle => 'Continue with Google';

  @override
  String profileCopiedToClipboard(String label) {
    return '$label copied to clipboard';
  }

  @override
  String get profileCreate => 'Create Profile';

  @override
  String get profileDeleteAccount => 'Delete Account';

  @override
  String get profileDeleteConfirmMsg =>
      'This will permanently delete your account and all associated data. This action cannot be undone.';

  @override
  String get profileDeleteRequiresInternet =>
      'Deleting your account requires an internet connection.';

  @override
  String get profileDeletingAccount => 'Deleting account...';

  @override
  String get profileDeletionFailed =>
      'Deletion failed. Please try again or contact support.';

  @override
  String get profileDetailsSection => 'Details';

  @override
  String get profileDiscordHint => 'username#0000';

  @override
  String get profileDiscordLabel => 'Discord';

  @override
  String get profileDisplayNameHint => 'How you want to be known';

  @override
  String get profileDisplayNameLabel => 'Display Name';

  @override
  String get profileDisplayNameTaken =>
      'This display name is already taken. Please choose a different one.';

  @override
  String get profileEditButton => 'Edit Profile';

  @override
  String get profileEditSheetTitle => 'Edit Profile';

  @override
  String get profileEditTooltip => 'Edit Profile';

  @override
  String get profileEmailLabel => 'Email';

  @override
  String get profileGitHubHint => 'username';

  @override
  String get profileGitHubLabel => 'GitHub';

  @override
  String get profileGitHubLinked => 'GitHub account linked successfully!';

  @override
  String get profileHelpTooltip => 'Help';

  @override
  String get profileImageAccessError =>
      'Could not access the selected image. Try saving it to your device first.';

  @override
  String get profileImageLoadError =>
      'Could not load the selected image. Make sure the file is downloaded locally and try again.';

  @override
  String get profileLinkFailed => 'Failed to link accounts';

  @override
  String get profileLinkGitHub => 'Link GitHub Account';

  @override
  String profileLinkGitHubMsg(String email, String provider) {
    return 'An account with $email already exists using $provider.\n\nSign in with $provider to link your GitHub account?';
  }

  @override
  String get profileLinkedAccounts => 'Linked accounts';

  @override
  String get profileLinksSection => 'Links';

  @override
  String get profileMastodonHint => '@user@instance.social';

  @override
  String get profileMastodonLabel => 'Mastodon';

  @override
  String get profileMemberSince => 'Member since';

  @override
  String get profileNoInternet => 'No internet connection';

  @override
  String get profileNotBackedUp => 'Not backed up';

  @override
  String get profileRemoveAvatar => 'Remove Avatar';

  @override
  String get profileRemoveAvatarRequiresInternet =>
      'Removing avatars requires an internet connection.';

  @override
  String get profileRemoveBanner => 'Remove Banner';

  @override
  String get profileRemoveBannerRequiresInternet =>
      'Removing banners requires an internet connection.';

  @override
  String get profileSave => 'Save';

  @override
  String profileSaveFailed(String error) {
    return 'Failed to save profile: $error';
  }

  @override
  String get profileSaveRequiresInternet =>
      'Saving your profile requires an internet connection.';

  @override
  String get profileSetup => 'Set up your profile';

  @override
  String get profileSetupDesc =>
      'Add your name, photo, and bio to personalize your mesh presence.';

  @override
  String get profileSignInDesc =>
      'Sign in to backup your profile to the cloud and sync across devices.';

  @override
  String get profileSignInFailed => 'Sign in failed';

  @override
  String get profileSignInRequiresInternet =>
      'Sign-in requires an internet connection.';

  @override
  String get profileSignInServicesUnavailable =>
      'Unable to connect to sign-in services. Check your internet connection and try again.';

  @override
  String profileSignInWithProvider(String provider) {
    return 'Sign in with $provider';
  }

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get profileSignOutConfirm => 'Are you sure you want to sign out?';

  @override
  String get profileSignOutRequiresInternet =>
      'Signing out requires an internet connection.';

  @override
  String get profileSignedInApple => 'Signed in with Apple';

  @override
  String get profileSignedInGitHub => 'Signed in with GitHub';

  @override
  String get profileSignedInGoogle => 'Signed in with Google';

  @override
  String get profileSigningIn => 'Signing in...';

  @override
  String get profileSocialSection => 'Social';

  @override
  String get profileSyncError => 'Sync error • Tap to retry';

  @override
  String get profileSyncFailed => 'Sync failed';

  @override
  String get profileSyncPermissionDenied => 'Sync permission denied';

  @override
  String get profileSyncRequiresInternet =>
      'Syncing requires an internet connection.';

  @override
  String get profileSyncTempUnavailable => 'Sync temporarily unavailable';

  @override
  String get profileSyncTempUnavailable2 =>
      'Cloud sync temporarily unavailable';

  @override
  String get profileSyncTimedOut => 'Sync timed out — try again';

  @override
  String profileSynced(String email) {
    return 'Synced • $email';
  }

  @override
  String get profileSynced2 => 'Profile synced!';

  @override
  String get profileSyncing => 'Syncing...';

  @override
  String get profileTelegramHint => 'username';

  @override
  String get profileTelegramLabel => 'Telegram';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileTwitterHint => 'username';

  @override
  String get profileTwitterLabel => 'Twitter';

  @override
  String get profileUidLabel => 'UID';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get profileUrlInvalid => 'Please enter a valid URL';

  @override
  String get profileUrlMustStartHttp =>
      'URL must start with http:// or https://';

  @override
  String get profileWebsiteHint => 'https://example.com';

  @override
  String get profileWebsiteLabel => 'Website';

  @override
  String get reachabilityAboutTitle => 'About Reachability';

  @override
  String get reachabilityAboutTooltip => 'About Reachability';

  @override
  String get reachabilityBetaBadge => 'BETA';

  @override
  String get reachabilityDisclaimerBanner =>
      'Likelihood estimates only. Delivery is never guaranteed in a mesh network.';

  @override
  String get reachabilityEmptyDescription =>
      'Nodes will appear as they\'re observed\non the mesh network.';

  @override
  String get reachabilityEmptyTitle => 'No nodes discovered yet';

  @override
  String get reachabilityGotIt => 'Got it';

  @override
  String get reachabilityHowCalculatedContent =>
      'The likelihood score combines several factors:\n• Freshness: How recently we heard from the node\n• Path Depth: Number of hops observed\n• Signal Quality: RSSI and SNR when available\n• Observation Pattern: Direct vs relayed packets\n• ACK History: DM acknowledgement success rate';

  @override
  String get reachabilityHowCalculatedTitle => 'How is it calculated?';

  @override
  String get reachabilityLevelHigh => 'High';

  @override
  String get reachabilityLevelLow => 'Low';

  @override
  String get reachabilityLevelMedium => 'Medium';

  @override
  String get reachabilityLevelsMeanContent =>
      '• High: Strong recent indicators, but not guaranteed\n• Medium: Moderate confidence based on available data\n• Low: Weak or stale indicators, delivery unlikely';

  @override
  String get reachabilityLevelsMeanTitle => 'What the levels mean';

  @override
  String get reachabilityLimitationsContent =>
      '• Meshtastic has no true routing tables\n• No end-to-end acknowledgements exist\n• Forwarding is opportunistic\n• Mesh topology changes constantly\n• All estimates based on passive observation only';

  @override
  String get reachabilityLimitationsTitle => 'Important limitations';

  @override
  String reachabilityScorePercent(String percentage) {
    return '$percentage%';
  }

  @override
  String get reachabilityScoringModelContent =>
      'Opportunistic Mesh Reach Likelihood Model (v1) — BETA\n\nA heuristic scoring model that estimates likelihood of reaching a node based on observed RF metrics and packet history. This score represents likelihood, not reachability. Meshtastic forwards packets opportunistically without routing. A high score does not guarantee delivery.';

  @override
  String get reachabilityScoringModelTitle => 'Scoring Model';

  @override
  String get reachabilityScreenTitle => 'Reachability';

  @override
  String get reachabilitySearchHint => 'Search nodes';

  @override
  String get reachabilityWhatIsThisContent =>
      'This screen shows a probabilistic estimate of how likely your messages will reach each node. It is NOT a guarantee of delivery.';

  @override
  String get reachabilityWhatIsThisTitle => 'What is this?';

  @override
  String get regionSelectionApplyDialogConfirm => 'Continue';

  @override
  String get regionSelectionApplyDialogMessageChange =>
      'Changing the region will cause your device to reboot. This may take up to 30 seconds.\n\nYou will be briefly disconnected while the device restarts.';

  @override
  String get regionSelectionApplyDialogMessageInitial =>
      'Your device will reboot to apply the region settings. This may take up to 30 seconds.\n\nThe app will automatically reconnect when ready.';

  @override
  String get regionSelectionApplyDialogTitle => 'Apply Region';

  @override
  String get regionSelectionApplying => 'Applying...';

  @override
  String get regionSelectionBannerSubtitle =>
      'Choose the correct frequency for your location to comply with local regulations.';

  @override
  String get regionSelectionBannerTitle => 'Important: Select Your Region';

  @override
  String get regionSelectionBluetoothSettings => 'Bluetooth Settings';

  @override
  String get regionSelectionContinue => 'Continue';

  @override
  String get regionSelectionCurrentBadge => 'CURRENT';

  @override
  String get regionSelectionDeviceDisconnected =>
      'Device disconnected. Please reconnect and try again.';

  @override
  String get regionSelectionOpenBluetoothSettingsError =>
      'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.';

  @override
  String get regionSelectionPairingHintMessage =>
      'Bluetooth pairing was removed. Forget \"Meshtastic_XXXX\" in Settings > Bluetooth and reconnect to continue.';

  @override
  String get regionSelectionPairingInvalidation =>
      'Your phone removed the stored pairing info for this device.\nGo to Settings > Bluetooth, forget the Meshtastic device, and try again.';

  @override
  String get regionSelectionReconnectTimeout =>
      'Reconnect timed out. Please try again.';

  @override
  String get regionSelectionRegionAnz => 'Australia/NZ';

  @override
  String get regionSelectionRegionAnzDesc => 'Australia and New Zealand';

  @override
  String get regionSelectionRegionAnzFreq => '915 MHz';

  @override
  String get regionSelectionRegionCn => 'China';

  @override
  String get regionSelectionRegionCnDesc => 'China';

  @override
  String get regionSelectionRegionCnFreq => '470 MHz';

  @override
  String get regionSelectionRegionEu433 => 'Europe 433';

  @override
  String get regionSelectionRegionEu433Desc => 'EU alternate frequency';

  @override
  String get regionSelectionRegionEu433Freq => '433 MHz';

  @override
  String get regionSelectionRegionEu868 => 'Europe 868';

  @override
  String get regionSelectionRegionEu868Desc => 'EU, UK, and most of Europe';

  @override
  String get regionSelectionRegionEu868Freq => '868 MHz';

  @override
  String get regionSelectionRegionIn => 'India';

  @override
  String get regionSelectionRegionInDesc => 'India';

  @override
  String get regionSelectionRegionInFreq => '865 MHz';

  @override
  String get regionSelectionRegionJp => 'Japan';

  @override
  String get regionSelectionRegionJpDesc => 'Japan';

  @override
  String get regionSelectionRegionJpFreq => '920 MHz';

  @override
  String get regionSelectionRegionKr => 'Korea';

  @override
  String get regionSelectionRegionKrDesc => 'South Korea';

  @override
  String get regionSelectionRegionKrFreq => '920 MHz';

  @override
  String get regionSelectionRegionLora24 => '2.4 GHz';

  @override
  String get regionSelectionRegionLora24Desc => 'Worldwide 2.4GHz band';

  @override
  String get regionSelectionRegionLora24Freq => '2.4 GHz';

  @override
  String get regionSelectionRegionMy433 => 'Malaysia 433';

  @override
  String get regionSelectionRegionMy433Desc => 'Malaysia';

  @override
  String get regionSelectionRegionMy433Freq => '433 MHz';

  @override
  String get regionSelectionRegionMy919 => 'Malaysia 919';

  @override
  String get regionSelectionRegionMy919Desc => 'Malaysia';

  @override
  String get regionSelectionRegionMy919Freq => '919 MHz';

  @override
  String get regionSelectionRegionNz865 => 'New Zealand 865';

  @override
  String get regionSelectionRegionNz865Desc => 'New Zealand alternate';

  @override
  String get regionSelectionRegionNz865Freq => '865 MHz';

  @override
  String get regionSelectionRegionRu => 'Russia';

  @override
  String get regionSelectionRegionRuDesc => 'Russia';

  @override
  String get regionSelectionRegionRuFreq => '868 MHz';

  @override
  String get regionSelectionRegionSg923 => 'Singapore';

  @override
  String get regionSelectionRegionSg923Desc => 'Singapore';

  @override
  String get regionSelectionRegionSg923Freq => '923 MHz';

  @override
  String get regionSelectionRegionTh => 'Thailand';

  @override
  String get regionSelectionRegionThDesc => 'Thailand';

  @override
  String get regionSelectionRegionThFreq => '920 MHz';

  @override
  String get regionSelectionRegionTw => 'Taiwan';

  @override
  String get regionSelectionRegionTwDesc => 'Taiwan';

  @override
  String get regionSelectionRegionTwFreq => '923 MHz';

  @override
  String get regionSelectionRegionUa433 => 'Ukraine 433';

  @override
  String get regionSelectionRegionUa433Desc => 'Ukraine';

  @override
  String get regionSelectionRegionUa433Freq => '433 MHz';

  @override
  String get regionSelectionRegionUa868 => 'Ukraine 868';

  @override
  String get regionSelectionRegionUa868Desc => 'Ukraine';

  @override
  String get regionSelectionRegionUa868Freq => '868 MHz';

  @override
  String get regionSelectionRegionUs => 'United States';

  @override
  String get regionSelectionRegionUsDesc => 'US, Canada, Mexico';

  @override
  String get regionSelectionRegionUsFreq => '915 MHz';

  @override
  String get regionSelectionSave => 'Save';

  @override
  String get regionSelectionSearchHint => 'Search regions...';

  @override
  String regionSelectionSetRegionError(String error) {
    return 'Failed to set region: $error';
  }

  @override
  String get regionSelectionTitleChange => 'Change Region';

  @override
  String get regionSelectionTitleInitial => 'Select Your Region';

  @override
  String get regionSelectionViewScanner => 'View Scanner';

  @override
  String get reviewModerationAllCaughtUp => 'All caught up!';

  @override
  String get reviewModerationAllReviews => 'All Reviews';

  @override
  String get reviewModerationAnonymous => 'Anonymous';

  @override
  String get reviewModerationApprove => 'Approve';

  @override
  String get reviewModerationApproved => 'Review approved';

  @override
  String get reviewModerationCancel => 'Cancel';

  @override
  String get reviewModerationDelete => 'Delete';

  @override
  String get reviewModerationDeleteMessage =>
      'Are you sure you want to permanently delete this review?';

  @override
  String get reviewModerationDeleteTitle => 'Delete Review';

  @override
  String get reviewModerationDeleted => 'Review deleted';

  @override
  String get reviewModerationErrorLoading => 'Error loading reviews';

  @override
  String get reviewModerationLegacy => 'Legacy (no status)';

  @override
  String get reviewModerationNoDatabase => 'No reviews in database';

  @override
  String get reviewModerationNoPending => 'No pending reviews to moderate';

  @override
  String get reviewModerationNoReviews => 'No reviews yet';

  @override
  String get reviewModerationPending => 'Pending';

  @override
  String get reviewModerationReject => 'Reject';

  @override
  String get reviewModerationRejectReasonHint =>
      'e.g., Inappropriate content, spam, etc.';

  @override
  String get reviewModerationRejectReasonLabel => 'Reason for rejection';

  @override
  String get reviewModerationRejectTitle => 'Reject Review';

  @override
  String get reviewModerationRejected => 'Review rejected';

  @override
  String get reviewModerationTitle => 'Review Management';

  @override
  String get reviewModerationVerified => 'Verified';

  @override
  String get routeDetailCenterOnNodeTooltip => 'Center on node';

  @override
  String routeDetailDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String get routeDetailDistanceLabel => 'Distance';

  @override
  String routeDetailDistanceMeters(String meters) {
    return '${meters}m';
  }

  @override
  String routeDetailDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get routeDetailDurationLabel => 'Duration';

  @override
  String routeDetailDurationMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String get routeDetailElevationLabel => 'Elevation';

  @override
  String routeDetailElevationValue(String meters) {
    return '${meters}m';
  }

  @override
  String routeDetailExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get routeDetailNoData => '--';

  @override
  String get routeDetailNoGpsPoints => 'No GPS Points';

  @override
  String get routeDetailPointsLabel => 'Points';

  @override
  String routeDetailShareText(String name) {
    return 'Route: $name';
  }

  @override
  String get routeDetailStorageUnavailable => 'Storage not available';

  @override
  String get routeDetailYouBadge => 'You';

  @override
  String get routesCancel => 'Cancel';

  @override
  String get routesCancelRecording => 'Cancel';

  @override
  String routesCardDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String routesCardDurationMinutes(int minutes) {
    return '${minutes}min';
  }

  @override
  String get routesColorLabel => 'Color';

  @override
  String get routesDeleteAction => 'Delete';

  @override
  String get routesDeleteConfirmAction => 'Delete';

  @override
  String routesDeleteConfirmMessage(String name) {
    return 'Are you sure you want to delete \"$name\"? This cannot be undone.';
  }

  @override
  String get routesDeleteConfirmTitle => 'Delete Route?';

  @override
  String routesDistanceDuration(String distance, String duration) {
    return '$distance • $duration';
  }

  @override
  String routesDistanceKilometers(String km) {
    return '${km}km';
  }

  @override
  String routesDistanceMeters(String meters) {
    return '${meters}m';
  }

  @override
  String routesDurationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String routesDurationMinutesSeconds(int minutes, int seconds) {
    return '${minutes}m ${seconds}s';
  }

  @override
  String routesDurationSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String routesElevationGain(String meters) {
    return '${meters}m ↑';
  }

  @override
  String get routesEmptyDescription =>
      'Record your first route or import a GPX file';

  @override
  String get routesEmptyTitle => 'No Routes Yet';

  @override
  String routesExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get routesExportGpx => 'Export GPX';

  @override
  String get routesFileReadFailed => 'Failed to read file';

  @override
  String routesImportFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get routesImportGpx => 'Import GPX';

  @override
  String routesImportSuccess(String name) {
    return 'Imported: $name';
  }

  @override
  String get routesInvalidGpxFile => 'Invalid GPX file';

  @override
  String get routesNewRouteSubtitle => 'Start recording your GPS track';

  @override
  String get routesNewRouteTitle => 'New Route';

  @override
  String get routesNotesHint => 'Trail conditions, weather, etc.';

  @override
  String get routesNotesLabel => 'Notes (optional)';

  @override
  String routesPointCount(int count) {
    return '$count points';
  }

  @override
  String routesPointsShort(int count) {
    return '$count pts';
  }

  @override
  String get routesRecordingLabel => 'Recording';

  @override
  String get routesRouteNameHint => 'Morning hike';

  @override
  String get routesRouteNameLabel => 'Route Name';

  @override
  String get routesScreenTitle => 'Routes';

  @override
  String routesShareText(String name) {
    return 'Route: $name';
  }

  @override
  String get routesStart => 'Start';

  @override
  String get routesStartRoute => 'Start Route';

  @override
  String get routesStopRecording => 'Stop';

  @override
  String get scannerAuthFailedError =>
      'Authentication failed. The device may need to be re-paired. Go to Settings > Bluetooth, forget the Meshtastic device, then tap it below to reconnect.';

  @override
  String get scannerAutoReconnectDisabledSubtitle =>
      'Select a device below to connect manually.';

  @override
  String scannerAutoReconnectDisabledSubtitleWithDevice(String name) {
    return 'Select \"$name\" below, or enable auto-reconnect.';
  }

  @override
  String get scannerAutoReconnectDisabledTitle => 'Auto-reconnect is disabled';

  @override
  String get scannerAvailableDevices => 'Available Devices';

  @override
  String get scannerBluetoothSettings => 'Bluetooth Settings';

  @override
  String get scannerBluetoothSettingsOpenFailed =>
      'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.';

  @override
  String get scannerConnectDeviceTitle => 'Connect Device';

  @override
  String get scannerConnectingStatus => 'Connecting...';

  @override
  String scannerConnectionFailedWithError(String error) {
    return 'Connection failed: $error';
  }

  @override
  String get scannerConnectionTimedOut =>
      'Connection timed out. The device may be out of range, powered off, or connected to another phone.';

  @override
  String get scannerCopyright => '© 2026 Socialmesh. All rights reserved.';

  @override
  String get scannerDetailAddress => 'Address';

  @override
  String get scannerDetailBluetoothLowEnergy => 'Bluetooth Low Energy';

  @override
  String get scannerDetailConnectionType => 'Connection Type';

  @override
  String get scannerDetailDeviceName => 'Device Name';

  @override
  String get scannerDetailManufacturerData => 'Manufacturer Data';

  @override
  String get scannerDetailServiceUuids => 'Service UUIDs';

  @override
  String get scannerDetailSignalStrength => 'Signal Strength';

  @override
  String get scannerDetailUsbSerial => 'USB Serial';

  @override
  String get scannerDeviceDisconnectedUnexpectedly =>
      'The device disconnected unexpectedly. It may have gone out of range or lost power.';

  @override
  String get scannerDeviceNotFoundSubtitle =>
      'If another app is connected to this device, disconnect from it first. Only one app can use Bluetooth at a time.';

  @override
  String scannerDeviceNotFoundTitle(String name) {
    return '$name not found';
  }

  @override
  String scannerDevicesFoundCount(int count) {
    return '$count devices found';
  }

  @override
  String get scannerDevicesTitle => 'Devices';

  @override
  String get scannerEnableAutoReconnectMessage =>
      'This will automatically connect to your last used device whenever you open the app.';

  @override
  String scannerEnableAutoReconnectMessageWithDevice(String name) {
    return 'This will automatically connect to \"$name\" now and whenever you open the app.';
  }

  @override
  String get scannerEnableAutoReconnectTitle => 'Enable Auto-Reconnect?';

  @override
  String get scannerEnableBluetoothHint =>
      'Make sure Bluetooth is enabled and your Meshtastic device is powered on';

  @override
  String get scannerEnableLabel => 'Enable';

  @override
  String get scannerGattConnectionFailed =>
      'Connection failed. This can happen if the device was previously paired with another app. Go to Settings > Bluetooth, find the Meshtastic device, tap \"Forget\", then try again.';

  @override
  String get scannerLookingForDevices => 'Looking for devices…';

  @override
  String get scannerMeshCoreConnectionFailed => 'MeshCore connection failed';

  @override
  String scannerMeshCoreConnectionFailedWithError(String error) {
    return 'MeshCore connection failed: $error';
  }

  @override
  String get scannerPairingInvalidatedError =>
      'Your phone removed the stored pairing info for this device. Return to Settings > Bluetooth, forget \"Meshtastic_XXXX\", and try again.';

  @override
  String get scannerPairingRemovedHint =>
      'Bluetooth pairing was removed. Forget \"Meshtastic\" in Settings > Bluetooth and reconnect to continue.';

  @override
  String get scannerPinRequiredError =>
      'Connection failed - please try again and enter the PIN when prompted';

  @override
  String get scannerProtocolMeshCore => 'MeshCore';

  @override
  String get scannerProtocolMeshtastic => 'Meshtastic';

  @override
  String get scannerProtocolUnknown => 'Unknown';

  @override
  String get scannerRetryScan => 'Retry Scan';

  @override
  String get scannerSavedDeviceFallbackName => 'Your saved device';

  @override
  String get scannerScanningSubtitle => 'Looking for Meshtastic devices...';

  @override
  String get scannerScanningTitle => 'Scanning for nearby devices';

  @override
  String get scannerTransportBluetooth => 'Bluetooth';

  @override
  String get scannerTransportUsb => 'USB';

  @override
  String get scannerUnknownDeviceDescription =>
      'This device was not detected as Meshtastic or MeshCore.';

  @override
  String get scannerUnknownProtocol => 'Unknown Protocol';

  @override
  String get scannerUnsupportedDeviceMessage =>
      'This device cannot be connected automatically. Only Meshtastic and MeshCore devices are supported.';

  @override
  String scannerVersionText(String version) {
    return 'Socialmesh v$version';
  }

  @override
  String scannerVersionTextShort(String version) {
    return 'Version v$version';
  }

  @override
  String get searchProductsBrowseByCategory => 'Browse by Category';

  @override
  String get searchProductsClear => 'Clear';

  @override
  String get searchProductsHint => 'Search devices, modules, antennas...';

  @override
  String searchProductsNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get searchProductsOutOfStock => 'Out of Stock';

  @override
  String get searchProductsRecentSearches => 'Recent Searches';

  @override
  String searchProductsResultCount(int count, String query) {
    return '$count results for \"$query\"';
  }

  @override
  String get searchProductsRetry => 'Retry';

  @override
  String get searchProductsSearchFailed => 'Search failed';

  @override
  String get searchProductsTrending => 'Trending';

  @override
  String get searchProductsTryDifferent =>
      'Try different keywords or browse categories';

  @override
  String get sellerProfileAbout => 'About';

  @override
  String get sellerProfileApplyCodeHint =>
      'Apply this code at checkout on the seller\'s store';

  @override
  String get sellerProfileCodeCopied => 'Code copied to clipboard';

  @override
  String get sellerProfileContactShipping => 'Contact & Shipping';

  @override
  String get sellerProfileDiscountExclusive =>
      'Exclusive discount code for Socialmesh users';

  @override
  String get sellerProfileEmail => 'Email';

  @override
  String get sellerProfileErrorLoading => 'Error loading seller';

  @override
  String get sellerProfileFoundedStat => 'Founded';

  @override
  String get sellerProfileGoBack => 'Go Back';

  @override
  String get sellerProfileNoProducts => 'No products listed yet';

  @override
  String sellerProfileNoSearchResults(String query) {
    return 'No products match \"$query\"';
  }

  @override
  String get sellerProfileNotFound => 'Seller not found';

  @override
  String get sellerProfileOfficialPartner => 'Official Partner';

  @override
  String get sellerProfilePartnerDiscount => 'Partner Discount';

  @override
  String sellerProfileProductsCount(int count) {
    return 'Products ($count)';
  }

  @override
  String get sellerProfileProductsStat => 'Products';

  @override
  String get sellerProfileRevealCode => 'Reveal Code';

  @override
  String sellerProfileReviewCount(int count) {
    return '$count reviews';
  }

  @override
  String get sellerProfileSalesStat => 'Sales';

  @override
  String get sellerProfileSearchHint => 'Search products...';

  @override
  String get sellerProfileShipsTo => 'Ships to';

  @override
  String get sellerProfileTitle => 'Seller';

  @override
  String get sellerProfileUnableToLoad => 'Unable to load products';

  @override
  String get sellerProfileWebsite => 'Website';

  @override
  String get serialConfigBaudRate => 'Baud Rate';

  @override
  String get serialConfigBaudRateSubtitle => 'Serial communication speed';

  @override
  String get serialConfigEcho => 'Echo';

  @override
  String get serialConfigEchoSubtitle =>
      'Echo sent packets back to the serial port';

  @override
  String get serialConfigEnabled => 'Serial Enabled';

  @override
  String get serialConfigEnabledSubtitle => 'Enable serial port communication';

  @override
  String serialConfigGpioPin(int pin) {
    return 'Pin $pin';
  }

  @override
  String get serialConfigGpioUnset => 'Unset';

  @override
  String get serialConfigModeCaltopoDesc =>
      'CalTopo format for mapping applications';

  @override
  String get serialConfigModeNmeaDesc =>
      'NMEA GPS sentence output for GPS applications';

  @override
  String get serialConfigModeProtoDesc =>
      'Protobuf binary protocol for programmatic access';

  @override
  String get serialConfigModeSimpleDesc =>
      'Simple serial output for basic terminal usage';

  @override
  String get serialConfigModeTextmsgDesc =>
      'Text message mode for SMS-style communication';

  @override
  String get serialConfigOverrideConsole => 'Override Console Serial';

  @override
  String get serialConfigOverrideConsoleSubtitle =>
      'Use serial module instead of console';

  @override
  String get serialConfigRxdGpio => 'RXD GPIO Pin';

  @override
  String get serialConfigRxdGpioSubtitle => 'Receive data GPIO pin number';

  @override
  String get serialConfigSave => 'Save';

  @override
  String serialConfigSaveError(String error) {
    return 'Error saving config: $error';
  }

  @override
  String get serialConfigSaved => 'Serial configuration saved';

  @override
  String get serialConfigSectionBaudRate => 'Baud Rate';

  @override
  String get serialConfigSectionGeneral => 'General';

  @override
  String get serialConfigSectionSerialMode => 'Serial Mode';

  @override
  String get serialConfigSectionTimeout => 'Timeout';

  @override
  String get serialConfigTimeout => 'Timeout';

  @override
  String serialConfigTimeoutValue(int seconds) {
    return '$seconds seconds';
  }

  @override
  String get serialConfigTitle => 'Serial Config';

  @override
  String get serialConfigTxdGpio => 'TXD GPIO Pin';

  @override
  String get serialConfigTxdGpioSubtitle => 'Transmit data GPIO pin number';

  @override
  String settingsClearAllDataFailed(String error) {
    return 'Failed to clear some data: $error';
  }

  @override
  String get settingsClearAllDataLabel => 'Clear All';

  @override
  String get settingsClearAllDataMessage =>
      'This will delete ALL app data: messages, nodes, channels, settings, keys, signals, bookmarks, automations, widgets, and saved preferences. This action cannot be undone.';

  @override
  String get settingsClearAllDataSuccess => 'All data cleared successfully';

  @override
  String get settingsClearAllDataTitle => 'Clear All Data';

  @override
  String get settingsClearMessagesLabel => 'Clear';

  @override
  String get settingsClearMessagesMessage =>
      'This will delete all stored messages. This action cannot be undone.';

  @override
  String get settingsClearMessagesSuccess => 'Messages cleared';

  @override
  String get settingsClearMessagesTitle => 'Clear Messages';

  @override
  String get settingsDeviceInfoConnection => 'Connection';

  @override
  String get settingsDeviceInfoDeviceName => 'Device Name';

  @override
  String get settingsDeviceInfoHardware => 'Hardware';

  @override
  String get settingsDeviceInfoLongName => 'Long Name';

  @override
  String get settingsDeviceInfoNodeNumber => 'Node Number';

  @override
  String get settingsDeviceInfoNone => 'None';

  @override
  String get settingsDeviceInfoNotConnected => 'Not connected';

  @override
  String get settingsDeviceInfoShortName => 'Short Name';

  @override
  String get settingsDeviceInfoTitle => 'Device Information';

  @override
  String get settingsDeviceInfoUnknown => 'Unknown';

  @override
  String get settingsDeviceInfoUserId => 'User ID';

  @override
  String settingsErrorLoading(String error) {
    return 'Error loading settings: $error';
  }

  @override
  String settingsForceSyncFailed(String error) {
    return 'Sync failed: $error';
  }

  @override
  String get settingsForceSyncLabel => 'Sync';

  @override
  String get settingsForceSyncMessage =>
      'This will clear all local messages, nodes, and channels, then re-sync everything from the connected device.\n\nAre you sure you want to continue?';

  @override
  String get settingsForceSyncNotConnected => 'Not connected to a device';

  @override
  String get settingsForceSyncSuccess => 'Sync complete';

  @override
  String get settingsForceSyncTitle => 'Force Sync';

  @override
  String get settingsForceSyncingStatus => 'Syncing from device…';

  @override
  String get settingsHapticIntensityTitle => 'Haptic Intensity';

  @override
  String get settingsHapticMediumDescription =>
      'Balanced feedback for most interactions';

  @override
  String get settingsHapticStrongDescription =>
      'Strong feedback for clear confirmation';

  @override
  String get settingsHapticSubtleDescription =>
      'Subtle feedback for a gentle touch';

  @override
  String get settingsHelpTooltip => 'Help';

  @override
  String settingsHistoryLimitOption(int limit) {
    return '$limit messages';
  }

  @override
  String get settingsHistoryLimitTitle => 'Message History Limit';

  @override
  String get settingsLoadingStatus => 'Loading…';

  @override
  String get settingsMeshtasticGoBack => 'Go back';

  @override
  String get settingsMeshtasticOfflineMessage =>
      'This content requires an internet connection. Please check your connection and try again.';

  @override
  String get settingsMeshtasticRefresh => 'Refresh';

  @override
  String get settingsMeshtasticUnableToLoad => 'Unable to load page';

  @override
  String get settingsMeshtasticWebViewTitle => 'Meshtastic';

  @override
  String get settingsNoSettingsFound => 'No settings found';

  @override
  String get settingsNotConfigured => 'Not configured';

  @override
  String get settingsOpenSourceAppName => 'Socialmesh';

  @override
  String get settingsOpenSourceLegalese =>
      '© 2024 Socialmesh\n\nThis app uses open source software. See below for the complete list of third-party licenses.';

  @override
  String get settingsPremiumAllUnlocked => 'All features unlocked!';

  @override
  String get settingsPremiumBadgeLocked => 'LOCKED';

  @override
  String get settingsPremiumBadgeOwned => 'OWNED';

  @override
  String get settingsPremiumBadgeTry => 'TRY IT';

  @override
  String settingsPremiumPartiallyUnlocked(int owned, int total) {
    return '$owned of $total unlocked';
  }

  @override
  String get settingsPremiumUnlockFeaturesTitle => 'Unlock Features';

  @override
  String get settingsProfileLocalOnly => 'Local only';

  @override
  String get settingsProfileSubtitle => 'Set up your profile';

  @override
  String get settingsProfileSynced => 'Synced';

  @override
  String get settingsProfileTitle => 'Profile';

  @override
  String get settingsRegionConfigureSubtitle =>
      'Configure device radio frequency';

  @override
  String get settingsRemoteAdminConfigureTitle => 'Configure Device';

  @override
  String get settingsRemoteAdminConfiguringTitle => 'Configuring Remote Node';

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
  String get settingsResetLocalDataLabel => 'Reset';

  @override
  String get settingsResetLocalDataMessage =>
      'This will clear all messages and node data, forcing a fresh sync from your device on next connection.\n\nYour settings, theme, and preferences will be kept.\n\nUse this if nodes show incorrect status or messages appear wrong.';

  @override
  String get settingsResetLocalDataSuccess =>
      'Local data reset. Reconnect to sync fresh data.';

  @override
  String get settingsResetLocalDataTitle => 'Reset Local Data';

  @override
  String get settingsSearchAutoAcceptTransfersSubtitle =>
      'Automatically accept incoming file offers';

  @override
  String get settingsSearchAutoAcceptTransfersTitle => 'Auto-accept transfers';

  @override
  String get settingsSearchAutomationsPackSubtitle =>
      'Automated actions and triggers';

  @override
  String get settingsSearchAutomationsPackTitle => 'Automations Pack';

  @override
  String get settingsSearchBluetoothConfigSubtitle =>
      'Bluetooth settings and PIN';

  @override
  String get settingsSearchBluetoothConfigTitle => 'Bluetooth config';

  @override
  String get settingsSearchCannedMessagesSubtitle =>
      'Pre-configured device messages';

  @override
  String get settingsSearchCannedMessagesTitle => 'Canned Messages';

  @override
  String get settingsSearchChannelNotificationsSubtitle =>
      'Notify for channel broadcasts';

  @override
  String get settingsSearchChannelNotificationsTitle =>
      'Channel message notifications';

  @override
  String get settingsSearchClearAllDataSubtitle =>
      'Delete messages, settings, and keys';

  @override
  String get settingsSearchClearAllMessagesSubtitle =>
      'Delete all stored messages';

  @override
  String get settingsSearchClearAllMessagesTitle => 'Clear all messages';

  @override
  String get settingsSearchCommentsSubtitle =>
      'Push notifications for comments and @mentions';

  @override
  String get settingsSearchDeviceConfigSubtitle =>
      'Device name, role, and behavior';

  @override
  String get settingsSearchDeviceConfigTitle => 'Device config';

  @override
  String get settingsSearchDisplayConfigSubtitle =>
      'Screen brightness and timeout';

  @override
  String get settingsSearchDisplayConfigTitle => 'Display config';

  @override
  String get settingsSearchDmNotificationsSubtitle =>
      'Notify for private messages';

  @override
  String get settingsSearchDmNotificationsTitle =>
      'Direct message notifications';

  @override
  String get settingsSearchExportDataSubtitle => 'Export messages and settings';

  @override
  String get settingsSearchExportDataTitle => 'Export data';

  @override
  String get settingsSearchFileTransferSubtitle =>
      'Send and receive small files over mesh';

  @override
  String get settingsSearchFileTransferTitle => 'File transfer';

  @override
  String get settingsSearchForceSyncSubtitle => 'Force configuration sync';

  @override
  String get settingsSearchForceSyncTitle => 'Force sync';

  @override
  String get settingsSearchHapticIntensitySubtitle =>
      'Light, medium, or heavy feedback';

  @override
  String get settingsSearchHelpSupportSubtitle =>
      'FAQ, troubleshooting, and contact info';

  @override
  String get settingsSearchHint => 'Find a setting';

  @override
  String get settingsSearchHistoryLimitSubtitle => 'Maximum messages to keep';

  @override
  String get settingsSearchHistoryLimitTitle => 'Message history limit';

  @override
  String get settingsSearchIftttPackSubtitle =>
      'Integration with external services';

  @override
  String get settingsSearchIftttPackTitle => 'IFTTT Pack';

  @override
  String get settingsSearchImportChannelSubtitle =>
      'Scan a Meshtastic channel QR code';

  @override
  String get settingsSearchImportChannelTitle => 'Import channel via QR';

  @override
  String get settingsSearchLikesSubtitle => 'Push notifications for post likes';

  @override
  String get settingsSearchLinkedDevicesSubtitle =>
      'Meshtastic devices connected to your profile';

  @override
  String get settingsSearchLinkedDevicesTitle => 'Linked Devices';

  @override
  String get settingsSearchNetworkConfigSubtitle => 'WiFi and network settings';

  @override
  String get settingsSearchNetworkConfigTitle => 'Network config';

  @override
  String get settingsSearchNewFollowersSubtitle =>
      'Push notifications when someone follows you';

  @override
  String get settingsSearchNewNodesNotificationsSubtitle =>
      'Notify when new nodes join the mesh';

  @override
  String get settingsSearchNewNodesNotificationsTitle =>
      'New nodes notifications';

  @override
  String get settingsSearchNotificationSoundSubtitle =>
      'Play sound for notifications';

  @override
  String get settingsSearchNotificationSoundTitle => 'Notification sound';

  @override
  String get settingsSearchNotificationVibrationSubtitle =>
      'Vibrate for notifications';

  @override
  String get settingsSearchNotificationVibrationTitle =>
      'Notification vibration';

  @override
  String get settingsSearchPositionConfigSubtitle => 'GPS and position sharing';

  @override
  String get settingsSearchPositionConfigTitle => 'Position config';

  @override
  String get settingsSearchPowerConfigSubtitle =>
      'Power saving and sleep settings';

  @override
  String get settingsSearchPowerConfigTitle => 'Power config';

  @override
  String get settingsSearchPremiumSubtitle =>
      'Ringtones, themes, automations, IFTTT, widgets';

  @override
  String get settingsSearchPrivacySubtitle => 'How we handle your data';

  @override
  String get settingsSearchProfileSubtitle =>
      'Your display name, avatar, and bio';

  @override
  String get settingsSearchRadioConfigSubtitle =>
      'LoRa, modem, channel settings';

  @override
  String get settingsSearchRadioConfigTitle => 'Radio config';

  @override
  String get settingsSearchRegionSubtitle => 'Device radio frequency region';

  @override
  String get settingsSearchRegionTitle => 'Region';

  @override
  String get settingsSearchRemoteAdminSubtitle =>
      'Configure remote nodes via PKI admin';

  @override
  String get settingsSearchRemoteAdminTitle => 'Remote Administration';

  @override
  String get settingsSearchResetLocalDataSubtitle => 'Clear all local app data';

  @override
  String get settingsSearchResetLocalDataTitle => 'Reset local data';

  @override
  String get settingsSearchRingtonePackSubtitle => 'Custom notification sounds';

  @override
  String get settingsSearchRingtonePackTitle => 'Ringtone Pack';

  @override
  String get settingsSearchScanForDeviceSubtitle =>
      'Scan QR code for easy setup';

  @override
  String get settingsSearchScanForDeviceTitle => 'Scan for device';

  @override
  String get settingsSearchSocialmeshSubtitle => 'Meshtastic companion app';

  @override
  String get settingsSearchTakGatewaySubtitle =>
      'Gateway URL, position publishing, callsign';

  @override
  String get settingsSearchTakGatewayTitle => 'TAK Gateway';

  @override
  String get settingsSearchTermsSubtitle => 'Legal terms and conditions';

  @override
  String get settingsSearchThemePackSubtitle =>
      'Accent colors and visual customization';

  @override
  String get settingsSearchThemePackTitle => 'Theme Pack';

  @override
  String get settingsSearchWidgetPackSubtitle => 'Home screen widgets';

  @override
  String get settingsSearchWidgetPackTitle => 'Widget Pack';

  @override
  String get settingsSectionAbout => 'ABOUT';

  @override
  String get settingsSectionAccount => 'ACCOUNT';

  @override
  String get settingsSectionAnimations => 'ANIMATIONS';

  @override
  String get settingsSectionAppearance => 'APPEARANCE';

  @override
  String get settingsSectionConnection => 'CONNECTION';

  @override
  String get settingsSectionDataStorage => 'DATA & STORAGE';

  @override
  String get settingsSectionDevice => 'DEVICE';

  @override
  String get settingsSectionFeedback => 'FEEDBACK';

  @override
  String get settingsSectionHapticFeedback => 'HAPTIC FEEDBACK';

  @override
  String get settingsSectionMessaging => 'MESSAGING';

  @override
  String get settingsSectionModules => 'MODULES';

  @override
  String get settingsSectionNotifications => 'NOTIFICATIONS';

  @override
  String get settingsSectionPremium => 'PREMIUM';

  @override
  String get settingsSectionRemoteAdmin => 'REMOTE ADMINISTRATION';

  @override
  String get settingsSectionSocialNotifications => 'SOCIAL NOTIFICATIONS';

  @override
  String get settingsSectionTelemetryLogs => 'TELEMETRY LOGS';

  @override
  String get settingsSectionTools => 'TOOLS';

  @override
  String get settingsSectionWhatsNew => 'WHAT’S NEW';

  @override
  String get settingsSocialCommentsSubtitle =>
      'When someone comments or @mentions you';

  @override
  String get settingsSocialCommentsTitle => 'Comments & mentions';

  @override
  String get settingsSocialLikesSubtitle => 'When someone likes your posts';

  @override
  String get settingsSocialLikesTitle => 'Likes';

  @override
  String get settingsSocialNewFollowersSubtitle =>
      'When someone follows you or sends a request';

  @override
  String get settingsSocialNewFollowersTitle => 'New followers';

  @override
  String get settingsSocialNotificationsLoading => 'Loading…';

  @override
  String get settingsSocialNotificationsLoadingSubtitle =>
      'Fetching notification preferences';

  @override
  String settingsSocialmeshVersionSnackbar(String version) {
    return 'Socialmesh v$version';
  }

  @override
  String get settingsTile3dEffectsSubtitle =>
      'Perspective transforms and depth effects';

  @override
  String get settingsTile3dEffectsTitle => '3D effects';

  @override
  String get settingsTileAirQualitySubtitle => 'PM2.5, PM10, CO2 readings';

  @override
  String get settingsTileAirQualityTitle => 'Air Quality';

  @override
  String get settingsTileAmbientLightingSubtitle =>
      'Configure LED and RGB settings';

  @override
  String get settingsTileAmbientLightingTitle => 'Ambient Lighting';

  @override
  String get settingsTileAppLogSubtitle => 'View application debug logs';

  @override
  String get settingsTileAppLogTitle => 'App Log';

  @override
  String get settingsTileAppearanceSubtitle =>
      'Font, text size, density, contrast, motion';

  @override
  String get settingsTileAppearanceTitle => 'Appearance & Accessibility';

  @override
  String get settingsTileAutoReconnectSubtitle =>
      'Automatically reconnect to last device';

  @override
  String get settingsTileAutoReconnectTitle => 'Auto-reconnect';

  @override
  String get settingsTileBackgroundConnectionSubtitle =>
      'Background BLE, notifications, and power settings';

  @override
  String get settingsTileBackgroundConnectionTitle => 'Background connection';

  @override
  String get settingsTileBluetoothSubtitle => 'Pairing mode, PIN settings';

  @override
  String get settingsTileBluetoothTitle => 'Bluetooth';

  @override
  String get settingsTileCannedMessagesSubtitle =>
      'Device-side canned message settings';

  @override
  String get settingsTileCannedMessagesTitle => 'Canned Messages Module';

  @override
  String get settingsTileChannelMessagesSubtitle =>
      'Notify for channel broadcasts';

  @override
  String get settingsTileChannelMessagesTitle => 'Channel messages';

  @override
  String get settingsTileClearAllDataSubtitle =>
      'Delete messages, settings, and keys';

  @override
  String get settingsTileClearAllDataTitle => 'Clear all data';

  @override
  String get settingsTileClearMessageHistorySubtitle =>
      'Delete all stored messages';

  @override
  String get settingsTileClearMessageHistoryTitle => 'Clear message history';

  @override
  String get settingsTileDetectionSensorLogsSubtitle => 'Sensor event history';

  @override
  String get settingsTileDetectionSensorLogsTitle => 'Detection Sensor Logs';

  @override
  String get settingsTileDetectionSensorSubtitle =>
      'Configure GPIO-based motion/door sensors';

  @override
  String get settingsTileDetectionSensorTitle => 'Detection Sensor';

  @override
  String get settingsTileDeviceInfoSubtitle => 'View connected device details';

  @override
  String get settingsTileDeviceInfoTitle => 'Device info';

  @override
  String get settingsTileDeviceManagementSubtitle =>
      'Reboot, shutdown, factory reset';

  @override
  String get settingsTileDeviceManagementTitle => 'Device Management';

  @override
  String get settingsTileDeviceMetricsSubtitle =>
      'Battery, voltage, utilization history';

  @override
  String get settingsTileDeviceMetricsTitle => 'Device Metrics';

  @override
  String get settingsTileDeviceRoleSubtitle =>
      'Configure device behavior and role';

  @override
  String get settingsTileDeviceRoleTitle => 'Device Role & Settings';

  @override
  String get settingsTileDirectMessagesSubtitle =>
      'Notify for private messages';

  @override
  String get settingsTileDirectMessagesTitle => 'Direct messages';

  @override
  String get settingsTileDisplaySettingsSubtitle =>
      'Screen timeout, units, display mode';

  @override
  String get settingsTileDisplaySettingsTitle => 'Display Settings';

  @override
  String get settingsTileEnvironmentMetricsSubtitle =>
      'Temperature, humidity, pressure logs';

  @override
  String get settingsTileEnvironmentMetricsTitle => 'Environment Metrics';

  @override
  String get settingsTileExportDataSubtitle =>
      'Export messages, telemetry, routes';

  @override
  String get settingsTileExportDataTitle => 'Export Data';

  @override
  String get settingsTileExportMessagesSubtitle =>
      'Export messages to PDF or CSV';

  @override
  String get settingsTileExportMessagesTitle => 'Export Messages';

  @override
  String get settingsTileExternalNotificationSubtitle =>
      'Configure buzzers, LEDs, and vibration alerts';

  @override
  String get settingsTileExternalNotificationTitle => 'External Notification';

  @override
  String get settingsTileFirmwareUpdateSubtitle =>
      'Check for device firmware updates';

  @override
  String get settingsTileFirmwareUpdateTitle => 'Firmware Update';

  @override
  String get settingsTileForceSyncSubtitle =>
      'Re-sync all data from connected device';

  @override
  String get settingsTileForceSyncTitle => 'Force Sync';

  @override
  String get settingsTileGlyphMatrixSubtitle => 'Nothing Phone 3 LED patterns';

  @override
  String get settingsTileGlyphMatrixTitle => 'Glyph Matrix Test';

  @override
  String get settingsTileGpsStatusSubtitle => 'View detailed GPS information';

  @override
  String get settingsTileGpsStatusTitle => 'GPS Status';

  @override
  String get settingsTileHapticFeedbackSubtitle =>
      'Vibration feedback for interactions';

  @override
  String get settingsTileHapticFeedbackTitle => 'Haptic feedback';

  @override
  String get settingsTileHelpCenterSubtitle =>
      'Interactive guides with Ico, your mesh guide';

  @override
  String get settingsTileHelpCenterTitle => 'Help Center';

  @override
  String get settingsTileHelpSupportSubtitle =>
      'FAQ, troubleshooting, and contact info';

  @override
  String get settingsTileHelpSupportTitle => 'Help & Support';

  @override
  String get settingsTileIntensityTitle => 'Intensity';

  @override
  String get settingsTileListAnimationsSubtitle =>
      'Slide and bounce effects on lists';

  @override
  String get settingsTileListAnimationsTitle => 'List animations';

  @override
  String settingsTileMessageHistorySubtitle(int count) {
    return '$count messages stored';
  }

  @override
  String get settingsTileMessageHistoryTitle => 'Message history';

  @override
  String get settingsTileMqttSubtitle => 'Configure mesh-to-internet bridge';

  @override
  String get settingsTileMqttTitle => 'MQTT';

  @override
  String get settingsTileMyBugReportsNotSignedIn =>
      'Sign in to track your reports and receive replies';

  @override
  String get settingsTileMyBugReportsSubtitle =>
      'View your reports and responses';

  @override
  String get settingsTileMyBugReportsTitle => 'My bug reports';

  @override
  String get settingsTileNetworkSubtitle => 'WiFi, Ethernet, NTP settings';

  @override
  String get settingsTileNetworkTitle => 'Network';

  @override
  String get settingsTileNewNodesSubtitle =>
      'Notify when new nodes join the mesh';

  @override
  String get settingsTileNewNodesTitle => 'New nodes';

  @override
  String get settingsTileOpenSourceSubtitle =>
      'Third-party libraries and attributions';

  @override
  String get settingsTileOpenSourceTitle => 'Open Source Licenses';

  @override
  String get settingsTilePaxCounterLogsSubtitle => 'Device detection history';

  @override
  String get settingsTilePaxCounterLogsTitle => 'PAX Counter Logs';

  @override
  String get settingsTilePaxCounterSubtitle =>
      'WiFi/BLE device detection settings';

  @override
  String get settingsTilePaxCounterTitle => 'PAX Counter';

  @override
  String get settingsTilePositionHistorySubtitle => 'GPS position logs';

  @override
  String get settingsTilePositionHistoryTitle => 'Position History';

  @override
  String get settingsTilePositionSubtitle =>
      'GPS mode, broadcast intervals, fixed position';

  @override
  String get settingsTilePositionTitle => 'Position & GPS';

  @override
  String get settingsTilePowerManagementSubtitle =>
      'Power saving, sleep settings';

  @override
  String get settingsTilePowerManagementTitle => 'Power Management';

  @override
  String get settingsTilePrivacyPolicySubtitle => 'How we handle your data';

  @override
  String get settingsTilePrivacyPolicyTitle => 'Privacy Policy';

  @override
  String get settingsTilePrivacySubtitle =>
      'Analytics, crash reporting, and data controls';

  @override
  String get settingsTilePrivacyTitle => 'Privacy';

  @override
  String get settingsTileProvideLocationSubtitle =>
      'Send phone GPS to mesh for devices without GPS hardware';

  @override
  String get settingsTileProvideLocationTitle => 'Provide phone location';

  @override
  String get settingsTilePushNotificationsSubtitle =>
      'Master toggle for all notifications';

  @override
  String get settingsTilePushNotificationsTitle => 'Push notifications';

  @override
  String get settingsTileQuickResponsesSubtitle =>
      'Manage canned responses for fast messaging';

  @override
  String get settingsTileQuickResponsesTitle => 'Quick responses';

  @override
  String get settingsTileRadioConfigSubtitle =>
      'LoRa settings, modem preset, power';

  @override
  String get settingsTileRadioConfigTitle => 'Radio Configuration';

  @override
  String get settingsTileRangeTestSubtitle =>
      'Test signal range with other nodes';

  @override
  String get settingsTileRangeTestTitle => 'Range Test';

  @override
  String get settingsTileRegionTitle => 'Region / Frequency';

  @override
  String get settingsTileResetLocalDataSubtitle =>
      'Clear messages and nodes, keep settings';

  @override
  String get settingsTileResetLocalDataTitle => 'Reset local data';

  @override
  String get settingsTileRoutesSubtitle => 'Record and manage GPS routes';

  @override
  String get settingsTileRoutesTitle => 'Routes';

  @override
  String get settingsTileScanQrCodeSubtitle =>
      'Import nodes, channels, or automations';

  @override
  String get settingsTileScanQrCodeTitle => 'Scan QR Code';

  @override
  String get settingsTileSecuritySubtitle => 'Access controls, managed mode';

  @override
  String get settingsTileSecurityTitle => 'Security';

  @override
  String get settingsTileSerialSubtitle => 'Serial port configuration';

  @override
  String get settingsTileSerialTitle => 'Serial';

  @override
  String get settingsTileShakeToReportSubtitle =>
      'Shake your device to open the bug report flow';

  @override
  String get settingsTileShakeToReportTitle => 'Shake to report a bug';

  @override
  String get settingsTileSocialmeshSubtitle => 'Meshtastic companion app';

  @override
  String get settingsTileSocialmeshTitle => 'Socialmesh';

  @override
  String get settingsTileSoundSubtitle => 'Play sound with notifications';

  @override
  String get settingsTileSoundTitle => 'Sound';

  @override
  String get settingsTileStoreForwardSubtitle =>
      'Store and relay messages for offline nodes';

  @override
  String get settingsTileStoreForwardTitle => 'Store & Forward';

  @override
  String get settingsTileTelemetryIntervalsSubtitle =>
      'Configure telemetry update frequency';

  @override
  String get settingsTileTelemetryIntervalsTitle => 'Telemetry Intervals';

  @override
  String get settingsTileTermsOfServiceSubtitle => 'Legal terms and conditions';

  @override
  String get settingsTileTermsOfServiceTitle => 'Terms of Service';

  @override
  String get settingsTileTracerouteHistorySubtitle =>
      'Network path analysis logs';

  @override
  String get settingsTileTracerouteHistoryTitle => 'Traceroute History';

  @override
  String get settingsTileTrafficManagementSubtitle =>
      'Mesh traffic optimization and filtering';

  @override
  String get settingsTileTrafficManagementTitle => 'Traffic Management';

  @override
  String get settingsTileVibrationSubtitle => 'Vibrate with notifications';

  @override
  String get settingsTileVibrationTitle => 'Vibration';

  @override
  String get settingsTileWhatsNewSubtitle =>
      'Browse recent features and updates';

  @override
  String get settingsTileWhatsNewTitle => 'What’s New';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsTryDifferentSearch => 'Try a different search term';

  @override
  String settingsVersionString(String version) {
    return 'Version $version';
  }

  @override
  String get shopAdminDashboardAccessDenied => 'Access Denied';

  @override
  String get shopAdminDashboardAccessRequired => 'Admin Access Required';

  @override
  String shopAdminDashboardActiveCount(int count) {
    return '$count active';
  }

  @override
  String get shopAdminDashboardAddProduct => 'Add Product';

  @override
  String get shopAdminDashboardAddSeller => 'Add Seller';

  @override
  String get shopAdminDashboardError => 'Error';

  @override
  String get shopAdminDashboardEstRevenue => 'Est. Revenue';

  @override
  String get shopAdminDashboardFeatured => 'Featured Products';

  @override
  String get shopAdminDashboardFeaturedSubtitle =>
      'Manage featured product display order';

  @override
  String get shopAdminDashboardInactive => 'Inactive';

  @override
  String get shopAdminDashboardManagement => 'Management';

  @override
  String get shopAdminDashboardNoPermission =>
      'You do not have permission to access this area.';

  @override
  String get shopAdminDashboardOutOfStock => 'Out of Stock';

  @override
  String get shopAdminDashboardProducts => 'Products';

  @override
  String get shopAdminDashboardProductsSubtitle =>
      'Manage all product listings';

  @override
  String get shopAdminDashboardQuickActions => 'Quick Actions';

  @override
  String get shopAdminDashboardRefresh => 'Refresh';

  @override
  String get shopAdminDashboardReviews => 'Reviews';

  @override
  String get shopAdminDashboardReviewsMgmt => 'Reviews';

  @override
  String get shopAdminDashboardReviewsSubtitle => 'Moderate product reviews';

  @override
  String get shopAdminDashboardSellers => 'Sellers';

  @override
  String get shopAdminDashboardSellersSubtitle =>
      'Manage seller profiles and partnerships';

  @override
  String get shopAdminDashboardTitle => 'Shop Admin';

  @override
  String get shopAdminDashboardTotalProducts => 'Total Products';

  @override
  String get shopAdminDashboardTotalSales => 'Total Sales';

  @override
  String get shopAdminDashboardTotalSellers => 'Total Sellers';

  @override
  String get shopAdminDashboardTotalViews => 'Total Views';

  @override
  String get shopFavoritesEmpty => 'No favorites yet';

  @override
  String get shopFavoritesEmptySubtitle =>
      'Tap the heart icon on products to save them';

  @override
  String get shopFavoritesErrorLoading => 'Error loading favorites';

  @override
  String get shopFavoritesInStock => 'In Stock';

  @override
  String get shopFavoritesOutOfStock => 'Out of Stock';

  @override
  String get shopFavoritesProductRemoved => 'Product no longer available';

  @override
  String get shopFavoritesRetry => 'Retry';

  @override
  String get shopFavoritesSignIn => 'Sign in to save favorites';

  @override
  String get shopFavoritesSignInSubtitle =>
      'Your favorite devices will appear here';

  @override
  String get shopFavoritesTitle => 'Favorites';

  @override
  String get shopFavoritesUnableToLoad => 'Unable to load product';

  @override
  String get shopModelBandAu915 => 'AU 915MHz';

  @override
  String get shopModelBandAu915Range => '915-928 MHz';

  @override
  String get shopModelBandCn470 => 'CN 470MHz';

  @override
  String get shopModelBandCn470Range => '470-510 MHz';

  @override
  String get shopModelBandEu868 => 'EU 868MHz';

  @override
  String get shopModelBandEu868Range => '863-870 MHz';

  @override
  String get shopModelBandIn865 => 'IN 865MHz';

  @override
  String get shopModelBandIn865Range => '865-867 MHz';

  @override
  String get shopModelBandJp920 => 'JP 920MHz';

  @override
  String get shopModelBandJp920Range => '920-925 MHz';

  @override
  String get shopModelBandKr920 => 'KR 920MHz';

  @override
  String get shopModelBandKr920Range => '920-923 MHz';

  @override
  String get shopModelBandMulti => 'Multi-band';

  @override
  String get shopModelBandMultiRange => 'Multiple frequencies';

  @override
  String get shopModelBandUs915 => 'US 915MHz';

  @override
  String get shopModelBandUs915Range => '902-928 MHz';

  @override
  String get shopModelCategoryAccessories => 'Accessories';

  @override
  String get shopModelCategoryAccessoriesDescription =>
      'Cables, batteries, and more';

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
  String get shopModelCategoryKits => 'Kits';

  @override
  String get shopModelCategoryKitsDescription => 'DIY kits and bundles';

  @override
  String get shopModelCategoryModules => 'Modules';

  @override
  String get shopModelCategoryModulesDescription => 'Add-on modules and boards';

  @override
  String get shopModelCategoryNodes => 'Nodes';

  @override
  String get shopModelCategoryNodesDescription => 'Complete Meshtastic devices';

  @override
  String get shopModelCategorySolar => 'Solar';

  @override
  String get shopModelCategorySolarDescription =>
      'Solar panels and power solutions';

  @override
  String shopModelPriceFrom(String price) {
    return 'From \$$price';
  }

  @override
  String get sigilStageHeraldic => 'Heraldic';

  @override
  String get sigilStageInscribed => 'Inscribed';

  @override
  String get sigilStageLegacy => 'Legacy';

  @override
  String get sigilStageMarked => 'Marked';

  @override
  String get sigilStageSeed => 'Seed';

  @override
  String get signalAcquiringDeviceLocation => 'Acquiring device location...';

  @override
  String signalActiveCount(int count) {
    return '$count active';
  }

  @override
  String signalActiveDays(int days) {
    return 'Active ${days}d';
  }

  @override
  String signalActiveHours(int hours) {
    return 'Active ${hours}h';
  }

  @override
  String signalActiveMinutes(int minutes) {
    return 'Active ${minutes}m';
  }

  @override
  String get signalActiveNow => 'Active now';

  @override
  String get signalAddLocation => 'Add location';

  @override
  String get signalAddPhotos => 'Add Photos';

  @override
  String get signalAnonAuthor => 'Anon';

  @override
  String get signalAnonymous => 'Anonymous';

  @override
  String get signalAnonymousAuthor => 'Anonymous';

  @override
  String get signalAnonymousFeed => 'Anonymous';

  @override
  String signalApproxArea(int radiusMeters) {
    return 'Approx. area (~${radiusMeters}m)';
  }

  @override
  String get signalAttachFile => 'Attach file';

  @override
  String get signalBackNearby => 'Back nearby';

  @override
  String get signalBeFirstToRespond => 'Be the first to respond to this signal';

  @override
  String get signalBleNoMeshTrafficIos =>
      'Connected to BLE but no mesh traffic detected. On iOS, Airplane Mode can block BLE traffic even when connected. Turn off Airplane Mode or toggle Bluetooth.';

  @override
  String get signalBroadcastYourSignal => 'Broadcast your signal';

  @override
  String get signalBroadcastingOverMesh => 'Broadcasting over mesh...';

  @override
  String get signalCancel => 'Cancel';

  @override
  String get signalChooseFromGallery => 'Choose from Gallery';

  @override
  String get signalCloudBadge => 'Cloud';

  @override
  String get signalCloudFeaturesUnavailable => 'Cloud features unavailable.';

  @override
  String signalCommentCount(int count) {
    return '$count comments';
  }

  @override
  String get signalCommentReported => 'Comment reported. Thank you.';

  @override
  String get signalConnectToAddLocation =>
      'Connect a device to add location to your signal.';

  @override
  String get signalConnectToGoActive => 'Connect to a device to go active';

  @override
  String get signalConnectToSend => 'Connect to a device to send signals';

  @override
  String get signalConversation => 'Conversation';

  @override
  String get signalCreateFailed => 'Failed to create signal';

  @override
  String get signalCurrentLocation => 'Current location';

  @override
  String get signalDelete => 'Delete';

  @override
  String get signalDeleteMessage => 'This signal will fade immediately.';

  @override
  String get signalDeleteTitle => 'Delete Signal?';

  @override
  String get signalDetailTitle => 'Signal';

  @override
  String get signalDeviceNotConnected => 'Device not connected';

  @override
  String get signalDiscardConfirm => 'Discard';

  @override
  String get signalDiscardMessage => 'Your draft will be lost.';

  @override
  String get signalDiscardTitle => 'Discard signal?';

  @override
  String get signalDuration => 'Signal Duration';

  @override
  String get signalDurationSubtitle => 'How long until your signal fades';

  @override
  String get signalEmptyTagline1 =>
      'Nothing active here right now.\nSignals appear when someone nearby goes active.';

  @override
  String get signalEmptyTagline2 =>
      'Signals are mesh-first and ephemeral.\nThey dissolve when their timer ends.';

  @override
  String get signalEmptyTagline3 =>
      'Share a quick status or photo.\nNearby nodes will see it in real time.';

  @override
  String get signalEmptyTagline4 =>
      'Go active to broadcast your presence.\nOff-grid, device to device.';

  @override
  String get signalEmptyTitleKeyword => 'signals';

  @override
  String get signalEmptyTitlePrefix => 'No active ';

  @override
  String get signalEmptyTitleSuffix => ' nearby';

  @override
  String get signalEnableGpsOrFixedPosition =>
      'Device has no location yet. Enable GPS or set a fixed position.';

  @override
  String get signalExpiredBadge => 'Expired';

  @override
  String get signalFaded => 'Faded';

  @override
  String get signalFadesIn => 'Fades in';

  @override
  String signalFadesInDays(int days) {
    return 'Fades in ${days}d';
  }

  @override
  String signalFadesInHours(int hours) {
    return 'Fades in ${hours}h';
  }

  @override
  String signalFadesInMinutes(int minutes) {
    return 'Fades in ${minutes}m';
  }

  @override
  String signalFadesInMinutesSeconds(int minutes, int seconds) {
    return 'Fades in ${minutes}m ${seconds}s';
  }

  @override
  String signalFadesInSeconds(int seconds) {
    return 'Fades in ${seconds}s';
  }

  @override
  String get signalFallbackContent => 'Signal';

  @override
  String signalFileTooLarge(int size) {
    return 'File too large. Mesh transfer is limited to $size KB.';
  }

  @override
  String get signalFileTransferFailed => 'File transfer failed to start';

  @override
  String get signalFileTransfers => 'File Transfers';

  @override
  String get signalFilterAll => 'All';

  @override
  String get signalFilterExpiring => 'Expiring';

  @override
  String get signalFilterHidden => 'Hidden';

  @override
  String get signalFilterLocation => 'Location';

  @override
  String get signalFilterMedia => 'Media';

  @override
  String get signalFilterMesh => 'Mesh';

  @override
  String get signalFilterNearby => 'Nearby';

  @override
  String get signalFilterReplies => 'Replies';

  @override
  String get signalFilterSaved => 'Saved';

  @override
  String get signalFitAllSignals => 'Fit all signals';

  @override
  String get signalGetLocationFailed => 'Failed to get location';

  @override
  String get signalGoActive => 'Go Active';

  @override
  String get signalGoActiveAction => 'Go Active';

  @override
  String get signalHasFaded => 'This signal has faded';

  @override
  String get signalHelp => 'Help';

  @override
  String get signalHidden => 'Signal hidden';

  @override
  String get signalHide => 'Hide';

  @override
  String signalHopSingular(int count) {
    return '$count hop';
  }

  @override
  String signalHopsBadge(int count) {
    return '$count hops';
  }

  @override
  String signalHopsPlural(int count) {
    return '$count hops';
  }

  @override
  String get signalImageBlockedSingular =>
      'Image violates content guidelines and was blocked';

  @override
  String signalImagesAddedCount(int passedCount) {
    return '$passedCount images added';
  }

  @override
  String signalImagesBlockedAndAdded(int failedCount, int passedCount) {
    return '$failedCount image(s) blocked, $passedCount added';
  }

  @override
  String signalImagesBlockedPlural(int failedCount) {
    return '$failedCount images blocked by content guidelines';
  }

  @override
  String get signalImagesHiddenOffline =>
      'Images hidden while offline. They will return when back online.';

  @override
  String get signalImagesRequireInternet =>
      'Images require internet. Images removed.';

  @override
  String get signalImagesRestored => 'Images restored!';

  @override
  String get signalIntentLabel => 'Intent';

  @override
  String get signalIosAirplaneModeWarning =>
      'iOS Airplane Mode can pause BLE mesh traffic even when connected. If signals stop, turn off Airplane Mode or toggle Bluetooth.';

  @override
  String get signalKeepEditing => 'Keep editing';

  @override
  String get signalLegendFiveMin => '< 5 min';

  @override
  String get signalLegendOverTwoHrs => '> 2 hrs';

  @override
  String get signalLegendThirtyMin => '< 30 min';

  @override
  String get signalLegendTwoHrs => '< 2 hrs';

  @override
  String get signalLetOthersKnowIntent => 'Let others know why you\'re active';

  @override
  String get signalLoadingComments => 'Loading comments...';

  @override
  String get signalLocal => 'Local';

  @override
  String get signalLocalBadge => 'Local';

  @override
  String get signalLocalBadgeGallery => 'Local';

  @override
  String get signalLocationBadge => 'Location';

  @override
  String signalLocationPrivacyNote(int radiusMeters) {
    return 'Signal location uses mesh device position, rounded to ~${radiusMeters}m.';
  }

  @override
  String get signalLocationUnavailableSent =>
      'Location unavailable, sent without location.';

  @override
  String signalMaxFileSize(int size) {
    return 'Max $size KB';
  }

  @override
  String signalMaxImagesAllowed(int maxImages) {
    return 'Maximum of $maxImages images allowed';
  }

  @override
  String get signalMeshOnlyDebugBanner =>
      'Mesh-only debug mode enabled. Signals use local DB + mesh only.';

  @override
  String get signalMeshOnlyDebugCloudDisabled =>
      'Mesh-only debug mode enabled. Cloud features disabled.';

  @override
  String get signalNoCommentsYet => 'No comments yet';

  @override
  String get signalNoDeviceConnectedTooltip => 'No device connected';

  @override
  String get signalNoDeviceLocation => 'No connected device location available';

  @override
  String get signalNoFilterMatch => 'No signals match this filter';

  @override
  String get signalNoIntent => 'No intent';

  @override
  String get signalNoLocationDescription =>
      'Signals will appear here when they include GPS coordinates';

  @override
  String get signalNoLocationTitle => 'No signals with location';

  @override
  String get signalNoSignals => 'No signals';

  @override
  String get signalOfflineCloudUnavailable =>
      'Offline: images and cloud features unavailable.';

  @override
  String signalOnMapCount(int count) {
    return '$count on map';
  }

  @override
  String get signalOriginCloud => 'Cloud';

  @override
  String get signalOriginMesh => 'Mesh';

  @override
  String signalPeopleActiveCount(int count) {
    return '$count people active';
  }

  @override
  String get signalProcessingImage => 'Processing image...';

  @override
  String get signalProfile => 'Profile';

  @override
  String get signalProximityDirect => 'direct';

  @override
  String signalProximityHops(int count) {
    return '$count hops';
  }

  @override
  String get signalProximityNearby => 'nearby';

  @override
  String get signalProximityOneHop => '1 hop';

  @override
  String get signalRemoveLocation => 'Remove location';

  @override
  String get signalRemoveVoteFailed => 'Failed to remove vote';

  @override
  String get signalRemovedFromSaved => 'Removed from saved';

  @override
  String get signalReplyAction => 'Reply';

  @override
  String signalReplyWithCount(int count) {
    return 'Reply ($count)';
  }

  @override
  String signalReplyingTo(String author) {
    return 'Replying to $author';
  }

  @override
  String get signalReport => 'Report';

  @override
  String get signalReportCopyright => 'Copyright violation';

  @override
  String signalReportFailed(String error) {
    return 'Failed to report: $error';
  }

  @override
  String get signalReportHarassment => 'Harassment or bullying';

  @override
  String get signalReportNudity => 'Nudity or sexual content';

  @override
  String get signalReportOther => 'Other';

  @override
  String get signalReportSpam => 'Spam or misleading';

  @override
  String get signalReportSubmitted => 'Report submitted. Thank you.';

  @override
  String get signalReportViolence => 'Violence or dangerous content';

  @override
  String get signalRespondToSignalHint => 'Respond to this signal...';

  @override
  String get signalRestore => 'Restore';

  @override
  String get signalRestored => 'Signal restored';

  @override
  String get signalRetrievingDeviceLocation => 'Retrieving device location...';

  @override
  String get signalSaved => 'Signal saved';

  @override
  String get signalSavedBadge => 'Saved';

  @override
  String get signalSearchHint => 'Search signals';

  @override
  String signalSeenCount(String formattedCount) {
    return 'Seen $formattedCount';
  }

  @override
  String get signalSelectUpToFourPhotos => 'Select up to 4 photos';

  @override
  String get signalSendASignal => 'Send a signal...';

  @override
  String get signalSendButton => 'Send Signal';

  @override
  String get signalSendResponseFailed => 'Failed to send response';

  @override
  String get signalSendSignal => 'Send signal';

  @override
  String get signalSending => 'Sending...';

  @override
  String get signalSendingLabel => 'Sending...';

  @override
  String get signalSent => 'Signal sent';

  @override
  String get signalSettings => 'Settings';

  @override
  String get signalShortStatusHint => 'e.g. \"On the trail near summit\"';

  @override
  String get signalShortStatusOptional => 'Short Status (optional)';

  @override
  String get signalShowAll => 'Show all signals';

  @override
  String get signalSignIn => 'Sign in';

  @override
  String get signalSignInForCloudFeatures =>
      'Sign in to enable images and cloud features.';

  @override
  String get signalSignInForImagesAndComments =>
      'Sign in for images and comments';

  @override
  String get signalSignInRequiredToComment => 'Sign in required to comment';

  @override
  String get signalSignInToViewMedia => 'Sign in to view attached media';

  @override
  String get signalSignInToVote => 'Sign in to vote on responses';

  @override
  String signalSignalsNearbyCount(int count) {
    return '$count signals nearby';
  }

  @override
  String get signalSomeone => 'Someone';

  @override
  String get signalSortByProximity => 'By Proximity';

  @override
  String get signalSortClosest => 'Closest';

  @override
  String get signalSortExpiring => 'Expiring';

  @override
  String get signalSortExpiringSoon => 'Expiring Soon';

  @override
  String get signalSortMostRecent => 'Most Recent';

  @override
  String get signalSortNewest => 'Newest';

  @override
  String get signalSwipeHide => 'Hide';

  @override
  String get signalSwipeSave => 'Save';

  @override
  String get signalSwipeUnsave => 'Unsave';

  @override
  String get signalSyncingMedia => 'Syncing media';

  @override
  String get signalTakePhoto => 'Take Photo';

  @override
  String get signalTapToSet => 'Tap to set';

  @override
  String get signalTapToView => 'Tap to view';

  @override
  String get signalTemporaryBanner =>
      'Signals are temporary. They fade automatically and exist only while active.';

  @override
  String signalTimeDaysAgo(int days) {
    return '${days}d ago';
  }

  @override
  String signalTimeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get signalTimeJustNow => 'Just now';

  @override
  String signalTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get signalTimeNowCompact => 'now';

  @override
  String signalTimeWeeksAgo(int weeks) {
    return '${weeks}w ago';
  }

  @override
  String signalTtlDaysLeft(int days) {
    return '${days}d left';
  }

  @override
  String get signalTtlExpired => 'Expired';

  @override
  String signalTtlHoursLeft(int hours) {
    return '${hours}h left';
  }

  @override
  String signalTtlMinutesLeft(int minutes) {
    return '${minutes}m left';
  }

  @override
  String signalTtlSecondsLeft(int seconds) {
    return '${seconds}s left';
  }

  @override
  String get signalUnknownAuthor => 'Unknown';

  @override
  String get signalUseCamera => 'Use camera';

  @override
  String get signalValidateImagesFailed => 'Failed to validate images';

  @override
  String signalValidatingImages(int count) {
    return 'Validating $count images...';
  }

  @override
  String get signalViewButton => 'View';

  @override
  String get signalViewGallery => 'View gallery';

  @override
  String get signalViewGrid => 'Grid view';

  @override
  String get signalViewList => 'List view';

  @override
  String get signalViewLocation => 'View Location';

  @override
  String get signalViewMap => 'Map view';

  @override
  String get signalVoteFailed => 'Failed to submit vote';

  @override
  String get signalWhatAreYouSignaling => 'What are you signaling?';

  @override
  String get signalWhyReportComment => 'Why are you reporting this comment?';

  @override
  String get signalWhyReportSignal => 'Why are you reporting this signal?';

  @override
  String get signalWriteReplyHint => 'Write a reply...';

  @override
  String get signalYouBadge => 'you';

  @override
  String get signalYourIntent => 'Your Intent';

  @override
  String get signalYourResponsibility => 'Your Responsibility';

  @override
  String get signalsFadeAutomatically =>
      'Signals fade automatically. Only what\'s still active can be seen.';

  @override
  String get signalsFeedTitle => 'Signals';

  @override
  String get signalsPanelTitle => 'Signals';

  @override
  String get socialAboutSensitiveContent => 'About Sensitive Content';

  @override
  String get socialAccountGoodStanding => 'Account in Good Standing';

  @override
  String get socialAccountGoodStandingDesc =>
      'You have no active warnings or strikes.';

  @override
  String get socialAccountGoodStandingLabel => 'Good Standing';

  @override
  String get socialAccountMaxStrikes => 'Max Strikes';

  @override
  String get socialAccountRecentActivity => 'Recent Activity';

  @override
  String get socialAccountStatusActive => 'Active';

  @override
  String socialAccountStatusError(String error) {
    return 'Error loading status: $error';
  }

  @override
  String get socialAccountStatusLabel => 'Account Status';

  @override
  String get socialAccountStatusTitle => 'Account Status';

  @override
  String get socialAccountStrike1 => 'First offense. Review our guidelines.';

  @override
  String get socialAccountStrike2 =>
      'Second offense. One more and your account will be suspended.';

  @override
  String get socialAccountStrike3 => 'Account will be suspended.';

  @override
  String get socialAccountStrikeMeter => 'Strike Meter';

  @override
  String get socialAccountStrikes => 'Strikes';

  @override
  String get socialAccountSuspended => 'Suspended';

  @override
  String get socialAccountSuspendedTitle => 'Account Suspended';

  @override
  String get socialAccountWarningStrikesActive => 'Warning: Strikes Active';

  @override
  String get socialAccountWarnings => 'Warnings';

  @override
  String get socialAccountWarningsActive => 'Warnings Active';

  @override
  String get socialActiveStrikes => 'Active Strikes';

  @override
  String get socialActiveWarnings => 'Active Warnings';

  @override
  String get socialActivityAllRead => 'All activity marked as read';

  @override
  String get socialActivityClearAll => 'Clear all';

  @override
  String get socialActivityClearConfirmLabel => 'Clear';

  @override
  String get socialActivityClearConfirmMessage =>
      'This will remove all activity items. This cannot be undone.';

  @override
  String get socialActivityClearConfirmTitle => 'Clear all activity?';

  @override
  String get socialActivityCleared => 'Activity cleared';

  @override
  String get socialActivityCommentedPost => ' commented on your post';

  @override
  String get socialActivityCommentedSignal => ' commented on your signal';

  @override
  String get socialActivityErrorLoading => 'Failed to load activity';

  @override
  String get socialActivityFollowRequest => ' requested to follow you';

  @override
  String get socialActivityFollowed => ' started following you';

  @override
  String get socialActivityGroupEarlier => 'Earlier';

  @override
  String get socialActivityGroupThisMonth => 'This Month';

  @override
  String get socialActivityGroupThisWeek => 'This Week';

  @override
  String get socialActivityGroupToday => 'Today';

  @override
  String get socialActivityGroupYesterday => 'Yesterday';

  @override
  String get socialActivityInteracted => ' interacted with your content';

  @override
  String get socialActivityLikedComment => ' liked your comment';

  @override
  String get socialActivityLikedPost => ' liked your post';

  @override
  String get socialActivityLikedSignal => ' liked your signal';

  @override
  String get socialActivityLikedStory => ' liked your story';

  @override
  String get socialActivityLoadingSignal => 'Loading Signal...';

  @override
  String get socialActivityMarkAllRead => 'Mark all as read';

  @override
  String get socialActivityRepliedComment => ' replied to your comment';

  @override
  String get socialActivitySignalNotFound => 'Signal not found';

  @override
  String get socialActivityTagline1 =>
      'No activity yet.\nInteractions with your posts appear here.';

  @override
  String get socialActivityTagline2 =>
      'Likes, comments, follows — all in one place.\nPost something to get started.';

  @override
  String get socialActivityTagline3 =>
      'Your social pulse starts here.\nConnect with others to see activity.';

  @override
  String get socialActivityTagline4 =>
      'Nothing yet. Activity appears as others\ninteract with your content.';

  @override
  String get socialActivityTitle => 'Activity';

  @override
  String get socialActivityTitleKeyword => 'activity';

  @override
  String get socialActivityTitlePrefix => 'No ';

  @override
  String get socialActivityTitleSuffix => ' yet';

  @override
  String get socialActivityViewedStory => ' viewed your story';

  @override
  String get socialAdd => 'Add';

  @override
  String get socialAddBanner => 'Add banner';

  @override
  String get socialAlbumAll => 'All Albums';

  @override
  String get socialAlbumFavorites => 'Favorites';

  @override
  String get socialAlbumRecents => 'Recents';

  @override
  String get socialAlbumVideos => 'Videos';

  @override
  String get socialAppealDecision => 'Appeal Decision';

  @override
  String get socialAuthorLabel => 'Author: ';

  @override
  String get socialBanReasonHarassment => 'Harassment / Bullying';

  @override
  String get socialBanReasonHateSpeech => 'Hate speech / Discrimination';

  @override
  String get socialBanReasonIllegal => 'Illegal activity';

  @override
  String get socialBanReasonImpersonation => 'Impersonation';

  @override
  String get socialBanReasonOther => 'Other violation';

  @override
  String get socialBanReasonPornography => 'Pornography / Sexual content';

  @override
  String get socialBanReasonSpam => 'Spam / Scam';

  @override
  String get socialBanReasonViolence => 'Violence / Threats';

  @override
  String get socialBanSelectReason => 'Select ban reason';

  @override
  String get socialBanSendEmail => 'Send notification email to user';

  @override
  String get socialBanSendEmailDesc =>
      'Inform them why their account was banned';

  @override
  String get socialBanUserAndDelete => 'Ban User & Delete';

  @override
  String get socialBanUserButton => 'Ban User';

  @override
  String get socialBanUserDesc => 'This will permanently disable their account';

  @override
  String socialBanUserFailed(String error) {
    return 'Failed to ban user: $error';
  }

  @override
  String get socialBanUserIdLabel => 'User ID: ';

  @override
  String get socialBanUserTitle => 'Ban User';

  @override
  String socialBannerRemoveFailed(String error) {
    return 'Failed to remove banner: $error';
  }

  @override
  String get socialBannerRemoved => 'Banner removed';

  @override
  String get socialBannerUpdated => 'Banner updated';

  @override
  String socialBannerUploadFailed(String error) {
    return 'Failed to upload banner: $error';
  }

  @override
  String get socialBlock => 'Block';

  @override
  String get socialBlockUser => 'Block User';

  @override
  String get socialBlockUserConfirm =>
      'You will no longer see posts from this user.';

  @override
  String get socialBlurSensitiveDesc =>
      'Blur potentially sensitive images and videos until you tap to reveal';

  @override
  String get socialBlurSensitiveMedia => 'Blur Sensitive Media';

  @override
  String get socialCancel => 'Cancel';

  @override
  String get socialCannotIdentifyUser => 'Cannot identify user to ban';

  @override
  String get socialChangeBanner => 'Change banner';

  @override
  String get socialClose => 'Close';

  @override
  String socialCommentActionFailed(String error) {
    return 'Failed: $error';
  }

  @override
  String get socialCommentDeleteConfirm =>
      'Are you sure you want to delete this comment?';

  @override
  String socialCommentDeleteFailed(String error) {
    return 'Failed to delete: $error';
  }

  @override
  String get socialCommentDeleteTitle => 'Delete Comment';

  @override
  String get socialCommentHintAdd => 'Add a comment...';

  @override
  String get socialCommentHintReply => 'Write a reply...';

  @override
  String get socialCommentReply => 'Reply';

  @override
  String socialCommentReportFailed(String error) {
    return 'Failed to report: $error';
  }

  @override
  String get socialCommentReported => 'Comment reported';

  @override
  String get socialCommentUnknown => 'Unknown';

  @override
  String get socialComments => 'Comments';

  @override
  String get socialCommunityGuidelines => 'Community Guidelines';

  @override
  String get socialConfirm => 'Confirm';

  @override
  String get socialConnectionsTitle => 'Connections';

  @override
  String get socialContactSupport => 'Questions? Contact Support';

  @override
  String get socialContactSupportButton => 'Contact Support';

  @override
  String get socialContentIdNotFound => 'Content ID not found';

  @override
  String get socialContentNotAvailable => 'Content not available';

  @override
  String get socialContentRemoved => 'Content Removed';

  @override
  String get socialContentType => 'Content Type';

  @override
  String get socialContentUnavailable => 'Content unavailable';

  @override
  String get socialCreatePostAction => 'Create Post';

  @override
  String get socialCreatePostAddImage => 'Add image';

  @override
  String get socialCreatePostAddLocation => 'Add location';

  @override
  String get socialCreatePostButton => 'Post';

  @override
  String get socialCreatePostCreated => 'Post created!';

  @override
  String get socialCreatePostCurrentDesc => 'Share your GPS coordinates';

  @override
  String get socialCreatePostCurrentLocation => 'Current Location';

  @override
  String get socialCreatePostDiscardMsgDraft => 'Your draft will be lost.';

  @override
  String get socialCreatePostDiscardMsgImages =>
      'Your uploaded images will be deleted.';

  @override
  String get socialCreatePostDiscardTitle => 'Discard post?';

  @override
  String get socialCreatePostEnterLocation => 'Enter Location';

  @override
  String get socialCreatePostEnterManually => 'Enter Location Manually';

  @override
  String socialCreatePostFailed(String error) {
    return 'Failed to create post: $error';
  }

  @override
  String get socialCreatePostHint => 'What\'s happening on the mesh?';

  @override
  String socialCreatePostImageCount(int count, int max) {
    return '$count/$max images';
  }

  @override
  String get socialCreatePostImageViolation =>
      'One or more images violated content policy.';

  @override
  String get socialCreatePostLocationDenied => 'Location permission denied';

  @override
  String get socialCreatePostLocationHint => 'e.g., San Francisco, CA';

  @override
  String get socialCreatePostLocationLabel => 'Location';

  @override
  String get socialCreatePostLocationSheetTitle => 'Add Location';

  @override
  String get socialCreatePostManualDesc => 'Type in a place name';

  @override
  String socialCreatePostMaxImages(int max) {
    return 'Maximum $max images allowed';
  }

  @override
  String get socialCreatePostNoNodes =>
      'No nodes available. Connect to a mesh first.';

  @override
  String socialCreatePostNodeLabel(String nodeId) {
    return 'Node $nodeId';
  }

  @override
  String get socialCreatePostSignIn => 'Sign in to create posts';

  @override
  String get socialCreatePostTagNode => 'Tag node';

  @override
  String get socialCreatePostTagNodeTitle => 'Tag a Node';

  @override
  String get socialCreatePostTitle => 'Create Post';

  @override
  String get socialCreatePostUseCurrent => 'Use Current Location';

  @override
  String get socialCreateStoryCamera => 'Camera';

  @override
  String get socialCreateStoryCloseFriends => 'Close Friends';

  @override
  String get socialCreateStoryDelete => 'Delete';

  @override
  String get socialCreateStoryDragInstructions =>
      'Drag to move • Pinch to resize • Long press to delete';

  @override
  String get socialCreateStoryEdit => 'Edit';

  @override
  String get socialCreateStoryFailed => 'Failed to create story';

  @override
  String get socialCreateStoryFollowers => 'Followers';

  @override
  String socialCreateStoryItemsCount(int count) {
    return '$count items';
  }

  @override
  String get socialCreateStoryLinkNode => 'Link to Node';

  @override
  String get socialCreateStoryLocationFailed => 'Could not get location';

  @override
  String get socialCreateStoryLocationRequired =>
      'Location permission required';

  @override
  String get socialCreateStoryPublic => 'Public';

  @override
  String get socialCreateStoryShared => 'Story shared!';

  @override
  String get socialCreateStorySignIn => 'Sign in to create stories';

  @override
  String get socialCreateStoryTitle => 'Add to Story';

  @override
  String get socialCreateStoryTypeSomething => 'Type something...';

  @override
  String get socialCreateStoryUntitledAlbum => 'Untitled Album';

  @override
  String get socialDate => 'Date';

  @override
  String get socialDefault => 'Default';

  @override
  String get socialDelete => 'Delete';

  @override
  String get socialDeleteComment => 'Delete Comment';

  @override
  String get socialDeleteCommentConfirm =>
      'Are you sure you want to delete this comment?';

  @override
  String get socialDeletePost => 'Delete Post';

  @override
  String get socialDeletePostConfirm =>
      'Are you sure you want to delete this post?';

  @override
  String get socialDeleteStory => 'Delete story';

  @override
  String get socialDeleteStoryConfirm =>
      'This story will be permanently deleted.';

  @override
  String socialDeleteType(String type) {
    return 'Delete $type';
  }

  @override
  String socialDeleteTypeConfirm(String type) {
    return 'This will permanently delete the reported $type. Continue?';
  }

  @override
  String get socialDiscard => 'Discard';

  @override
  String socialDiscordCopied(String username) {
    return 'Discord username copied: $username';
  }

  @override
  String get socialDismiss => 'Dismiss';

  @override
  String get socialDisplayOptions => 'Display Options';

  @override
  String get socialDone => 'Done';

  @override
  String get socialEditProfile => 'Edit profile';

  @override
  String get socialEmailCopied => 'Email copied to clipboard';

  @override
  String get socialEmptyPostsTagline1 =>
      'Share photos and stories about your mesh adventures.';

  @override
  String get socialEmptyPostsTagline2 =>
      'Post about your node setups, range tests, and discoveries.';

  @override
  String get socialEmptyPostsTagline3 =>
      'Your mesh community is waiting to see what you build.';

  @override
  String get socialEmptyPostsTagline4 =>
      'Document your adventures and share them with the mesh.';

  @override
  String get socialErrorLoadingReports => 'Error loading reports';

  @override
  String get socialErrorLoadingViewers => 'Error loading viewers';

  @override
  String get socialExpires => 'Expires';

  @override
  String get socialFeedLocationFallback => 'Location';

  @override
  String get socialFilterAll => 'All';

  @override
  String get socialFilterLevelLess => 'Less';

  @override
  String get socialFilterLevelLessDesc =>
      'You may see some content that could be upsetting or offensive. This setting errs on the side of showing more content.';

  @override
  String get socialFilterLevelStandard => 'Standard';

  @override
  String get socialFilterLevelStandardDesc =>
      'Content that may be upsetting or offensive is filtered. You may still see some borderline content.';

  @override
  String get socialFilterLocation => 'Location';

  @override
  String get socialFilterNodes => 'Nodes';

  @override
  String get socialFilterPhotos => 'Photos';

  @override
  String get socialFollow => 'Follow';

  @override
  String socialFollowActionFailed(String error) {
    return 'Failed: $error';
  }

  @override
  String socialFollowFailed(String error) {
    return 'Failed to update follow: $error';
  }

  @override
  String get socialFollowRequestAcceptFailed => 'Failed to accept request';

  @override
  String socialFollowRequestAccepted(String name) {
    return 'Accepted $name\'s request';
  }

  @override
  String get socialFollowRequestDeclineFailed => 'Failed to decline request';

  @override
  String socialFollowRequestDeclined(String name) {
    return 'Declined $name\'s request';
  }

  @override
  String get socialFollowRequestsEmpty => 'No pending requests';

  @override
  String get socialFollowRequestsEmptyDesc =>
      'When someone requests to follow you, it will appear here.';

  @override
  String socialFollowRequestsError(String error) {
    return 'Failed to load: $error';
  }

  @override
  String get socialFollowRequestsTitle => 'Follow Requests';

  @override
  String socialFollowersAndPosts(String followers, String posts) {
    return '$followers followers • $posts posts';
  }

  @override
  String socialFollowersError(String error) {
    return 'Failed to load: $error';
  }

  @override
  String get socialFollowing => 'Following';

  @override
  String get socialGuidelineNoExplicit => 'No explicit or adult content';

  @override
  String get socialGuidelineNoHarassment =>
      'No harassment, threats, or hate speech';

  @override
  String get socialGuidelineNoSpam => 'No spam, scams, or misleading content';

  @override
  String get socialGuidelineRespectful => 'Be respectful and constructive';

  @override
  String get socialGuidelinesWarning => 'Community Guidelines Warning';

  @override
  String get socialHubSignIn => 'Sign in to access Social';

  @override
  String get socialHubSignInDesc =>
      'Create posts, follow users, and connect with the mesh community.';

  @override
  String get socialHubTitle => 'Social';

  @override
  String get socialIUnderstand => 'I Understand';

  @override
  String get socialImageUnavailable => 'Image unavailable';

  @override
  String socialJoined(String date) {
    return 'Joined $date';
  }

  @override
  String get socialLike => 'Like';

  @override
  String get socialLiked => 'Liked';

  @override
  String get socialLinkNodeHint => 'Link a mesh node to your next post';

  @override
  String get socialLocationFallback => 'Location';

  @override
  String socialMediaLabel(String type) {
    return 'Media ($type)';
  }

  @override
  String get socialModerationAdditionalNotes => 'Additional notes (optional)';

  @override
  String get socialModerationApprove => 'Approve';

  @override
  String get socialModerationApproved => 'Content approved';

  @override
  String get socialModerationErrorLoading => 'Error loading queue';

  @override
  String get socialModerationNoPending => 'No items pending review';

  @override
  String socialModerationNoStatus(String status) {
    return 'No $status items';
  }

  @override
  String get socialModerationQueueTitle => 'Moderation Queue';

  @override
  String get socialModerationReasonHarassment => 'Harassment or bullying';

  @override
  String get socialModerationReasonHateSpeech =>
      'Hate speech or discrimination';

  @override
  String get socialModerationReasonIP => 'Intellectual property violation';

  @override
  String get socialModerationReasonNudity => 'Nudity or sexual content';

  @override
  String get socialModerationReasonOther => 'Other policy violation';

  @override
  String get socialModerationReasonSpam => 'Spam or misleading content';

  @override
  String get socialModerationReasonViolence => 'Violence or dangerous content';

  @override
  String get socialModerationReject => 'Reject';

  @override
  String get socialModerationRejected => 'Content rejected';

  @override
  String get socialModerationRejectionReason => 'Rejection Reason';

  @override
  String socialModerationReviewedBy(String reviewedBy) {
    return 'Reviewed by $reviewedBy';
  }

  @override
  String get socialModerationTabApproved => 'Approved';

  @override
  String get socialModerationTabPending => 'Pending';

  @override
  String get socialModerationTabRejected => 'Rejected';

  @override
  String socialModerationUserLabel(String userId) {
    return 'User: $userId';
  }

  @override
  String get socialNext => 'Next';

  @override
  String get socialNoAlbumsFound => 'No albums found';

  @override
  String get socialNoCommentsYet => 'No comments yet. Be the first!';

  @override
  String get socialNoContent => 'No content';

  @override
  String get socialNoFollowersYet => 'No followers yet';

  @override
  String get socialNoLocationPosts => 'No location posts';

  @override
  String get socialNoNodePosts => 'No node posts';

  @override
  String socialNoPendingFilterReports(String filter) {
    return 'No pending $filter reports';
  }

  @override
  String get socialNoPendingReports => 'No pending reports';

  @override
  String get socialNoPhotoPosts => 'No photo posts';

  @override
  String get socialNoPosts => 'No posts';

  @override
  String get socialNoPostsYet => 'No posts yet';

  @override
  String get socialNoReasonProvided => 'No reason provided';

  @override
  String get socialNoRecentActivity => 'No recent activity';

  @override
  String get socialNoSuggestions => 'No suggestions available';

  @override
  String get socialNoUsersFound => 'No users found';

  @override
  String get socialNoViewsYet => 'No views yet';

  @override
  String socialNodeLabel(String nodeId) {
    return 'Node $nodeId';
  }

  @override
  String get socialNotFollowingAnyone => 'Not following anyone yet';

  @override
  String socialNoticesCount(int current, int total) {
    return '$current of $total notices';
  }

  @override
  String get socialOK => 'OK';

  @override
  String get socialOnline => 'Online';

  @override
  String get socialOpenSettings => 'Open Settings';

  @override
  String get socialPermanentlyBanned => 'Permanently Banned';

  @override
  String get socialPhotoAccessDesc =>
      'To create stories, we need access to your photo library.';

  @override
  String get socialPhotoAccessTitle => 'Allow access to your photos';

  @override
  String get socialPostCardLocationFallback => 'Location';

  @override
  String socialPostCardNodeLabel(String nodeId) {
    return 'Node $nodeId';
  }

  @override
  String get socialPostCardUnknownUser => 'Unknown User';

  @override
  String get socialPostDeleted => 'Post deleted';

  @override
  String get socialPostDetailTitle => 'Post';

  @override
  String get socialPostNotFound => 'Post not found';

  @override
  String get socialPostNotFoundForComment => 'Post not found for this comment';

  @override
  String get socialPrivateAccount => 'This Account is Private';

  @override
  String socialPrivateAccountDesc(String name) {
    return 'Follow $name to see their posts and linked devices.';
  }

  @override
  String get socialProfileBlockLabel => 'Block';

  @override
  String get socialProfileLoadFailed => 'Failed to load profile';

  @override
  String get socialProfileNotFound => 'Profile not found';

  @override
  String get socialProfileNotFoundDesc =>
      'This profile may have been removed or is temporarily unavailable.';

  @override
  String get socialProfileReportLabel => 'Report';

  @override
  String get socialProfileShareLabel => 'Share Profile';

  @override
  String get socialReason => 'Reason';

  @override
  String get socialRecentFailed => 'Failed to load recent users';

  @override
  String get socialRecentlyActive => 'Recently active';

  @override
  String get socialRejectDelete => 'Reject & Delete';

  @override
  String socialRejectDeleteMsg(String contentType) {
    return 'This will delete the $contentType and warn the user.';
  }

  @override
  String get socialRemoveBanner => 'Remove banner';

  @override
  String get socialReply => 'Reply';

  @override
  String socialReplyingTo(String name) {
    return 'Replying to $name';
  }

  @override
  String get socialReport => 'Report';

  @override
  String get socialReportCommentTitle => 'Report Comment';

  @override
  String get socialReportCommentWhy => 'Why are you reporting this comment?';

  @override
  String get socialReportDescribeIssue => 'Describe the issue...';

  @override
  String get socialReportDismissed => 'Report dismissed';

  @override
  String get socialReportPost => 'Report Post';

  @override
  String get socialReportPostWhy => 'Why are you reporting this post?';

  @override
  String get socialReportProfileSubmitted => 'Report submitted';

  @override
  String get socialReportReasonFalseInfo => 'False information';

  @override
  String get socialReportReasonHarassment => 'Harassment or bullying';

  @override
  String get socialReportReasonHateSpeech => 'Hate speech';

  @override
  String get socialReportReasonNudity => 'Nudity or sexual content';

  @override
  String get socialReportReasonOther => 'Other';

  @override
  String get socialReportReasonSpam => 'Spam';

  @override
  String get socialReportReasonViolence => 'Violence or threats';

  @override
  String get socialReportStory => 'Report story';

  @override
  String get socialReportStoryReasonCopyright => 'Copyright violation';

  @override
  String get socialReportStoryReasonHarassment => 'Harassment or bullying';

  @override
  String get socialReportStoryReasonNudity => 'Nudity or sexual content';

  @override
  String get socialReportStoryReasonOther => 'Other';

  @override
  String get socialReportStoryReasonSpam => 'Spam or misleading';

  @override
  String get socialReportStoryReasonViolence => 'Violence or dangerous content';

  @override
  String get socialReportStoryWhy => 'Why are you reporting this story?';

  @override
  String get socialReportSubmitted => 'Report submitted. Thank you.';

  @override
  String get socialReportedContentApproved => 'Content approved';

  @override
  String get socialReportedContentRejected =>
      'Content rejected and user warned';

  @override
  String get socialReportedContentTitle => 'Reported Content';

  @override
  String get socialReportedErrorLoading => 'Error loading moderation queue';

  @override
  String get socialReportedNoFlagged => 'No flagged content';

  @override
  String get socialReportedNoFlaggedDesc =>
      'Auto-moderation has not flagged any content';

  @override
  String get socialReportedTabAll => 'All';

  @override
  String get socialReportedTabAuto => 'Auto';

  @override
  String get socialReportedTabComments => 'Comments';

  @override
  String get socialReportedTabPosts => 'Posts';

  @override
  String get socialReportedTabSigComments => 'Sig. Comments';

  @override
  String get socialReportedTabSignals => 'Signals';

  @override
  String get socialRequested => 'Requested';

  @override
  String get socialRetry => 'Retry';

  @override
  String socialSearchFailed(String error) {
    return 'Search failed: $error';
  }

  @override
  String get socialSearchHint => 'Search users...';

  @override
  String get socialSearchTitle => 'Search';

  @override
  String get socialSearchTooltip => 'Search';

  @override
  String get socialSendMessage => 'Send Message';

  @override
  String get socialSensitiveContentControl => 'Sensitive Content Control';

  @override
  String get socialSensitiveContentExplanation =>
      'Control what type of content you see in your feed. This affects AI-moderated content filtering across posts, signals, and stories.';

  @override
  String get socialSensitiveContentTitle => 'Sensitive Content';

  @override
  String get socialSettingsTooltip => 'Settings';

  @override
  String get socialShare => 'Share';

  @override
  String get socialShareFirstPostKeyword => 'post';

  @override
  String get socialShareFirstPostPrefix => 'Share your first ';

  @override
  String get socialSharePhotoHint => 'Share a photo post to see it here';

  @override
  String get socialSignIn => 'Sign In';

  @override
  String get socialSignInSubscriptions => 'Sign in to manage subscriptions';

  @override
  String get socialSignalCommentLabel => 'SIGNAL COMMENT';

  @override
  String get socialSignalContentNotAvailable => 'Signal content not available';

  @override
  String socialSignalIdLabel(String id) {
    return 'Signal: $id';
  }

  @override
  String get socialSignalLabel => 'SIGNAL';

  @override
  String get socialStatFollower => 'Follower';

  @override
  String get socialStatFollowers => 'Followers';

  @override
  String get socialStatFollowing => 'Following';

  @override
  String get socialStatPost => 'Post';

  @override
  String get socialStatPosts => 'Posts';

  @override
  String get socialStatsBarFollowers => 'Followers';

  @override
  String get socialStatsBarFollowing => 'Following';

  @override
  String get socialStatsBarPosts => 'Posts';

  @override
  String get socialStatusFlagged => 'FLAGGED';

  @override
  String get socialStatusPending => 'PENDING';

  @override
  String get socialStatusRejected => 'REJECTED';

  @override
  String get socialStatusStrike => 'STRIKE';

  @override
  String get socialStatusSuspended => 'SUSPENDED';

  @override
  String get socialStoryBarAdd => 'Add';

  @override
  String get socialStoryContentUnavailable => 'Content unavailable';

  @override
  String socialStoryDeleteFailed(String error) {
    return 'Failed to delete story: $error';
  }

  @override
  String get socialStoryDeleted => 'Story deleted';

  @override
  String get socialStoryLabel => 'STORY';

  @override
  String get socialStoryMayBeRemoved => 'This story may have been removed';

  @override
  String get socialStoryReported => 'Story reported. We\'ll review it soon.';

  @override
  String get socialStoryUserFallback => 'User';

  @override
  String get socialStrike3Suspension =>
      '3 strikes result in account suspension';

  @override
  String get socialStrikeAcknowledge => 'I Understand';

  @override
  String get socialStrikeAgainstAccount => 'Strike Against Your Account';

  @override
  String socialStrikeContentLabel(String type) {
    return 'Content: $type';
  }

  @override
  String socialStrikeContentTitle(String typeDisplayName) {
    return 'Content $typeDisplayName';
  }

  @override
  String socialStrikeError(String error) {
    return 'Error: $error';
  }

  @override
  String get socialStrikeNext => 'Next';

  @override
  String socialStrikeOfTotal(int current, int total) {
    return '$current of $total';
  }

  @override
  String get socialStrikeReasonLabel => 'Reason';

  @override
  String get socialStrikeReceivedStrike =>
      'You have received a strike on your account due to a community guideline violation.';

  @override
  String get socialStrikeReceivedWarning =>
      'You have received a warning. Please review our community guidelines.';

  @override
  String socialStrikeTapReview(int count) {
    return 'You have $count strike(s) - tap to review';
  }

  @override
  String get socialStrikesExpireInfo =>
      'Strikes expire after 90 days of no violations.';

  @override
  String socialStrikesOnAccount(int count) {
    return '$count active strike(s) on your account';
  }

  @override
  String get socialSubscribe => 'Subscribe';

  @override
  String get socialSubscribed => 'Subscribed';

  @override
  String socialSubscriptionFailed(String error) {
    return 'Failed to update subscription: $error';
  }

  @override
  String get socialSuggestedForYou => 'Suggested for you';

  @override
  String get socialSuggestionsFailed => 'Failed to load suggestions';

  @override
  String get socialSuspendedContactSupport =>
      'Contact support to appeal this decision';

  @override
  String socialSuspendedDaysPlural(int n) {
    return '$n days';
  }

  @override
  String socialSuspendedDaysSingular(int n) {
    return '$n day';
  }

  @override
  String get socialSuspendedDefaultReason =>
      'Your account has been suspended due to repeated violations of our community guidelines.';

  @override
  String get socialSuspendedGoBack => 'Go back';

  @override
  String socialSuspendedHoursPlural(int n) {
    return '$n hours';
  }

  @override
  String socialSuspendedHoursSingular(int n) {
    return '$n hour';
  }

  @override
  String get socialSuspendedIndefinite => 'Indefinite suspension';

  @override
  String get socialSuspendedIndefinitely => 'indefinitely';

  @override
  String get socialSuspendedLabel => 'Suspended';

  @override
  String socialSuspendedMinutesPlural(int n) {
    return '$n minutes';
  }

  @override
  String socialSuspendedMinutesSingular(int n) {
    return '$n minute';
  }

  @override
  String get socialSuspendedPermanent => 'Account Suspended';

  @override
  String socialSuspendedRemaining(String duration) {
    return 'Remaining: $duration';
  }

  @override
  String get socialSuspendedReviewGuidelines =>
      'Review our community guidelines';

  @override
  String get socialSuspendedShortly => 'shortly';

  @override
  String socialSuspendedStrikesCount(int count) {
    return '$count strike(s) on your account';
  }

  @override
  String get socialSuspendedTemporary => 'Posting Temporarily Suspended';

  @override
  String get socialSuspendedWaitAppeal => 'Wait for your appeal to be reviewed';

  @override
  String get socialSuspendedWaitPeriod =>
      'Wait for the suspension period to end';

  @override
  String get socialSuspendedWhatCanIDo => 'What can I do?';

  @override
  String get socialSuspendedWhyTitle => 'Why am I seeing this?';

  @override
  String get socialSuspensionEnds => 'Suspension Ends';

  @override
  String get socialTabFollowers => 'Followers';

  @override
  String get socialTabFollowing => 'Following';

  @override
  String get socialTagLocationHint => 'Tag a location in your next post';

  @override
  String socialTimeDaysAgo(int n) {
    return '${n}d ago';
  }

  @override
  String socialTimeHoursAgo(int n) {
    return '${n}h ago';
  }

  @override
  String get socialTimeJustNow => 'Just now';

  @override
  String socialTimeMinutesAgo(int n) {
    return '${n}m ago';
  }

  @override
  String get socialTryDifferentFilter => 'Try selecting a different filter';

  @override
  String get socialTryDifferentSearch => 'Try a different search term';

  @override
  String socialTypeDeleted(String type) {
    return '$type deleted';
  }

  @override
  String get socialUnfollow => 'Unfollow';

  @override
  String get socialUnknownUser => 'Unknown User';

  @override
  String get socialUnsubscribed => 'Unsubscribed';

  @override
  String get socialUnsuspend => 'Unsuspend';

  @override
  String get socialUnsuspendConfirm =>
      'Are you sure you want to lift the suspension on this user?';

  @override
  String get socialUnsuspendUser => 'Unsuspend User';

  @override
  String socialUserBannedAndDeleted(String type) {
    return 'User banned and $type deleted';
  }

  @override
  String get socialUserBlocked => 'User blocked';

  @override
  String socialUserBlockedName(String name) {
    return '$name blocked';
  }

  @override
  String get socialUserFallback => 'User';

  @override
  String get socialUserUnsuspended => 'User unsuspended successfully';

  @override
  String get socialVideoContent => 'Video content';

  @override
  String get socialView => 'View';

  @override
  String get socialViewLabel => 'view';

  @override
  String get socialViewLocation => 'View location';

  @override
  String get socialViewOnMap => 'View on Map';

  @override
  String get socialViewersTitle => 'Viewers';

  @override
  String get socialViewsLabel => 'views';

  @override
  String get socialViolationsDetected => 'Violations Detected';

  @override
  String get socialVisibilityFollowers => 'Followers';

  @override
  String get socialVisibilityFollowersDesc =>
      'Only your followers can see this';

  @override
  String get socialVisibilityOnlyMe => 'Only me';

  @override
  String get socialVisibilityOnlyMeDesc => 'Only you can see this post';

  @override
  String get socialVisibilityPublic => 'Public';

  @override
  String get socialVisibilityPublicDesc => 'Anyone can see this post';

  @override
  String get socialVisibilityWhoCanSee => 'Who can see this?';

  @override
  String socialWarningsOnAccount(int count) {
    return '$count active warning(s) on your account';
  }

  @override
  String socialWarningsTapReview(int count) {
    return 'You have $count warning(s) - tap to review';
  }

  @override
  String get socialYourStory => 'Your story';

  @override
  String get takAffiliationAssumedFriend => 'Assumed Friend';

  @override
  String get takAffiliationFriendly => 'Friendly';

  @override
  String get takAffiliationHostile => 'Hostile';

  @override
  String get takAffiliationNeutral => 'Neutral';

  @override
  String get takAffiliationPending => 'Pending';

  @override
  String get takAffiliationSuspect => 'Suspect';

  @override
  String get takAffiliationUnknown => 'Unknown';

  @override
  String get takCompassE => 'E';

  @override
  String get takCompassN => 'N';

  @override
  String get takCompassNE => 'NE';

  @override
  String get takCompassNW => 'NW';

  @override
  String get takCompassS => 'S';

  @override
  String get takCompassSE => 'SE';

  @override
  String get takCompassSW => 'SW';

  @override
  String get takCompassW => 'W';

  @override
  String get takCotTypeAtom => 'Atom';

  @override
  String get takCotTypeBits => 'Bits';

  @override
  String get takCotTypeFriendly => 'Friendly';

  @override
  String get takCotTypeHostile => 'Hostile';

  @override
  String get takCotTypeNeutral => 'Neutral';

  @override
  String get takCotTypeTasking => 'Tasking';

  @override
  String get takCotTypeUnknown => 'Unknown';

  @override
  String get takDashboardConnected => 'Connected';

  @override
  String get takDashboardConnection => 'Connection';

  @override
  String get takDashboardDisconnected => 'Disconnected';

  @override
  String get takDashboardForceDisposition => 'Force Disposition';

  @override
  String get takDashboardFriendly => 'Friendly';

  @override
  String get takDashboardHostile => 'Hostile';

  @override
  String get takDashboardLastEvent => 'Last event';

  @override
  String get takDashboardLastEventNone => 'None';

  @override
  String takDashboardNearestHostile(String callsign) {
    return 'Nearest hostile: $callsign';
  }

  @override
  String takDashboardNearestUnknown(String callsign) {
    return 'Nearest unknown: $callsign';
  }

  @override
  String get takDashboardNeutral => 'Neutral';

  @override
  String get takDashboardNoHostileContacts => 'No hostile contacts';

  @override
  String get takDashboardNoUnknownContacts => 'No unknown contacts';

  @override
  String get takDashboardPositionPublishing => 'Position publishing';

  @override
  String takDashboardPublishingActive(String intervalSeconds) {
    return 'Active (${intervalSeconds}s)';
  }

  @override
  String get takDashboardPublishingDisabled => 'Disabled';

  @override
  String takDashboardRelativeTimeDays(int count) {
    return '${count}d ago';
  }

  @override
  String takDashboardRelativeTimeHours(int count) {
    return '${count}h ago';
  }

  @override
  String takDashboardRelativeTimeMinutes(int count) {
    return '${count}m ago';
  }

  @override
  String takDashboardRelativeTimeSeconds(int count) {
    return '${count}s ago';
  }

  @override
  String get takDashboardStaleEntities => 'Stale entities';

  @override
  String get takDashboardStatusHeader => 'Status';

  @override
  String get takDashboardThreatProximity => 'Threat Proximity';

  @override
  String get takDashboardTitle => 'SA Dashboard';

  @override
  String get takDashboardTotalEntities => 'Total entities';

  @override
  String get takDashboardTracked => 'Tracked';

  @override
  String get takDashboardUnknown => 'Unknown';

  @override
  String takDistanceKilometers(double km) {
    return '$km km';
  }

  @override
  String takDistanceMeters(double meters) {
    return '$meters m';
  }

  @override
  String takEventAltitudeFormat(double meters, String feet) {
    return '$meters m ($feet ft)';
  }

  @override
  String takEventCourseFormat(String degrees, String compassDirection) {
    return '$degrees° ($compassDirection)';
  }

  @override
  String get takEventDetailHelpAffiliation => 'Affiliation';

  @override
  String get takEventDetailHelpCotType => 'CoT Type String';

  @override
  String get takEventDetailHelpIdentity => 'Identity';

  @override
  String get takEventDetailHelpMotion => 'Motion Data';

  @override
  String get takEventDetailHelpPosition => 'Position';

  @override
  String get takEventDetailHelpRawPayload => 'Raw Payload';

  @override
  String get takEventDetailHelpTimestamps => 'Timestamps';

  @override
  String get takEventDetailHelpTracking => 'Tracking';

  @override
  String get takEventDetailJsonCopied => 'Event JSON copied';

  @override
  String get takEventDetailLabelAltitude => 'Altitude';

  @override
  String get takEventDetailLabelCallsign => 'Callsign';

  @override
  String get takEventDetailLabelCourse => 'Course';

  @override
  String get takEventDetailLabelDescription => 'Description';

  @override
  String get takEventDetailLabelEventTime => 'Event Time';

  @override
  String get takEventDetailLabelLatitude => 'Latitude';

  @override
  String get takEventDetailLabelLongitude => 'Longitude';

  @override
  String get takEventDetailLabelReceived => 'Received';

  @override
  String get takEventDetailLabelSpeed => 'Speed';

  @override
  String get takEventDetailLabelStaleTime => 'Stale Time';

  @override
  String get takEventDetailLabelStatus => 'Status';

  @override
  String get takEventDetailLabelType => 'Type';

  @override
  String get takEventDetailLabelUid => 'UID';

  @override
  String get takEventDetailNavigateTo => 'Navigate to';

  @override
  String get takEventDetailNoMovement => 'No movement recorded';

  @override
  String takEventDetailPositionCount(int count) {
    return '($count positions)';
  }

  @override
  String get takEventDetailSectionIdentity => 'Identity';

  @override
  String get takEventDetailSectionMotion => 'Motion';

  @override
  String get takEventDetailSectionPosition => 'Position';

  @override
  String get takEventDetailSectionPositionHistory => 'POSITION HISTORY';

  @override
  String get takEventDetailSectionRawPayload => 'Raw Payload';

  @override
  String get takEventDetailSectionTimestamps => 'Timestamps';

  @override
  String takEventDetailShowAllPositions(int count) {
    return 'Show all $count positions';
  }

  @override
  String get takEventDetailShowLess => 'Show less';

  @override
  String get takEventDetailStatusActive => 'ACTIVE';

  @override
  String get takEventDetailStatusStale => 'STALE';

  @override
  String get takEventDetailTooltipCopyJson => 'Copy JSON';

  @override
  String get takEventDetailTooltipShowOnMap => 'Show on Map';

  @override
  String get takEventDetailTooltipTrack => 'Track';

  @override
  String get takEventDetailTooltipUntrack => 'Untrack';

  @override
  String takEventSpeedFormat(String kmh, String knots) {
    return '$kmh km/h ($knots kn)';
  }

  @override
  String get takEventSpeedStationary => 'Stationary';

  @override
  String get takEventTileActive => 'Active';

  @override
  String takEventTileRelativeTimeHours(int count) {
    return '${count}h ago';
  }

  @override
  String takEventTileRelativeTimeMinutes(int count) {
    return '${count}m ago';
  }

  @override
  String takEventTileRelativeTimeSeconds(int count) {
    return '${count}s ago';
  }

  @override
  String get takEventTileStale => 'Stale';

  @override
  String get takFilterBarClear => 'Clear';

  @override
  String get takFilterBarSearchHint => 'Search callsign or UID...';

  @override
  String get takFilterBarStaleModeActive => 'Active';

  @override
  String get takFilterBarStaleModeAll => 'All';

  @override
  String get takFilterBarStaleModeStale => 'Stale';

  @override
  String takNavigateEta(String eta) {
    return 'ETA: $eta';
  }

  @override
  String get takNavigateLastUpdate => 'Last update';

  @override
  String get takNavigateNoPosition =>
      'Position unavailable\nConnect to a node with GPS';

  @override
  String get takNavigatePosition => 'Position';

  @override
  String takNavigateRelativeTimeDays(int count) {
    return '${count}d ago';
  }

  @override
  String takNavigateRelativeTimeHours(int count) {
    return '${count}h ago';
  }

  @override
  String takNavigateRelativeTimeMinutes(int count) {
    return '${count}m ago';
  }

  @override
  String takNavigateRelativeTimeSeconds(int count) {
    return '${count}s ago';
  }

  @override
  String takNavigateTitle(String callsign) {
    return 'Navigate to $callsign';
  }

  @override
  String takNavigationEtaHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String get takNavigationEtaLessThanOneMin => '< 1 min';

  @override
  String takNavigationEtaMinutes(int count) {
    return '$count min';
  }

  @override
  String takNavigationTargetMoving(int speed) {
    return 'Target moving at $speed km/h';
  }

  @override
  String takNavigationTargetMovingWithDirection(String direction, int speed) {
    return 'Target moving $direction at $speed km/h';
  }

  @override
  String get takNavigationTargetStationary => 'Target stationary';

  @override
  String takProximityAlertMovingBody(
    String affiliation,
    int distance,
    String heading,
    int speed,
  ) {
    return '$affiliation entity at $distance -- heading $heading at $speed km/h';
  }

  @override
  String takProximityAlertStationaryBody(String affiliation, int distance) {
    return '$affiliation entity at $distance -- stationary';
  }

  @override
  String get takScreenButtonConnect => 'Connect';

  @override
  String get takScreenButtonSignIn => 'Sign In to Connect';

  @override
  String get takScreenEmptyDisconnected =>
      'Connect to the TAK Gateway to start streaming CoT entities.';

  @override
  String get takScreenEmptyListening =>
      'Listening for CoT events from the TAK Gateway...';

  @override
  String get takScreenEmptySignIn =>
      'Sign in and connect to start receiving live CoT entities.';

  @override
  String get takScreenEmptyTitle => 'No TAK Entities';

  @override
  String get takScreenFilterAll => 'All';

  @override
  String get takScreenHelpTitleDefault => 'Info';

  @override
  String get takScreenHelpTitleFilters => 'Filters';

  @override
  String get takScreenHelpTitleSettings => 'Settings';

  @override
  String get takScreenHelpTitleStatus => 'Connection Status';

  @override
  String get takScreenOverflowDashboard => 'SA Dashboard';

  @override
  String get takScreenOverflowSettings => 'TAK Settings';

  @override
  String get takScreenSearchHint => 'Search callsign or UID';

  @override
  String get takScreenStaleModeActiveOnly => 'Active Only';

  @override
  String get takScreenStaleModeAll => 'Status: All';

  @override
  String get takScreenStaleModeStaleOnly => 'Stale Only';

  @override
  String get takScreenTitle => 'TAK Gateway';

  @override
  String get takScreenTooltipConnect => 'Connect';

  @override
  String get takScreenTooltipDisconnect => 'Disconnect';

  @override
  String get takScreenTooltipSignInToConnect => 'Sign in to connect';

  @override
  String get takSettingsAlertHostile => 'Hostile';

  @override
  String get takSettingsAlertOn => 'Alert on:';

  @override
  String get takSettingsAlertSuspect => 'Suspect';

  @override
  String get takSettingsAlertUnknown => 'Unknown';

  @override
  String get takSettingsAutoConnectSubtitle =>
      'Automatically connect when TAK screens open';

  @override
  String get takSettingsAutoConnectTitle => 'Auto-connect on open';

  @override
  String get takSettingsCallsignDefault => 'Using node name';

  @override
  String get takSettingsCallsignEditorHint =>
      'Leave empty to use your node name';

  @override
  String get takSettingsCallsignEditorPlaceholder => 'e.g., ALPHA-1';

  @override
  String get takSettingsCallsignEditorTitle => 'Callsign Override';

  @override
  String get takSettingsCallsignTitle => 'Callsign override';

  @override
  String takSettingsError(String error) {
    return 'Error: $error';
  }

  @override
  String get takSettingsGatewayEditorHint =>
      'Leave empty to use the default gateway';

  @override
  String get takSettingsGatewayEditorPlaceholder =>
      'https://tak.socialmesh.app';

  @override
  String get takSettingsGatewayEditorTitle => 'Gateway URL';

  @override
  String get takSettingsGatewayUrlDefault => 'Default (tak.socialmesh.app)';

  @override
  String get takSettingsGatewayUrlTitle => 'Gateway URL';

  @override
  String takSettingsIntervalMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String takSettingsIntervalSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get takSettingsIntervalSubtitle => 'How often to send your position';

  @override
  String get takSettingsIntervalTitle => 'Publish interval';

  @override
  String get takSettingsMapLayerSubtitle =>
      'Display TAK entity markers on the dedicated map';

  @override
  String get takSettingsMapLayerTitle => 'Show TAK layer on map';

  @override
  String get takSettingsProximitySubtitle =>
      'Notify when hostile/unknown entities enter radius';

  @override
  String get takSettingsProximityTitle => 'Enable proximity alerts';

  @override
  String get takSettingsPublishSubtitle =>
      'Share your node position with ATAK/WinTAK operators';

  @override
  String get takSettingsPublishTitle => 'Publish my position';

  @override
  String takSettingsRadiusSubtitle(double km) {
    return '$km km';
  }

  @override
  String get takSettingsRadiusTitle => 'Alert radius';

  @override
  String get takSettingsSave => 'Save';

  @override
  String get takSettingsSectionConnection => 'CONNECTION';

  @override
  String get takSettingsSectionMap => 'MAP';

  @override
  String get takSettingsSectionProximity => 'PROXIMITY ALERTS';

  @override
  String get takSettingsSectionPublishing => 'POSITION PUBLISHING';

  @override
  String get takSettingsTitle => 'TAK Settings';

  @override
  String get takStatusCardConnected => 'Connected';

  @override
  String get takStatusCardConnecting => 'Connecting...';

  @override
  String get takStatusCardCounterEntities => 'Entities';

  @override
  String get takStatusCardCounterEvents => 'Events';

  @override
  String get takStatusCardCounterUptime => 'Uptime';

  @override
  String get takStatusCardDisconnected => 'Disconnected';

  @override
  String get takStatusCardLabel => 'TAK Gateway';

  @override
  String get takStatusCardReconnecting => 'Reconnecting...';

  @override
  String takStatusCardUptimeHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String takStatusCardUptimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String takStatusCardUptimeSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get tapbackReact => 'React';

  @override
  String taskErrorCompleteTaskDenied(String roleName) {
    return 'completeTask denied for role $roleName';
  }

  @override
  String get taskErrorCompletionNoteRequired =>
      'Completion requires a note with at least 10 characters';

  @override
  String taskErrorCreateDenied(String roleName) {
    return 'createTask denied for role $roleName';
  }

  @override
  String get taskErrorFailureReasonRequired =>
      'Failure requires a reason with at least 10 characters';

  @override
  String taskErrorInvalidTransition(String fromState, String toState) {
    return '$fromState -> $toState is not a valid transition';
  }

  @override
  String get taskErrorOnlyAssigneeCanAcknowledge =>
      'Only the assignee can acknowledge a task';

  @override
  String get taskErrorOnlyAssigneeCanReportFailure =>
      'Only the assignee can report task failure';

  @override
  String get taskErrorOnlyAssigneeCanStartWork =>
      'Only the assignee can start work on a task';

  @override
  String get taskErrorReassignmentRequiresAssignee =>
      'Reassignment requires a newAssigneeId';

  @override
  String taskErrorRequiresSupervisorOrAdmin(String action, String roleName) {
    return '$action requires supervisor or admin role, current role: $roleName';
  }

  @override
  String taskErrorTerminalState(String stateName) {
    return 'Cannot transition from $stateName: terminal state: $stateName';
  }

  @override
  String get taskPriorityImmediate => 'immediate';

  @override
  String get taskPriorityPriority => 'priority';

  @override
  String get taskPriorityRoutine => 'routine';

  @override
  String get taskStateAcknowledged => 'acknowledged';

  @override
  String get taskStateAssigned => 'assigned';

  @override
  String get taskStateCancelled => 'cancelled';

  @override
  String get taskStateCompleted => 'completed';

  @override
  String get taskStateCreated => 'created';

  @override
  String get taskStateFailed => 'failed';

  @override
  String get taskStateInProgress => 'inProgress';

  @override
  String get taskStateReassigned => 'reassigned';

  @override
  String taskTransitionNoteAssignedTo(String assigneeId) {
    return 'Assigned to $assigneeId';
  }

  @override
  String get taskTransitionNoteCreated => 'Task created';

  @override
  String taskTransitionNoteCreatedViaReassignment(String originalTaskId) {
    return 'Task created via reassignment from $originalTaskId';
  }

  @override
  String taskTransitionNoteReassignedToNewTask(String newTaskId) {
    return 'Reassigned to new task $newTaskId';
  }

  @override
  String get telemetryAirQualityEmpty => 'No air quality data recorded yet';

  @override
  String get telemetryAirQualityLogTitle => 'Air Quality Log';

  @override
  String get telemetryAirQualityParticle03um => '>0.3µm';

  @override
  String get telemetryAirQualityParticle05um => '>0.5µm';

  @override
  String get telemetryAirQualityParticle100um => '>10µm';

  @override
  String get telemetryAirQualityParticle10um => '>1.0µm';

  @override
  String get telemetryAirQualityParticle25um => '>2.5µm';

  @override
  String get telemetryAirQualityParticle50um => '>5.0µm';

  @override
  String get telemetryAirQualityParticleCounts => 'Particle Counts (per 0.1L)';

  @override
  String get telemetryAirQualityParticulateEnvironmental =>
      'Particulate Matter (Environmental)';

  @override
  String get telemetryAirQualityParticulateStandard =>
      'Particulate Matter (Standard)';

  @override
  String get telemetryAirQualityPm100Label => 'PM10';

  @override
  String get telemetryAirQualityPm10Label => 'PM1.0';

  @override
  String get telemetryAirQualityPm25Label => 'PM2.5';

  @override
  String get telemetryAirQualityUnitMicrogram => 'µg/m³';

  @override
  String get telemetryAllNodes => 'All Nodes';

  @override
  String get telemetryAqiGood => 'Good';

  @override
  String get telemetryAqiHazardous => 'Hazardous';

  @override
  String get telemetryAqiModerate => 'Moderate';

  @override
  String get telemetryAqiUnhealthy => 'Unhealthy';

  @override
  String get telemetryAqiUnhealthySensitive => 'Unhealthy (S)';

  @override
  String get telemetryBatteryCharging => 'Charging';

  @override
  String get telemetryClearAllFilters => 'Clear all filters';

  @override
  String get telemetryClearConfirmLabel => 'Clear';

  @override
  String get telemetryClearData => 'Clear Data';

  @override
  String get telemetryClearDateFilterTooltip => 'Clear date filter';

  @override
  String get telemetryCo2Excellent => 'Excellent';

  @override
  String get telemetryCo2Fair => 'Fair';

  @override
  String get telemetryCo2Good => 'Good';

  @override
  String telemetryCo2LabelPrefix(String quality) {
    return 'CO₂ - $quality';
  }

  @override
  String get telemetryCo2Poor => 'Poor';

  @override
  String telemetryCo2Ppm(String ppm) {
    return '$ppm ppm';
  }

  @override
  String get telemetryConfigAirQualityDesc =>
      'PM1.0, PM2.5, PM10, particle counts, CO2';

  @override
  String get telemetryConfigAirtimeWarning =>
      'Telemetry data is shared with all nodes on the mesh network. Shorter intervals increase airtime usage.';

  @override
  String get telemetryConfigDeviceMetricsDesc =>
      'Battery level, voltage, channel utilization, air util TX';

  @override
  String get telemetryConfigDisplayFahrenheit => 'Display Fahrenheit';

  @override
  String get telemetryConfigDisplayFahrenheitSubtitle =>
      'Show temperature in Fahrenheit instead of Celsius';

  @override
  String get telemetryConfigDisplayOnScreen => 'Display on Screen';

  @override
  String get telemetryConfigDisplayOnScreenSubtitle =>
      'Show environment data on device screen';

  @override
  String get telemetryConfigEnabled => 'Enabled';

  @override
  String get telemetryConfigEnvironmentMetricsDesc =>
      'Temperature, humidity, barometric pressure, gas resistance';

  @override
  String get telemetryConfigMinutes => ' minutes';

  @override
  String get telemetryConfigPowerMetricsDesc =>
      'Voltage and current for channels 1-3';

  @override
  String get telemetryConfigSave => 'Save';

  @override
  String telemetryConfigSaveError(String error) {
    return 'Failed to save: $error';
  }

  @override
  String get telemetryConfigSaved => 'Telemetry config saved';

  @override
  String get telemetryConfigSectionAirQuality => 'Air Quality';

  @override
  String get telemetryConfigSectionDeviceMetrics => 'Device Metrics';

  @override
  String get telemetryConfigSectionEnvironmentMetrics => 'Environment Metrics';

  @override
  String get telemetryConfigSectionPowerMetrics => 'Power Metrics';

  @override
  String get telemetryConfigTitle => 'Telemetry';

  @override
  String get telemetryConfigUpdateInterval => 'Update Interval';

  @override
  String get telemetryDateRangeTooltip => 'Date range';

  @override
  String get telemetryDetectionClear => 'Clear';

  @override
  String get telemetryDetectionDetected => 'DETECTED';

  @override
  String get telemetryDetectionSensorDefault => 'Detection Sensor';

  @override
  String get telemetryDetectionSensorEmpty => 'No sensor events recorded yet';

  @override
  String get telemetryDetectionSensorLogTitle => 'Detection Sensor Log';

  @override
  String get telemetryDetectionSensorSubtitle =>
      'Detection sensors report motion and presence';

  @override
  String telemetryDeviceMetricsAirUtil(int percent) {
    return 'Air $percent%';
  }

  @override
  String telemetryDeviceMetricsChannelUtil(int percent) {
    return 'Ch $percent%';
  }

  @override
  String get telemetryDeviceMetricsTitle => 'Device Metrics';

  @override
  String telemetryDeviceMetricsVoltageValue(double voltage) {
    return '${voltage}V';
  }

  @override
  String get telemetryEndDate => 'End Date';

  @override
  String telemetryEnvGasResistanceValue(int value) {
    return '$value Ω';
  }

  @override
  String telemetryEnvHumidityValue(int value) {
    return '$value%';
  }

  @override
  String telemetryEnvIaqValue(int value) {
    return 'IAQ $value';
  }

  @override
  String telemetryEnvLuxValue(int value) {
    return '$value lux';
  }

  @override
  String telemetryEnvPressureValue(int value) {
    return '$value hPa';
  }

  @override
  String telemetryEnvTemperatureValue(int value) {
    return '$value°C';
  }

  @override
  String telemetryEnvWindSpeedValue(int value) {
    return '$value m/s';
  }

  @override
  String get telemetryEnvironmentMetricsTitle => 'Environment Metrics';

  @override
  String telemetryErrorPrefix(String error) {
    return 'Error: $error';
  }

  @override
  String get telemetryExportCsv => 'Export CSV';

  @override
  String telemetryExportFailed(String error) {
    return 'Export failed: $error';
  }

  @override
  String get telemetryExporting => 'Exporting...';

  @override
  String telemetryFailedToClearData(String error) {
    return 'Failed to clear data: $error';
  }

  @override
  String get telemetryFilterAirUtil => 'Air Util';

  @override
  String get telemetryFilterAll => 'All';

  @override
  String get telemetryFilterBattery => 'Battery';

  @override
  String get telemetryFilterChannel => 'Channel';

  @override
  String get telemetryFilterGas => 'Gas';

  @override
  String get telemetryFilterHumidity => 'Humidity';

  @override
  String get telemetryFilterIaq => 'IAQ';

  @override
  String get telemetryFilterLight => 'Light';

  @override
  String get telemetryFilterPressure => 'Pressure';

  @override
  String get telemetryFilterTemp => 'Temp';

  @override
  String get telemetryFilterUptime => 'Uptime';

  @override
  String get telemetryFilterVoltage => 'Voltage';

  @override
  String get telemetryFilterWind => 'Wind';

  @override
  String get telemetryHelp => 'Help';

  @override
  String get telemetryLegendAirUtil => 'Air Util';

  @override
  String get telemetryLegendBattery => 'Battery';

  @override
  String get telemetryLegendChUtil => 'Ch Util';

  @override
  String get telemetryLegendHumidity => 'Humidity';

  @override
  String get telemetryLegendTemperature => 'Temperature';

  @override
  String get telemetryLegendVoltage => 'Voltage';

  @override
  String get telemetryMapStyle => 'Map Style';

  @override
  String get telemetryMetricsWillAppear =>
      'Metrics will appear when your device reports telemetry';

  @override
  String get telemetryNoDeviceMetricsYet => 'No device metrics yet';

  @override
  String get telemetryNoEnvironmentMetricsYet => 'No environment metrics yet';

  @override
  String get telemetryNoMetricsMatchFilters => 'No metrics match filters';

  @override
  String get telemetryPaxBluetooth => 'Bluetooth';

  @override
  String get telemetryPaxCounterEmpty => 'No PAX data recorded yet';

  @override
  String get telemetryPaxCounterLogTitle => 'PAX Counter Log';

  @override
  String get telemetryPaxCounterSubtitle =>
      'PAX counter detects nearby devices';

  @override
  String telemetryPaxUptime(String uptime) {
    return 'Uptime: $uptime';
  }

  @override
  String telemetryPaxUptimeDaysHours(int days, int hours) {
    return '${days}d ${hours}h';
  }

  @override
  String telemetryPaxUptimeHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String telemetryPaxUptimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String telemetryPaxUptimeSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String get telemetryPaxWifi => 'WiFi';

  @override
  String telemetryPositionAltitude(double meters) {
    return '${meters}m';
  }

  @override
  String get telemetryPositionClearMessage =>
      'This will permanently delete all position history for all nodes. This cannot be undone.';

  @override
  String get telemetryPositionClearTitle => 'Clear Position Data';

  @override
  String telemetryPositionCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count position$_temp0';
  }

  @override
  String get telemetryPositionDataCleared => 'Position data cleared';

  @override
  String get telemetryPositionDateRange => 'Date range';

  @override
  String get telemetryPositionExportSubject => 'Socialmesh Position Export';

  @override
  String telemetryPositionExportedCount(int count) {
    return 'Exported $count positions';
  }

  @override
  String get telemetryPositionFilterGoodFix => 'Good Fix';

  @override
  String get telemetryPositionFilterMyNode => 'My Node';

  @override
  String get telemetryPositionFilterThisWeek => 'This Week';

  @override
  String get telemetryPositionFilterToday => 'Today';

  @override
  String get telemetryPositionListViewTooltip => 'List view';

  @override
  String get telemetryPositionMapViewTooltip => 'Map view';

  @override
  String get telemetryPositionNoDataExport => 'No position data to export';

  @override
  String get telemetryPositionNoHistory => 'No position history';

  @override
  String get telemetryPositionNoMatchFilters => 'No positions match filters';

  @override
  String get telemetryPositionNoPositionsToDisplay => 'No positions to display';

  @override
  String telemetryPositionNodeCount(int count) {
    return '$count nodes';
  }

  @override
  String get telemetryPositionNodeDrawerTitle => 'Nodes';

  @override
  String telemetryPositionSats(int count) {
    return '$count sats';
  }

  @override
  String get telemetryPositionShowAllNodes => 'All Nodes';

  @override
  String get telemetryPositionShowAllSubtitle =>
      'Show positions from all nodes';

  @override
  String telemetryPositionSpeed(int speed) {
    return '$speed km/h';
  }

  @override
  String get telemetryPositionStatDistance => 'Distance';

  @override
  String get telemetryPositionStatNodes => 'Nodes';

  @override
  String get telemetryPositionStatPoints => 'Points';

  @override
  String get telemetryPositionTitle => 'Position';

  @override
  String telemetryReadingsCount(int count) {
    return '$count readings';
  }

  @override
  String get telemetrySearchByNode => 'Search by node';

  @override
  String get telemetrySearchByNodeName => 'Search by node name';

  @override
  String get telemetrySettings => 'Settings';

  @override
  String get telemetryStartDate => 'Start Date';

  @override
  String telemetryTracerouteClearMessage(String scope) {
    return 'This will permanently delete all traceroute history for $scope. This cannot be undone.';
  }

  @override
  String get telemetryTracerouteClearTitle => 'Clear Traceroute Data';

  @override
  String get telemetryTracerouteDataCleared => 'Traceroute data cleared';

  @override
  String get telemetryTracerouteDestinationLabel => 'To';

  @override
  String get telemetryTracerouteDirectConnection =>
      'Direct connection — no intermediate hops';

  @override
  String get telemetryTracerouteEmpty => 'No traceroutes recorded yet';

  @override
  String get telemetryTracerouteEmptySubtitle =>
      'Send a traceroute from a node to see network paths';

  @override
  String telemetryTracerouteExportSubject(String scope) {
    return 'Socialmesh Traceroute Export ($scope)';
  }

  @override
  String telemetryTracerouteExportedCount(int count) {
    return 'Exported $count traceroutes';
  }

  @override
  String get telemetryTracerouteFilterNoResponse => 'No Response';

  @override
  String get telemetryTracerouteFilterResponse => 'Response';

  @override
  String get telemetryTracerouteForwardPath => 'Forward Path';

  @override
  String get telemetryTracerouteHistoryTitle => 'Traceroute History';

  @override
  String telemetryTracerouteHopSnr(int value) {
    return '$value dB';
  }

  @override
  String get telemetryTracerouteHopsBack => 'Hops ←';

  @override
  String get telemetryTracerouteHopsForward => 'Hops →';

  @override
  String get telemetryTracerouteMoreActions => 'More actions';

  @override
  String get telemetryTracerouteNoDataExport => 'No traceroute data to export';

  @override
  String get telemetryTracerouteNoMatch => 'No traceroutes match filters';

  @override
  String get telemetryTracerouteReturnPath => 'Return Path';

  @override
  String telemetryTracerouteSnr(int value) {
    return 'SNR: $value dB';
  }

  @override
  String get telemetryTryAdjustingFilters =>
      'Try adjusting your search or filters';

  @override
  String telemetryUptimeDaysHours(int days, int hours) {
    return '${days}d ${hours}h';
  }

  @override
  String telemetryUptimeHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}m';
  }

  @override
  String telemetryUptimeMinutes(int minutes) {
    return '${minutes}m';
  }

  @override
  String get worldMeshAddToFavorites => 'Add to favorites';

  @override
  String get worldMeshAddedToFavorites => 'Added to favorites';

  @override
  String get worldMeshBadgeActive => 'ACTIVE';

  @override
  String get worldMeshCoordinatesCopied => 'Coordinates copied to clipboard';

  @override
  String get worldMeshCopyCoordinates => 'Copy Coordinates';

  @override
  String get worldMeshCopyCoordinatesSubtitle => 'Both A and B coordinates';

  @override
  String get worldMeshCopyId => 'Copy ID';

  @override
  String get worldMeshCopySummary => 'Copy Summary';

  @override
  String get worldMeshErrorTitle => 'Unable to load mesh map';

  @override
  String get worldMeshExitMeasureMode => 'Exit measure mode';

  @override
  String get worldMeshFavoritesTooltip => 'Favorites';

  @override
  String worldMeshFilterActiveCount(int count) {
    return '$count active';
  }

  @override
  String get worldMeshFilterAny => 'Any';

  @override
  String get worldMeshFilterBatteryInfo => 'Battery Info';

  @override
  String get worldMeshFilterCatBatteryInfo => 'Battery Info';

  @override
  String get worldMeshFilterCatEnvSensors => 'Environment Sensors';

  @override
  String get worldMeshFilterCatFirmware => 'Firmware';

  @override
  String get worldMeshFilterCatHardware => 'Hardware';

  @override
  String get worldMeshFilterCatModemPreset => 'Modem Preset';

  @override
  String get worldMeshFilterCatRegion => 'Region';

  @override
  String get worldMeshFilterCatRole => 'Role';

  @override
  String get worldMeshFilterCatStatus => 'Status';

  @override
  String get worldMeshFilterClearAll => 'Clear All';

  @override
  String get worldMeshFilterEnvironmentSensors => 'Environment Sensors';

  @override
  String get worldMeshFilterFirmwareVersion => 'Firmware Version';

  @override
  String get worldMeshFilterHardwareModel => 'Hardware Model';

  @override
  String get worldMeshFilterModemPreset => 'Modem Preset';

  @override
  String get worldMeshFilterNo => 'No';

  @override
  String get worldMeshFilterNoOptions => 'No options available';

  @override
  String worldMeshFilterNodeCount(int filteredCount, int totalCount) {
    return '$filteredCount of $totalCount nodes';
  }

  @override
  String get worldMeshFilterNodeRole => 'Node Role';

  @override
  String worldMeshFilterNodesWithBattery(int count) {
    return '$count nodes with battery data';
  }

  @override
  String worldMeshFilterNodesWithSensors(int count) {
    return '$count nodes with sensors';
  }

  @override
  String get worldMeshFilterRegion => 'Region';

  @override
  String get worldMeshFilterStatus => 'Status';

  @override
  String get worldMeshFilterStatusActive => 'Active (≤2m)';

  @override
  String get worldMeshFilterStatusFading => 'Fading (2-10m)';

  @override
  String get worldMeshFilterStatusInactive => 'Inactive (10-60m)';

  @override
  String get worldMeshFilterStatusUnknown => 'Unknown (>60m)';

  @override
  String get worldMeshFilterTitle => 'Filter Nodes';

  @override
  String get worldMeshFilterTooltip => 'Filter nodes';

  @override
  String get worldMeshFilterYes => 'Yes';

  @override
  String get worldMeshFocus => 'Focus';

  @override
  String worldMeshFsplSubtitle(String db) {
    return 'FSPL: $db dB';
  }

  @override
  String get worldMeshHelp => 'Help';

  @override
  String get worldMeshInfoAltitude => 'Altitude';

  @override
  String get worldMeshInfoCoordinates => 'Coordinates';

  @override
  String get worldMeshInfoFirmware => 'Firmware';

  @override
  String get worldMeshInfoHardware => 'Hardware';

  @override
  String get worldMeshInfoLocalNodes => 'Local Nodes';

  @override
  String get worldMeshInfoModem => 'Modem';

  @override
  String get worldMeshInfoPrecision => 'Precision';

  @override
  String get worldMeshInfoRegion => 'Region';

  @override
  String get worldMeshInfoRole => 'Role';

  @override
  String worldMeshLastSeen(String time) {
    return 'Last seen: $time';
  }

  @override
  String get worldMeshLegendActive => 'Active (<1h)';

  @override
  String get worldMeshLegendIdle => 'Idle (1-24h)';

  @override
  String get worldMeshLegendOffline => 'Offline (>24h)';

  @override
  String get worldMeshLinkBudgetCopied => 'Link budget copied to clipboard';

  @override
  String get worldMeshLoadingNodeInfo => 'Loading node info...';

  @override
  String get worldMeshLongPressHint => 'Long-press for actions';

  @override
  String get worldMeshLosAnalysis => 'LOS Analysis';

  @override
  String worldMeshLosBulgeAndFresnel(String bulge, String fresnel) {
    return 'Bulge: ${bulge}m · F1: ${fresnel}m';
  }

  @override
  String get worldMeshLosSubtitle => 'Earth curvature + Fresnel zone check';

  @override
  String worldMeshLosVerdict(String verdict) {
    return 'LOS: $verdict';
  }

  @override
  String get worldMeshMapStyleDark => 'Dark Map';

  @override
  String get worldMeshMapStyleLight => 'Light Map';

  @override
  String get worldMeshMapStyleSatellite => 'Satellite';

  @override
  String get worldMeshMapStyleTerrain => 'Terrain';

  @override
  String get worldMeshMeasurePointA => 'A';

  @override
  String get worldMeshMeasurePointB => 'B';

  @override
  String get worldMeshMeasureTapA => 'Tap node or map for point A';

  @override
  String get worldMeshMeasureTapB => 'Tap node or map for point B';

  @override
  String get worldMeshMeasurementActions => 'Measurement Actions';

  @override
  String get worldMeshMeasurementCopied => 'Measurement copied to clipboard';

  @override
  String worldMeshMoreGateways(int count) {
    return ' +$count more';
  }

  @override
  String get worldMeshNewMeasurement => 'New measurement';

  @override
  String get worldMeshNodeIdCopied => 'Node ID copied';

  @override
  String get worldMeshOpenMidpointInMaps => 'Open Midpoint in Maps';

  @override
  String get worldMeshOpenMidpointSubtitle => 'Open in external map app';

  @override
  String get worldMeshRefresh => 'Refresh';

  @override
  String get worldMeshRefreshing => 'Refreshing world mesh data...';

  @override
  String get worldMeshRemoveFromFavorites => 'Remove from favorites';

  @override
  String get worldMeshRemovedFromFavorites => 'Removed from favorites';

  @override
  String get worldMeshRetry => 'Retry';

  @override
  String get worldMeshRfLinkBudget => 'RF Link Budget';

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
  String get worldMeshScrollForMore => 'Scroll for more...';

  @override
  String get worldMeshSearchHint => 'Find a node';

  @override
  String worldMeshSearchResultCount(int count) {
    return '$count results';
  }

  @override
  String get worldMeshSectionDevice => 'Device';

  @override
  String get worldMeshSectionDeviceMetrics => 'Device Metrics';

  @override
  String get worldMeshSectionEnvironment => 'Environment';

  @override
  String worldMeshSectionNeighbors(int count) {
    return 'Neighbors ($count)';
  }

  @override
  String get worldMeshSectionPosition => 'Position';

  @override
  String worldMeshSectionSeenBy(int count) {
    return 'Seen By ($count gateways)';
  }

  @override
  String get worldMeshStatsFiltered => 'filtered';

  @override
  String get worldMeshStatsTotal => 'total';

  @override
  String get worldMeshStatsVisible => 'visible';

  @override
  String get worldMeshSwapAB => 'Swap A ↔ B';

  @override
  String get worldMeshSwapSubtitle => 'Reverse measurement direction';

  @override
  String worldMeshTimeHoursAgo(int hours) {
    return '${hours}h ago';
  }

  @override
  String get worldMeshTimeJustNow => 'just now';

  @override
  String worldMeshTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String get worldMeshTitle => 'World Map';

  @override
  String worldMeshUptimeLabel(String uptime) {
    return 'Uptime: $uptime';
  }

  @override
  String telemetryError(String error) {
    return 'Error: $error';
  }

  @override
  String telemetryFailedToClear(String error) {
    return 'Failed to clear data: $error';
  }

  @override
  String get telemetryAirQualityTitle => 'Air Quality Log';

  @override
  String get telemetryAirQualityNoData => 'No air quality data recorded yet';

  @override
  String get telemetryAirQualityPmStandard => 'Particulate Matter (Standard)';

  @override
  String get telemetryAirQualityPmEnvironmental =>
      'Particulate Matter (Environmental)';

  @override
  String telemetryCo2Label(String rating) {
    return 'CO₂ - $rating';
  }

  @override
  String get telemetryDetectionTitle => 'Detection Sensor Log';

  @override
  String get telemetryDetectionNoData => 'No sensor events recorded yet';

  @override
  String get telemetryDetectionDescription =>
      'Detection sensors report motion and presence';

  @override
  String get telemetryDetectionSensor => 'Detection Sensor';

  @override
  String get telemetryDetectionClearBadge => 'Clear';

  @override
  String get telemetryPaxTitle => 'PAX Counter Log';

  @override
  String get telemetryPaxNoData => 'No PAX data recorded yet';

  @override
  String get telemetryPaxDescription => 'PAX counter detects nearby devices';

  @override
  String get telemetryDeviceNoMetrics => 'No device metrics yet';

  @override
  String get telemetryDeviceFilterBattery => 'Battery';

  @override
  String get telemetryDeviceFilterVoltage => 'Voltage';

  @override
  String get telemetryDeviceFilterChannel => 'Channel';

  @override
  String get telemetryDeviceFilterAirUtil => 'Air Util';

  @override
  String get telemetryDeviceFilterUptime => 'Uptime';

  @override
  String get telemetryDeviceLegendBattery => 'Battery';

  @override
  String get telemetryDeviceLegendVoltage => 'Voltage';

  @override
  String get telemetryDeviceLegendChUtil => 'Ch Util';

  @override
  String get telemetryDeviceLegendAirUtil => 'Air Util';

  @override
  String get telemetryDeviceCharging => 'Charging';

  @override
  String get telemetryEnvironmentTitle => 'Environment Metrics';

  @override
  String get telemetryEnvironmentNoMetrics => 'No environment metrics yet';

  @override
  String get telemetryEnvironmentFilterTemp => 'Temp';

  @override
  String get telemetryEnvironmentFilterHumidity => 'Humidity';

  @override
  String get telemetryEnvironmentFilterPressure => 'Pressure';

  @override
  String get telemetryEnvironmentFilterGas => 'Gas';

  @override
  String get telemetryEnvironmentFilterIaq => 'IAQ';

  @override
  String get telemetryEnvironmentFilterLight => 'Light';

  @override
  String get telemetryEnvironmentFilterWind => 'Wind';

  @override
  String get telemetryEnvironmentLegendTemperature => 'Temperature';

  @override
  String get telemetryEnvironmentLegendHumidity => 'Humidity';

  @override
  String get telemetryPositionListView => 'List view';

  @override
  String get telemetryPositionMapView => 'Map view';

  @override
  String get telemetryPositionMapStyle => 'Map Style';

  @override
  String get telemetryPositionNoMatch => 'No positions match filters';

  @override
  String get telemetryPositionNoExportData => 'No position data to export';

  @override
  String get telemetryPositionClearLabel => 'Clear';

  @override
  String get telemetryPositionCleared => 'Position data cleared';

  @override
  String get telemetryPositionNoDisplay => 'No positions to display';

  @override
  String get telemetryPositionDrawerTitle => 'Nodes';

  @override
  String get telemetryPositionAllNodesOption => 'All Nodes';

  @override
  String get telemetryPositionAllNodesDescription =>
      'Show positions from all nodes';

  @override
  String telemetryPositionNodesCount(int count) {
    return '$count nodes';
  }

  @override
  String get telemetryTracerouteTitle => 'Traceroute History';

  @override
  String get telemetryTracerouteNoData => 'No traceroutes recorded yet';

  @override
  String get telemetryTracerouteEmptyHint =>
      'Send a traceroute from a node to see network paths';

  @override
  String get telemetryTracerouteNoExportData => 'No traceroute data to export';

  @override
  String get telemetryTracerouteClearLabel => 'Clear';

  @override
  String get telemetryTracerouteCleared => 'Traceroute data cleared';

  @override
  String get telemetryTracerouteTo => 'To';

  @override
  String get telemetryTracerouteResponseBadge => 'Response';

  @override
  String get telemetryTracerouteNoResponseBadge => 'No Response';
}
