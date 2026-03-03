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

  /// No description provided for @adminProductsActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get adminProductsActivate;

  /// No description provided for @adminProductsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminProductsActive;

  /// No description provided for @adminProductsActiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Product is visible in the shop'**
  String get adminProductsActiveSubtitle;

  /// No description provided for @adminProductsAddImage.
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get adminProductsAddImage;

  /// No description provided for @adminProductsAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get adminProductsAddTitle;

  /// No description provided for @adminProductsAddTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get adminProductsAddTooltip;

  /// No description provided for @adminProductsAllCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get adminProductsAllCategories;

  /// No description provided for @adminProductsBasicInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get adminProductsBasicInfoSection;

  /// No description provided for @adminProductsBatteryHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 4000mAh'**
  String get adminProductsBatteryHint;

  /// No description provided for @adminProductsBatteryLabel.
  ///
  /// In en, this message translates to:
  /// **'Battery Capacity'**
  String get adminProductsBatteryLabel;

  /// No description provided for @adminProductsBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get adminProductsBluetooth;

  /// No description provided for @adminProductsCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get adminProductsCategoryLabel;

  /// No description provided for @adminProductsCategorySellerSection.
  ///
  /// In en, this message translates to:
  /// **'Category & Seller'**
  String get adminProductsCategorySellerSection;

  /// No description provided for @adminProductsChipsetHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., ESP32-S3'**
  String get adminProductsChipsetHint;

  /// No description provided for @adminProductsChipsetLabel.
  ///
  /// In en, this message translates to:
  /// **'Chipset'**
  String get adminProductsChipsetLabel;

  /// No description provided for @adminProductsComparePriceHint.
  ///
  /// In en, this message translates to:
  /// **'Original price for sale'**
  String get adminProductsComparePriceHint;

  /// No description provided for @adminProductsComparePriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Compare at Price'**
  String get adminProductsComparePriceLabel;

  /// No description provided for @adminProductsCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Product'**
  String get adminProductsCreate;

  /// No description provided for @adminProductsCreated.
  ///
  /// In en, this message translates to:
  /// **'Product created'**
  String get adminProductsCreated;

  /// No description provided for @adminProductsDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get adminProductsDeactivate;

  /// No description provided for @adminProductsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminProductsDelete;

  /// No description provided for @adminProductsDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this product?'**
  String get adminProductsDeleteConfirmMessage;

  /// No description provided for @adminProductsDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get adminProductsDeleteConfirmTitle;

  /// No description provided for @adminProductsDeleteMenu.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminProductsDeleteMenu;

  /// No description provided for @adminProductsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete \"{name}\"?\n\nThis action cannot be undone.'**
  String adminProductsDeleteMessage(String name);

  /// No description provided for @adminProductsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get adminProductsDeleteTitle;

  /// No description provided for @adminProductsDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminProductsDeleteTooltip;

  /// No description provided for @adminProductsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Product deleted'**
  String get adminProductsDeleted;

  /// No description provided for @adminProductsDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Product deleted'**
  String get adminProductsDeletedSuccess;

  /// No description provided for @adminProductsDimensionsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 100x50x25mm'**
  String get adminProductsDimensionsHint;

  /// No description provided for @adminProductsDimensionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Dimensions'**
  String get adminProductsDimensionsLabel;

  /// No description provided for @adminProductsDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get adminProductsDisplay;

  /// No description provided for @adminProductsEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminProductsEdit;

  /// No description provided for @adminProductsEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get adminProductsEditTitle;

  /// No description provided for @adminProductsErrorLoadingSellers.
  ///
  /// In en, this message translates to:
  /// **'Error loading sellers: {error}'**
  String adminProductsErrorLoadingSellers(String error);

  /// No description provided for @adminProductsFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get adminProductsFeatured;

  /// No description provided for @adminProductsFeaturedBadge.
  ///
  /// In en, this message translates to:
  /// **'FEATURED'**
  String get adminProductsFeaturedBadge;

  /// No description provided for @adminProductsFeaturedOrderHelper.
  ///
  /// In en, this message translates to:
  /// **'Controls display order in featured section'**
  String get adminProductsFeaturedOrderHelper;

  /// No description provided for @adminProductsFeaturedOrderHint.
  ///
  /// In en, this message translates to:
  /// **'Lower numbers appear first (0 = top)'**
  String get adminProductsFeaturedOrderHint;

  /// No description provided for @adminProductsFeaturedOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Featured Order'**
  String get adminProductsFeaturedOrderLabel;

  /// No description provided for @adminProductsFeaturedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show in featured products section'**
  String get adminProductsFeaturedSubtitle;

  /// No description provided for @adminProductsFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter by category'**
  String get adminProductsFilterTooltip;

  /// No description provided for @adminProductsFrequencyBandsSection.
  ///
  /// In en, this message translates to:
  /// **'Frequency Bands'**
  String get adminProductsFrequencyBandsSection;

  /// No description provided for @adminProductsFullDescHint.
  ///
  /// In en, this message translates to:
  /// **'Detailed product description'**
  String get adminProductsFullDescHint;

  /// No description provided for @adminProductsFullDescLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Description *'**
  String get adminProductsFullDescLabel;

  /// No description provided for @adminProductsGps.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get adminProductsGps;

  /// No description provided for @adminProductsHideInactive.
  ///
  /// In en, this message translates to:
  /// **'Hide inactive'**
  String get adminProductsHideInactive;

  /// No description provided for @adminProductsImageRequired.
  ///
  /// In en, this message translates to:
  /// **'At least one image is required'**
  String get adminProductsImageRequired;

  /// No description provided for @adminProductsImageWarning.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one image'**
  String get adminProductsImageWarning;

  /// No description provided for @adminProductsImagesSection.
  ///
  /// In en, this message translates to:
  /// **'Product Images'**
  String get adminProductsImagesSection;

  /// No description provided for @adminProductsInStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get adminProductsInStock;

  /// No description provided for @adminProductsInactiveBadge.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get adminProductsInactiveBadge;

  /// No description provided for @adminProductsInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get adminProductsInvalid;

  /// No description provided for @adminProductsLoraChipHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., SX1262'**
  String get adminProductsLoraChipHint;

  /// No description provided for @adminProductsLoraChipLabel.
  ///
  /// In en, this message translates to:
  /// **'LoRa Chip'**
  String get adminProductsLoraChipLabel;

  /// No description provided for @adminProductsMainImage.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get adminProductsMainImage;

  /// No description provided for @adminProductsNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., T-Beam Supreme'**
  String get adminProductsNameHint;

  /// No description provided for @adminProductsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Product Name *'**
  String get adminProductsNameLabel;

  /// No description provided for @adminProductsNotFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get adminProductsNotFound;

  /// No description provided for @adminProductsPhysicalSpecsSection.
  ///
  /// In en, this message translates to:
  /// **'Physical Specifications'**
  String get adminProductsPhysicalSpecsSection;

  /// No description provided for @adminProductsPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price (USD) *'**
  String get adminProductsPriceLabel;

  /// No description provided for @adminProductsPricingSection.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get adminProductsPricingSection;

  /// No description provided for @adminProductsPurchaseLinkSection.
  ///
  /// In en, this message translates to:
  /// **'Purchase Link'**
  String get adminProductsPurchaseLinkSection;

  /// No description provided for @adminProductsPurchaseUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase URL'**
  String get adminProductsPurchaseUrlLabel;

  /// No description provided for @adminProductsRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get adminProductsRequired;

  /// No description provided for @adminProductsSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get adminProductsSaveChanges;

  /// No description provided for @adminProductsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get adminProductsSearchHint;

  /// No description provided for @adminProductsSelectSeller.
  ///
  /// In en, this message translates to:
  /// **'Select seller'**
  String get adminProductsSelectSeller;

  /// No description provided for @adminProductsSelectSellerWarning.
  ///
  /// In en, this message translates to:
  /// **'Please select a seller'**
  String get adminProductsSelectSellerWarning;

  /// No description provided for @adminProductsSellerLabel.
  ///
  /// In en, this message translates to:
  /// **'Seller *'**
  String get adminProductsSellerLabel;

  /// No description provided for @adminProductsShortDescHint.
  ///
  /// In en, this message translates to:
  /// **'Brief summary (max 150 chars)'**
  String get adminProductsShortDescHint;

  /// No description provided for @adminProductsShortDescLabel.
  ///
  /// In en, this message translates to:
  /// **'Short Description'**
  String get adminProductsShortDescLabel;

  /// No description provided for @adminProductsShowInactive.
  ///
  /// In en, this message translates to:
  /// **'Show inactive'**
  String get adminProductsShowInactive;

  /// No description provided for @adminProductsStockHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for unlimited'**
  String get adminProductsStockHint;

  /// No description provided for @adminProductsStockLabel.
  ///
  /// In en, this message translates to:
  /// **'Stock Quantity'**
  String get adminProductsStockLabel;

  /// No description provided for @adminProductsStockSection.
  ///
  /// In en, this message translates to:
  /// **'Stock & Status'**
  String get adminProductsStockSection;

  /// No description provided for @adminProductsTagsHint.
  ///
  /// In en, this message translates to:
  /// **'meshtastic, lora, gps (comma separated)'**
  String get adminProductsTagsHint;

  /// No description provided for @adminProductsTagsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get adminProductsTagsLabel;

  /// No description provided for @adminProductsTagsSection.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get adminProductsTagsSection;

  /// No description provided for @adminProductsTechSpecsSection.
  ///
  /// In en, this message translates to:
  /// **'Technical Specifications'**
  String get adminProductsTechSpecsSection;

  /// No description provided for @adminProductsTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Products'**
  String get adminProductsTitle;

  /// No description provided for @adminProductsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Product updated'**
  String get adminProductsUpdated;

  /// No description provided for @adminProductsUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get adminProductsUploading;

  /// No description provided for @adminProductsVendorUnverifiedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mark when vendor confirms all specs are accurate'**
  String get adminProductsVendorUnverifiedSubtitle;

  /// No description provided for @adminProductsVendorVerificationSection.
  ///
  /// In en, this message translates to:
  /// **'Vendor Verification'**
  String get adminProductsVendorVerificationSection;

  /// No description provided for @adminProductsVendorVerifiedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Specifications have been verified by the vendor'**
  String get adminProductsVendorVerifiedSubtitle;

  /// No description provided for @adminProductsVendorVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Vendor Verified Specs'**
  String get adminProductsVendorVerifiedTitle;

  /// No description provided for @adminProductsWeightHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 50g'**
  String get adminProductsWeightHint;

  /// No description provided for @adminProductsWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get adminProductsWeightLabel;

  /// No description provided for @adminProductsWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get adminProductsWifi;

  /// No description provided for @adminSellersActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get adminSellersActivate;

  /// No description provided for @adminSellersActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminSellersActive;

  /// No description provided for @adminSellersActiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Seller is visible in the shop'**
  String get adminSellersActiveSubtitle;

  /// No description provided for @adminSellersAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Seller'**
  String get adminSellersAddTitle;

  /// No description provided for @adminSellersAddTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add Seller'**
  String get adminSellersAddTooltip;

  /// No description provided for @adminSellersBasicInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get adminSellersBasicInfoSection;

  /// No description provided for @adminSellersCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get adminSellersCancel;

  /// No description provided for @adminSellersClearDiscount.
  ///
  /// In en, this message translates to:
  /// **'Clear Discount Code'**
  String get adminSellersClearDiscount;

  /// No description provided for @adminSellersContactInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get adminSellersContactInfoSection;

  /// No description provided for @adminSellersCountriesHint.
  ///
  /// In en, this message translates to:
  /// **'US, CA, UK, DE (comma separated)'**
  String get adminSellersCountriesHint;

  /// No description provided for @adminSellersCountriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Countries'**
  String get adminSellersCountriesLabel;

  /// No description provided for @adminSellersCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Seller'**
  String get adminSellersCreate;

  /// No description provided for @adminSellersCreated.
  ///
  /// In en, this message translates to:
  /// **'Seller created'**
  String get adminSellersCreated;

  /// No description provided for @adminSellersDangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get adminSellersDangerZone;

  /// No description provided for @adminSellersDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get adminSellersDeactivate;

  /// No description provided for @adminSellersDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adminSellersDeleteConfirm;

  /// No description provided for @adminSellersDeleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete this seller and deactivate all their products. This action cannot be undone.'**
  String get adminSellersDeleteDescription;

  /// No description provided for @adminSellersDeleteDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete \"{name}\"?'**
  String adminSellersDeleteDialogMessage(String name);

  /// No description provided for @adminSellersDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Seller'**
  String get adminSellersDeleteDialogTitle;

  /// No description provided for @adminSellersDeletePermanently.
  ///
  /// In en, this message translates to:
  /// **'Delete Seller Permanently'**
  String get adminSellersDeletePermanently;

  /// No description provided for @adminSellersDeleteProductWarning.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 product will be deactivated.} other{{count} products will be deactivated.}}'**
  String adminSellersDeleteProductWarning(int count);

  /// No description provided for @adminSellersDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Seller'**
  String get adminSellersDeleteTitle;

  /// No description provided for @adminSellersDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete Seller'**
  String get adminSellersDeleteTooltip;

  /// No description provided for @adminSellersDeleteUndoWarning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get adminSellersDeleteUndoWarning;

  /// No description provided for @adminSellersDeleted.
  ///
  /// In en, this message translates to:
  /// **'Seller deleted'**
  String get adminSellersDeleted;

  /// No description provided for @adminSellersDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Brief description of the seller'**
  String get adminSellersDescriptionHint;

  /// No description provided for @adminSellersDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get adminSellersDescriptionLabel;

  /// No description provided for @adminSellersDiscountCodeHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., MESH10'**
  String get adminSellersDiscountCodeHint;

  /// No description provided for @adminSellersDiscountCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Discount Code'**
  String get adminSellersDiscountCodeLabel;

  /// No description provided for @adminSellersDiscountDisplayHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 10% off for Socialmesh users'**
  String get adminSellersDiscountDisplayHint;

  /// No description provided for @adminSellersDiscountDisplayLabel.
  ///
  /// In en, this message translates to:
  /// **'Display Label'**
  String get adminSellersDiscountDisplayLabel;

  /// No description provided for @adminSellersDiscountExpired.
  ///
  /// In en, this message translates to:
  /// **'Discount code has expired'**
  String get adminSellersDiscountExpired;

  /// No description provided for @adminSellersDiscountExpiryLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date (optional)'**
  String get adminSellersDiscountExpiryLabel;

  /// No description provided for @adminSellersDiscountNoExpiry.
  ///
  /// In en, this message translates to:
  /// **'No expiry'**
  String get adminSellersDiscountNoExpiry;

  /// No description provided for @adminSellersDiscountSection.
  ///
  /// In en, this message translates to:
  /// **'Partner Discount Code'**
  String get adminSellersDiscountSection;

  /// No description provided for @adminSellersDiscountTermsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Cannot be combined with other offers'**
  String get adminSellersDiscountTermsHint;

  /// No description provided for @adminSellersDiscountTermsLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get adminSellersDiscountTermsLabel;

  /// No description provided for @adminSellersEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adminSellersEdit;

  /// No description provided for @adminSellersEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Seller'**
  String get adminSellersEditTitle;

  /// No description provided for @adminSellersEmailHint.
  ///
  /// In en, this message translates to:
  /// **'support@example.com'**
  String get adminSellersEmailHint;

  /// No description provided for @adminSellersEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact Email'**
  String get adminSellersEmailLabel;

  /// No description provided for @adminSellersHideInactive.
  ///
  /// In en, this message translates to:
  /// **'Hide inactive'**
  String get adminSellersHideInactive;

  /// No description provided for @adminSellersInactiveBadge.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get adminSellersInactiveBadge;

  /// No description provided for @adminSellersLogoSection.
  ///
  /// In en, this message translates to:
  /// **'Seller Logo'**
  String get adminSellersLogoSection;

  /// No description provided for @adminSellersNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., LilyGO, RAK Wireless'**
  String get adminSellersNameHint;

  /// No description provided for @adminSellersNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Seller Name *'**
  String get adminSellersNameLabel;

  /// No description provided for @adminSellersNotFound.
  ///
  /// In en, this message translates to:
  /// **'No sellers found'**
  String get adminSellersNotFound;

  /// No description provided for @adminSellersOfficialPartner.
  ///
  /// In en, this message translates to:
  /// **'Official Partner'**
  String get adminSellersOfficialPartner;

  /// No description provided for @adminSellersOfficialPartnerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display as official Meshtastic partner'**
  String get adminSellersOfficialPartnerSubtitle;

  /// No description provided for @adminSellersPartnerBadge.
  ///
  /// In en, this message translates to:
  /// **'PARTNER'**
  String get adminSellersPartnerBadge;

  /// No description provided for @adminSellersRemoveLogo.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get adminSellersRemoveLogo;

  /// No description provided for @adminSellersSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get adminSellersSaveChanges;

  /// No description provided for @adminSellersSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search sellers...'**
  String get adminSellersSearchHint;

  /// No description provided for @adminSellersShippingSection.
  ///
  /// In en, this message translates to:
  /// **'Shipping Countries'**
  String get adminSellersShippingSection;

  /// No description provided for @adminSellersShowInactive.
  ///
  /// In en, this message translates to:
  /// **'Show inactive'**
  String get adminSellersShowInactive;

  /// No description provided for @adminSellersStatusSection.
  ///
  /// In en, this message translates to:
  /// **'Status & Verification'**
  String get adminSellersStatusSection;

  /// No description provided for @adminSellersTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Sellers'**
  String get adminSellersTitle;

  /// No description provided for @adminSellersUpdated.
  ///
  /// In en, this message translates to:
  /// **'Seller updated'**
  String get adminSellersUpdated;

  /// No description provided for @adminSellersUploadLogo.
  ///
  /// In en, this message translates to:
  /// **'Upload Logo'**
  String get adminSellersUploadLogo;

  /// No description provided for @adminSellersUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get adminSellersUploading;

  /// No description provided for @adminSellersVerifiedBadge.
  ///
  /// In en, this message translates to:
  /// **'VERIFIED'**
  String get adminSellersVerifiedBadge;

  /// No description provided for @adminSellersVerifiedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Seller identity has been verified'**
  String get adminSellersVerifiedSubtitle;

  /// No description provided for @adminSellersVerifiedToggle.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get adminSellersVerifiedToggle;

  /// No description provided for @adminSellersWebsiteLabel.
  ///
  /// In en, this message translates to:
  /// **'Website URL *'**
  String get adminSellersWebsiteLabel;

  /// No description provided for @ambientLightingBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get ambientLightingBlue;

  /// No description provided for @ambientLightingBrightness.
  ///
  /// In en, this message translates to:
  /// **'LED Brightness'**
  String get ambientLightingBrightness;

  /// No description provided for @ambientLightingCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get ambientLightingCurrent;

  /// No description provided for @ambientLightingCurrentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'LED drive current (brightness)'**
  String get ambientLightingCurrentSubtitle;

  /// No description provided for @ambientLightingCurrentValue.
  ///
  /// In en, this message translates to:
  /// **'{milliamps} mA'**
  String ambientLightingCurrentValue(int milliamps);

  /// No description provided for @ambientLightingCustomColor.
  ///
  /// In en, this message translates to:
  /// **'Custom Color'**
  String get ambientLightingCustomColor;

  /// No description provided for @ambientLightingDeviceSupportInfo.
  ///
  /// In en, this message translates to:
  /// **'Ambient lighting is only available on devices with LED support (RAK WisBlock, T-Beam, etc.)'**
  String get ambientLightingDeviceSupportInfo;

  /// No description provided for @ambientLightingGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get ambientLightingGreen;

  /// No description provided for @ambientLightingLedEnabled.
  ///
  /// In en, this message translates to:
  /// **'LED Enabled'**
  String get ambientLightingLedEnabled;

  /// No description provided for @ambientLightingLedEnabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn ambient lighting on or off'**
  String get ambientLightingLedEnabledSubtitle;

  /// No description provided for @ambientLightingPresetColors.
  ///
  /// In en, this message translates to:
  /// **'Preset Colors'**
  String get ambientLightingPresetColors;

  /// No description provided for @ambientLightingRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get ambientLightingRed;

  /// No description provided for @ambientLightingSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get ambientLightingSave;

  /// No description provided for @ambientLightingSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String ambientLightingSaveError(String error);

  /// No description provided for @ambientLightingSaved.
  ///
  /// In en, this message translates to:
  /// **'Ambient lighting saved'**
  String get ambientLightingSaved;

  /// No description provided for @ambientLightingTitle.
  ///
  /// In en, this message translates to:
  /// **'Ambient Lighting'**
  String get ambientLightingTitle;

  /// The name of the application.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh'**
  String get appTitle;

  /// No description provided for @categoryProductsApplyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get categoryProductsApplyFilters;

  /// No description provided for @categoryProductsClearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get categoryProductsClearFilters;

  /// No description provided for @categoryProductsErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading products'**
  String get categoryProductsErrorLoading;

  /// No description provided for @categoryProductsFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get categoryProductsFilter;

  /// No description provided for @categoryProductsFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get categoryProductsFiltersTitle;

  /// No description provided for @categoryProductsFrequencyBands.
  ///
  /// In en, this message translates to:
  /// **'Frequency Bands'**
  String get categoryProductsFrequencyBands;

  /// No description provided for @categoryProductsInStockOnly.
  ///
  /// In en, this message translates to:
  /// **'In Stock Only'**
  String get categoryProductsInStockOnly;

  /// No description provided for @categoryProductsNotFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get categoryProductsNotFound;

  /// No description provided for @categoryProductsOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'OUT OF STOCK'**
  String get categoryProductsOutOfStock;

  /// No description provided for @categoryProductsPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get categoryProductsPriceRange;

  /// No description provided for @categoryProductsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get categoryProductsReset;

  /// No description provided for @categoryProductsResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String categoryProductsResultCount(int count);

  /// No description provided for @categoryProductsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get categoryProductsRetry;

  /// No description provided for @categoryProductsSortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest First'**
  String get categoryProductsSortNewest;

  /// No description provided for @categoryProductsSortPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get categoryProductsSortPopular;

  /// No description provided for @categoryProductsSortPriceHigh.
  ///
  /// In en, this message translates to:
  /// **'Price: High to Low'**
  String get categoryProductsSortPriceHigh;

  /// No description provided for @categoryProductsSortPriceLow.
  ///
  /// In en, this message translates to:
  /// **'Price: Low to High'**
  String get categoryProductsSortPriceLow;

  /// No description provided for @categoryProductsSortRating.
  ///
  /// In en, this message translates to:
  /// **'Highest Rated'**
  String get categoryProductsSortRating;

  /// No description provided for @categoryProductsTryFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters'**
  String get categoryProductsTryFilters;

  /// No description provided for @channelFormApproxLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Approximate Location'**
  String get channelFormApproxLocationTitle;

  /// No description provided for @channelFormCreatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Channel created'**
  String get channelFormCreatedSnackbar;

  /// No description provided for @channelFormDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Channel {index}'**
  String channelFormDefaultName(int index);

  /// No description provided for @channelFormDeviceNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot save channel: Device not connected'**
  String get channelFormDeviceNotConnected;

  /// No description provided for @channelFormDeviceNotReady.
  ///
  /// In en, this message translates to:
  /// **'Device not ready - please wait for connection'**
  String get channelFormDeviceNotReady;

  /// No description provided for @channelFormDownlinkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive messages from MQTT server'**
  String get channelFormDownlinkSubtitle;

  /// No description provided for @channelFormDownlinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Downlink Enabled'**
  String get channelFormDownlinkTitle;

  /// No description provided for @channelFormEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Channel'**
  String get channelFormEditTitle;

  /// No description provided for @channelFormEncryptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get channelFormEncryptionLabel;

  /// No description provided for @channelFormError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String channelFormError(String error);

  /// No description provided for @channelFormInvalidBase64.
  ///
  /// In en, this message translates to:
  /// **'Invalid base64 encoding'**
  String get channelFormInvalidBase64;

  /// No description provided for @channelFormInvalidKeySize.
  ///
  /// In en, this message translates to:
  /// **'Invalid key size ({byteCount} bytes). Use 1, 16, or 32 bytes.'**
  String channelFormInvalidKeySize(int byteCount);

  /// No description provided for @channelFormKeyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Key cannot be empty'**
  String get channelFormKeyEmpty;

  /// No description provided for @channelFormKeySizeAes128.
  ///
  /// In en, this message translates to:
  /// **'AES-128'**
  String get channelFormKeySizeAes128;

  /// No description provided for @channelFormKeySizeAes256.
  ///
  /// In en, this message translates to:
  /// **'AES-256'**
  String get channelFormKeySizeAes256;

  /// No description provided for @channelFormKeySizeBitDesc.
  ///
  /// In en, this message translates to:
  /// **'{bits}-bit encryption key'**
  String channelFormKeySizeBitDesc(int bits);

  /// No description provided for @channelFormKeySizeDefault.
  ///
  /// In en, this message translates to:
  /// **'Default (Simple)'**
  String get channelFormKeySizeDefault;

  /// No description provided for @channelFormKeySizeDefaultDesc.
  ///
  /// In en, this message translates to:
  /// **'1-byte simple key (AQ==)'**
  String get channelFormKeySizeDefaultDesc;

  /// No description provided for @channelFormKeySizeNone.
  ///
  /// In en, this message translates to:
  /// **'No Encryption'**
  String get channelFormKeySizeNone;

  /// No description provided for @channelFormKeySizeNoneDesc.
  ///
  /// In en, this message translates to:
  /// **'Messages sent in plaintext'**
  String get channelFormKeySizeNoneDesc;

  /// No description provided for @channelFormMaxChannelsReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum 8 channels allowed'**
  String get channelFormMaxChannelsReached;

  /// No description provided for @channelFormMqttLabel.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get channelFormMqttLabel;

  /// No description provided for @channelFormMqttWarning.
  ///
  /// In en, this message translates to:
  /// **'Most devices have very limited processing power and RAM. Bridging a busy channel like LongFast via the default MQTT server can flood the device with 15-25 packets per second, causing it to stop responding. Consider using a private broker or a quieter channel.'**
  String get channelFormMqttWarning;

  /// No description provided for @channelFormNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter channel name (no spaces)'**
  String get channelFormNameHint;

  /// No description provided for @channelFormNameMaxHint.
  ///
  /// In en, this message translates to:
  /// **'Max 11 characters'**
  String get channelFormNameMaxHint;

  /// No description provided for @channelFormNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Channel Name'**
  String get channelFormNameTitle;

  /// No description provided for @channelFormNewTitle.
  ///
  /// In en, this message translates to:
  /// **'New Channel'**
  String get channelFormNewTitle;

  /// No description provided for @channelFormPositionEnabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share position on this channel'**
  String get channelFormPositionEnabledSubtitle;

  /// No description provided for @channelFormPositionEnabledTitle.
  ///
  /// In en, this message translates to:
  /// **'Positions Enabled'**
  String get channelFormPositionEnabledTitle;

  /// No description provided for @channelFormPositionLabel.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get channelFormPositionLabel;

  /// No description provided for @channelFormPreciseLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share exact GPS coordinates'**
  String get channelFormPreciseLocationSubtitle;

  /// No description provided for @channelFormPreciseLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Precise Location'**
  String get channelFormPreciseLocationTitle;

  /// No description provided for @channelFormPrecision12.
  ///
  /// In en, this message translates to:
  /// **'Within 5.8 km'**
  String get channelFormPrecision12;

  /// No description provided for @channelFormPrecision13.
  ///
  /// In en, this message translates to:
  /// **'Within 2.9 km'**
  String get channelFormPrecision13;

  /// No description provided for @channelFormPrecision14.
  ///
  /// In en, this message translates to:
  /// **'Within 1.5 km'**
  String get channelFormPrecision14;

  /// No description provided for @channelFormPrecision15.
  ///
  /// In en, this message translates to:
  /// **'Within 700 m'**
  String get channelFormPrecision15;

  /// No description provided for @channelFormPrecision32.
  ///
  /// In en, this message translates to:
  /// **'Precise location'**
  String get channelFormPrecision32;

  /// No description provided for @channelFormPrecisionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get channelFormPrecisionUnknown;

  /// No description provided for @channelFormPrimaryChannelNote.
  ///
  /// In en, this message translates to:
  /// **'This is the main channel for device communication. Changes may affect connectivity.'**
  String get channelFormPrimaryChannelNote;

  /// No description provided for @channelFormPrimaryChannelTitle.
  ///
  /// In en, this message translates to:
  /// **'Primary Channel'**
  String get channelFormPrimaryChannelTitle;

  /// No description provided for @channelFormSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get channelFormSaveButton;

  /// No description provided for @channelFormUpdatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Channel updated'**
  String get channelFormUpdatedSnackbar;

  /// No description provided for @channelFormUplinkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Forward messages to MQTT server'**
  String get channelFormUplinkSubtitle;

  /// No description provided for @channelFormUplinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Uplink Enabled'**
  String get channelFormUplinkTitle;

  /// No description provided for @channelOptionsCopyButton.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get channelOptionsCopyButton;

  /// No description provided for @channelOptionsDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Channel {index}'**
  String channelOptionsDefaultName(int index);

  /// No description provided for @channelOptionsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Channel'**
  String get channelOptionsDelete;

  /// No description provided for @channelOptionsDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get channelOptionsDeleteButton;

  /// No description provided for @channelOptionsDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete channel \"{name}\"?'**
  String channelOptionsDeleteConfirm(String name);

  /// No description provided for @channelOptionsDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete channel: {error}'**
  String channelOptionsDeleteFailed(String error);

  /// No description provided for @channelOptionsDeleteNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete channel: Device not connected'**
  String get channelOptionsDeleteNotConnected;

  /// No description provided for @channelOptionsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Channel'**
  String get channelOptionsDeleteTitle;

  /// No description provided for @channelOptionsEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Channel'**
  String get channelOptionsEdit;

  /// No description provided for @channelOptionsEncrypted.
  ///
  /// In en, this message translates to:
  /// **'Encrypted'**
  String get channelOptionsEncrypted;

  /// No description provided for @channelOptionsHideButton.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get channelOptionsHideButton;

  /// No description provided for @channelOptionsInviteLink.
  ///
  /// In en, this message translates to:
  /// **'Share Invite Link'**
  String get channelOptionsInviteLink;

  /// No description provided for @channelOptionsKeyCopied.
  ///
  /// In en, this message translates to:
  /// **'Key copied to clipboard'**
  String get channelOptionsKeyCopied;

  /// No description provided for @channelOptionsKeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'{keyBits}-bit · {keyBytes} bytes · Base64'**
  String channelOptionsKeySubtitle(int keyBits, int keyBytes);

  /// No description provided for @channelOptionsKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Encryption Key'**
  String get channelOptionsKeyTitle;

  /// No description provided for @channelOptionsNoEncryption.
  ///
  /// In en, this message translates to:
  /// **'No encryption'**
  String get channelOptionsNoEncryption;

  /// No description provided for @channelOptionsShare.
  ///
  /// In en, this message translates to:
  /// **'Share Channel'**
  String get channelOptionsShare;

  /// No description provided for @channelOptionsShowButton.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get channelOptionsShowButton;

  /// No description provided for @channelOptionsViewKey.
  ///
  /// In en, this message translates to:
  /// **'View Encryption Key'**
  String get channelOptionsViewKey;

  /// No description provided for @channelShareCreatingInvite.
  ///
  /// In en, this message translates to:
  /// **'Creating invite link...'**
  String get channelShareCreatingInvite;

  /// No description provided for @channelShareDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Channel {index}'**
  String channelShareDefaultName(int index);

  /// No description provided for @channelShareInviteCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite link copied to clipboard'**
  String get channelShareInviteCopied;

  /// No description provided for @channelShareInviteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create invite link'**
  String get channelShareInviteFailed;

  /// No description provided for @channelShareMessage.
  ///
  /// In en, this message translates to:
  /// **'Join my channel on Socialmesh!'**
  String get channelShareMessage;

  /// No description provided for @channelShareQrInfo.
  ///
  /// In en, this message translates to:
  /// **'Scan this QR code in Socialmesh to import this channel'**
  String get channelShareQrInfo;

  /// No description provided for @channelShareSignInAction.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get channelShareSignInAction;

  /// No description provided for @channelShareSignInRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in to share channels'**
  String get channelShareSignInRequired;

  /// No description provided for @channelShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh Channel: {channelName}'**
  String channelShareSubject(String channelName);

  /// No description provided for @channelShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Channel'**
  String get channelShareTitle;

  /// No description provided for @channelWizardBackButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get channelWizardBackButton;

  /// No description provided for @channelWizardCompatMax.
  ///
  /// In en, this message translates to:
  /// **'Highest security. Ensure all participants support AES-256 encryption.'**
  String get channelWizardCompatMax;

  /// No description provided for @channelWizardCompatOpen.
  ///
  /// In en, this message translates to:
  /// **'Compatible with all devices. No key exchange needed.'**
  String get channelWizardCompatOpen;

  /// No description provided for @channelWizardCompatPrivate.
  ///
  /// In en, this message translates to:
  /// **'Recommended. Share the QR code securely with people you want to communicate with.'**
  String get channelWizardCompatPrivate;

  /// No description provided for @channelWizardCompatShared.
  ///
  /// In en, this message translates to:
  /// **'Uses the default Meshtastic key. Other users with default settings may intercept messages.'**
  String get channelWizardCompatShared;

  /// No description provided for @channelWizardContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get channelWizardContinueButton;

  /// No description provided for @channelWizardCopyUrlButton.
  ///
  /// In en, this message translates to:
  /// **'Copy URL'**
  String get channelWizardCopyUrlButton;

  /// No description provided for @channelWizardCreateButton.
  ///
  /// In en, this message translates to:
  /// **'Create Channel'**
  String get channelWizardCreateButton;

  /// No description provided for @channelWizardCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create channel: {error}'**
  String channelWizardCreateFailed(String error);

  /// No description provided for @channelWizardCreatedHeading.
  ///
  /// In en, this message translates to:
  /// **'Channel Created!'**
  String get channelWizardCreatedHeading;

  /// No description provided for @channelWizardCreatedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share this QR code with others to let them join.'**
  String get channelWizardCreatedSubtitle;

  /// No description provided for @channelWizardCreating.
  ///
  /// In en, this message translates to:
  /// **'Creating channel...'**
  String get channelWizardCreating;

  /// No description provided for @channelWizardDefaultKey.
  ///
  /// In en, this message translates to:
  /// **'Default key'**
  String get channelWizardDefaultKey;

  /// No description provided for @channelWizardDeviceNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot save channel: Device not connected'**
  String get channelWizardDeviceNotConnected;

  /// No description provided for @channelWizardDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get channelWizardDisabled;

  /// No description provided for @channelWizardDoneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get channelWizardDoneButton;

  /// No description provided for @channelWizardDownlinkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive messages from MQTT and broadcast them on this channel.'**
  String get channelWizardDownlinkSubtitle;

  /// No description provided for @channelWizardDownlinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Downlink Enabled'**
  String get channelWizardDownlinkTitle;

  /// No description provided for @channelWizardEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get channelWizardEnabled;

  /// No description provided for @channelWizardEncryptionKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Encryption Key'**
  String get channelWizardEncryptionKeyLabel;

  /// No description provided for @channelWizardHelpTooltip.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get channelWizardHelpTooltip;

  /// No description provided for @channelWizardKeyBits.
  ///
  /// In en, this message translates to:
  /// **'{bits} bits'**
  String channelWizardKeyBits(int bits);

  /// No description provided for @channelWizardKeySizeAes128.
  ///
  /// In en, this message translates to:
  /// **'AES-128'**
  String get channelWizardKeySizeAes128;

  /// No description provided for @channelWizardKeySizeAes128Desc.
  ///
  /// In en, this message translates to:
  /// **'Strong encryption - recommended for most uses'**
  String get channelWizardKeySizeAes128Desc;

  /// No description provided for @channelWizardKeySizeAes256.
  ///
  /// In en, this message translates to:
  /// **'AES-256'**
  String get channelWizardKeySizeAes256;

  /// No description provided for @channelWizardKeySizeAes256Desc.
  ///
  /// In en, this message translates to:
  /// **'Maximum encryption - highest security'**
  String get channelWizardKeySizeAes256Desc;

  /// No description provided for @channelWizardKeySizeDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get channelWizardKeySizeDefault;

  /// No description provided for @channelWizardKeySizeDefaultDesc.
  ///
  /// In en, this message translates to:
  /// **'Simple shared key - compatible but not secure'**
  String get channelWizardKeySizeDefaultDesc;

  /// No description provided for @channelWizardKeySizeNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get channelWizardKeySizeNone;

  /// No description provided for @channelWizardKeySizeNoneDesc.
  ///
  /// In en, this message translates to:
  /// **'No encryption - messages are sent in plain text'**
  String get channelWizardKeySizeNoneDesc;

  /// No description provided for @channelWizardMqttFloodWarning.
  ///
  /// In en, this message translates to:
  /// **'Most devices have very limited processing power and RAM. Bridging a busy channel like LongFast via the default MQTT server can flood the device with 15-25 packets per second, causing it to stop responding. Consider using a private broker or a quieter channel.'**
  String get channelWizardMqttFloodWarning;

  /// No description provided for @channelWizardMqttHeader.
  ///
  /// In en, this message translates to:
  /// **'MQTT Settings'**
  String get channelWizardMqttHeader;

  /// No description provided for @channelWizardMqttWarning.
  ///
  /// In en, this message translates to:
  /// **'MQTT must be configured on your device for uplink/downlink to work.'**
  String get channelWizardMqttWarning;

  /// No description provided for @channelWizardNameBannerInfo.
  ///
  /// In en, this message translates to:
  /// **'Channel names are limited to 12 alphanumeric characters.'**
  String get channelWizardNameBannerInfo;

  /// No description provided for @channelWizardNameHeading.
  ///
  /// In en, this message translates to:
  /// **'Name Your Channel'**
  String get channelWizardNameHeading;

  /// No description provided for @channelWizardNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Family, Friends, Hiking'**
  String get channelWizardNameHint;

  /// No description provided for @channelWizardNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Channel Name'**
  String get channelWizardNameLabel;

  /// No description provided for @channelWizardNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a name that helps you identify this channel. It will be visible to anyone who joins.'**
  String get channelWizardNameSubtitle;

  /// No description provided for @channelWizardNoKey.
  ///
  /// In en, this message translates to:
  /// **'No key'**
  String get channelWizardNoKey;

  /// No description provided for @channelWizardOptionsHeading.
  ///
  /// In en, this message translates to:
  /// **'Advanced Options'**
  String get channelWizardOptionsHeading;

  /// No description provided for @channelWizardOptionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure optional channel settings.'**
  String get channelWizardOptionsSubtitle;

  /// No description provided for @channelWizardPositionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share your position on this channel.'**
  String get channelWizardPositionSubtitle;

  /// No description provided for @channelWizardPositionTitle.
  ///
  /// In en, this message translates to:
  /// **'Position Enabled'**
  String get channelWizardPositionTitle;

  /// No description provided for @channelWizardPrivacyHeading.
  ///
  /// In en, this message translates to:
  /// **'Choose Privacy Level'**
  String get channelWizardPrivacyHeading;

  /// No description provided for @channelWizardPrivacyMaxDesc.
  ///
  /// In en, this message translates to:
  /// **'AES-256 encryption for maximum security. Ideal for sensitive communications. Slightly higher battery usage.'**
  String get channelWizardPrivacyMaxDesc;

  /// No description provided for @channelWizardPrivacyMaxTitle.
  ///
  /// In en, this message translates to:
  /// **'Maximum Security'**
  String get channelWizardPrivacyMaxTitle;

  /// No description provided for @channelWizardPrivacyOpenDesc.
  ///
  /// In en, this message translates to:
  /// **'No encryption. Anyone with a compatible radio can read your messages. Use only for public broadcasts.'**
  String get channelWizardPrivacyOpenDesc;

  /// No description provided for @channelWizardPrivacyOpenTitle.
  ///
  /// In en, this message translates to:
  /// **'Open Channel'**
  String get channelWizardPrivacyOpenTitle;

  /// No description provided for @channelWizardPrivacyPrivateDesc.
  ///
  /// In en, this message translates to:
  /// **'AES-128 encryption with a random key. Only people you share the QR code with can join. Recommended for most uses.'**
  String get channelWizardPrivacyPrivateDesc;

  /// No description provided for @channelWizardPrivacyPrivateTitle.
  ///
  /// In en, this message translates to:
  /// **'Private Channel'**
  String get channelWizardPrivacyPrivateTitle;

  /// No description provided for @channelWizardPrivacySharedDesc.
  ///
  /// In en, this message translates to:
  /// **'Uses the well-known default key. Other Meshtastic users may be able to read messages. Good for community channels.'**
  String get channelWizardPrivacySharedDesc;

  /// No description provided for @channelWizardPrivacySharedTitle.
  ///
  /// In en, this message translates to:
  /// **'Shared Channel'**
  String get channelWizardPrivacySharedTitle;

  /// No description provided for @channelWizardPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select how secure you want this channel to be. Higher security uses stronger encryption.'**
  String get channelWizardPrivacySubtitle;

  /// No description provided for @channelWizardRadioComplianceLink.
  ///
  /// In en, this message translates to:
  /// **'View Radio Compliance Rules'**
  String get channelWizardRadioComplianceLink;

  /// No description provided for @channelWizardReviewEncryption.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get channelWizardReviewEncryption;

  /// No description provided for @channelWizardReviewHeading.
  ///
  /// In en, this message translates to:
  /// **'Review & Create'**
  String get channelWizardReviewHeading;

  /// No description provided for @channelWizardReviewKeySize.
  ///
  /// In en, this message translates to:
  /// **'Key Size'**
  String get channelWizardReviewKeySize;

  /// No description provided for @channelWizardReviewMqttDownlink.
  ///
  /// In en, this message translates to:
  /// **'MQTT Downlink'**
  String get channelWizardReviewMqttDownlink;

  /// No description provided for @channelWizardReviewMqttUplink.
  ///
  /// In en, this message translates to:
  /// **'MQTT Uplink'**
  String get channelWizardReviewMqttUplink;

  /// No description provided for @channelWizardReviewName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get channelWizardReviewName;

  /// No description provided for @channelWizardReviewPositionSharing.
  ///
  /// In en, this message translates to:
  /// **'Position Sharing'**
  String get channelWizardReviewPositionSharing;

  /// No description provided for @channelWizardReviewPrivacyLevel.
  ///
  /// In en, this message translates to:
  /// **'Privacy Level'**
  String get channelWizardReviewPrivacyLevel;

  /// No description provided for @channelWizardReviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your channel settings before creating.'**
  String get channelWizardReviewSubtitle;

  /// No description provided for @channelWizardScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Channel'**
  String get channelWizardScreenTitle;

  /// No description provided for @channelWizardStepNameContent.
  ///
  /// In en, this message translates to:
  /// **'Choose a memorable name for your channel.\n\n• Names are limited to 12 characters\n• Only letters and numbers allowed\n• The name is visible to anyone who joins\n• Pick something descriptive like \"Family\" or \"Hiking\"'**
  String get channelWizardStepNameContent;

  /// No description provided for @channelWizardStepNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Channel Name'**
  String get channelWizardStepNameTitle;

  /// No description provided for @channelWizardStepOptionsContent.
  ///
  /// In en, this message translates to:
  /// **'Configure optional channel settings.\n\n• Position Sharing: Allow location sharing on this channel\n• MQTT Uplink: Send messages to the internet (requires MQTT setup)\n• MQTT Downlink: Receive messages from the internet\n• Encryption Key: Auto-generated, but you can paste a custom key\n\nMost users can skip these advanced options.'**
  String get channelWizardStepOptionsContent;

  /// No description provided for @channelWizardStepOptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Options'**
  String get channelWizardStepOptionsTitle;

  /// No description provided for @channelWizardStepPrivacyContent.
  ///
  /// In en, this message translates to:
  /// **'Select how secure your channel should be.\n\n• OPEN: No encryption - anyone can read messages\n• SHARED: Uses the default Meshtastic key - not private\n• PRIVATE (Recommended): Unique AES-128 key - secure\n• MAXIMUM: AES-256 encryption - highest security\n\nHigher security requires sharing your channel key with others.'**
  String get channelWizardStepPrivacyContent;

  /// No description provided for @channelWizardStepPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Level'**
  String get channelWizardStepPrivacyTitle;

  /// No description provided for @channelWizardStepReviewContent.
  ///
  /// In en, this message translates to:
  /// **'Review your channel settings before creating.\n\n• Verify the name and privacy level are correct\n• After creation, share the QR code with others\n• Others scan the QR code to join your channel\n• You can also copy the URL to share via text'**
  String get channelWizardStepReviewContent;

  /// No description provided for @channelWizardStepReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review & Create'**
  String get channelWizardStepReviewTitle;

  /// No description provided for @channelWizardSummaryEncryption.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get channelWizardSummaryEncryption;

  /// No description provided for @channelWizardSummaryName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get channelWizardSummaryName;

  /// No description provided for @channelWizardSummaryPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get channelWizardSummaryPrivacy;

  /// No description provided for @channelWizardUplinkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send messages from this channel to MQTT when connected to the internet.'**
  String get channelWizardUplinkSubtitle;

  /// No description provided for @channelWizardUplinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Uplink Enabled'**
  String get channelWizardUplinkTitle;

  /// No description provided for @channelWizardUrlCopied.
  ///
  /// In en, this message translates to:
  /// **'Channel URL copied to clipboard'**
  String get channelWizardUrlCopied;

  /// No description provided for @channelsClearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get channelsClearSearch;

  /// No description provided for @channelsDefaultChannelName.
  ///
  /// In en, this message translates to:
  /// **'Channel {index}'**
  String channelsDefaultChannelName(int index);

  /// No description provided for @channelsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No channels configured'**
  String get channelsEmpty;

  /// No description provided for @channelsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Channels are still being loaded from device\nor use the icons above to add channels'**
  String get channelsEmptySubtitle;

  /// No description provided for @channelsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get channelsFilterAll;

  /// No description provided for @channelsFilterEncrypted.
  ///
  /// In en, this message translates to:
  /// **'Encrypted'**
  String get channelsFilterEncrypted;

  /// No description provided for @channelsFilterMqtt.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get channelsFilterMqtt;

  /// No description provided for @channelsFilterPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get channelsFilterPosition;

  /// No description provided for @channelsFilterPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get channelsFilterPrimary;

  /// No description provided for @channelsMenuAddChannel.
  ///
  /// In en, this message translates to:
  /// **'Add Channel'**
  String get channelsMenuAddChannel;

  /// No description provided for @channelsMenuHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get channelsMenuHelp;

  /// No description provided for @channelsMenuScanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get channelsMenuScanQrCode;

  /// No description provided for @channelsMenuSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get channelsMenuSettings;

  /// No description provided for @channelsNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No channels match \"{query}\"'**
  String channelsNoMatch(String query);

  /// No description provided for @channelsPrimaryChannelName.
  ///
  /// In en, this message translates to:
  /// **'Primary Channel'**
  String get channelsPrimaryChannelName;

  /// No description provided for @channelsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Channels ({count})'**
  String channelsScreenTitle(int count);

  /// No description provided for @channelsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search channels'**
  String get channelsSearchHint;

  /// No description provided for @channelsTileEncrypted.
  ///
  /// In en, this message translates to:
  /// **'Encrypted'**
  String get channelsTileEncrypted;

  /// No description provided for @channelsTileNoEncryption.
  ///
  /// In en, this message translates to:
  /// **'No encryption'**
  String get channelsTileNoEncryption;

  /// No description provided for @channelsTilePrimaryBadge.
  ///
  /// In en, this message translates to:
  /// **'PRIMARY'**
  String get channelsTilePrimaryBadge;

  /// No description provided for @channelsUnreadOverflow.
  ///
  /// In en, this message translates to:
  /// **'99+'**
  String get channelsUnreadOverflow;

  /// Label for a Cancel button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Label for a Close button.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// Label for a Confirm button.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get commonConfirm;

  /// Label for a Continue button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// Label for a Delete button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

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

  /// Label for an OK button.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// Label for a Retry button.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// Label for a Save button.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @deviceConfigBleName.
  ///
  /// In en, this message translates to:
  /// **'BLE Name'**
  String get deviceConfigBleName;

  /// No description provided for @deviceConfigBroadcastEighteenHours.
  ///
  /// In en, this message translates to:
  /// **'Eighteen Hours'**
  String get deviceConfigBroadcastEighteenHours;

  /// No description provided for @deviceConfigBroadcastFiveHours.
  ///
  /// In en, this message translates to:
  /// **'Five Hours'**
  String get deviceConfigBroadcastFiveHours;

  /// No description provided for @deviceConfigBroadcastFortyEightHours.
  ///
  /// In en, this message translates to:
  /// **'Forty Eight Hours'**
  String get deviceConfigBroadcastFortyEightHours;

  /// No description provided for @deviceConfigBroadcastFourHours.
  ///
  /// In en, this message translates to:
  /// **'Four Hours'**
  String get deviceConfigBroadcastFourHours;

  /// No description provided for @deviceConfigBroadcastInterval.
  ///
  /// In en, this message translates to:
  /// **'Broadcast Interval'**
  String get deviceConfigBroadcastInterval;

  /// No description provided for @deviceConfigBroadcastIntervalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How often to broadcast node info to the mesh'**
  String get deviceConfigBroadcastIntervalSubtitle;

  /// No description provided for @deviceConfigBroadcastNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get deviceConfigBroadcastNever;

  /// No description provided for @deviceConfigBroadcastSeventyTwoHours.
  ///
  /// In en, this message translates to:
  /// **'Seventy Two Hours'**
  String get deviceConfigBroadcastSeventyTwoHours;

  /// No description provided for @deviceConfigBroadcastSixHours.
  ///
  /// In en, this message translates to:
  /// **'Six Hours'**
  String get deviceConfigBroadcastSixHours;

  /// No description provided for @deviceConfigBroadcastThirtySixHours.
  ///
  /// In en, this message translates to:
  /// **'Thirty Six Hours'**
  String get deviceConfigBroadcastThirtySixHours;

  /// No description provided for @deviceConfigBroadcastThreeHours.
  ///
  /// In en, this message translates to:
  /// **'Three Hours'**
  String get deviceConfigBroadcastThreeHours;

  /// No description provided for @deviceConfigBroadcastTwelveHours.
  ///
  /// In en, this message translates to:
  /// **'Twelve Hours'**
  String get deviceConfigBroadcastTwelveHours;

  /// No description provided for @deviceConfigBroadcastTwentyFourHours.
  ///
  /// In en, this message translates to:
  /// **'Twenty Four Hours'**
  String get deviceConfigBroadcastTwentyFourHours;

  /// No description provided for @deviceConfigButtonGpio.
  ///
  /// In en, this message translates to:
  /// **'Button GPIO'**
  String get deviceConfigButtonGpio;

  /// No description provided for @deviceConfigBuzzerAllEnabled.
  ///
  /// In en, this message translates to:
  /// **'All Enabled'**
  String get deviceConfigBuzzerAllEnabled;

  /// No description provided for @deviceConfigBuzzerAllEnabledDesc.
  ///
  /// In en, this message translates to:
  /// **'Buzzer sounds for all feedback including buttons and alerts.'**
  String get deviceConfigBuzzerAllEnabledDesc;

  /// No description provided for @deviceConfigBuzzerDirectMsgOnly.
  ///
  /// In en, this message translates to:
  /// **'Direct Messages Only'**
  String get deviceConfigBuzzerDirectMsgOnly;

  /// No description provided for @deviceConfigBuzzerDirectMsgOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Buzzer only for direct messages and alerts.'**
  String get deviceConfigBuzzerDirectMsgOnlyDesc;

  /// No description provided for @deviceConfigBuzzerDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get deviceConfigBuzzerDisabled;

  /// No description provided for @deviceConfigBuzzerDisabledDesc.
  ///
  /// In en, this message translates to:
  /// **'All buzzer audio feedback is disabled.'**
  String get deviceConfigBuzzerDisabledDesc;

  /// No description provided for @deviceConfigBuzzerGpio.
  ///
  /// In en, this message translates to:
  /// **'Buzzer GPIO'**
  String get deviceConfigBuzzerGpio;

  /// No description provided for @deviceConfigBuzzerNotificationsOnly.
  ///
  /// In en, this message translates to:
  /// **'Notifications Only'**
  String get deviceConfigBuzzerNotificationsOnly;

  /// No description provided for @deviceConfigBuzzerNotificationsOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Buzzer only for notifications and alerts, not button presses.'**
  String get deviceConfigBuzzerNotificationsOnlyDesc;

  /// No description provided for @deviceConfigBuzzerSystemOnly.
  ///
  /// In en, this message translates to:
  /// **'System Only'**
  String get deviceConfigBuzzerSystemOnly;

  /// No description provided for @deviceConfigBuzzerSystemOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Button presses, startup, shutdown sounds only. No alerts.'**
  String get deviceConfigBuzzerSystemOnlyDesc;

  /// No description provided for @deviceConfigDisableLedHeartbeat.
  ///
  /// In en, this message translates to:
  /// **'Disable LED Heartbeat'**
  String get deviceConfigDisableLedHeartbeat;

  /// No description provided for @deviceConfigDisableLedHeartbeatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn off the blinking status LED'**
  String get deviceConfigDisableLedHeartbeatSubtitle;

  /// No description provided for @deviceConfigDisableTripleClick.
  ///
  /// In en, this message translates to:
  /// **'Disable Triple Click'**
  String get deviceConfigDisableTripleClick;

  /// No description provided for @deviceConfigDisableTripleClickSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Disable triple-click to toggle GPS'**
  String get deviceConfigDisableTripleClickSubtitle;

  /// No description provided for @deviceConfigDoubleTapAsButton.
  ///
  /// In en, this message translates to:
  /// **'Double Tap as Button'**
  String get deviceConfigDoubleTapAsButton;

  /// No description provided for @deviceConfigDoubleTapAsButtonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Treat accelerometer double-tap as button press'**
  String get deviceConfigDoubleTapAsButtonSubtitle;

  /// No description provided for @deviceConfigFactoryReset.
  ///
  /// In en, this message translates to:
  /// **'Factory Reset'**
  String get deviceConfigFactoryReset;

  /// No description provided for @deviceConfigFactoryResetDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Factory Reset'**
  String get deviceConfigFactoryResetDialogConfirm;

  /// No description provided for @deviceConfigFactoryResetDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will reset ALL device settings to factory defaults, including channels, configuration, and stored data.\n\nThis action cannot be undone!'**
  String get deviceConfigFactoryResetDialogMessage;

  /// No description provided for @deviceConfigFactoryResetDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Factory Reset'**
  String get deviceConfigFactoryResetDialogTitle;

  /// No description provided for @deviceConfigFactoryResetError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset: {error}'**
  String deviceConfigFactoryResetError(String error);

  /// No description provided for @deviceConfigFactoryResetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reset device to factory defaults'**
  String get deviceConfigFactoryResetSubtitle;

  /// No description provided for @deviceConfigFactoryResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Factory reset initiated - device will restart'**
  String get deviceConfigFactoryResetSuccess;

  /// No description provided for @deviceConfigFrequencyOverride.
  ///
  /// In en, this message translates to:
  /// **'Frequency Override (MHz)'**
  String get deviceConfigFrequencyOverride;

  /// No description provided for @deviceConfigFrequencyOverrideHint.
  ///
  /// In en, this message translates to:
  /// **'0.0 (use default)'**
  String get deviceConfigFrequencyOverrideHint;

  /// No description provided for @deviceConfigGpioWarning.
  ///
  /// In en, this message translates to:
  /// **'Only change these if you know your hardware requires custom GPIO pins.'**
  String get deviceConfigGpioWarning;

  /// No description provided for @deviceConfigHamModeInfo.
  ///
  /// In en, this message translates to:
  /// **'Ham mode uses your long name as call sign (max 8 chars), broadcasts node info every 10 minutes, overrides frequency, duty cycle, and TX power, and disables encryption.'**
  String get deviceConfigHamModeInfo;

  /// No description provided for @deviceConfigHamModeWarning.
  ///
  /// In en, this message translates to:
  /// **'HAM nodes cannot relay encrypted traffic. Other non-HAM nodes in your mesh will not be able to route encrypted messages through this node, creating a relay gap in the network.'**
  String get deviceConfigHamModeWarning;

  /// No description provided for @deviceConfigHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get deviceConfigHardware;

  /// No description provided for @deviceConfigLicensedOperator.
  ///
  /// In en, this message translates to:
  /// **'Licensed Operator (Ham)'**
  String get deviceConfigLicensedOperator;

  /// No description provided for @deviceConfigLicensedOperatorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sets call sign, overrides frequency/power, disables encryption'**
  String get deviceConfigLicensedOperatorSubtitle;

  /// No description provided for @deviceConfigLongName.
  ///
  /// In en, this message translates to:
  /// **'Long Name'**
  String get deviceConfigLongName;

  /// No description provided for @deviceConfigLongNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter display name'**
  String get deviceConfigLongNameHint;

  /// No description provided for @deviceConfigLongNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Display name visible on the mesh'**
  String get deviceConfigLongNameSubtitle;

  /// No description provided for @deviceConfigNameHelpText.
  ///
  /// In en, this message translates to:
  /// **'Your device name is broadcast to the mesh and visible to other nodes.'**
  String get deviceConfigNameHelpText;

  /// No description provided for @deviceConfigNodeNumber.
  ///
  /// In en, this message translates to:
  /// **'Node Number'**
  String get deviceConfigNodeNumber;

  /// No description provided for @deviceConfigPosixTimezone.
  ///
  /// In en, this message translates to:
  /// **'POSIX Timezone'**
  String get deviceConfigPosixTimezone;

  /// No description provided for @deviceConfigPosixTimezoneExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. EST5EDT,M3.2.0,M11.1.0'**
  String get deviceConfigPosixTimezoneExample;

  /// No description provided for @deviceConfigPosixTimezoneHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for UTC'**
  String get deviceConfigPosixTimezoneHint;

  /// No description provided for @deviceConfigRebootWarning.
  ///
  /// In en, this message translates to:
  /// **'Changes to device configuration will cause the device to reboot.'**
  String get deviceConfigRebootWarning;

  /// No description provided for @deviceConfigRebroadcastAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get deviceConfigRebroadcastAll;

  /// No description provided for @deviceConfigRebroadcastAllDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast any observed message. Default behavior.'**
  String get deviceConfigRebroadcastAllDesc;

  /// No description provided for @deviceConfigRebroadcastAllSkipDecoding.
  ///
  /// In en, this message translates to:
  /// **'All (Skip Decoding)'**
  String get deviceConfigRebroadcastAllSkipDecoding;

  /// No description provided for @deviceConfigRebroadcastAllSkipDecodingDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast all messages without decoding. Faster, less CPU.'**
  String get deviceConfigRebroadcastAllSkipDecodingDesc;

  /// No description provided for @deviceConfigRebroadcastCorePortnumsOnly.
  ///
  /// In en, this message translates to:
  /// **'Core Port Numbers Only'**
  String get deviceConfigRebroadcastCorePortnumsOnly;

  /// No description provided for @deviceConfigRebroadcastCorePortnumsOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast only core Meshtastic packets (position, telemetry, etc).'**
  String get deviceConfigRebroadcastCorePortnumsOnlyDesc;

  /// No description provided for @deviceConfigRebroadcastKnownOnly.
  ///
  /// In en, this message translates to:
  /// **'Known Only'**
  String get deviceConfigRebroadcastKnownOnly;

  /// No description provided for @deviceConfigRebroadcastKnownOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Only rebroadcast messages from nodes in the node database.'**
  String get deviceConfigRebroadcastKnownOnlyDesc;

  /// No description provided for @deviceConfigRebroadcastLocalOnly.
  ///
  /// In en, this message translates to:
  /// **'Local Only'**
  String get deviceConfigRebroadcastLocalOnly;

  /// No description provided for @deviceConfigRebroadcastLocalOnlyDesc.
  ///
  /// In en, this message translates to:
  /// **'Only rebroadcast messages from local senders. Good for isolated networks.'**
  String get deviceConfigRebroadcastLocalOnlyDesc;

  /// No description provided for @deviceConfigRebroadcastNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get deviceConfigRebroadcastNone;

  /// No description provided for @deviceConfigRebroadcastNoneDesc.
  ///
  /// In en, this message translates to:
  /// **'Do not rebroadcast any messages. Node only receives.'**
  String get deviceConfigRebroadcastNoneDesc;

  /// No description provided for @deviceConfigRemoteAdminConfiguring.
  ///
  /// In en, this message translates to:
  /// **'Configuring: {nodeName}'**
  String deviceConfigRemoteAdminConfiguring(String nodeName);

  /// No description provided for @deviceConfigRemoteAdminTitle.
  ///
  /// In en, this message translates to:
  /// **'Remote Administration'**
  String get deviceConfigRemoteAdminTitle;

  /// No description provided for @deviceConfigResetNodeDb.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceConfigResetNodeDb;

  /// No description provided for @deviceConfigResetNodeDbDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get deviceConfigResetNodeDbDialogConfirm;

  /// No description provided for @deviceConfigResetNodeDbDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will clear all stored node information from the device. The mesh network will need to rediscover all nodes.\n\nAre you sure you want to continue?'**
  String get deviceConfigResetNodeDbDialogMessage;

  /// No description provided for @deviceConfigResetNodeDbDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceConfigResetNodeDbDialogTitle;

  /// No description provided for @deviceConfigResetNodeDbError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset: {error}'**
  String deviceConfigResetNodeDbError(String error);

  /// No description provided for @deviceConfigResetNodeDbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all stored node information'**
  String get deviceConfigResetNodeDbSubtitle;

  /// No description provided for @deviceConfigResetNodeDbSuccess.
  ///
  /// In en, this message translates to:
  /// **'Node database reset initiated'**
  String get deviceConfigResetNodeDbSuccess;

  /// No description provided for @deviceConfigRoleClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get deviceConfigRoleClient;

  /// No description provided for @deviceConfigRoleClientBase.
  ///
  /// In en, this message translates to:
  /// **'Client Base'**
  String get deviceConfigRoleClientBase;

  /// No description provided for @deviceConfigRoleClientBaseDesc.
  ///
  /// In en, this message translates to:
  /// **'Base station for favorited nodes. Routes their packets like a router, others as client.'**
  String get deviceConfigRoleClientBaseDesc;

  /// No description provided for @deviceConfigRoleClientDesc.
  ///
  /// In en, this message translates to:
  /// **'Default role. Mesh packets are routed through this node. Can send and receive messages.'**
  String get deviceConfigRoleClientDesc;

  /// No description provided for @deviceConfigRoleClientHidden.
  ///
  /// In en, this message translates to:
  /// **'Client Hidden'**
  String get deviceConfigRoleClientHidden;

  /// No description provided for @deviceConfigRoleClientHiddenDesc.
  ///
  /// In en, this message translates to:
  /// **'Acts as client but hides from the node list. Still routes traffic.'**
  String get deviceConfigRoleClientHiddenDesc;

  /// No description provided for @deviceConfigRoleClientMute.
  ///
  /// In en, this message translates to:
  /// **'Client Mute'**
  String get deviceConfigRoleClientMute;

  /// No description provided for @deviceConfigRoleClientMuteDesc.
  ///
  /// In en, this message translates to:
  /// **'Same as client but will not transmit any messages from itself. Useful for monitoring.'**
  String get deviceConfigRoleClientMuteDesc;

  /// No description provided for @deviceConfigRoleLostAndFound.
  ///
  /// In en, this message translates to:
  /// **'Lost and Found'**
  String get deviceConfigRoleLostAndFound;

  /// No description provided for @deviceConfigRoleLostAndFoundDesc.
  ///
  /// In en, this message translates to:
  /// **'Optimized for finding lost devices. Sends periodic beacons.'**
  String get deviceConfigRoleLostAndFoundDesc;

  /// No description provided for @deviceConfigRoleRouter.
  ///
  /// In en, this message translates to:
  /// **'Router'**
  String get deviceConfigRoleRouter;

  /// No description provided for @deviceConfigRoleRouterDesc.
  ///
  /// In en, this message translates to:
  /// **'Routes mesh packets between nodes. Screen and Bluetooth disabled to conserve power.'**
  String get deviceConfigRoleRouterDesc;

  /// No description provided for @deviceConfigRoleRouterLate.
  ///
  /// In en, this message translates to:
  /// **'Router Late'**
  String get deviceConfigRoleRouterLate;

  /// No description provided for @deviceConfigRoleRouterLateDesc.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcasts all packets after other routers. Extends coverage without consuming priority hops.'**
  String get deviceConfigRoleRouterLateDesc;

  /// No description provided for @deviceConfigRoleSensor.
  ///
  /// In en, this message translates to:
  /// **'Sensor'**
  String get deviceConfigRoleSensor;

  /// No description provided for @deviceConfigRoleSensorDesc.
  ///
  /// In en, this message translates to:
  /// **'Designed for remote sensing. Reports telemetry data at defined intervals.'**
  String get deviceConfigRoleSensorDesc;

  /// No description provided for @deviceConfigRoleTak.
  ///
  /// In en, this message translates to:
  /// **'TAK'**
  String get deviceConfigRoleTak;

  /// No description provided for @deviceConfigRoleTakDesc.
  ///
  /// In en, this message translates to:
  /// **'Team Awareness Kit integration. Bridges Meshtastic and TAK systems.'**
  String get deviceConfigRoleTakDesc;

  /// No description provided for @deviceConfigRoleTakTracker.
  ///
  /// In en, this message translates to:
  /// **'TAK Tracker'**
  String get deviceConfigRoleTakTracker;

  /// No description provided for @deviceConfigRoleTakTrackerDesc.
  ///
  /// In en, this message translates to:
  /// **'Combination of TAK and Tracker modes.'**
  String get deviceConfigRoleTakTrackerDesc;

  /// No description provided for @deviceConfigRoleTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get deviceConfigRoleTracker;

  /// No description provided for @deviceConfigRoleTrackerDesc.
  ///
  /// In en, this message translates to:
  /// **'Optimized for GPS tracking. Sends position updates at defined intervals.'**
  String get deviceConfigRoleTrackerDesc;

  /// No description provided for @deviceConfigSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get deviceConfigSave;

  /// No description provided for @deviceConfigSaveAndReboot.
  ///
  /// In en, this message translates to:
  /// **'Save & Reboot'**
  String get deviceConfigSaveAndReboot;

  /// No description provided for @deviceConfigSaveChangesMessage.
  ///
  /// In en, this message translates to:
  /// **'Saving device configuration will cause the device to reboot. You will be briefly disconnected while the device restarts.'**
  String get deviceConfigSaveChangesMessage;

  /// No description provided for @deviceConfigSaveChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Changes?'**
  String get deviceConfigSaveChangesTitle;

  /// No description provided for @deviceConfigSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error saving config: {error}'**
  String deviceConfigSaveError(String error);

  /// No description provided for @deviceConfigSavedLocal.
  ///
  /// In en, this message translates to:
  /// **'Configuration saved - device rebooting'**
  String get deviceConfigSavedLocal;

  /// No description provided for @deviceConfigSavedRemote.
  ///
  /// In en, this message translates to:
  /// **'Configuration sent to remote node'**
  String get deviceConfigSavedRemote;

  /// No description provided for @deviceConfigSectionButtonInput.
  ///
  /// In en, this message translates to:
  /// **'Button & Input'**
  String get deviceConfigSectionButtonInput;

  /// No description provided for @deviceConfigSectionBuzzer.
  ///
  /// In en, this message translates to:
  /// **'Buzzer'**
  String get deviceConfigSectionBuzzer;

  /// No description provided for @deviceConfigSectionDangerZone.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get deviceConfigSectionDangerZone;

  /// No description provided for @deviceConfigSectionDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get deviceConfigSectionDeviceInfo;

  /// No description provided for @deviceConfigSectionDeviceRole.
  ///
  /// In en, this message translates to:
  /// **'Device Role'**
  String get deviceConfigSectionDeviceRole;

  /// No description provided for @deviceConfigSectionGpio.
  ///
  /// In en, this message translates to:
  /// **'GPIO (Advanced)'**
  String get deviceConfigSectionGpio;

  /// No description provided for @deviceConfigSectionLed.
  ///
  /// In en, this message translates to:
  /// **'LED'**
  String get deviceConfigSectionLed;

  /// No description provided for @deviceConfigSectionNodeInfoBroadcast.
  ///
  /// In en, this message translates to:
  /// **'Node Info Broadcast'**
  String get deviceConfigSectionNodeInfoBroadcast;

  /// No description provided for @deviceConfigSectionRebroadcastMode.
  ///
  /// In en, this message translates to:
  /// **'Rebroadcast Mode'**
  String get deviceConfigSectionRebroadcastMode;

  /// No description provided for @deviceConfigSectionSerial.
  ///
  /// In en, this message translates to:
  /// **'Serial'**
  String get deviceConfigSectionSerial;

  /// No description provided for @deviceConfigSectionTimezone.
  ///
  /// In en, this message translates to:
  /// **'Timezone'**
  String get deviceConfigSectionTimezone;

  /// No description provided for @deviceConfigSectionUserFlags.
  ///
  /// In en, this message translates to:
  /// **'User Flags'**
  String get deviceConfigSectionUserFlags;

  /// No description provided for @deviceConfigSerialConsole.
  ///
  /// In en, this message translates to:
  /// **'Serial Console'**
  String get deviceConfigSerialConsole;

  /// No description provided for @deviceConfigSerialConsoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable serial port for debugging'**
  String get deviceConfigSerialConsoleSubtitle;

  /// No description provided for @deviceConfigShortName.
  ///
  /// In en, this message translates to:
  /// **'Short Name'**
  String get deviceConfigShortName;

  /// No description provided for @deviceConfigShortNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. FUZZ'**
  String get deviceConfigShortNameHint;

  /// No description provided for @deviceConfigShortNameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Max {maxLength} characters (A-Z, 0-9)'**
  String deviceConfigShortNameSubtitle(int maxLength);

  /// No description provided for @deviceConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Config'**
  String get deviceConfigTitle;

  /// No description provided for @deviceConfigTitleRemote.
  ///
  /// In en, this message translates to:
  /// **'Device Config (Remote)'**
  String get deviceConfigTitleRemote;

  /// No description provided for @deviceConfigTxPower.
  ///
  /// In en, this message translates to:
  /// **'TX Power'**
  String get deviceConfigTxPower;

  /// No description provided for @deviceConfigTxPowerValue.
  ///
  /// In en, this message translates to:
  /// **'{power} dBm'**
  String deviceConfigTxPowerValue(int power);

  /// No description provided for @deviceConfigUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get deviceConfigUnknown;

  /// No description provided for @deviceConfigUnmessagable.
  ///
  /// In en, this message translates to:
  /// **'Unmessagable'**
  String get deviceConfigUnmessagable;

  /// No description provided for @deviceConfigUnmessagableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as infrastructure node that won\'t respond to messages'**
  String get deviceConfigUnmessagableSubtitle;

  /// No description provided for @deviceConfigUserId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get deviceConfigUserId;

  /// No description provided for @deviceSheetActionAppSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get deviceSheetActionAppSettings;

  /// No description provided for @deviceSheetActionAppSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications, theme, preferences'**
  String get deviceSheetActionAppSettingsSubtitle;

  /// No description provided for @deviceSheetActionDeviceConfig.
  ///
  /// In en, this message translates to:
  /// **'Device Config'**
  String get deviceSheetActionDeviceConfig;

  /// No description provided for @deviceSheetActionDeviceConfigSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure device role and settings'**
  String get deviceSheetActionDeviceConfigSubtitle;

  /// No description provided for @deviceSheetActionDeviceManagement.
  ///
  /// In en, this message translates to:
  /// **'Device Management'**
  String get deviceSheetActionDeviceManagement;

  /// No description provided for @deviceSheetActionDeviceManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Radio, display, power, and position settings'**
  String get deviceSheetActionDeviceManagementSubtitle;

  /// No description provided for @deviceSheetActionResetNodeDb.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceSheetActionResetNodeDb;

  /// No description provided for @deviceSheetActionResetNodeDbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all learned nodes from device'**
  String get deviceSheetActionResetNodeDbSubtitle;

  /// No description provided for @deviceSheetActionScanQr.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get deviceSheetActionScanQr;

  /// No description provided for @deviceSheetActionScanQrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import nodes, channels, or automations'**
  String get deviceSheetActionScanQrSubtitle;

  /// No description provided for @deviceSheetAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get deviceSheetAddress;

  /// No description provided for @deviceSheetBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get deviceSheetBattery;

  /// No description provided for @deviceSheetBatteryPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String deviceSheetBatteryPercent(String percent);

  /// No description provided for @deviceSheetBatteryRefreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get deviceSheetBatteryRefreshFailed;

  /// No description provided for @deviceSheetBatteryRefreshIdle.
  ///
  /// In en, this message translates to:
  /// **'Fetch battery from device'**
  String get deviceSheetBatteryRefreshIdle;

  /// No description provided for @deviceSheetBatteryRefreshResult.
  ///
  /// In en, this message translates to:
  /// **'{percent}%{millivolts}'**
  String deviceSheetBatteryRefreshResult(String percent, String millivolts);

  /// No description provided for @deviceSheetBluetoothLe.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth LE'**
  String get deviceSheetBluetoothLe;

  /// No description provided for @deviceSheetCharging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get deviceSheetCharging;

  /// No description provided for @deviceSheetConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get deviceSheetConnected;

  /// No description provided for @deviceSheetConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get deviceSheetConnecting;

  /// No description provided for @deviceSheetConnectionType.
  ///
  /// In en, this message translates to:
  /// **'Connection Type'**
  String get deviceSheetConnectionType;

  /// No description provided for @deviceSheetDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get deviceSheetDeviceName;

  /// No description provided for @deviceSheetDisconnectButton.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get deviceSheetDisconnectButton;

  /// No description provided for @deviceSheetDisconnectDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get deviceSheetDisconnectDialogConfirm;

  /// No description provided for @deviceSheetDisconnectDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect from this device?'**
  String get deviceSheetDisconnectDialogMessage;

  /// No description provided for @deviceSheetDisconnectDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get deviceSheetDisconnectDialogTitle;

  /// No description provided for @deviceSheetDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get deviceSheetDisconnected;

  /// No description provided for @deviceSheetDisconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get deviceSheetDisconnecting;

  /// No description provided for @deviceSheetDisconnectingButton.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get deviceSheetDisconnectingButton;

  /// No description provided for @deviceSheetError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get deviceSheetError;

  /// No description provided for @deviceSheetFirmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get deviceSheetFirmware;

  /// No description provided for @deviceSheetInfoCardConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get deviceSheetInfoCardConnected;

  /// No description provided for @deviceSheetInfoCardConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get deviceSheetInfoCardConnecting;

  /// No description provided for @deviceSheetInfoCardConnectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get deviceSheetInfoCardConnectionError;

  /// No description provided for @deviceSheetInfoCardDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get deviceSheetInfoCardDisconnected;

  /// No description provided for @deviceSheetInfoCardDisconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get deviceSheetInfoCardDisconnecting;

  /// No description provided for @deviceSheetNoDevice.
  ///
  /// In en, this message translates to:
  /// **'No Device'**
  String get deviceSheetNoDevice;

  /// No description provided for @deviceSheetNodeId.
  ///
  /// In en, this message translates to:
  /// **'Node ID'**
  String get deviceSheetNodeId;

  /// No description provided for @deviceSheetNodeName.
  ///
  /// In en, this message translates to:
  /// **'Node Name'**
  String get deviceSheetNodeName;

  /// No description provided for @deviceSheetProtocol.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get deviceSheetProtocol;

  /// No description provided for @deviceSheetReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting...'**
  String get deviceSheetReconnecting;

  /// No description provided for @deviceSheetRefreshBattery.
  ///
  /// In en, this message translates to:
  /// **'Refresh Battery'**
  String get deviceSheetRefreshBattery;

  /// No description provided for @deviceSheetRefreshingBattery.
  ///
  /// In en, this message translates to:
  /// **'Refreshing battery...'**
  String get deviceSheetRefreshingBattery;

  /// No description provided for @deviceSheetResetNodeDbDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get deviceSheetResetNodeDbDialogConfirm;

  /// No description provided for @deviceSheetResetNodeDbDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will clear all learned nodes from the device and app. The device will need to rediscover nodes on the mesh.\n\nAre you sure you want to continue?'**
  String get deviceSheetResetNodeDbDialogMessage;

  /// No description provided for @deviceSheetResetNodeDbDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Node Database'**
  String get deviceSheetResetNodeDbDialogTitle;

  /// No description provided for @deviceSheetResetNodeDbError.
  ///
  /// In en, this message translates to:
  /// **'Failed to reset node database: {error}'**
  String deviceSheetResetNodeDbError(String error);

  /// No description provided for @deviceSheetResetNodeDbSuccess.
  ///
  /// In en, this message translates to:
  /// **'Node database reset successfully'**
  String get deviceSheetResetNodeDbSuccess;

  /// No description provided for @deviceSheetScanForDevices.
  ///
  /// In en, this message translates to:
  /// **'Scan for Devices'**
  String get deviceSheetScanForDevices;

  /// No description provided for @deviceSheetSectionConnectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Connection Details'**
  String get deviceSheetSectionConnectionDetails;

  /// No description provided for @deviceSheetSectionDeveloperTools.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get deviceSheetSectionDeveloperTools;

  /// No description provided for @deviceSheetSectionQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get deviceSheetSectionQuickActions;

  /// No description provided for @deviceSheetSignalStrength.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get deviceSheetSignalStrength;

  /// No description provided for @deviceSheetSignalStrengthValue.
  ///
  /// In en, this message translates to:
  /// **'{rssi} dBm'**
  String deviceSheetSignalStrengthValue(String rssi);

  /// No description provided for @deviceSheetStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get deviceSheetStatus;

  /// No description provided for @deviceSheetUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get deviceSheetUnknown;

  /// No description provided for @deviceSheetUsb.
  ///
  /// In en, this message translates to:
  /// **'USB'**
  String get deviceSheetUsb;

  /// No description provided for @deviceShopBecomeSeller.
  ///
  /// In en, this message translates to:
  /// **'Become a Seller'**
  String get deviceShopBecomeSeller;

  /// No description provided for @deviceShopBecomeSellerBody.
  ///
  /// In en, this message translates to:
  /// **'Are you a manufacturer or distributor of Meshtastic-compatible devices? Join our marketplace to reach mesh radio enthusiasts worldwide.'**
  String get deviceShopBecomeSellerBody;

  /// No description provided for @deviceShopBrowseByCategory.
  ///
  /// In en, this message translates to:
  /// **'Browse by Category'**
  String get deviceShopBrowseByCategory;

  /// No description provided for @deviceShopCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get deviceShopCategories;

  /// No description provided for @deviceShopClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get deviceShopClear;

  /// No description provided for @deviceShopConnectToBrowse.
  ///
  /// In en, this message translates to:
  /// **'Connect to browse devices'**
  String get deviceShopConnectToBrowse;

  /// No description provided for @deviceShopContactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get deviceShopContactUs;

  /// No description provided for @deviceShopErrorLoadingProducts.
  ///
  /// In en, this message translates to:
  /// **'Error loading products'**
  String get deviceShopErrorLoadingProducts;

  /// No description provided for @deviceShopFavoritesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get deviceShopFavoritesTooltip;

  /// No description provided for @deviceShopFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get deviceShopFeatured;

  /// No description provided for @deviceShopHelpTooltip.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get deviceShopHelpTooltip;

  /// No description provided for @deviceShopMarketplaceDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Purchases are completed on the seller\'s official store. Socialmesh does not handle payment, shipping, warranty, or returns.'**
  String get deviceShopMarketplaceDisclaimer;

  /// No description provided for @deviceShopMarketplaceInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Marketplace Information'**
  String get deviceShopMarketplaceInfoTitle;

  /// No description provided for @deviceShopNewArrivals.
  ///
  /// In en, this message translates to:
  /// **'New Arrivals'**
  String get deviceShopNewArrivals;

  /// No description provided for @deviceShopNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get deviceShopNoInternet;

  /// No description provided for @deviceShopNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String deviceShopNoResults(String query);

  /// No description provided for @deviceShopOfficialPartners.
  ///
  /// In en, this message translates to:
  /// **'Official Partners'**
  String get deviceShopOfficialPartners;

  /// No description provided for @deviceShopOnSale.
  ///
  /// In en, this message translates to:
  /// **'On Sale'**
  String get deviceShopOnSale;

  /// No description provided for @deviceShopOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'OUT OF STOCK'**
  String get deviceShopOutOfStock;

  /// No description provided for @deviceShopPopularDevices.
  ///
  /// In en, this message translates to:
  /// **'Popular Devices'**
  String get deviceShopPopularDevices;

  /// No description provided for @deviceShopRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get deviceShopRecentSearches;

  /// No description provided for @deviceShopRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get deviceShopRetry;

  /// No description provided for @deviceShopSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search devices, modules, antennas...'**
  String get deviceShopSearchHint;

  /// No description provided for @deviceShopSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get deviceShopSeeAll;

  /// No description provided for @deviceShopSellYourDevices.
  ///
  /// In en, this message translates to:
  /// **'Sell your Meshtastic devices'**
  String get deviceShopSellYourDevices;

  /// No description provided for @deviceShopSupportEmail.
  ///
  /// In en, this message translates to:
  /// **'support@socialmesh.app'**
  String get deviceShopSupportEmail;

  /// No description provided for @deviceShopTitle.
  ///
  /// In en, this message translates to:
  /// **'Device Shop'**
  String get deviceShopTitle;

  /// No description provided for @deviceShopTrending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get deviceShopTrending;

  /// No description provided for @deviceShopTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again in a moment'**
  String get deviceShopTryAgain;

  /// No description provided for @deviceShopTryDifferentKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try different keywords'**
  String get deviceShopTryDifferentKeywords;

  /// No description provided for @deviceShopUnableToLoad.
  ///
  /// In en, this message translates to:
  /// **'Unable to load products'**
  String get deviceShopUnableToLoad;

  /// Badge label shown on newly discovered node cards.
  ///
  /// In en, this message translates to:
  /// **'DISCOVERED'**
  String get discoveryDiscoveredBadge;

  /// Subtitle showing the number of discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 node found} other{{count} nodes found}}'**
  String discoveryNodesFound(int count);

  /// Title shown in the discovery overlay while scanning for mesh nodes.
  ///
  /// In en, this message translates to:
  /// **'Scanning Network'**
  String get discoveryScanningNetwork;

  /// Subtitle shown while no nodes have been discovered yet.
  ///
  /// In en, this message translates to:
  /// **'Searching for nodes...'**
  String get discoverySearchingForNodes;

  /// Signal quality label for strong RSSI values.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get discoverySignalExcellent;

  /// Signal quality label for moderate RSSI values.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get discoverySignalGood;

  /// Signal quality label for poor RSSI values.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get discoverySignalWeak;

  /// Fallback display name for a discovered node with no name.
  ///
  /// In en, this message translates to:
  /// **'Unknown Node'**
  String get discoveryUnknownNode;

  /// Label for the Admin Dashboard menu tile in the navigation drawer.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get drawerAdminDashboard;

  /// Section header for the admin area in the navigation drawer.
  ///
  /// In en, this message translates to:
  /// **'ADMIN'**
  String get drawerAdminSectionHeader;

  /// Badge label for newly added drawer menu items.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get drawerBadgeNew;

  /// Badge label for locked premium features in the drawer.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get drawerBadgePro;

  /// Badge label for premium features available to try in the drawer.
  ///
  /// In en, this message translates to:
  /// **'TRY IT'**
  String get drawerBadgeTryIt;

  /// Label for the Device Management menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Device Management'**
  String get drawerEnterpriseDeviceManagement;

  /// Tooltip shown when a user without sufficient role tries to access export reports.
  ///
  /// In en, this message translates to:
  /// **'Requires Supervisor or Admin role'**
  String get drawerEnterpriseExportDenied;

  /// Label for the Field Reports menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Field Reports'**
  String get drawerEnterpriseFieldReports;

  /// Label for the Incidents menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Incidents'**
  String get drawerEnterpriseIncidents;

  /// Label for the Org Settings menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Org Settings'**
  String get drawerEnterpriseOrgSettings;

  /// Label for the Reports menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get drawerEnterpriseReports;

  /// Section header for the enterprise (RBAC) area in the navigation drawer.
  ///
  /// In en, this message translates to:
  /// **'ENTERPRISE'**
  String get drawerEnterpriseSectionHeader;

  /// Label for the Tasks menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get drawerEnterpriseTasks;

  /// Label for the User Management menu tile in the enterprise drawer section.
  ///
  /// In en, this message translates to:
  /// **'User Management'**
  String get drawerEnterpriseUserManagement;

  /// Fallback node name shown in drawer header when no device is connected.
  ///
  /// In en, this message translates to:
  /// **'Not Connected'**
  String get drawerNodeNotConnected;

  /// Connection status chip label when the device is disconnected.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get drawerNodeOffline;

  /// Connection status chip label when the device is connected.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get drawerNodeOnline;

  /// Explorer title for 50-99 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Cartographer'**
  String get explorerTitleCartographer;

  /// Description for the Cartographer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Mapping the invisible infrastructure'**
  String get explorerTitleCartographerDescription;

  /// Explorer title for 20-49 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get explorerTitleExplorer;

  /// Description for the Explorer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Actively discovering the network'**
  String get explorerTitleExplorerDescription;

  /// Explorer title for the longest distance record above 10 km.
  ///
  /// In en, this message translates to:
  /// **'Long-Range Record Holder'**
  String get explorerTitleLongRangeRecordHolder;

  /// Description for the Long-Range Record Holder explorer title.
  ///
  /// In en, this message translates to:
  /// **'Pushing the limits of range'**
  String get explorerTitleLongRangeRecordHolderDescription;

  /// Explorer title for 200+ nodes AND 5+ regions.
  ///
  /// In en, this message translates to:
  /// **'Mesh Cartographer'**
  String get explorerTitleMeshCartographer;

  /// Description for the Mesh Cartographer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Charting regions and routes'**
  String get explorerTitleMeshCartographerDescription;

  /// Explorer title for 200+ discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Mesh Veteran'**
  String get explorerTitleMeshVeteran;

  /// Description for the Mesh Veteran explorer title.
  ///
  /// In en, this message translates to:
  /// **'Deep knowledge of the mesh'**
  String get explorerTitleMeshVeteranDescription;

  /// Explorer title for fewer than 5 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Newcomer'**
  String get explorerTitleNewcomer;

  /// Description for the Newcomer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Beginning the mesh journey'**
  String get explorerTitleNewcomerDescription;

  /// Explorer title for 5-19 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Observer'**
  String get explorerTitleObserver;

  /// Description for the Observer explorer title.
  ///
  /// In en, this message translates to:
  /// **'Building awareness of the mesh'**
  String get explorerTitleObserverDescription;

  /// Explorer title for 100-199 discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'Signal Hunter'**
  String get explorerTitleSignalHunter;

  /// Description for the Signal Hunter explorer title.
  ///
  /// In en, this message translates to:
  /// **'Seeking signals across the spectrum'**
  String get explorerTitleSignalHunterDescription;

  /// No description provided for @favoritesCancelCompare.
  ///
  /// In en, this message translates to:
  /// **'Cancel compare'**
  String get favoritesCancelCompare;

  /// No description provided for @favoritesCannotCompare.
  ///
  /// In en, this message translates to:
  /// **'Cannot compare nodes not in mesh'**
  String get favoritesCannotCompare;

  /// No description provided for @favoritesCharging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get favoritesCharging;

  /// No description provided for @favoritesCompareNodes.
  ///
  /// In en, this message translates to:
  /// **'Compare nodes'**
  String get favoritesCompareNodes;

  /// No description provided for @favoritesDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get favoritesDelete;

  /// No description provided for @favoritesEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap the star icon on any node to add it to your favorites for quick access.'**
  String get favoritesEmptyDescription;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Favorites Yet'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading favorites'**
  String get favoritesErrorLoading;

  /// No description provided for @favoritesNodeNotInMesh.
  ///
  /// In en, this message translates to:
  /// **'Node not currently in mesh. Check back later.'**
  String get favoritesNodeNotInMesh;

  /// No description provided for @favoritesNotInMesh.
  ///
  /// In en, this message translates to:
  /// **'Not in mesh'**
  String get favoritesNotInMesh;

  /// No description provided for @favoritesRemoveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get favoritesRemoveConfirm;

  /// No description provided for @favoritesRemoveMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from your favorites?'**
  String favoritesRemoveMessage(String name);

  /// No description provided for @favoritesRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Favorite?'**
  String get favoritesRemoveTitle;

  /// No description provided for @favoritesRemoveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get favoritesRemoveTooltip;

  /// No description provided for @favoritesRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get favoritesRetry;

  /// No description provided for @favoritesSelectFirst.
  ///
  /// In en, this message translates to:
  /// **'Select first node'**
  String get favoritesSelectFirst;

  /// No description provided for @favoritesSelectSecond.
  ///
  /// In en, this message translates to:
  /// **'Select second node'**
  String get favoritesSelectSecond;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorite Nodes'**
  String get favoritesTitle;

  /// No description provided for @featuredProductsDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get featuredProductsDiscard;

  /// No description provided for @featuredProductsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No featured products'**
  String get featuredProductsEmpty;

  /// No description provided for @featuredProductsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mark products as featured to manage their order here'**
  String get featuredProductsEmptySubtitle;

  /// No description provided for @featuredProductsOrderUpdated.
  ///
  /// In en, this message translates to:
  /// **'Featured order updated'**
  String get featuredProductsOrderUpdated;

  /// No description provided for @featuredProductsRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get featuredProductsRemove;

  /// No description provided for @featuredProductsRemoveMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from featured products?'**
  String featuredProductsRemoveMessage(String name);

  /// No description provided for @featuredProductsRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove from Featured'**
  String get featuredProductsRemoveTitle;

  /// No description provided for @featuredProductsRemoveTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from featured'**
  String get featuredProductsRemoveTooltip;

  /// No description provided for @featuredProductsRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from featured'**
  String get featuredProductsRemoved;

  /// No description provided for @featuredProductsReorderInfo.
  ///
  /// In en, this message translates to:
  /// **'Drag and drop products to reorder. Products at the top will appear first in the featured section.'**
  String get featuredProductsReorderInfo;

  /// No description provided for @featuredProductsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get featuredProductsSave;

  /// No description provided for @featuredProductsTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Products'**
  String get featuredProductsTitle;

  /// No description provided for @featuredProductsUnsavedChanges.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes'**
  String get featuredProductsUnsavedChanges;

  /// No description provided for @firmwareUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get firmwareUpdateAvailable;

  /// No description provided for @firmwareUpdateBackupWarningSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Firmware updates may reset your device configuration. Consider exporting your settings before updating.'**
  String get firmwareUpdateBackupWarningSubtitle;

  /// No description provided for @firmwareUpdateBackupWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup Your Settings'**
  String get firmwareUpdateBackupWarningTitle;

  /// No description provided for @firmwareUpdateBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get firmwareUpdateBluetooth;

  /// No description provided for @firmwareUpdateCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to check for updates'**
  String get firmwareUpdateCheckFailed;

  /// No description provided for @firmwareUpdateChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking for updates...'**
  String get firmwareUpdateChecking;

  /// No description provided for @firmwareUpdateDownload.
  ///
  /// In en, this message translates to:
  /// **'Download Update'**
  String get firmwareUpdateDownload;

  /// No description provided for @firmwareUpdateHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get firmwareUpdateHardware;

  /// No description provided for @firmwareUpdateInstalledFirmware.
  ///
  /// In en, this message translates to:
  /// **'Installed Firmware'**
  String get firmwareUpdateInstalledFirmware;

  /// No description provided for @firmwareUpdateLatestVersion.
  ///
  /// In en, this message translates to:
  /// **'Latest: {version}'**
  String firmwareUpdateLatestVersion(String version);

  /// No description provided for @firmwareUpdateNewBadge.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get firmwareUpdateNewBadge;

  /// No description provided for @firmwareUpdateNodeId.
  ///
  /// In en, this message translates to:
  /// **'Node ID'**
  String get firmwareUpdateNodeId;

  /// No description provided for @firmwareUpdateOpenWebFlasher.
  ///
  /// In en, this message translates to:
  /// **'Open Web Flasher'**
  String get firmwareUpdateOpenWebFlasher;

  /// No description provided for @firmwareUpdateReleaseNotes.
  ///
  /// In en, this message translates to:
  /// **'Release Notes'**
  String get firmwareUpdateReleaseNotes;

  /// No description provided for @firmwareUpdateSectionAvailableUpdate.
  ///
  /// In en, this message translates to:
  /// **'Available Update'**
  String get firmwareUpdateSectionAvailableUpdate;

  /// No description provided for @firmwareUpdateSectionCurrentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current Version'**
  String get firmwareUpdateSectionCurrentVersion;

  /// No description provided for @firmwareUpdateSectionHowToUpdate.
  ///
  /// In en, this message translates to:
  /// **'How to Update'**
  String get firmwareUpdateSectionHowToUpdate;

  /// No description provided for @firmwareUpdateStep1.
  ///
  /// In en, this message translates to:
  /// **'Download the firmware file for your device'**
  String get firmwareUpdateStep1;

  /// No description provided for @firmwareUpdateStep2.
  ///
  /// In en, this message translates to:
  /// **'Connect your device via USB'**
  String get firmwareUpdateStep2;

  /// No description provided for @firmwareUpdateStep3.
  ///
  /// In en, this message translates to:
  /// **'Use the Meshtastic Web Flasher or CLI to flash'**
  String get firmwareUpdateStep3;

  /// No description provided for @firmwareUpdateStep4.
  ///
  /// In en, this message translates to:
  /// **'Wait for device to reboot and reconnect'**
  String get firmwareUpdateStep4;

  /// No description provided for @firmwareUpdateSupported.
  ///
  /// In en, this message translates to:
  /// **'Supported'**
  String get firmwareUpdateSupported;

  /// No description provided for @firmwareUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Firmware Update'**
  String get firmwareUpdateTitle;

  /// No description provided for @firmwareUpdateUnableToCheck.
  ///
  /// In en, this message translates to:
  /// **'Unable to check for updates'**
  String get firmwareUpdateUnableToCheck;

  /// No description provided for @firmwareUpdateUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get firmwareUpdateUnknown;

  /// No description provided for @firmwareUpdateUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Up to Date'**
  String get firmwareUpdateUpToDate;

  /// No description provided for @firmwareUpdateUptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get firmwareUpdateUptime;

  /// No description provided for @firmwareUpdateVisitWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit the Meshtastic website for the latest firmware.'**
  String get firmwareUpdateVisitWebsite;

  /// No description provided for @firmwareUpdateWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get firmwareUpdateWifi;

  /// No description provided for @globeEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Nodes with position data will appear here'**
  String get globeEmptyDescription;

  /// No description provided for @globeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No nodes with GPS'**
  String get globeEmptyTitle;

  /// No description provided for @globeHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get globeHelp;

  /// No description provided for @globeHideConnections.
  ///
  /// In en, this message translates to:
  /// **'Hide connections'**
  String get globeHideConnections;

  /// No description provided for @globeNodeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes'**
  String globeNodeCount(int count);

  /// No description provided for @globeResetView.
  ///
  /// In en, this message translates to:
  /// **'Reset view'**
  String get globeResetView;

  /// No description provided for @globeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Mesh Globe'**
  String get globeScreenTitle;

  /// No description provided for @globeSelectNode.
  ///
  /// In en, this message translates to:
  /// **'Select Node'**
  String get globeSelectNode;

  /// No description provided for @globeShowConnections.
  ///
  /// In en, this message translates to:
  /// **'Show connections'**
  String get globeShowConnections;

  /// No description provided for @gpsStatusAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get gpsStatusAccuracy;

  /// No description provided for @gpsStatusAccuracyValue.
  ///
  /// In en, this message translates to:
  /// **'±{meters}m'**
  String gpsStatusAccuracyValue(String meters);

  /// No description provided for @gpsStatusAcquiring.
  ///
  /// In en, this message translates to:
  /// **'Acquiring GPS...'**
  String get gpsStatusAcquiring;

  /// No description provided for @gpsStatusActiveBadge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get gpsStatusActiveBadge;

  /// No description provided for @gpsStatusAltitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get gpsStatusAltitude;

  /// No description provided for @gpsStatusAltitudeValue.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String gpsStatusAltitudeValue(String meters);

  /// No description provided for @gpsStatusCardinalE.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get gpsStatusCardinalE;

  /// No description provided for @gpsStatusCardinalN.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get gpsStatusCardinalN;

  /// No description provided for @gpsStatusCardinalNE.
  ///
  /// In en, this message translates to:
  /// **'NE'**
  String get gpsStatusCardinalNE;

  /// No description provided for @gpsStatusCardinalNW.
  ///
  /// In en, this message translates to:
  /// **'NW'**
  String get gpsStatusCardinalNW;

  /// No description provided for @gpsStatusCardinalS.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get gpsStatusCardinalS;

  /// No description provided for @gpsStatusCardinalSE.
  ///
  /// In en, this message translates to:
  /// **'SE'**
  String get gpsStatusCardinalSE;

  /// No description provided for @gpsStatusCardinalSW.
  ///
  /// In en, this message translates to:
  /// **'SW'**
  String get gpsStatusCardinalSW;

  /// No description provided for @gpsStatusCardinalW.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get gpsStatusCardinalW;

  /// No description provided for @gpsStatusDateAt.
  ///
  /// In en, this message translates to:
  /// **'{date} {time}'**
  String gpsStatusDateAt(String date, String time);

  /// No description provided for @gpsStatusDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String gpsStatusDaysAgo(int count);

  /// No description provided for @gpsStatusFixAcquired.
  ///
  /// In en, this message translates to:
  /// **'GPS Fix Acquired'**
  String get gpsStatusFixAcquired;

  /// No description provided for @gpsStatusGroundSpeed.
  ///
  /// In en, this message translates to:
  /// **'Ground Speed'**
  String get gpsStatusGroundSpeed;

  /// No description provided for @gpsStatusGroundSpeedValue.
  ///
  /// In en, this message translates to:
  /// **'{mps} m/s ({kmh} km/h)'**
  String gpsStatusGroundSpeedValue(String mps, String kmh);

  /// No description provided for @gpsStatusGroundTrack.
  ///
  /// In en, this message translates to:
  /// **'Ground Track'**
  String get gpsStatusGroundTrack;

  /// No description provided for @gpsStatusGroundTrackValue.
  ///
  /// In en, this message translates to:
  /// **'{degrees}° {direction}'**
  String gpsStatusGroundTrackValue(String degrees, String direction);

  /// No description provided for @gpsStatusHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String gpsStatusHoursAgo(int count);

  /// No description provided for @gpsStatusLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get gpsStatusLatitude;

  /// No description provided for @gpsStatusLatitudeValue.
  ///
  /// In en, this message translates to:
  /// **'{value}°'**
  String gpsStatusLatitudeValue(String value);

  /// No description provided for @gpsStatusLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get gpsStatusLongitude;

  /// No description provided for @gpsStatusLongitudeValue.
  ///
  /// In en, this message translates to:
  /// **'{value}°'**
  String gpsStatusLongitudeValue(String value);

  /// No description provided for @gpsStatusMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String gpsStatusMinutesAgo(int count);

  /// No description provided for @gpsStatusNoGpsFix.
  ///
  /// In en, this message translates to:
  /// **'No GPS Fix'**
  String get gpsStatusNoGpsFix;

  /// No description provided for @gpsStatusNoGpsFixMessage.
  ///
  /// In en, this message translates to:
  /// **'The device has not acquired a GPS position yet. Make sure the device has a clear view of the sky.'**
  String get gpsStatusNoGpsFixMessage;

  /// No description provided for @gpsStatusOpenInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get gpsStatusOpenInMaps;

  /// No description provided for @gpsStatusPrecisionBits.
  ///
  /// In en, this message translates to:
  /// **'Precision Bits'**
  String get gpsStatusPrecisionBits;

  /// No description provided for @gpsStatusSatFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get gpsStatusSatFair;

  /// No description provided for @gpsStatusSatGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get gpsStatusSatGood;

  /// No description provided for @gpsStatusSatNoFix.
  ///
  /// In en, this message translates to:
  /// **'No Fix'**
  String get gpsStatusSatNoFix;

  /// No description provided for @gpsStatusSatPoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get gpsStatusSatPoor;

  /// No description provided for @gpsStatusSatellitesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} satellites in view'**
  String gpsStatusSatellitesCount(int count);

  /// No description provided for @gpsStatusSatellitesInView.
  ///
  /// In en, this message translates to:
  /// **'Satellites in View'**
  String get gpsStatusSatellitesInView;

  /// No description provided for @gpsStatusSearchingSatellites.
  ///
  /// In en, this message translates to:
  /// **'Searching for satellites...'**
  String get gpsStatusSearchingSatellites;

  /// No description provided for @gpsStatusSecondsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} seconds ago'**
  String gpsStatusSecondsAgo(int count);

  /// No description provided for @gpsStatusSectionLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last Update'**
  String get gpsStatusSectionLastUpdate;

  /// No description provided for @gpsStatusSectionMotion.
  ///
  /// In en, this message translates to:
  /// **'Motion'**
  String get gpsStatusSectionMotion;

  /// No description provided for @gpsStatusSectionPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get gpsStatusSectionPosition;

  /// No description provided for @gpsStatusSectionSatellites.
  ///
  /// In en, this message translates to:
  /// **'Satellites'**
  String get gpsStatusSectionSatellites;

  /// No description provided for @gpsStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'GPS Status'**
  String get gpsStatusTitle;

  /// No description provided for @gpsStatusTodayAt.
  ///
  /// In en, this message translates to:
  /// **'Today at {time}'**
  String gpsStatusTodayAt(String time);

  /// No description provided for @gpsStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get gpsStatusUnknown;

  /// Error text shown when a help article fails to load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load article'**
  String get helpArticleLoadFailed;

  /// Reading time estimate shown on a help article.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min read'**
  String helpArticleMinRead(int minutes);

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

  /// Suffix label on the progress counter in the help center.
  ///
  /// In en, this message translates to:
  /// **'articles read'**
  String get helpCenterArticlesRead;

  /// Empty state subtitle when all articles have been read.
  ///
  /// In en, this message translates to:
  /// **'Come back anytime to refresh your knowledge.'**
  String get helpCenterComeBackToRefresh;

  /// Badge label on a completed help article.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get helpCenterCompleted;

  /// Helper text when no articles are available yet.
  ///
  /// In en, this message translates to:
  /// **'Help content is being prepared. Check back soon.'**
  String get helpCenterContentBeingPrepared;

  /// Label for the All filter chip in the help center.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get helpCenterFilterAll;

  /// Label shown on a help article chip indicating where the feature lives.
  ///
  /// In en, this message translates to:
  /// **'Find this in: {screenName}'**
  String helpCenterFindThisIn(String screenName);

  /// Subtitle for the haptic feedback toggle in help preferences.
  ///
  /// In en, this message translates to:
  /// **'Vibrate during typewriter text effect'**
  String get helpCenterHapticFeedbackSubtitle;

  /// Title for the haptic feedback toggle in help preferences.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get helpCenterHapticFeedbackTitle;

  /// Section header for the help preferences section.
  ///
  /// In en, this message translates to:
  /// **'HELP PREFERENCES'**
  String get helpCenterHelpPreferences;

  /// Section title for the interactive tours section of the help center.
  ///
  /// In en, this message translates to:
  /// **'Interactive Tours'**
  String get helpCenterInteractiveTours;

  /// Empty state title when no articles have been read yet.
  ///
  /// In en, this message translates to:
  /// **'Learn how Meshtastic works'**
  String get helpCenterLearnHowItWorks;

  /// Error text shown when the help center content fails to load.
  ///
  /// In en, this message translates to:
  /// **'Failed to load help content'**
  String get helpCenterLoadFailed;

  /// Button label to mark a help article as read.
  ///
  /// In en, this message translates to:
  /// **'Mark as Complete'**
  String get helpCenterMarkAsComplete;

  /// Empty state text shown when there are no articles at all.
  ///
  /// In en, this message translates to:
  /// **'No articles available'**
  String get helpCenterNoArticlesAvailable;

  /// Empty state text when the selected category has no articles.
  ///
  /// In en, this message translates to:
  /// **'No articles in this category'**
  String get helpCenterNoArticlesInCategory;

  /// Empty state text when the article search returns no results.
  ///
  /// In en, this message translates to:
  /// **'No articles match your search.\nTry different keywords.'**
  String get helpCenterNoArticlesMatchSearch;

  /// Empty state title when all articles have been read.
  ///
  /// In en, this message translates to:
  /// **'You’ve read everything!'**
  String get helpCenterReadEverything;

  /// Button label to reset all help progress.
  ///
  /// In en, this message translates to:
  /// **'Reset All Progress'**
  String get helpCenterResetAllProgress;

  /// Confirm label on the reset help progress sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get helpCenterResetProgressLabel;

  /// Body of the reset help progress confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will mark all articles as unread and reset interactive tour progress. You can start fresh.'**
  String get helpCenterResetProgressMessage;

  /// Title of the reset help progress confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset Help Progress?'**
  String get helpCenterResetProgressTitle;

  /// Screen name shown in help article topic chips for the Aether screen.
  ///
  /// In en, this message translates to:
  /// **'Aether'**
  String get helpCenterScreenAether;

  /// Screen name shown in help article topic chips for the Automations screen.
  ///
  /// In en, this message translates to:
  /// **'Automations'**
  String get helpCenterScreenAutomations;

  /// Screen name shown in help article topic chips for the Channels screen.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get helpCenterScreenChannels;

  /// Screen name shown in help article topic chips for the Create Signal screen.
  ///
  /// In en, this message translates to:
  /// **'Create Signal'**
  String get helpCenterScreenCreateSignal;

  /// Screen name shown in help article topic chips for the Device Shop screen.
  ///
  /// In en, this message translates to:
  /// **'Device Shop'**
  String get helpCenterScreenDeviceShop;

  /// Screen name shown in help article topic chips for the Globe screen.
  ///
  /// In en, this message translates to:
  /// **'Globe'**
  String get helpCenterScreenGlobe;

  /// Screen name shown in help article topic chips for the Map screen.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get helpCenterScreenMap;

  /// Screen name shown in help article topic chips for the Mesh 3D screen.
  ///
  /// In en, this message translates to:
  /// **'Mesh 3D'**
  String get helpCenterScreenMesh3d;

  /// Screen name shown in help article topic chips for the Mesh Health screen.
  ///
  /// In en, this message translates to:
  /// **'Mesh Health'**
  String get helpCenterScreenMeshHealth;

  /// Screen name shown in help article topic chips for the Messages screen.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get helpCenterScreenMessages;

  /// Screen name shown in help article topic chips for the NodeDex screen.
  ///
  /// In en, this message translates to:
  /// **'NodeDex'**
  String get helpCenterScreenNodeDex;

  /// Screen name shown in help article topic chips for the Nodes screen.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get helpCenterScreenNodes;

  /// Screen name shown in help article topic chips for the Presence screen.
  ///
  /// In en, this message translates to:
  /// **'Presence'**
  String get helpCenterScreenPresence;

  /// Screen name shown in help article topic chips for the Profile screen.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get helpCenterScreenProfile;

  /// Screen name shown in help article topic chips for the Radio Config screen.
  ///
  /// In en, this message translates to:
  /// **'Radio Config'**
  String get helpCenterScreenRadioConfig;

  /// Screen name shown in help article topic chips for the Reachability screen.
  ///
  /// In en, this message translates to:
  /// **'Reachability'**
  String get helpCenterScreenReachability;

  /// Screen name shown in help article topic chips for the Region Selection screen.
  ///
  /// In en, this message translates to:
  /// **'Region Selection'**
  String get helpCenterScreenRegionSelection;

  /// Screen name shown in help article topic chips for the Routes screen.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get helpCenterScreenRoutes;

  /// Screen name shown in help article topic chips for the Scanner screen.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get helpCenterScreenScanner;

  /// Screen name shown in help article topic chips for the Settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get helpCenterScreenSettings;

  /// Screen name shown in help article topic chips for the Signal Feed screen.
  ///
  /// In en, this message translates to:
  /// **'Signal Feed'**
  String get helpCenterScreenSignalFeed;

  /// Screen name shown in help article topic chips for the TAK Gateway screen.
  ///
  /// In en, this message translates to:
  /// **'TAK Gateway'**
  String get helpCenterScreenTakGateway;

  /// Screen name shown in help article topic chips for the Timeline screen.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get helpCenterScreenTimeline;

  /// Screen name shown in help article topic chips for the Trace Route Log screen.
  ///
  /// In en, this message translates to:
  /// **'Trace Route Log'**
  String get helpCenterScreenTraceRouteLog;

  /// Screen name shown in help article topic chips for the Widget Builder screen.
  ///
  /// In en, this message translates to:
  /// **'Widget Builder'**
  String get helpCenterScreenWidgetBuilder;

  /// Screen name shown in help article topic chips for the Widget Dashboard screen.
  ///
  /// In en, this message translates to:
  /// **'Widget Dashboard'**
  String get helpCenterScreenWidgetDashboard;

  /// Screen name shown in help article topic chips for the Widget Marketplace screen.
  ///
  /// In en, this message translates to:
  /// **'Widget Marketplace'**
  String get helpCenterScreenWidgetMarketplace;

  /// Screen name shown in help article topic chips for the World Mesh screen.
  ///
  /// In en, this message translates to:
  /// **'World Mesh'**
  String get helpCenterScreenWorldMesh;

  /// Helper description shown in the search empty state.
  ///
  /// In en, this message translates to:
  /// **'Search by article title\nor description.'**
  String get helpCenterSearchByTitle;

  /// Hint text in the help center article search field.
  ///
  /// In en, this message translates to:
  /// **'Search articles'**
  String get helpCenterSearchHint;

  /// Subtitle for the show help hints preference toggle.
  ///
  /// In en, this message translates to:
  /// **'Display pulsing help buttons on screens'**
  String get helpCenterShowHelpHintsSubtitle;

  /// Title for the show help hints preference toggle.
  ///
  /// In en, this message translates to:
  /// **'Show Help Hints'**
  String get helpCenterShowHelpHintsTitle;

  /// Empty state subtitle when no articles have been read yet.
  ///
  /// In en, this message translates to:
  /// **'Tap an article to learn about mesh networking, radio settings, and more.'**
  String get helpCenterTapToLearn;

  /// Title of the help center screen.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenterTitle;

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

  /// Helper text in the no-articles-in-category empty state.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different category from the filter chips above.'**
  String get helpCenterTryDifferentCategory;

  /// No description provided for @lilygoModelPriceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Price unavailable'**
  String get lilygoModelPriceUnavailable;

  /// Button label to link the device.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get linkDeviceBannerLinkButton;

  /// Error snackbar when device linking fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to link: {error}'**
  String linkDeviceBannerLinkError(String error);

  /// Success snackbar after linking a device to the user profile.
  ///
  /// In en, this message translates to:
  /// **'Device linked to your profile!'**
  String get linkDeviceBannerLinkedSuccess;

  /// Subtitle text on the link device banner.
  ///
  /// In en, this message translates to:
  /// **'Others can find and follow you'**
  String get linkDeviceBannerSubtitle;

  /// Title text on the link device banner.
  ///
  /// In en, this message translates to:
  /// **'Link this device to your profile'**
  String get linkDeviceBannerTitle;

  /// No description provided for @mapAgeHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String mapAgeHours(String hours);

  /// No description provided for @mapAgeMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String mapAgeMinutes(String minutes);

  /// No description provided for @mapAgeSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s ago'**
  String mapAgeSeconds(String seconds);

  /// No description provided for @mapCoordinatesCopied.
  ///
  /// In en, this message translates to:
  /// **'Coordinates copied to clipboard'**
  String get mapCoordinatesCopied;

  /// No description provided for @mapCopyBothCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Both A and B coordinates'**
  String get mapCopyBothCoordinates;

  /// No description provided for @mapCopyCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Copy Coordinates'**
  String get mapCopyCoordinates;

  /// No description provided for @mapCopyCoordinatesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy coordinates'**
  String get mapCopyCoordinatesTooltip;

  /// No description provided for @mapCopySummary.
  ///
  /// In en, this message translates to:
  /// **'Copy Summary'**
  String get mapCopySummary;

  /// No description provided for @mapDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get mapDelete;

  /// No description provided for @mapDismissTooltip.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get mapDismissTooltip;

  /// No description provided for @mapDistance10Km.
  ///
  /// In en, this message translates to:
  /// **'10 km'**
  String get mapDistance10Km;

  /// No description provided for @mapDistance1Km.
  ///
  /// In en, this message translates to:
  /// **'1 km'**
  String get mapDistance1Km;

  /// No description provided for @mapDistance25Km.
  ///
  /// In en, this message translates to:
  /// **'25 km'**
  String get mapDistance25Km;

  /// No description provided for @mapDistance5Km.
  ///
  /// In en, this message translates to:
  /// **'5 km'**
  String get mapDistance5Km;

  /// No description provided for @mapDistanceAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get mapDistanceAll;

  /// No description provided for @mapDistanceKilometers.
  ///
  /// In en, this message translates to:
  /// **'{km}km'**
  String mapDistanceKilometers(String km);

  /// No description provided for @mapDistanceKilometersFormal.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String mapDistanceKilometersFormal(String km);

  /// No description provided for @mapDistanceKilometersPrecise.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String mapDistanceKilometersPrecise(String km);

  /// No description provided for @mapDistanceKilometersRound.
  ///
  /// In en, this message translates to:
  /// **'{km}km'**
  String mapDistanceKilometersRound(String km);

  /// No description provided for @mapDistanceMeters.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String mapDistanceMeters(String meters);

  /// No description provided for @mapDistanceMetersFormal.
  ///
  /// In en, this message translates to:
  /// **'{meters} m'**
  String mapDistanceMetersFormal(String meters);

  /// No description provided for @mapDropWaypoint.
  ///
  /// In en, this message translates to:
  /// **'Drop Waypoint'**
  String get mapDropWaypoint;

  /// No description provided for @mapEmptyBodyNoNodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes will appear on the map once they\nreport their GPS position.'**
  String get mapEmptyBodyNoNodes;

  /// No description provided for @mapEmptyBodyWithNodes.
  ///
  /// In en, this message translates to:
  /// **'{totalNodes} nodes discovered but none have\nreported GPS position yet.'**
  String mapEmptyBodyWithNodes(int totalNodes);

  /// No description provided for @mapEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Nodes with GPS'**
  String get mapEmptyTitle;

  /// No description provided for @mapEntitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Entities'**
  String get mapEntitiesTitle;

  /// No description provided for @mapEstimatedPathLoss.
  ///
  /// In en, this message translates to:
  /// **'Estimated path loss: {pathLoss} dB (free-space)'**
  String mapEstimatedPathLoss(String pathLoss);

  /// No description provided for @mapExitMeasureMode.
  ///
  /// In en, this message translates to:
  /// **'Exit measure mode'**
  String get mapExitMeasureMode;

  /// No description provided for @mapExitMeasureModeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Exit measure mode'**
  String get mapExitMeasureModeTooltip;

  /// No description provided for @mapFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get mapFilterActive;

  /// No description provided for @mapFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get mapFilterAll;

  /// No description provided for @mapFilterInRange.
  ///
  /// In en, this message translates to:
  /// **'In Range'**
  String get mapFilterInRange;

  /// No description provided for @mapFilterInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get mapFilterInactive;

  /// No description provided for @mapFilterNodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Nodes'**
  String get mapFilterNodesTitle;

  /// No description provided for @mapFilterNodesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter nodes'**
  String get mapFilterNodesTooltip;

  /// No description provided for @mapFilterWithGps.
  ///
  /// In en, this message translates to:
  /// **'With GPS'**
  String get mapFilterWithGps;

  /// No description provided for @mapGlobeView.
  ///
  /// In en, this message translates to:
  /// **'3D Globe View'**
  String get mapGlobeView;

  /// No description provided for @mapHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get mapHelp;

  /// No description provided for @mapHideConnectionLines.
  ///
  /// In en, this message translates to:
  /// **'Hide connection lines'**
  String get mapHideConnectionLines;

  /// No description provided for @mapHideHeatmap.
  ///
  /// In en, this message translates to:
  /// **'Hide heatmap'**
  String get mapHideHeatmap;

  /// No description provided for @mapHidePositionHistory.
  ///
  /// In en, this message translates to:
  /// **'Hide position history'**
  String get mapHidePositionHistory;

  /// No description provided for @mapHideRangeCircles.
  ///
  /// In en, this message translates to:
  /// **'Hide range circles'**
  String get mapHideRangeCircles;

  /// No description provided for @mapHideTakEntities.
  ///
  /// In en, this message translates to:
  /// **'Hide TAK entities'**
  String get mapHideTakEntities;

  /// No description provided for @mapLastKnown.
  ///
  /// In en, this message translates to:
  /// **'• Last known'**
  String get mapLastKnown;

  /// No description provided for @mapLinkBudgetCopied.
  ///
  /// In en, this message translates to:
  /// **'Link budget copied to clipboard'**
  String get mapLinkBudgetCopied;

  /// No description provided for @mapLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get mapLocationTitle;

  /// No description provided for @mapLongPressForActions.
  ///
  /// In en, this message translates to:
  /// **'Long-press for actions'**
  String get mapLongPressForActions;

  /// No description provided for @mapLosAnalysis.
  ///
  /// In en, this message translates to:
  /// **'LOS Analysis'**
  String get mapLosAnalysis;

  /// No description provided for @mapLosAnalysisSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Earth curvature + Fresnel zone check'**
  String get mapLosAnalysisSubtitle;

  /// No description provided for @mapLosBulgeAndFresnel.
  ///
  /// In en, this message translates to:
  /// **'Bulge: {bulge}m · F1: {fresnel}m'**
  String mapLosBulgeAndFresnel(String bulge, String fresnel);

  /// No description provided for @mapLosVerdict.
  ///
  /// In en, this message translates to:
  /// **'LOS: {verdict}'**
  String mapLosVerdict(String verdict);

  /// No description provided for @mapMaxDistance.
  ///
  /// In en, this message translates to:
  /// **'Max Distance'**
  String get mapMaxDistance;

  /// No description provided for @mapMeasureDistance.
  ///
  /// In en, this message translates to:
  /// **'Measure distance'**
  String get mapMeasureDistance;

  /// No description provided for @mapMeasureMarkerA.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get mapMeasureMarkerA;

  /// No description provided for @mapMeasureMarkerB.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get mapMeasureMarkerB;

  /// No description provided for @mapMeasureTapPointA.
  ///
  /// In en, this message translates to:
  /// **'Tap node or map for point A'**
  String get mapMeasureTapPointA;

  /// No description provided for @mapMeasureTapPointB.
  ///
  /// In en, this message translates to:
  /// **'Tap node or map for point B'**
  String get mapMeasureTapPointB;

  /// No description provided for @mapMeasurementActions.
  ///
  /// In en, this message translates to:
  /// **'Measurement Actions'**
  String get mapMeasurementActions;

  /// No description provided for @mapMeasurementCopied.
  ///
  /// In en, this message translates to:
  /// **'Measurement copied to clipboard'**
  String get mapMeasurementCopied;

  /// No description provided for @mapNavigateToTooltip.
  ///
  /// In en, this message translates to:
  /// **'Navigate to'**
  String get mapNavigateToTooltip;

  /// No description provided for @mapNewMeasurement.
  ///
  /// In en, this message translates to:
  /// **'New measurement'**
  String get mapNewMeasurement;

  /// No description provided for @mapNoEntities.
  ///
  /// In en, this message translates to:
  /// **'No entities'**
  String get mapNoEntities;

  /// No description provided for @mapNoMatchingEntities.
  ///
  /// In en, this message translates to:
  /// **'No matching entities'**
  String get mapNoMatchingEntities;

  /// No description provided for @mapNodeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes'**
  String mapNodeCount(String count);

  /// No description provided for @mapNodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get mapNodesTitle;

  /// No description provided for @mapOpenInExternalApp.
  ///
  /// In en, this message translates to:
  /// **'Open in external map app'**
  String get mapOpenInExternalApp;

  /// No description provided for @mapOpenMidpointInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open Midpoint in Maps'**
  String get mapOpenMidpointInMaps;

  /// No description provided for @mapPositionBroadcastHint.
  ///
  /// In en, this message translates to:
  /// **'Position broadcasts can take up to 15 minutes.\nTap to request immediately.'**
  String get mapPositionBroadcastHint;

  /// No description provided for @mapRefreshPositions.
  ///
  /// In en, this message translates to:
  /// **'Refresh positions'**
  String get mapRefreshPositions;

  /// No description provided for @mapRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing...'**
  String get mapRefreshing;

  /// No description provided for @mapRequestPositions.
  ///
  /// In en, this message translates to:
  /// **'Request Positions'**
  String get mapRequestPositions;

  /// No description provided for @mapRequesting.
  ///
  /// In en, this message translates to:
  /// **'Requesting...'**
  String get mapRequesting;

  /// No description provided for @mapReverseDirection.
  ///
  /// In en, this message translates to:
  /// **'Reverse measurement direction'**
  String get mapReverseDirection;

  /// No description provided for @mapRfLinkBudget.
  ///
  /// In en, this message translates to:
  /// **'RF Link Budget'**
  String get mapRfLinkBudget;

  /// No description provided for @mapRfLinkBudgetClipboard.
  ///
  /// In en, this message translates to:
  /// **'RF Link Budget (free-space path loss)\nDistance: {distance}\nFrequency: {frequency}\nPath Loss: {pathLoss}\nLink Margin: {linkMargin}'**
  String mapRfLinkBudgetClipboard(
    String distance,
    String frequency,
    String pathLoss,
    String linkMargin,
  );

  /// No description provided for @mapSaDashboard.
  ///
  /// In en, this message translates to:
  /// **'SA Dashboard'**
  String get mapSaDashboard;

  /// No description provided for @mapScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Mesh Map'**
  String get mapScreenTitle;

  /// No description provided for @mapSearchEntitiesHint.
  ///
  /// In en, this message translates to:
  /// **'Search entities...'**
  String get mapSearchEntitiesHint;

  /// No description provided for @mapSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term'**
  String get mapSearchHint;

  /// No description provided for @mapSearchNodesHint.
  ///
  /// In en, this message translates to:
  /// **'Search nodes...'**
  String get mapSearchNodesHint;

  /// No description provided for @mapSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get mapSettings;

  /// No description provided for @mapShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get mapShare;

  /// No description provided for @mapShareDistanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance: {distance}'**
  String mapShareDistanceLabel(String distance);

  /// No description provided for @mapShareLocation.
  ///
  /// In en, this message translates to:
  /// **'Share Location'**
  String get mapShareLocation;

  /// No description provided for @mapShareMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Share Measurement'**
  String get mapShareMeasurement;

  /// No description provided for @mapShareMeasurementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share via system share sheet'**
  String get mapShareMeasurementSubtitle;

  /// No description provided for @mapShowConnectionLines.
  ///
  /// In en, this message translates to:
  /// **'Show connection lines'**
  String get mapShowConnectionLines;

  /// No description provided for @mapShowHeatmap.
  ///
  /// In en, this message translates to:
  /// **'Show heatmap'**
  String get mapShowHeatmap;

  /// No description provided for @mapShowPositionHistory.
  ///
  /// In en, this message translates to:
  /// **'Show position history'**
  String get mapShowPositionHistory;

  /// No description provided for @mapShowRangeCircles.
  ///
  /// In en, this message translates to:
  /// **'Show range circles'**
  String get mapShowRangeCircles;

  /// No description provided for @mapShowTakEntities.
  ///
  /// In en, this message translates to:
  /// **'Show TAK entities'**
  String get mapShowTakEntities;

  /// No description provided for @mapStyleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Map style'**
  String get mapStyleTooltip;

  /// No description provided for @mapSwapAB.
  ///
  /// In en, this message translates to:
  /// **'Swap A ↔ B'**
  String get mapSwapAB;

  /// No description provided for @mapTakActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get mapTakActive;

  /// No description provided for @mapTakActiveBadge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get mapTakActiveBadge;

  /// No description provided for @mapTakEntityCount.
  ///
  /// In en, this message translates to:
  /// **'• {count} entities'**
  String mapTakEntityCount(int count);

  /// No description provided for @mapTakStale.
  ///
  /// In en, this message translates to:
  /// **'Stale'**
  String get mapTakStale;

  /// No description provided for @mapTakStaleBadge.
  ///
  /// In en, this message translates to:
  /// **'STALE'**
  String get mapTakStaleBadge;

  /// No description provided for @mapTakTrack.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get mapTakTrack;

  /// No description provided for @mapTakTracked.
  ///
  /// In en, this message translates to:
  /// **'Tracked'**
  String get mapTakTracked;

  /// No description provided for @mapWaypointDefaultLabel.
  ///
  /// In en, this message translates to:
  /// **'WP {number}'**
  String mapWaypointDefaultLabel(int number);

  /// No description provided for @mapYouBadge.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get mapYouBadge;

  /// No description provided for @meshcoreConsoleCaptureCleared.
  ///
  /// In en, this message translates to:
  /// **'Capture cleared'**
  String get meshcoreConsoleCaptureCleared;

  /// No description provided for @meshcoreConsoleClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get meshcoreConsoleClear;

  /// No description provided for @meshcoreConsoleCopyHex.
  ///
  /// In en, this message translates to:
  /// **'Copy Hex'**
  String get meshcoreConsoleCopyHex;

  /// No description provided for @meshcoreConsoleDevBadge.
  ///
  /// In en, this message translates to:
  /// **'DEV'**
  String get meshcoreConsoleDevBadge;

  /// No description provided for @meshcoreConsoleFramesCaptured.
  ///
  /// In en, this message translates to:
  /// **'{count} frames captured'**
  String meshcoreConsoleFramesCaptured(int count);

  /// No description provided for @meshcoreConsoleHexCopied.
  ///
  /// In en, this message translates to:
  /// **'Hex log copied to clipboard'**
  String get meshcoreConsoleHexCopied;

  /// No description provided for @meshcoreConsoleNoFrames.
  ///
  /// In en, this message translates to:
  /// **'No frames captured yet'**
  String get meshcoreConsoleNoFrames;

  /// No description provided for @meshcoreConsoleRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get meshcoreConsoleRefresh;

  /// No description provided for @meshcoreConsoleTitle.
  ///
  /// In en, this message translates to:
  /// **'MeshCore Console'**
  String get meshcoreConsoleTitle;

  /// Info snackbar hint after navigating to channels tab.
  ///
  /// In en, this message translates to:
  /// **'Use the menu to create or join a channel'**
  String get meshcoreShellAddChannelHint;

  /// Info snackbar hint after navigating to contacts tab.
  ///
  /// In en, this message translates to:
  /// **'Use the + button to add a contact'**
  String get meshcoreShellAddContactHint;

  /// Subtitle for the Add Contact action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Scan QR or enter contact code'**
  String get meshcoreShellAddContactSubtitle;

  /// Success snackbar after sending a MeshCore contact discovery advertisement.
  ///
  /// In en, this message translates to:
  /// **'Advertisement sent - listen for responses'**
  String get meshcoreShellAdvertisementSent;

  /// Success snackbar after sending discovery advertisement from device sheet.
  ///
  /// In en, this message translates to:
  /// **'Advertisement sent - listening for responses'**
  String get meshcoreShellAdvertisementSentListening;

  /// Title for the App Settings action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get meshcoreShellAppSettings;

  /// Subtitle for the App Settings action tile in the device sheet.
  ///
  /// In en, this message translates to:
  /// **'Notifications, theme, preferences'**
  String get meshcoreShellAppSettingsSubtitle;

  /// Success snackbar after reconnecting to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Connected to {deviceName}'**
  String meshcoreShellConnectedTo(String deviceName);

  /// Fallback short device name for MeshCore when no name is saved.
  ///
  /// In en, this message translates to:
  /// **'MeshCore'**
  String get meshcoreShellDefaultDeviceName;

  /// Fallback full device name for MeshCore.
  ///
  /// In en, this message translates to:
  /// **'MeshCore Device'**
  String get meshcoreShellDefaultDeviceNameFull;

  /// Fallback avatar initials for MeshCore node.
  ///
  /// In en, this message translates to:
  /// **'MC'**
  String get meshcoreShellDefaultInitials;

  /// Error message when device self-info is not yet available.
  ///
  /// In en, this message translates to:
  /// **'Device info not available'**
  String get meshcoreShellDeviceInfoNotAvailable;

  /// Tooltip for the device status button in the MeshCore app bar.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get meshcoreShellDeviceTooltip;

  /// Button label and confirmation dialog title for disconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get meshcoreShellDisconnect;

  /// Confirmation dialog body when disconnecting from a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to disconnect from this MeshCore device?'**
  String get meshcoreShellDisconnectConfirmMessage;

  /// Banner text shown when the MeshCore device disconnects.
  ///
  /// In en, this message translates to:
  /// **'Disconnected from {deviceName}'**
  String meshcoreShellDisconnectedFrom(String deviceName);

  /// Button label while disconnection is in progress.
  ///
  /// In en, this message translates to:
  /// **'Disconnecting...'**
  String get meshcoreShellDisconnecting;

  /// Subtitle for the Discover Contacts action tile in the device sheet.
  ///
  /// In en, this message translates to:
  /// **'Send advertisement to find nearby nodes'**
  String get meshcoreShellDiscoverSubtitle;

  /// Drawer menu item label for adding a MeshCore channel.
  ///
  /// In en, this message translates to:
  /// **'Add Channel'**
  String get meshcoreShellDrawerAddChannel;

  /// Drawer menu item label for adding a MeshCore contact.
  ///
  /// In en, this message translates to:
  /// **'Add Contact'**
  String get meshcoreShellDrawerAddContact;

  /// Drawer disconnect button label.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get meshcoreShellDrawerDisconnect;

  /// Drawer menu item label for discovering nearby MeshCore contacts.
  ///
  /// In en, this message translates to:
  /// **'Discover Contacts'**
  String get meshcoreShellDrawerDiscoverContacts;

  /// Drawer menu item label for showing the user's own MeshCore contact QR code.
  ///
  /// In en, this message translates to:
  /// **'My Contact Code'**
  String get meshcoreShellDrawerMyContactCode;

  /// Section header for the MeshCore menu items in the drawer.
  ///
  /// In en, this message translates to:
  /// **'MESHCORE'**
  String get meshcoreShellDrawerSectionHeader;

  /// Drawer menu item label for MeshCore settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get meshcoreShellDrawerSettings;

  /// Info table label for the node ID row.
  ///
  /// In en, this message translates to:
  /// **'Node ID'**
  String get meshcoreShellInfoNodeId;

  /// Info table label for the node name row.
  ///
  /// In en, this message translates to:
  /// **'Node Name'**
  String get meshcoreShellInfoNodeName;

  /// Info table label for the protocol row.
  ///
  /// In en, this message translates to:
  /// **'Protocol'**
  String get meshcoreShellInfoProtocol;

  /// Info table protocol value for MeshCore.
  ///
  /// In en, this message translates to:
  /// **'MeshCore'**
  String get meshcoreShellInfoProtocolValue;

  /// Info table label for the public key row.
  ///
  /// In en, this message translates to:
  /// **'Public Key'**
  String get meshcoreShellInfoPublicKey;

  /// Info table label for the connection status row.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get meshcoreShellInfoStatus;

  /// Title for the Join Channel action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Join Channel'**
  String get meshcoreShellJoinChannel;

  /// Info snackbar hint after navigating to channels tab from device sheet.
  ///
  /// In en, this message translates to:
  /// **'Use the menu to join a channel'**
  String get meshcoreShellJoinChannelHint;

  /// Subtitle for the Join Channel action tile in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Scan QR or enter channel code'**
  String get meshcoreShellJoinChannelSubtitle;

  /// Tooltip for the hamburger menu button in the MeshCore app bar.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get meshcoreShellMenuTooltip;

  /// Bottom navigation label for the Channels tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get meshcoreShellNavChannels;

  /// Bottom navigation label for the Contacts tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get meshcoreShellNavContacts;

  /// Bottom navigation label for the Map tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get meshcoreShellNavMap;

  /// Bottom navigation label for the Tools tab in MeshCore.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get meshcoreShellNavTools;

  /// Error snackbar when attempting to reconnect without a saved device.
  ///
  /// In en, this message translates to:
  /// **'No saved device to reconnect to'**
  String get meshcoreShellNoSavedDevice;

  /// Error message when attempting an action while MeshCore is disconnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get meshcoreShellNotConnected;

  /// Button label to reconnect to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Reconnect'**
  String get meshcoreShellReconnectButton;

  /// Error snackbar when MeshCore reconnection fails.
  ///
  /// In en, this message translates to:
  /// **'Reconnect failed: {error}'**
  String meshcoreShellReconnectFailed(String error);

  /// Loading snackbar shown during MeshCore reconnection.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting to {deviceName}...'**
  String meshcoreShellReconnecting(String deviceName);

  /// Subtitle on the QR share sheet for adding a MeshCore contact.
  ///
  /// In en, this message translates to:
  /// **'Scan to add as contact'**
  String get meshcoreShellScanToAddContact;

  /// Section title for connection actions in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get meshcoreShellSectionConnection;

  /// Section title for device information in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get meshcoreShellSectionDeviceInfo;

  /// Section title for quick actions in the MeshCore device sheet.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get meshcoreShellSectionQuickActions;

  /// Info text on the QR contact code share sheet.
  ///
  /// In en, this message translates to:
  /// **'Share your contact code so others can message you'**
  String get meshcoreShellShareContactInfo;

  /// Subtitle for the My Contact Code action tile in the device sheet.
  ///
  /// In en, this message translates to:
  /// **'Share your contact info'**
  String get meshcoreShellShareContactSubtitle;

  /// Device sheet status when connected to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get meshcoreShellStatusConnected;

  /// Device sheet status while connecting to a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get meshcoreShellStatusConnecting;

  /// Device sheet status when disconnected from a MeshCore device.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get meshcoreShellStatusDisconnected;

  /// Connection status label when the MeshCore device is disconnected.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get meshcoreShellStatusOffline;

  /// Connection status label when the MeshCore device is connected.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get meshcoreShellStatusOnline;

  /// Fallback value when a node name is empty.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get meshcoreShellUnknown;

  /// Fallback title for QR share when device has no node name.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Node'**
  String get meshcoreShellUnnamedNode;

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

  /// Header label in the message details section of the context menu.
  ///
  /// In en, this message translates to:
  /// **'Message Details'**
  String get messageContextMenuMessageDetails;

  /// Placeholder text in the emoji picker when there are no recent emoji.
  ///
  /// In en, this message translates to:
  /// **'No Recents'**
  String get messageContextMenuNoRecents;

  /// Label for the Reply action in the message context menu.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get messageContextMenuReply;

  /// Hint text in the emoji picker search field.
  ///
  /// In en, this message translates to:
  /// **'Search emoji…'**
  String get messageContextMenuSearchEmoji;

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

  /// Error snackbar when sending a tapback fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to send tapback'**
  String get messageContextMenuTapbackFailed;

  /// Success snackbar after sending a tapback reaction.
  ///
  /// In en, this message translates to:
  /// **'Tapback sent'**
  String get messageContextMenuTapbackSent;

  /// Error shown when user tries to add a channel while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to add channels'**
  String get messagesAddChannelNotConnected;

  /// Tab label for the channels tab in the messages container.
  ///
  /// In en, this message translates to:
  /// **'Channels'**
  String get messagesChannelsTab;

  /// Tab label for the contacts tab in the messages container.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get messagesContactsTab;

  /// Title of the messages container screen app bar.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesContainerTitle;

  /// Error shown when user tries to scan a QR channel while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to scan channels'**
  String get messagesScanChannelNotConnected;

  /// Popup menu item to open the channel creation wizard.
  ///
  /// In en, this message translates to:
  /// **'Add channel'**
  String get messagingAddChannel;

  /// Advanced option link in the encryption key issue sheet.
  ///
  /// In en, this message translates to:
  /// **'Advanced: Reset Node Database'**
  String get messagingAdvancedResetNodeDatabase;

  /// Tooltip for the channel settings icon button in a channel conversation.
  ///
  /// In en, this message translates to:
  /// **'Channel Settings'**
  String get messagingChannelSettings;

  /// Subtitle shown below the channel name in the messaging screen header.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get messagingChannelSubtitle;

  /// Button label to clear the contact search query.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get messagingClearSearch;

  /// Tooltip for the icon button that closes the message search bar.
  ///
  /// In en, this message translates to:
  /// **'Close Search'**
  String get messagingCloseSearch;

  /// Helper text below an empty quick responses panel.
  ///
  /// In en, this message translates to:
  /// **'Configure quick responses in Settings'**
  String get messagingConfigureQuickResponses;

  /// Helper text shown below the no-contacts empty state.
  ///
  /// In en, this message translates to:
  /// **'Discovered nodes will appear here'**
  String get messagingContactsDiscoveredHint;

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

  /// Body of the delete message confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this message? This only removes it locally.'**
  String get messagingDeleteMessageConfirmation;

  /// Title of the delete message confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Delete Message'**
  String get messagingDeleteMessageTitle;

  /// Subtitle shown below the contact name in a DM conversation.
  ///
  /// In en, this message translates to:
  /// **'Direct Message'**
  String get messagingDirectMessageSubtitle;

  /// Subtitle of the encryption key issue sheet showing the target node name.
  ///
  /// In en, this message translates to:
  /// **'Direct message to {name} failed'**
  String messagingEncryptionKeyIssueSubtitle(String name);

  /// Title of the encryption key issue bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Encryption Key Issue'**
  String get messagingEncryptionKeyIssueTitle;

  /// Warning banner body in the encryption key issue sheet.
  ///
  /// In en, this message translates to:
  /// **'The encryption keys may be out of sync. This can happen when a node has been reset or rolled out of the mesh database.'**
  String get messagingEncryptionKeyWarning;

  /// Fallback error text shown on a message that failed to send.
  ///
  /// In en, this message translates to:
  /// **'Failed to send'**
  String get messagingFailedToSend;

  /// Label for the Active filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get messagingFilterActive;

  /// Label for the All filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get messagingFilterAll;

  /// Label for the Favorites filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get messagingFilterFavorites;

  /// Label for the Messaged filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Messaged'**
  String get messagingFilterMessaged;

  /// Label for the Unread filter chip in the contacts list.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get messagingFilterUnread;

  /// Hint text in the message search field.
  ///
  /// In en, this message translates to:
  /// **'Find a message'**
  String get messagingFindMessageHint;

  /// Popup menu item to start the messaging help tour.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get messagingHelp;

  /// Success snackbar after deleting a message.
  ///
  /// In en, this message translates to:
  /// **'Message deleted'**
  String get messagingMessageDeleted;

  /// Hint text in the message compose field.
  ///
  /// In en, this message translates to:
  /// **'Message…'**
  String get messagingMessageHint;

  /// Info snackbar shown when a message is queued because the device is offline.
  ///
  /// In en, this message translates to:
  /// **'Message queued - will send when connected'**
  String get messagingMessageQueuedOffline;

  /// Empty state text when the contact search returns no results.
  ///
  /// In en, this message translates to:
  /// **'No contacts match \"{query}\"'**
  String messagingNoContactsMatchSearch(String query);

  /// Empty state text when no contacts exist at all.
  ///
  /// In en, this message translates to:
  /// **'No contacts yet'**
  String get messagingNoContactsYet;

  /// Empty state text when the active filter returns no contacts.
  ///
  /// In en, this message translates to:
  /// **'No {filter} contacts'**
  String messagingNoFilteredContacts(String filter);

  /// Empty state text when a channel has no messages.
  ///
  /// In en, this message translates to:
  /// **'No messages in this channel'**
  String get messagingNoMessagesInChannel;

  /// Empty state text in the message list when search returns no results.
  ///
  /// In en, this message translates to:
  /// **'No messages match your search'**
  String get messagingNoMessagesMatchSearch;

  /// Empty state text in the quick responses panel.
  ///
  /// In en, this message translates to:
  /// **'No quick responses configured.\nAdd some in Settings → Quick responses.'**
  String get messagingNoQuickResponsesConfigured;

  /// Fallback text shown when the quoted reply message has no text.
  ///
  /// In en, this message translates to:
  /// **'Original message'**
  String get messagingOriginalMessage;

  /// Title of the quick responses panel in the messaging bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Quick Responses'**
  String get messagingQuickResponses;

  /// Label shown in the reply banner above the text input.
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String messagingReplyingTo(String name);

  /// Button label to request fresh node info.
  ///
  /// In en, this message translates to:
  /// **'Request User Info'**
  String get messagingRequestUserInfo;

  /// Error snackbar when requesting node info fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to request info: {error}'**
  String messagingRequestUserInfoFailed(String error);

  /// Success snackbar after requesting node info.
  ///
  /// In en, this message translates to:
  /// **'Requested fresh info from {name}'**
  String messagingRequestUserInfoSuccess(String name);

  /// Button label to retry sending a failed message.
  ///
  /// In en, this message translates to:
  /// **'Retry Message'**
  String get messagingRetryMessage;

  /// Popup menu item to scan a QR code for a channel.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get messagingScanQrCode;

  /// Hint text in the contact search field.
  ///
  /// In en, this message translates to:
  /// **'Search contacts'**
  String get messagingSearchContactsHint;

  /// Tooltip for the icon button that opens the message search bar.
  ///
  /// In en, this message translates to:
  /// **'Search Messages'**
  String get messagingSearchMessages;

  /// Section header for recently active contacts.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get messagingSectionActive;

  /// Section header for favorite contacts in the contact list.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get messagingSectionFavorites;

  /// Section header for inactive contacts.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get messagingSectionInactive;

  /// Section header for contacts with unread messages.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get messagingSectionUnread;

  /// Popup menu item to navigate to the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get messagingSettings;

  /// Source label for messages sent by an automation rule.
  ///
  /// In en, this message translates to:
  /// **'Automation'**
  String get messagingSourceAutomation;

  /// Source label for messages triggered by a notification action.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get messagingSourceNotification;

  /// Source label for messages sent via a shortcut.
  ///
  /// In en, this message translates to:
  /// **'Shortcut'**
  String get messagingSourceShortcut;

  /// Source label for tapback reaction messages.
  ///
  /// In en, this message translates to:
  /// **'Tapback'**
  String get messagingSourceTapback;

  /// Empty state text in a new DM conversation.
  ///
  /// In en, this message translates to:
  /// **'Start the conversation'**
  String get messagingStartConversation;

  /// Fallback display name for a node with no stored name.
  ///
  /// In en, this message translates to:
  /// **'Unknown Node'**
  String get messagingUnknownNode;

  /// Label for the Activity drawer item.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get navigationActivity;

  /// Label for the Aether drawer item.
  ///
  /// In en, this message translates to:
  /// **'Aether'**
  String get navigationAether;

  /// Label for the Automations premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Automations'**
  String get navigationAutomations;

  /// Label for the Dashboard bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navigationDashboard;

  /// Label for the Device Logs drawer item.
  ///
  /// In en, this message translates to:
  /// **'Device Logs'**
  String get navigationDeviceLogs;

  /// Tooltip for the device status button.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get navigationDeviceTooltip;

  /// Label for the File Transfers drawer item.
  ///
  /// In en, this message translates to:
  /// **'File Transfers'**
  String get navigationFileTransfers;

  /// Push notification title for firmware errors.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic Device Error'**
  String get navigationFirmwareErrorTitle;

  /// Snackbar text for firmware client notifications.
  ///
  /// In en, this message translates to:
  /// **'Firmware: {message}'**
  String navigationFirmwareMessage(String message);

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

  /// Default display name when user is not signed in.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get navigationGuestName;

  /// Label for the Help and Support drawer item.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get navigationHelpSupport;

  /// Label for the IFTTT Integration premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'IFTTT Integration'**
  String get navigationIftttIntegration;

  /// Label for the Map bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get navigationMap;

  /// Tooltip for the hamburger menu button.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navigationMenuTooltip;

  /// Label for the 3D Mesh View drawer item.
  ///
  /// In en, this message translates to:
  /// **'3D Mesh View'**
  String get navigationMesh3dView;

  /// Label for the Mesh Health drawer item.
  ///
  /// In en, this message translates to:
  /// **'Mesh Health'**
  String get navigationMeshHealth;

  /// Label for the Messages bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navigationMessages;

  /// Label for the NodeDex drawer item.
  ///
  /// In en, this message translates to:
  /// **'NodeDex'**
  String get navigationNodeDex;

  /// Label for the Nodes bottom nav tab.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get navigationNodes;

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

  /// Label for the Presence drawer item.
  ///
  /// In en, this message translates to:
  /// **'Presence'**
  String get navigationPresence;

  /// Label for the Reachability drawer item.
  ///
  /// In en, this message translates to:
  /// **'Reachability'**
  String get navigationReachability;

  /// Label for the Ringtone Pack premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Ringtone Pack'**
  String get navigationRingtonePack;

  /// Label for the Routes drawer item.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get navigationRoutes;

  /// Drawer section header for account section.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get navigationSectionAccount;

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

  /// Drawer section header for social features.
  ///
  /// In en, this message translates to:
  /// **'SOCIAL'**
  String get navigationSectionSocial;

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

  /// Sync status text during active sync.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get navigationSyncing;

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

  /// Label for the Theme Pack premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Theme Pack'**
  String get navigationThemePack;

  /// Label for the Timeline drawer item.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get navigationTimeline;

  /// Sync status text linking to profile screen.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get navigationViewProfile;

  /// Label for the Widgets premium drawer item.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get navigationWidgets;

  /// Label for the World Map drawer item.
  ///
  /// In en, this message translates to:
  /// **'World Map'**
  String get navigationWorldMap;

  /// No description provided for @nodeAnalyticsAddFavoriteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get nodeAnalyticsAddFavoriteTooltip;

  /// No description provided for @nodeAnalyticsAddedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get nodeAnalyticsAddedToFavorites;

  /// No description provided for @nodeAnalyticsAirTimeTx.
  ///
  /// In en, this message translates to:
  /// **'Air Time TX'**
  String get nodeAnalyticsAirTimeTx;

  /// No description provided for @nodeAnalyticsAltitude.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String nodeAnalyticsAltitude(String meters);

  /// No description provided for @nodeAnalyticsAvgBattery.
  ///
  /// In en, this message translates to:
  /// **'Avg Battery'**
  String get nodeAnalyticsAvgBattery;

  /// No description provided for @nodeAnalyticsBadgeLive.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get nodeAnalyticsBadgeLive;

  /// No description provided for @nodeAnalyticsBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodeAnalyticsBattery;

  /// No description provided for @nodeAnalyticsChannelUtilization.
  ///
  /// In en, this message translates to:
  /// **'Channel Utilization'**
  String get nodeAnalyticsChannelUtilization;

  /// No description provided for @nodeAnalyticsCharging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get nodeAnalyticsCharging;

  /// No description provided for @nodeAnalyticsClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get nodeAnalyticsClear;

  /// No description provided for @nodeAnalyticsClearConfirm.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get nodeAnalyticsClearConfirm;

  /// No description provided for @nodeAnalyticsClearHistoryMessage.
  ///
  /// In en, this message translates to:
  /// **'This will delete all historical data for this node. This action cannot be undone.'**
  String get nodeAnalyticsClearHistoryMessage;

  /// No description provided for @nodeAnalyticsClearHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get nodeAnalyticsClearHistoryTitle;

  /// No description provided for @nodeAnalyticsCsvShared.
  ///
  /// In en, this message translates to:
  /// **'CSV data shared'**
  String get nodeAnalyticsCsvShared;

  /// No description provided for @nodeAnalyticsDataUpdated.
  ///
  /// In en, this message translates to:
  /// **'Node data updated'**
  String get nodeAnalyticsDataUpdated;

  /// No description provided for @nodeAnalyticsDirectNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Direct Neighbors ({count})'**
  String nodeAnalyticsDirectNeighbors(int count);

  /// No description provided for @nodeAnalyticsExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get nodeAnalyticsExport;

  /// No description provided for @nodeAnalyticsExportCsv.
  ///
  /// In en, this message translates to:
  /// **'CSV'**
  String get nodeAnalyticsExportCsv;

  /// No description provided for @nodeAnalyticsExportCsvSubject.
  ///
  /// In en, this message translates to:
  /// **'Node {name} History (CSV)'**
  String nodeAnalyticsExportCsvSubject(String name);

  /// No description provided for @nodeAnalyticsExportHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Export History'**
  String get nodeAnalyticsExportHistoryTitle;

  /// No description provided for @nodeAnalyticsExportJson.
  ///
  /// In en, this message translates to:
  /// **'JSON'**
  String get nodeAnalyticsExportJson;

  /// No description provided for @nodeAnalyticsExportJsonSubject.
  ///
  /// In en, this message translates to:
  /// **'Node {name} History (JSON)'**
  String nodeAnalyticsExportJsonSubject(String name);

  /// No description provided for @nodeAnalyticsExportRecordCount.
  ///
  /// In en, this message translates to:
  /// **'{count} records'**
  String nodeAnalyticsExportRecordCount(int count);

  /// No description provided for @nodeAnalyticsFirstSeen.
  ///
  /// In en, this message translates to:
  /// **'First seen'**
  String get nodeAnalyticsFirstSeen;

  /// No description provided for @nodeAnalyticsHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get nodeAnalyticsHardware;

  /// No description provided for @nodeAnalyticsHistoryCleared.
  ///
  /// In en, this message translates to:
  /// **'History cleared'**
  String get nodeAnalyticsHistoryCleared;

  /// No description provided for @nodeAnalyticsJsonShared.
  ///
  /// In en, this message translates to:
  /// **'JSON data shared'**
  String get nodeAnalyticsJsonShared;

  /// No description provided for @nodeAnalyticsLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update'**
  String get nodeAnalyticsLastUpdate;

  /// No description provided for @nodeAnalyticsLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get nodeAnalyticsLatitude;

  /// No description provided for @nodeAnalyticsLiveWatchDisabled.
  ///
  /// In en, this message translates to:
  /// **'Live watching disabled'**
  String get nodeAnalyticsLiveWatchDisabled;

  /// No description provided for @nodeAnalyticsLiveWatchEnabled.
  ///
  /// In en, this message translates to:
  /// **'Live watching enabled (updates every 30s)'**
  String get nodeAnalyticsLiveWatchEnabled;

  /// No description provided for @nodeAnalyticsLongName.
  ///
  /// In en, this message translates to:
  /// **'Long Name'**
  String get nodeAnalyticsLongName;

  /// No description provided for @nodeAnalyticsLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get nodeAnalyticsLongitude;

  /// No description provided for @nodeAnalyticsNoGatewayData.
  ///
  /// In en, this message translates to:
  /// **'No gateway data available'**
  String get nodeAnalyticsNoGatewayData;

  /// No description provided for @nodeAnalyticsNoHistoryToExport.
  ///
  /// In en, this message translates to:
  /// **'No history data to export'**
  String get nodeAnalyticsNoHistoryToExport;

  /// No description provided for @nodeAnalyticsNoHistoryYet.
  ///
  /// In en, this message translates to:
  /// **'No historical data yet'**
  String get nodeAnalyticsNoHistoryYet;

  /// No description provided for @nodeAnalyticsNoNeighborData.
  ///
  /// In en, this message translates to:
  /// **'No neighbor data available'**
  String get nodeAnalyticsNoNeighborData;

  /// No description provided for @nodeAnalyticsNodeIdCopied.
  ///
  /// In en, this message translates to:
  /// **'Node ID copied'**
  String get nodeAnalyticsNodeIdCopied;

  /// No description provided for @nodeAnalyticsNodeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Node not found in mesh'**
  String get nodeAnalyticsNodeNotFound;

  /// No description provided for @nodeAnalyticsRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get nodeAnalyticsRecords;

  /// No description provided for @nodeAnalyticsRefreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to refresh: {error}'**
  String nodeAnalyticsRefreshFailed(String error);

  /// No description provided for @nodeAnalyticsRefreshNow.
  ///
  /// In en, this message translates to:
  /// **'Refresh Now'**
  String get nodeAnalyticsRefreshNow;

  /// No description provided for @nodeAnalyticsRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing...'**
  String get nodeAnalyticsRefreshing;

  /// No description provided for @nodeAnalyticsRemoveFavoriteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get nodeAnalyticsRemoveFavoriteTooltip;

  /// No description provided for @nodeAnalyticsRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get nodeAnalyticsRemovedFromFavorites;

  /// No description provided for @nodeAnalyticsRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get nodeAnalyticsRole;

  /// No description provided for @nodeAnalyticsSectionDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get nodeAnalyticsSectionDeviceInfo;

  /// No description provided for @nodeAnalyticsSectionDeviceMetrics.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get nodeAnalyticsSectionDeviceMetrics;

  /// No description provided for @nodeAnalyticsSectionHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get nodeAnalyticsSectionHistory;

  /// No description provided for @nodeAnalyticsSectionNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get nodeAnalyticsSectionNetwork;

  /// No description provided for @nodeAnalyticsSectionTrends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get nodeAnalyticsSectionTrends;

  /// No description provided for @nodeAnalyticsSeenByGateways.
  ///
  /// In en, this message translates to:
  /// **'Seen by Gateways ({count})'**
  String nodeAnalyticsSeenByGateways(int count);

  /// No description provided for @nodeAnalyticsShareDetailBatteryCharging.
  ///
  /// In en, this message translates to:
  /// **'Battery: Charging'**
  String get nodeAnalyticsShareDetailBatteryCharging;

  /// No description provided for @nodeAnalyticsShareDetailBatteryLevel.
  ///
  /// In en, this message translates to:
  /// **'Battery: {level}%'**
  String nodeAnalyticsShareDetailBatteryLevel(String level);

  /// No description provided for @nodeAnalyticsShareDetailGateways.
  ///
  /// In en, this message translates to:
  /// **'Gateways: {count}'**
  String nodeAnalyticsShareDetailGateways(String count);

  /// No description provided for @nodeAnalyticsShareDetailHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware: {hardware}'**
  String nodeAnalyticsShareDetailHardware(String hardware);

  /// No description provided for @nodeAnalyticsShareDetailHeader.
  ///
  /// In en, this message translates to:
  /// **'🛰️ Mesh Node: {name}'**
  String nodeAnalyticsShareDetailHeader(String name);

  /// No description provided for @nodeAnalyticsShareDetailId.
  ///
  /// In en, this message translates to:
  /// **'ID: !{nodeId}'**
  String nodeAnalyticsShareDetailId(String nodeId);

  /// No description provided for @nodeAnalyticsShareDetailLocation.
  ///
  /// In en, this message translates to:
  /// **'Location: {location}'**
  String nodeAnalyticsShareDetailLocation(String location);

  /// No description provided for @nodeAnalyticsShareDetailNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Neighbors: {count}'**
  String nodeAnalyticsShareDetailNeighbors(String count);

  /// No description provided for @nodeAnalyticsShareDetailRole.
  ///
  /// In en, this message translates to:
  /// **'Role: {role}'**
  String nodeAnalyticsShareDetailRole(String role);

  /// No description provided for @nodeAnalyticsShareDetailStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String nodeAnalyticsShareDetailStatus(String status);

  /// No description provided for @nodeAnalyticsShareDetails.
  ///
  /// In en, this message translates to:
  /// **'Share Details'**
  String get nodeAnalyticsShareDetails;

  /// No description provided for @nodeAnalyticsShareDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Full technical info as text'**
  String get nodeAnalyticsShareDetailsSubtitle;

  /// No description provided for @nodeAnalyticsShareFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to share node: {error}'**
  String nodeAnalyticsShareFailed(String error);

  /// No description provided for @nodeAnalyticsShareLink.
  ///
  /// In en, this message translates to:
  /// **'Share Link'**
  String get nodeAnalyticsShareLink;

  /// No description provided for @nodeAnalyticsShareLinkSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rich preview in iMessage, Slack, etc.'**
  String get nodeAnalyticsShareLinkSubtitle;

  /// No description provided for @nodeAnalyticsShareNodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Node'**
  String get nodeAnalyticsShareNodeTitle;

  /// No description provided for @nodeAnalyticsShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Mesh Node: {name}'**
  String nodeAnalyticsShareSubject(String name);

  /// No description provided for @nodeAnalyticsShareText.
  ///
  /// In en, this message translates to:
  /// **'Check out {name} on Socialmesh!\n{url}'**
  String nodeAnalyticsShareText(String name, String url);

  /// No description provided for @nodeAnalyticsShareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share node info'**
  String get nodeAnalyticsShareTooltip;

  /// No description provided for @nodeAnalyticsShortName.
  ///
  /// In en, this message translates to:
  /// **'Short Name'**
  String get nodeAnalyticsShortName;

  /// No description provided for @nodeAnalyticsShowOnMap.
  ///
  /// In en, this message translates to:
  /// **'Show on Map'**
  String get nodeAnalyticsShowOnMap;

  /// No description provided for @nodeAnalyticsSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get nodeAnalyticsSignIn;

  /// No description provided for @nodeAnalyticsSignInToShare.
  ///
  /// In en, this message translates to:
  /// **'Sign in to share nodes'**
  String get nodeAnalyticsSignInToShare;

  /// No description provided for @nodeAnalyticsStopWatching.
  ///
  /// In en, this message translates to:
  /// **'Stop watching'**
  String get nodeAnalyticsStopWatching;

  /// No description provided for @nodeAnalyticsTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String nodeAnalyticsTimeDaysAgo(int days);

  /// No description provided for @nodeAnalyticsTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String nodeAnalyticsTimeHoursAgo(int hours);

  /// No description provided for @nodeAnalyticsTimeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get nodeAnalyticsTimeJustNow;

  /// No description provided for @nodeAnalyticsTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String nodeAnalyticsTimeMinutesAgo(int minutes);

  /// No description provided for @nodeAnalyticsUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodeAnalyticsUnknown;

  /// No description provided for @nodeAnalyticsUptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get nodeAnalyticsUptime;

  /// No description provided for @nodeAnalyticsUptimeStat.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get nodeAnalyticsUptimeStat;

  /// No description provided for @nodeAnalyticsVisitAgain.
  ///
  /// In en, this message translates to:
  /// **'Visit this node again to build history'**
  String get nodeAnalyticsVisitAgain;

  /// No description provided for @nodeAnalyticsVoltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get nodeAnalyticsVoltage;

  /// No description provided for @nodeAnalyticsWatchLive.
  ///
  /// In en, this message translates to:
  /// **'Watch live'**
  String get nodeAnalyticsWatchLive;

  /// No description provided for @nodeComparisonCharging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get nodeComparisonCharging;

  /// No description provided for @nodeComparisonNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get nodeComparisonNo;

  /// No description provided for @nodeComparisonNoData.
  ///
  /// In en, this message translates to:
  /// **'--'**
  String get nodeComparisonNoData;

  /// No description provided for @nodeComparisonNodeIdCopied.
  ///
  /// In en, this message translates to:
  /// **'Node ID copied'**
  String get nodeComparisonNodeIdCopied;

  /// No description provided for @nodeComparisonRowAirTimeTx.
  ///
  /// In en, this message translates to:
  /// **'Air Time TX'**
  String get nodeComparisonRowAirTimeTx;

  /// No description provided for @nodeComparisonRowBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodeComparisonRowBattery;

  /// No description provided for @nodeComparisonRowChannelUtil.
  ///
  /// In en, this message translates to:
  /// **'Channel Util'**
  String get nodeComparisonRowChannelUtil;

  /// No description provided for @nodeComparisonRowFirmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get nodeComparisonRowFirmware;

  /// No description provided for @nodeComparisonRowGateways.
  ///
  /// In en, this message translates to:
  /// **'Gateways'**
  String get nodeComparisonRowGateways;

  /// No description provided for @nodeComparisonRowHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get nodeComparisonRowHardware;

  /// No description provided for @nodeComparisonRowHasLocation.
  ///
  /// In en, this message translates to:
  /// **'Has Location'**
  String get nodeComparisonRowHasLocation;

  /// No description provided for @nodeComparisonRowNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Neighbors'**
  String get nodeComparisonRowNeighbors;

  /// No description provided for @nodeComparisonRowRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get nodeComparisonRowRegion;

  /// No description provided for @nodeComparisonRowRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get nodeComparisonRowRole;

  /// No description provided for @nodeComparisonRowStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get nodeComparisonRowStatus;

  /// No description provided for @nodeComparisonRowUptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get nodeComparisonRowUptime;

  /// No description provided for @nodeComparisonRowVoltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get nodeComparisonRowVoltage;

  /// No description provided for @nodeComparisonSectionDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get nodeComparisonSectionDeviceInfo;

  /// No description provided for @nodeComparisonSectionMetrics.
  ///
  /// In en, this message translates to:
  /// **'Metrics'**
  String get nodeComparisonSectionMetrics;

  /// No description provided for @nodeComparisonSectionNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get nodeComparisonSectionNetwork;

  /// No description provided for @nodeComparisonSectionStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get nodeComparisonSectionStatus;

  /// No description provided for @nodeComparisonTitle.
  ///
  /// In en, this message translates to:
  /// **'Compare Nodes'**
  String get nodeComparisonTitle;

  /// No description provided for @nodeComparisonUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodeComparisonUnknown;

  /// No description provided for @nodeComparisonVs.
  ///
  /// In en, this message translates to:
  /// **'VS'**
  String get nodeComparisonVs;

  /// No description provided for @nodeComparisonYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get nodeComparisonYes;

  /// Tooltip for adding to favorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get nodeDetailAddToFavoritesTooltip;

  /// Snackbar after adding a node to favorites.
  ///
  /// In en, this message translates to:
  /// **'{name} added to favorites'**
  String nodeDetailAddedToFavorites(String name);

  /// App bar title for the node detail screen.
  ///
  /// In en, this message translates to:
  /// **'Node Details'**
  String get nodeDetailAppBarTitle;

  /// Battery status label when charging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get nodeDetailBatteryCharging;

  /// Battery percentage display.
  ///
  /// In en, this message translates to:
  /// **'{level}%'**
  String nodeDetailBatteryPercent(int level);

  /// Distance display in kilometers.
  ///
  /// In en, this message translates to:
  /// **'{km} km'**
  String nodeDetailDistanceKilometers(String km);

  /// Distance display in meters.
  ///
  /// In en, this message translates to:
  /// **'{meters} m'**
  String nodeDetailDistanceMeters(String meters);

  /// Badge for favorite nodes.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get nodeDetailFavoriteBadge;

  /// Error snackbar when favorite toggle fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to update favorite: {error}'**
  String nodeDetailFavoriteError(String error);

  /// Error snackbar when fixed position fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to set fixed position: {error}'**
  String nodeDetailFixedPositionError(String error);

  /// Success snackbar after setting fixed position.
  ///
  /// In en, this message translates to:
  /// **'Fixed position set to {name}\'s location'**
  String nodeDetailFixedPositionSet(String name);

  /// Info table label for air utilization TX.
  ///
  /// In en, this message translates to:
  /// **'Air Util TX'**
  String get nodeDetailLabelAirUtilTx;

  /// Info table label for altitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get nodeDetailLabelAltitude;

  /// Info table label for bad packets.
  ///
  /// In en, this message translates to:
  /// **'Bad Packets'**
  String get nodeDetailLabelBadPackets;

  /// Info table label for battery level.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodeDetailLabelBattery;

  /// Info table label for cache hits.
  ///
  /// In en, this message translates to:
  /// **'Cache Hits'**
  String get nodeDetailLabelCacheHits;

  /// Info table label for channel utilization.
  ///
  /// In en, this message translates to:
  /// **'Channel Util'**
  String get nodeDetailLabelChannelUtil;

  /// Info table label for distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get nodeDetailLabelDistance;

  /// Info table label for encryption status.
  ///
  /// In en, this message translates to:
  /// **'Encryption'**
  String get nodeDetailLabelEncryption;

  /// Info table label for firmware version.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get nodeDetailLabelFirmware;

  /// Info table label for hardware model.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get nodeDetailLabelHardware;

  /// Info table label for hop-exhausted packets.
  ///
  /// In en, this message translates to:
  /// **'Hop Exhausted'**
  String get nodeDetailLabelHopExhausted;

  /// Info table label for preserved hops.
  ///
  /// In en, this message translates to:
  /// **'Hops Preserved'**
  String get nodeDetailLabelHopsPreserved;

  /// Info table label for inspected packets.
  ///
  /// In en, this message translates to:
  /// **'Inspected'**
  String get nodeDetailLabelInspected;

  /// Info table label for noise floor.
  ///
  /// In en, this message translates to:
  /// **'Noise Floor'**
  String get nodeDetailLabelNoiseFloor;

  /// Info table label for online node count.
  ///
  /// In en, this message translates to:
  /// **'Online Nodes'**
  String get nodeDetailLabelOnlineNodes;

  /// Info table label for received packets.
  ///
  /// In en, this message translates to:
  /// **'Packets RX'**
  String get nodeDetailLabelPacketsRx;

  /// Info table label for transmitted packets.
  ///
  /// In en, this message translates to:
  /// **'Packets TX'**
  String get nodeDetailLabelPacketsTx;

  /// Info table label for GPS position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get nodeDetailLabelPosition;

  /// Info table label for position deduplication.
  ///
  /// In en, this message translates to:
  /// **'Position Dedup'**
  String get nodeDetailLabelPositionDedup;

  /// Info table label for rate-limited drops.
  ///
  /// In en, this message translates to:
  /// **'Rate Limit Drops'**
  String get nodeDetailLabelRateLimitDrops;

  /// Info table label for RSSI.
  ///
  /// In en, this message translates to:
  /// **'RSSI'**
  String get nodeDetailLabelRssi;

  /// Info table label for SNR.
  ///
  /// In en, this message translates to:
  /// **'SNR'**
  String get nodeDetailLabelSnr;

  /// Info table label for node status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get nodeDetailLabelStatus;

  /// Info table label for total node count.
  ///
  /// In en, this message translates to:
  /// **'Total Nodes'**
  String get nodeDetailLabelTotalNodes;

  /// Info table label for dropped transmissions.
  ///
  /// In en, this message translates to:
  /// **'TX Dropped'**
  String get nodeDetailLabelTxDropped;

  /// Info table label for unknown drops.
  ///
  /// In en, this message translates to:
  /// **'Unknown Drops'**
  String get nodeDetailLabelUnknownDrops;

  /// Info table label for uptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get nodeDetailLabelUptime;

  /// Info table label for user ID.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get nodeDetailLabelUserId;

  /// Info table label for voltage.
  ///
  /// In en, this message translates to:
  /// **'Voltage'**
  String get nodeDetailLabelVoltage;

  /// Relative time label in days.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String nodeDetailLastHeardDaysAgo(int days);

  /// Relative time label in hours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String nodeDetailLastHeardHoursAgo(int hours);

  /// Relative time label for very recent contact.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get nodeDetailLastHeardJustNow;

  /// Relative time label in minutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String nodeDetailLastHeardMinutesAgo(int minutes);

  /// Relative time label when a node has never been heard.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get nodeDetailLastHeardNever;

  /// Footer showing when the node was last heard.
  ///
  /// In en, this message translates to:
  /// **'Last heard {timestamp}'**
  String nodeDetailLastHeardTimestamp(String timestamp);

  /// Overflow menu item for remote admin settings.
  ///
  /// In en, this message translates to:
  /// **'Admin Settings'**
  String get nodeDetailMenuAdminSettings;

  /// Subtitle for the admin settings menu item.
  ///
  /// In en, this message translates to:
  /// **'Configure this node remotely'**
  String get nodeDetailMenuAdminSubtitle;

  /// Overflow menu item for exchanging positions.
  ///
  /// In en, this message translates to:
  /// **'Exchange Positions'**
  String get nodeDetailMenuExchangePositions;

  /// Overflow menu item for QR code.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get nodeDetailMenuQrCode;

  /// Overflow menu item for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove Node'**
  String get nodeDetailMenuRemoveNode;

  /// Overflow menu item for requesting user info.
  ///
  /// In en, this message translates to:
  /// **'Request User Info'**
  String get nodeDetailMenuRequestUserInfo;

  /// Overflow menu item for setting fixed position.
  ///
  /// In en, this message translates to:
  /// **'Set as Fixed Position'**
  String get nodeDetailMenuSetFixedPosition;

  /// Overflow menu item for showing node on map.
  ///
  /// In en, this message translates to:
  /// **'Show on Map'**
  String get nodeDetailMenuShowOnMap;

  /// Overflow menu item for traceroute history.
  ///
  /// In en, this message translates to:
  /// **'Traceroute History'**
  String get nodeDetailMenuTracerouteHistory;

  /// Action button label for messaging the node.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get nodeDetailMessageButton;

  /// Error snackbar when mute toggle fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to update mute status: {error}'**
  String nodeDetailMuteError(String error);

  /// Error when trying to mute while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot change mute status: Device not connected'**
  String get nodeDetailMuteNotConnected;

  /// Tooltip for muting a node.
  ///
  /// In en, this message translates to:
  /// **'Mute node'**
  String get nodeDetailMuteTooltip;

  /// Snackbar after muting a node.
  ///
  /// In en, this message translates to:
  /// **'{name} muted'**
  String nodeDetailMuted(String name);

  /// Badge for muted nodes.
  ///
  /// In en, this message translates to:
  /// **'Muted'**
  String get nodeDetailMutedBadge;

  /// Badge for nodes without PKI encryption.
  ///
  /// In en, this message translates to:
  /// **'No PKI'**
  String get nodeDetailNoPkiBadge;

  /// Error when node has no GPS position for fixed position.
  ///
  /// In en, this message translates to:
  /// **'Node has no position data'**
  String get nodeDetailNoPositionData;

  /// Badge for nodes with PKI encryption.
  ///
  /// In en, this message translates to:
  /// **'PKI'**
  String get nodeDetailPkiBadge;

  /// Error snackbar when position request fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to request position: {error}'**
  String nodeDetailPositionError(String error);

  /// Success snackbar after requesting position.
  ///
  /// In en, this message translates to:
  /// **'Position requested from {name}'**
  String nodeDetailPositionRequested(String name);

  /// QR code sheet info text with hex node ID.
  ///
  /// In en, this message translates to:
  /// **'Node ID: {nodeId}'**
  String nodeDetailQrInfoText(String nodeId);

  /// QR code sheet subtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan to add this node'**
  String get nodeDetailQrSubtitle;

  /// Action button label for rebooting the device.
  ///
  /// In en, this message translates to:
  /// **'Reboot'**
  String get nodeDetailRebootButton;

  /// Confirmation button label for rebooting.
  ///
  /// In en, this message translates to:
  /// **'Reboot'**
  String get nodeDetailRebootConfirm;

  /// Error snackbar when reboot fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to reboot: {error}'**
  String nodeDetailRebootError(String error);

  /// Confirmation dialog body for rebooting.
  ///
  /// In en, this message translates to:
  /// **'This will reboot your Meshtastic device. The app will automatically reconnect once the device restarts.'**
  String get nodeDetailRebootMessage;

  /// Error when rebooting while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot reboot: Device not connected'**
  String get nodeDetailRebootNotConnected;

  /// Confirmation dialog title for rebooting.
  ///
  /// In en, this message translates to:
  /// **'Reboot Device'**
  String get nodeDetailRebootTitle;

  /// Snackbar shown after initiating a reboot.
  ///
  /// In en, this message translates to:
  /// **'Device is rebooting...'**
  String get nodeDetailRebootingSnackbar;

  /// Confirmation button label for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get nodeDetailRemoveConfirm;

  /// Error snackbar when node removal fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove node: {error}'**
  String nodeDetailRemoveError(String error);

  /// Tooltip for removing from favorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get nodeDetailRemoveFromFavoritesTooltip;

  /// Confirmation dialog body for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove {name} from the node database? This will remove the node from your local device.'**
  String nodeDetailRemoveMessage(String name);

  /// Confirmation dialog title for removing a node.
  ///
  /// In en, this message translates to:
  /// **'Remove Node'**
  String get nodeDetailRemoveTitle;

  /// Snackbar after removing a node from favorites.
  ///
  /// In en, this message translates to:
  /// **'{name} removed from favorites'**
  String nodeDetailRemovedFromFavorites(String name);

  /// Snackbar after successfully removing a node.
  ///
  /// In en, this message translates to:
  /// **'{name} removed'**
  String nodeDetailRemovedSnackbar(String name);

  /// Section title for device metrics.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get nodeDetailSectionDeviceMetrics;

  /// Section title for identity info.
  ///
  /// In en, this message translates to:
  /// **'Identity'**
  String get nodeDetailSectionIdentity;

  /// Section title for network info.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get nodeDetailSectionNetwork;

  /// Section title for radio info.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get nodeDetailSectionRadio;

  /// Section title for traffic management info.
  ///
  /// In en, this message translates to:
  /// **'Traffic Management'**
  String get nodeDetailSectionTraffic;

  /// Action button label for shutting down the device.
  ///
  /// In en, this message translates to:
  /// **'Shutdown'**
  String get nodeDetailShutdownButton;

  /// Confirmation button label for shutdown.
  ///
  /// In en, this message translates to:
  /// **'Shutdown'**
  String get nodeDetailShutdownConfirm;

  /// Error snackbar when shutdown fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to shutdown: {error}'**
  String nodeDetailShutdownError(String error);

  /// Confirmation dialog body for shutdown.
  ///
  /// In en, this message translates to:
  /// **'This will turn off your Meshtastic device. You will need to physically power it back on to reconnect.'**
  String get nodeDetailShutdownMessage;

  /// Error when shutting down while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot shutdown: Device not connected'**
  String get nodeDetailShutdownNotConnected;

  /// Confirmation dialog title for shutdown.
  ///
  /// In en, this message translates to:
  /// **'Shutdown Device'**
  String get nodeDetailShutdownTitle;

  /// Snackbar shown after initiating a shutdown.
  ///
  /// In en, this message translates to:
  /// **'Device is shutting down...'**
  String get nodeDetailShuttingDownSnackbar;

  /// Tooltip for the sigil card button.
  ///
  /// In en, this message translates to:
  /// **'Sigil Card'**
  String get nodeDetailSigilCardTooltip;

  /// Signal quality label for excellent RSSI.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get nodeDetailSignalExcellent;

  /// Signal quality label for fair RSSI.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get nodeDetailSignalFair;

  /// Signal quality label for good RSSI.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get nodeDetailSignalGood;

  /// Signal quality label when RSSI is unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodeDetailSignalUnknown;

  /// Signal quality label for very weak RSSI.
  ///
  /// In en, this message translates to:
  /// **'Very Weak'**
  String get nodeDetailSignalVeryWeak;

  /// Signal quality label for weak RSSI.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get nodeDetailSignalWeak;

  /// Tooltip showing remaining traceroute cooldown.
  ///
  /// In en, this message translates to:
  /// **'Traceroute cooldown: {seconds}s'**
  String nodeDetailTracerouteCooldownTooltip(int seconds);

  /// Error snackbar when traceroute fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to send traceroute: {error}'**
  String nodeDetailTracerouteError(String error);

  /// Error when sending traceroute while disconnected.
  ///
  /// In en, this message translates to:
  /// **'Cannot send traceroute: Device not connected'**
  String get nodeDetailTracerouteNotConnected;

  /// Success snackbar after sending a traceroute.
  ///
  /// In en, this message translates to:
  /// **'Traceroute sent to {name} — check Traceroute History for results'**
  String nodeDetailTracerouteSent(String name);

  /// Tooltip for the traceroute button.
  ///
  /// In en, this message translates to:
  /// **'Traceroute'**
  String get nodeDetailTracerouteTooltip;

  /// Tooltip for unmuting a node.
  ///
  /// In en, this message translates to:
  /// **'Unmute node'**
  String get nodeDetailUnmuteTooltip;

  /// Snackbar after unmuting a node.
  ///
  /// In en, this message translates to:
  /// **'{name} unmuted'**
  String nodeDetailUnmuted(String name);

  /// Error snackbar when user info request fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to request user info: {error}'**
  String nodeDetailUserInfoError(String error);

  /// Success snackbar after requesting user info.
  ///
  /// In en, this message translates to:
  /// **'User info requested from {name}'**
  String nodeDetailUserInfoRequested(String name);

  /// Altitude value with unit.
  ///
  /// In en, this message translates to:
  /// **'{altitude} m'**
  String nodeDetailValueAltitude(int altitude);

  /// Encryption value when no public key exists.
  ///
  /// In en, this message translates to:
  /// **'No Public Key'**
  String get nodeDetailValueNoPublicKey;

  /// Noise floor value with unit.
  ///
  /// In en, this message translates to:
  /// **'{noiseFloor} dBm'**
  String nodeDetailValueNoiseFloor(int noiseFloor);

  /// Generic percentage value display.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String nodeDetailValuePercent(String value);

  /// Encryption value when PKI is enabled.
  ///
  /// In en, this message translates to:
  /// **'PKI Enabled'**
  String get nodeDetailValuePkiEnabled;

  /// RSSI value with unit.
  ///
  /// In en, this message translates to:
  /// **'{rssi} dBm'**
  String nodeDetailValueRssi(int rssi);

  /// SNR value with unit.
  ///
  /// In en, this message translates to:
  /// **'{snr} dB'**
  String nodeDetailValueSnr(String snr);

  /// Voltage value with unit.
  ///
  /// In en, this message translates to:
  /// **'{voltage} V'**
  String nodeDetailValueVoltage(String voltage);

  /// Badge on the user's own node in the detail screen.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get nodeDetailYouBadge;

  /// No description provided for @nodeHistoryDataPointCount.
  ///
  /// In en, this message translates to:
  /// **'{current}/{required} data points'**
  String nodeHistoryDataPointCount(int current, int required);

  /// No description provided for @nodeHistoryMetricBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodeHistoryMetricBattery;

  /// No description provided for @nodeHistoryMetricChannelUtil.
  ///
  /// In en, this message translates to:
  /// **'Channel Util'**
  String get nodeHistoryMetricChannelUtil;

  /// No description provided for @nodeHistoryMetricConnectivity.
  ///
  /// In en, this message translates to:
  /// **'Connectivity'**
  String get nodeHistoryMetricConnectivity;

  /// No description provided for @nodeHistoryNeedMoreData.
  ///
  /// In en, this message translates to:
  /// **'Need more data for charts'**
  String get nodeHistoryNeedMoreData;

  /// No description provided for @nodeHistoryNoMetricData.
  ///
  /// In en, this message translates to:
  /// **'No {metric} data'**
  String nodeHistoryNoMetricData(String metric);

  /// No description provided for @nodeIntelligenceActivityActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get nodeIntelligenceActivityActive;

  /// No description provided for @nodeIntelligenceActivityCold.
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get nodeIntelligenceActivityCold;

  /// No description provided for @nodeIntelligenceActivityHot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get nodeIntelligenceActivityHot;

  /// No description provided for @nodeIntelligenceActivityQuiet.
  ///
  /// In en, this message translates to:
  /// **'Quiet'**
  String get nodeIntelligenceActivityQuiet;

  /// No description provided for @nodeIntelligenceChannelUtil.
  ///
  /// In en, this message translates to:
  /// **'Channel Utilization'**
  String get nodeIntelligenceChannelUtil;

  /// No description provided for @nodeIntelligenceConnectivity.
  ///
  /// In en, this message translates to:
  /// **'Connectivity'**
  String get nodeIntelligenceConnectivity;

  /// No description provided for @nodeIntelligenceDerivedBadge.
  ///
  /// In en, this message translates to:
  /// **'DERIVED'**
  String get nodeIntelligenceDerivedBadge;

  /// No description provided for @nodeIntelligenceGatewayCount.
  ///
  /// In en, this message translates to:
  /// **'{count} gateways'**
  String nodeIntelligenceGatewayCount(int count);

  /// No description provided for @nodeIntelligenceHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get nodeIntelligenceHealth;

  /// No description provided for @nodeIntelligenceMobilityElevated.
  ///
  /// In en, this message translates to:
  /// **'Elevated'**
  String get nodeIntelligenceMobilityElevated;

  /// No description provided for @nodeIntelligenceMobilityInfra.
  ///
  /// In en, this message translates to:
  /// **'Infrastructure'**
  String get nodeIntelligenceMobilityInfra;

  /// No description provided for @nodeIntelligenceMobilityMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get nodeIntelligenceMobilityMobile;

  /// No description provided for @nodeIntelligenceMobilityStationary.
  ///
  /// In en, this message translates to:
  /// **'Stationary'**
  String get nodeIntelligenceMobilityStationary;

  /// No description provided for @nodeIntelligenceMobilityTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get nodeIntelligenceMobilityTracker;

  /// No description provided for @nodeIntelligenceNeighborCount.
  ///
  /// In en, this message translates to:
  /// **'{count} neighbors'**
  String nodeIntelligenceNeighborCount(int count);

  /// No description provided for @nodeIntelligenceTapHint.
  ///
  /// In en, this message translates to:
  /// **'Tap for deep analytics'**
  String get nodeIntelligenceTapHint;

  /// No description provided for @nodeIntelligenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Mesh Intelligence'**
  String get nodeIntelligenceTitle;

  /// No description provided for @nodeIntelligenceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodeIntelligenceUnknown;

  /// No description provided for @nodedexActiveDaysOf14.
  ///
  /// In en, this message translates to:
  /// **'{count}/14 days'**
  String nodedexActiveDaysOf14(int count);

  /// No description provided for @nodedexActiveNow.
  ///
  /// In en, this message translates to:
  /// **'active now'**
  String get nodedexActiveNow;

  /// No description provided for @nodedexActivityTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity Timeline'**
  String get nodedexActivityTimelineTitle;

  /// No description provided for @nodedexAddToAppleWallet.
  ///
  /// In en, this message translates to:
  /// **'Add to Apple Wallet'**
  String get nodedexAddToAppleWallet;

  /// No description provided for @nodedexAdditionalTraits.
  ///
  /// In en, this message translates to:
  /// **'Additional Traits'**
  String get nodedexAdditionalTraits;

  /// No description provided for @nodedexAgeDiscoveredDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'discovered {days}d ago'**
  String nodedexAgeDiscoveredDaysAgo(int days);

  /// No description provided for @nodedexAgeDiscoveredMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'discovered {months}mo ago'**
  String nodedexAgeDiscoveredMonthsAgo(int months);

  /// No description provided for @nodedexAgeDiscoveredWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'discovered {weeks}w ago'**
  String nodedexAgeDiscoveredWeeksAgo(int weeks);

  /// No description provided for @nodedexAgeDiscoveredYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'discovered {years}y ago'**
  String nodedexAgeDiscoveredYearsAgo(int years);

  /// No description provided for @nodedexAgeDiscoveredYesterday.
  ///
  /// In en, this message translates to:
  /// **'discovered yesterday'**
  String get nodedexAgeDiscoveredYesterday;

  /// No description provided for @nodedexAgeNewToday.
  ///
  /// In en, this message translates to:
  /// **'new today'**
  String get nodedexAgeNewToday;

  /// No description provided for @nodedexAirUtilTxLabel.
  ///
  /// In en, this message translates to:
  /// **'Air Util TX'**
  String get nodedexAirUtilTxLabel;

  /// No description provided for @nodedexBatteryLabel.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodedexBatteryLabel;

  /// No description provided for @nodedexBestRssi.
  ///
  /// In en, this message translates to:
  /// **'Best RSSI'**
  String get nodedexBestRssi;

  /// No description provided for @nodedexBestSnr.
  ///
  /// In en, this message translates to:
  /// **'Best SNR'**
  String get nodedexBestSnr;

  /// No description provided for @nodedexBestSnrStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Best SNR'**
  String get nodedexBestSnrStatLabel;

  /// No description provided for @nodedexBusiestDay.
  ///
  /// In en, this message translates to:
  /// **'Busiest {day}'**
  String nodedexBusiestDay(String day);

  /// No description provided for @nodedexCardBrandSocialmesh.
  ///
  /// In en, this message translates to:
  /// **'SOCIALMESH'**
  String get nodedexCardBrandSocialmesh;

  /// No description provided for @nodedexCardDeviceFirmware.
  ///
  /// In en, this message translates to:
  /// **'FIRMWARE'**
  String get nodedexCardDeviceFirmware;

  /// No description provided for @nodedexCardDeviceHardware.
  ///
  /// In en, this message translates to:
  /// **'HARDWARE'**
  String get nodedexCardDeviceHardware;

  /// No description provided for @nodedexCardDeviceRole.
  ///
  /// In en, this message translates to:
  /// **'ROLE'**
  String get nodedexCardDeviceRole;

  /// No description provided for @nodedexCardRarity100plus.
  ///
  /// In en, this message translates to:
  /// **'100+ encounters'**
  String get nodedexCardRarity100plus;

  /// No description provided for @nodedexCardRarity20to49.
  ///
  /// In en, this message translates to:
  /// **'20 - 49 encounters'**
  String get nodedexCardRarity20to49;

  /// No description provided for @nodedexCardRarity50to99.
  ///
  /// In en, this message translates to:
  /// **'50 - 99 encounters'**
  String get nodedexCardRarity50to99;

  /// No description provided for @nodedexCardRarity5to19.
  ///
  /// In en, this message translates to:
  /// **'5 - 19 encounters'**
  String get nodedexCardRarity5to19;

  /// No description provided for @nodedexCardRarityEpic.
  ///
  /// In en, this message translates to:
  /// **'EPIC'**
  String get nodedexCardRarityEpic;

  /// No description provided for @nodedexCardRarityInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'A card\'s rarity reflects how often you\'ve encountered this node on the mesh. The more you cross paths, the rarer the card becomes.'**
  String get nodedexCardRarityInfoDescription;

  /// No description provided for @nodedexCardRarityInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Card Rarity'**
  String get nodedexCardRarityInfoTitle;

  /// No description provided for @nodedexCardRarityLegendary.
  ///
  /// In en, this message translates to:
  /// **'LEGENDARY'**
  String get nodedexCardRarityLegendary;

  /// No description provided for @nodedexCardRarityRare.
  ///
  /// In en, this message translates to:
  /// **'RARE'**
  String get nodedexCardRarityRare;

  /// No description provided for @nodedexCardRarityStandard.
  ///
  /// In en, this message translates to:
  /// **'STANDARD'**
  String get nodedexCardRarityStandard;

  /// No description provided for @nodedexCardRarityUncommon.
  ///
  /// In en, this message translates to:
  /// **'UNCOMMON'**
  String get nodedexCardRarityUncommon;

  /// No description provided for @nodedexCardRarityUnder5.
  ///
  /// In en, this message translates to:
  /// **'Under 5 encounters'**
  String get nodedexCardRarityUnder5;

  /// No description provided for @nodedexChannelUtilLabel.
  ///
  /// In en, this message translates to:
  /// **'Channel Util'**
  String get nodedexChannelUtilLabel;

  /// No description provided for @nodedexClassificationChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get nodedexClassificationChange;

  /// No description provided for @nodedexClassificationClassify.
  ///
  /// In en, this message translates to:
  /// **'Classify'**
  String get nodedexClassificationClassify;

  /// No description provided for @nodedexClassificationLabel.
  ///
  /// In en, this message translates to:
  /// **'CLASSIFICATION'**
  String get nodedexClassificationLabel;

  /// No description provided for @nodedexClassificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get nodedexClassificationTitle;

  /// No description provided for @nodedexClassifyNodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Assign a personal classification to this node. This is only visible to you.'**
  String get nodedexClassifyNodeDescription;

  /// No description provided for @nodedexClassifyNodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Classify Node'**
  String get nodedexClassifyNodeTitle;

  /// No description provided for @nodedexClearFilter.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get nodedexClearFilter;

  /// No description provided for @nodedexCloseGallerySemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Close gallery'**
  String get nodedexCloseGallerySemanticLabel;

  /// No description provided for @nodedexCoSeenCompactLabel.
  ///
  /// In en, this message translates to:
  /// **'Co-seen'**
  String get nodedexCoSeenCompactLabel;

  /// No description provided for @nodedexCoSeenDescription.
  ///
  /// In en, this message translates to:
  /// **'Nodes frequently seen in the same session'**
  String get nodedexCoSeenDescription;

  /// No description provided for @nodedexCoSeenLinksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} links'**
  String nodedexCoSeenLinksCount(int count);

  /// No description provided for @nodedexCoSeenLinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Co-Seen Links'**
  String get nodedexCoSeenLinksTitle;

  /// No description provided for @nodedexCoSeenRelationshipDetails.
  ///
  /// In en, this message translates to:
  /// **'Co-seen relationship details'**
  String get nodedexCoSeenRelationshipDetails;

  /// No description provided for @nodedexCollectedCount.
  ///
  /// In en, this message translates to:
  /// **'{count} collected'**
  String nodedexCollectedCount(int count);

  /// No description provided for @nodedexConfidenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get nodedexConfidenceLabel;

  /// No description provided for @nodedexConfidenceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Confidence: {percentage}%'**
  String nodedexConfidenceTooltip(int percentage);

  /// No description provided for @nodedexConstellationCloseSearch.
  ///
  /// In en, this message translates to:
  /// **'Close search'**
  String get nodedexConstellationCloseSearch;

  /// No description provided for @nodedexConstellationEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover more nodes to see how they connect.\nNodes seen together form constellation links.'**
  String get nodedexConstellationEmptySubtitle;

  /// No description provided for @nodedexConstellationEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Constellation Yet'**
  String get nodedexConstellationEmptyTitle;

  /// No description provided for @nodedexConstellationLinkCount.
  ///
  /// In en, this message translates to:
  /// **'{count} links'**
  String nodedexConstellationLinkCount(int count);

  /// No description provided for @nodedexConstellationLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Constellation Link'**
  String get nodedexConstellationLinkTitle;

  /// No description provided for @nodedexConstellationNodeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes'**
  String nodedexConstellationNodeCount(int count);

  /// No description provided for @nodedexConstellationProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nodedexConstellationProfile;

  /// No description provided for @nodedexConstellationSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or node ID…'**
  String get nodedexConstellationSearchHint;

  /// No description provided for @nodedexConstellationSearchNodes.
  ///
  /// In en, this message translates to:
  /// **'Search nodes'**
  String get nodedexConstellationSearchNodes;

  /// No description provided for @nodedexConstellationTitle.
  ///
  /// In en, this message translates to:
  /// **'Constellation'**
  String get nodedexConstellationTitle;

  /// No description provided for @nodedexDayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get nodedexDayFri;

  /// No description provided for @nodedexDayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get nodedexDayFriday;

  /// No description provided for @nodedexDayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get nodedexDayMon;

  /// No description provided for @nodedexDayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get nodedexDayMonday;

  /// No description provided for @nodedexDaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get nodedexDaySat;

  /// No description provided for @nodedexDaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get nodedexDaySaturday;

  /// No description provided for @nodedexDaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get nodedexDaySun;

  /// No description provided for @nodedexDaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get nodedexDaySunday;

  /// No description provided for @nodedexDayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get nodedexDayThu;

  /// No description provided for @nodedexDayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get nodedexDayThursday;

  /// No description provided for @nodedexDayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get nodedexDayTue;

  /// No description provided for @nodedexDayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get nodedexDayTuesday;

  /// No description provided for @nodedexDayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get nodedexDayWed;

  /// No description provided for @nodedexDayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get nodedexDayWednesday;

  /// No description provided for @nodedexDaysCompactLabel.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get nodedexDaysCompactLabel;

  /// No description provided for @nodedexDefaultStampLabel.
  ///
  /// In en, this message translates to:
  /// **'Trace'**
  String get nodedexDefaultStampLabel;

  /// No description provided for @nodedexDefaultSummaryText.
  ///
  /// In en, this message translates to:
  /// **'Keep observing to build a profile'**
  String get nodedexDefaultSummaryText;

  /// No description provided for @nodedexDensityAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get nodedexDensityAll;

  /// No description provided for @nodedexDensityDense.
  ///
  /// In en, this message translates to:
  /// **'Dense'**
  String get nodedexDensityDense;

  /// No description provided for @nodedexDensityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get nodedexDensityNormal;

  /// No description provided for @nodedexDensitySparse.
  ///
  /// In en, this message translates to:
  /// **'Sparse'**
  String get nodedexDensitySparse;

  /// No description provided for @nodedexDensityStars.
  ///
  /// In en, this message translates to:
  /// **'Stars'**
  String get nodedexDensityStars;

  /// No description provided for @nodedexDetailNotFoundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This node has not been discovered yet.'**
  String get nodedexDetailNotFoundSubtitle;

  /// No description provided for @nodedexDetailNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Node not found in NodeDex'**
  String get nodedexDetailNotFoundTitle;

  /// No description provided for @nodedexDeviceTitle.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get nodedexDeviceTitle;

  /// No description provided for @nodedexDiscoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Discovery'**
  String get nodedexDiscoveryTitle;

  /// No description provided for @nodedexDistanceUnknown.
  ///
  /// In en, this message translates to:
  /// **'unknown range'**
  String get nodedexDistanceUnknown;

  /// No description provided for @nodedexDurationDays.
  ///
  /// In en, this message translates to:
  /// **'{days} d'**
  String nodedexDurationDays(int days);

  /// No description provided for @nodedexDurationHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} hr'**
  String nodedexDurationHours(int hours);

  /// No description provided for @nodedexDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String nodedexDurationMinutes(int minutes);

  /// No description provided for @nodedexDurationMonths.
  ///
  /// In en, this message translates to:
  /// **'{months} mo'**
  String nodedexDurationMonths(int months);

  /// No description provided for @nodedexDurationMonthsDays.
  ///
  /// In en, this message translates to:
  /// **'{months} mo {days} d'**
  String nodedexDurationMonthsDays(int months, int days);

  /// No description provided for @nodedexDurationYears.
  ///
  /// In en, this message translates to:
  /// **'{years} yr'**
  String nodedexDurationYears(int years);

  /// No description provided for @nodedexDurationYearsMonths.
  ///
  /// In en, this message translates to:
  /// **'{years} yr {months} mo'**
  String nodedexDurationYearsMonths(int years, int months);

  /// No description provided for @nodedexEdgeDensityAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get nodedexEdgeDensityAll;

  /// No description provided for @nodedexEdgeDensityDense.
  ///
  /// In en, this message translates to:
  /// **'Dense'**
  String get nodedexEdgeDensityDense;

  /// No description provided for @nodedexEdgeDensityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get nodedexEdgeDensityNormal;

  /// No description provided for @nodedexEdgeDensitySparse.
  ///
  /// In en, this message translates to:
  /// **'Sparse'**
  String get nodedexEdgeDensitySparse;

  /// No description provided for @nodedexEdgeDensityTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edge density: {label}'**
  String nodedexEdgeDensityTooltip(String label);

  /// No description provided for @nodedexEmptyAlbumDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect to a mesh device and discover nodes\nto start building your collection'**
  String get nodedexEmptyAlbumDescription;

  /// No description provided for @nodedexEmptyAlbumHintMove.
  ///
  /// In en, this message translates to:
  /// **'Move around'**
  String get nodedexEmptyAlbumHintMove;

  /// No description provided for @nodedexEmptyAlbumHintScan.
  ///
  /// In en, this message translates to:
  /// **'Scan for devices'**
  String get nodedexEmptyAlbumHintScan;

  /// No description provided for @nodedexEmptyAlbumTitle.
  ///
  /// In en, this message translates to:
  /// **'No cards yet'**
  String get nodedexEmptyAlbumTitle;

  /// No description provided for @nodedexEmptyAllSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect to a Meshtastic device and nodes will appear here as they are discovered on the mesh.'**
  String get nodedexEmptyAllSubtitle;

  /// No description provided for @nodedexEmptyAllTitle.
  ///
  /// In en, this message translates to:
  /// **'No nodes discovered yet'**
  String get nodedexEmptyAllTitle;

  /// No description provided for @nodedexEmptyBeaconsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Beacons are nodes with very high activity and frequent encounters. They take time to classify.'**
  String get nodedexEmptyBeaconsSubtitle;

  /// No description provided for @nodedexEmptyBeaconsTitle.
  ///
  /// In en, this message translates to:
  /// **'No beacons found'**
  String get nodedexEmptyBeaconsTitle;

  /// No description provided for @nodedexEmptyContactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nodes you classify as Contact will appear here. Long-press a node to assign this tag.'**
  String get nodedexEmptyContactSubtitle;

  /// No description provided for @nodedexEmptyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'No contacts'**
  String get nodedexEmptyContactTitle;

  /// No description provided for @nodedexEmptyFrequentPeerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nodes you classify as Frequent Peer will appear here. Long-press a node to assign this tag.'**
  String get nodedexEmptyFrequentPeerSubtitle;

  /// No description provided for @nodedexEmptyFrequentPeerTitle.
  ///
  /// In en, this message translates to:
  /// **'No frequent peers'**
  String get nodedexEmptyFrequentPeerTitle;

  /// No description provided for @nodedexEmptyGalleryDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover nodes to fill your collection'**
  String get nodedexEmptyGalleryDescription;

  /// No description provided for @nodedexEmptyGalleryTitle.
  ///
  /// In en, this message translates to:
  /// **'No cards to display'**
  String get nodedexEmptyGalleryTitle;

  /// No description provided for @nodedexEmptyGhostsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ghosts are nodes that appear rarely relative to how long they have been known.'**
  String get nodedexEmptyGhostsSubtitle;

  /// No description provided for @nodedexEmptyGhostsTitle.
  ///
  /// In en, this message translates to:
  /// **'No ghosts found'**
  String get nodedexEmptyGhostsTitle;

  /// No description provided for @nodedexEmptyKnownRelaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nodes you classify as Known Relay will appear here. Long-press a node to assign this tag.'**
  String get nodedexEmptyKnownRelaySubtitle;

  /// No description provided for @nodedexEmptyKnownRelayTitle.
  ///
  /// In en, this message translates to:
  /// **'No known relays'**
  String get nodedexEmptyKnownRelayTitle;

  /// No description provided for @nodedexEmptyRecentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nodes discovered in the last 24 hours will appear here.'**
  String get nodedexEmptyRecentSubtitle;

  /// No description provided for @nodedexEmptyRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'No recent discoveries'**
  String get nodedexEmptyRecentTitle;

  /// No description provided for @nodedexEmptyRelaysSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Relays are nodes with router roles and active traffic forwarding.'**
  String get nodedexEmptyRelaysSubtitle;

  /// No description provided for @nodedexEmptyRelaysTitle.
  ///
  /// In en, this message translates to:
  /// **'No relays found'**
  String get nodedexEmptyRelaysTitle;

  /// No description provided for @nodedexEmptySentinelsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sentinels are long-lived, fixed-position nodes with reliable presence.'**
  String get nodedexEmptySentinelsSubtitle;

  /// No description provided for @nodedexEmptySentinelsTitle.
  ///
  /// In en, this message translates to:
  /// **'No sentinels found'**
  String get nodedexEmptySentinelsTitle;

  /// No description provided for @nodedexEmptyTaggedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Long-press a node in the list to assign a social tag like Contact, Trusted Node, or Known Relay.'**
  String get nodedexEmptyTaggedSubtitle;

  /// No description provided for @nodedexEmptyTaggedTitle.
  ///
  /// In en, this message translates to:
  /// **'No tagged nodes'**
  String get nodedexEmptyTaggedTitle;

  /// No description provided for @nodedexEmptyTagline1.
  ///
  /// In en, this message translates to:
  /// **'No nodes discovered yet.\nConnect to a mesh device to start building your field journal.'**
  String get nodedexEmptyTagline1;

  /// No description provided for @nodedexEmptyTagline2.
  ///
  /// In en, this message translates to:
  /// **'NodeDex catalogs every node you encounter.\nEach one gets a unique procedural identity.'**
  String get nodedexEmptyTagline2;

  /// No description provided for @nodedexEmptyTagline3.
  ///
  /// In en, this message translates to:
  /// **'Discover wanderers, sentinels, and ghosts.\nPersonality traits emerge from behavior patterns.'**
  String get nodedexEmptyTagline3;

  /// No description provided for @nodedexEmptyTagline4.
  ///
  /// In en, this message translates to:
  /// **'Tag nodes as contacts or trusted relays.\nBuild your mesh community over time.'**
  String get nodedexEmptyTagline4;

  /// No description provided for @nodedexEmptyTitleKeyword.
  ///
  /// In en, this message translates to:
  /// **'NodeDex'**
  String get nodedexEmptyTitleKeyword;

  /// No description provided for @nodedexEmptyTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'Your '**
  String get nodedexEmptyTitlePrefix;

  /// No description provided for @nodedexEmptyTitleSuffix.
  ///
  /// In en, this message translates to:
  /// **' is empty'**
  String get nodedexEmptyTitleSuffix;

  /// No description provided for @nodedexEmptyTrustedNodeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nodes you classify as Trusted Node will appear here. Long-press a node to assign this tag.'**
  String get nodedexEmptyTrustedNodeSubtitle;

  /// No description provided for @nodedexEmptyTrustedNodeTitle.
  ///
  /// In en, this message translates to:
  /// **'No trusted nodes'**
  String get nodedexEmptyTrustedNodeTitle;

  /// No description provided for @nodedexEmptyWanderersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Wanderers are nodes seen across multiple locations. They emerge over time as position data accumulates.'**
  String get nodedexEmptyWanderersSubtitle;

  /// No description provided for @nodedexEmptyWanderersTitle.
  ///
  /// In en, this message translates to:
  /// **'No wanderers found'**
  String get nodedexEmptyWanderersTitle;

  /// No description provided for @nodedexEncounterActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Encounter Activity'**
  String get nodedexEncounterActivityTitle;

  /// No description provided for @nodedexEncounterCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 encounter} other{{count} encounters}}'**
  String nodedexEncounterCountLabel(int count);

  /// No description provided for @nodedexEncounterLogLabel.
  ///
  /// In en, this message translates to:
  /// **'ENCOUNTER LOG'**
  String get nodedexEncounterLogLabel;

  /// No description provided for @nodedexEncountersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters'**
  String nodedexEncountersCount(int count);

  /// No description provided for @nodedexEncountersLabel.
  ///
  /// In en, this message translates to:
  /// **'Encounters'**
  String get nodedexEncountersLabel;

  /// No description provided for @nodedexEncountersStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Encounters'**
  String get nodedexEncountersStatLabel;

  /// No description provided for @nodedexEvidenceActiveLastHour.
  ///
  /// In en, this message translates to:
  /// **'Active within the last hour'**
  String get nodedexEvidenceActiveLastHour;

  /// No description provided for @nodedexEvidenceAirtimeTx.
  ///
  /// In en, this message translates to:
  /// **'Airtime TX {percent}%'**
  String nodedexEvidenceAirtimeTx(String percent);

  /// No description provided for @nodedexEvidenceChannelUtilization.
  ///
  /// In en, this message translates to:
  /// **'Channel utilization {percent}%'**
  String nodedexEvidenceChannelUtilization(String percent);

  /// No description provided for @nodedexEvidenceCoSeenWith.
  ///
  /// In en, this message translates to:
  /// **'Co-seen with {count} nodes'**
  String nodedexEvidenceCoSeenWith(int count);

  /// No description provided for @nodedexEvidenceDistinctPositions.
  ///
  /// In en, this message translates to:
  /// **'Observed at {count} distinct positions'**
  String nodedexEvidenceDistinctPositions(int count);

  /// No description provided for @nodedexEvidenceEncounterRate.
  ///
  /// In en, this message translates to:
  /// **'{rate} encounters/day'**
  String nodedexEvidenceEncounterRate(String rate);

  /// No description provided for @nodedexEvidenceEncounterRateLow.
  ///
  /// In en, this message translates to:
  /// **'Encounter rate {rate}/day'**
  String nodedexEvidenceEncounterRateLow(String rate);

  /// No description provided for @nodedexEvidenceEncountersReliable.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters (reliable)'**
  String nodedexEvidenceEncountersReliable(int count);

  /// No description provided for @nodedexEvidenceFewEncountersOverDays.
  ///
  /// In en, this message translates to:
  /// **'Only {encounters} encounters over {days} days'**
  String nodedexEvidenceFewEncountersOverDays(int encounters, int days);

  /// No description provided for @nodedexEvidenceFixedLocation.
  ///
  /// In en, this message translates to:
  /// **'Fixed location'**
  String get nodedexEvidenceFixedLocation;

  /// No description provided for @nodedexEvidenceFixedPosition.
  ///
  /// In en, this message translates to:
  /// **'Fixed position (single location)'**
  String get nodedexEvidenceFixedPosition;

  /// No description provided for @nodedexEvidenceHighEncounterCount.
  ///
  /// In en, this message translates to:
  /// **'High encounter count (20+)'**
  String get nodedexEvidenceHighEncounterCount;

  /// No description provided for @nodedexEvidenceInsufficientData.
  ///
  /// In en, this message translates to:
  /// **'Insufficient data to classify'**
  String get nodedexEvidenceInsufficientData;

  /// No description provided for @nodedexEvidenceIrregularTiming.
  ///
  /// In en, this message translates to:
  /// **'Irregular timing (CV {cv})'**
  String nodedexEvidenceIrregularTiming(String cv);

  /// No description provided for @nodedexEvidenceKnownForDays.
  ///
  /// In en, this message translates to:
  /// **'Known for {days} days'**
  String nodedexEvidenceKnownForDays(int days);

  /// No description provided for @nodedexEvidenceLastSeenDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'Last seen {days}d ago'**
  String nodedexEvidenceLastSeenDaysAgo(int days);

  /// No description provided for @nodedexEvidenceMaxRange.
  ///
  /// In en, this message translates to:
  /// **'Max range {km}km'**
  String nodedexEvidenceMaxRange(String km);

  /// No description provided for @nodedexEvidenceMessagesExchanged.
  ///
  /// In en, this message translates to:
  /// **'{count} messages exchanged'**
  String nodedexEvidenceMessagesExchanged(int count);

  /// No description provided for @nodedexEvidenceMessagesPerEncounter.
  ///
  /// In en, this message translates to:
  /// **'{ratio} messages per encounter'**
  String nodedexEvidenceMessagesPerEncounter(String ratio);

  /// No description provided for @nodedexEvidenceMobileWithMessaging.
  ///
  /// In en, this message translates to:
  /// **'Mobile with active messaging'**
  String get nodedexEvidenceMobileWithMessaging;

  /// No description provided for @nodedexEvidenceModerateEncounterRate.
  ///
  /// In en, this message translates to:
  /// **'Moderate encounter rate ({rate}/day)'**
  String nodedexEvidenceModerateEncounterRate(String rate);

  /// No description provided for @nodedexEvidencePersistentPresence.
  ///
  /// In en, this message translates to:
  /// **'Persistent presence ({days} days)'**
  String nodedexEvidencePersistentPresence(int days);

  /// No description provided for @nodedexEvidencePositionsObserved.
  ///
  /// In en, this message translates to:
  /// **'{count} positions observed'**
  String nodedexEvidencePositionsObserved(int count);

  /// No description provided for @nodedexEvidenceRoleIs.
  ///
  /// In en, this message translates to:
  /// **'Role is {role}'**
  String nodedexEvidenceRoleIs(String role);

  /// No description provided for @nodedexEvidenceSeenAcrossRegions.
  ///
  /// In en, this message translates to:
  /// **'Seen across {count} regions'**
  String nodedexEvidenceSeenAcrossRegions(int count);

  /// No description provided for @nodedexEvidenceSomewhatIrregularTiming.
  ///
  /// In en, this message translates to:
  /// **'Somewhat irregular timing (CV {cv})'**
  String nodedexEvidenceSomewhatIrregularTiming(String cv);

  /// No description provided for @nodedexEvidenceTotalEncounters.
  ///
  /// In en, this message translates to:
  /// **'{count} total encounters'**
  String nodedexEvidenceTotalEncounters(int count);

  /// No description provided for @nodedexEvidenceUptime.
  ///
  /// In en, this message translates to:
  /// **'Uptime {days}d'**
  String nodedexEvidenceUptime(int days);

  /// No description provided for @nodedexExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String nodedexExportFailed(String error);

  /// No description provided for @nodedexExportNothingToExport.
  ///
  /// In en, this message translates to:
  /// **'Nothing to export — NodeDex is empty'**
  String get nodedexExportNothingToExport;

  /// No description provided for @nodedexExportShareSubject.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh NodeDex Export'**
  String get nodedexExportShareSubject;

  /// No description provided for @nodedexFieldNoteAnchor0.
  ///
  /// In en, this message translates to:
  /// **'Hub node. Co-seen with {coSeen} other nodes.'**
  String nodedexFieldNoteAnchor0(int coSeen);

  /// No description provided for @nodedexFieldNoteAnchor1.
  ///
  /// In en, this message translates to:
  /// **'Social center of local mesh. Many connections.'**
  String get nodedexFieldNoteAnchor1;

  /// No description provided for @nodedexFieldNoteAnchor2.
  ///
  /// In en, this message translates to:
  /// **'Persistent hub. {coSeen} nodes observed in proximity.'**
  String nodedexFieldNoteAnchor2(int coSeen);

  /// No description provided for @nodedexFieldNoteAnchor3.
  ///
  /// In en, this message translates to:
  /// **'Anchor point for nearby nodes. Fixed and well-connected.'**
  String get nodedexFieldNoteAnchor3;

  /// No description provided for @nodedexFieldNoteAnchor4.
  ///
  /// In en, this message translates to:
  /// **'Central to local topology. High co-seen density.'**
  String get nodedexFieldNoteAnchor4;

  /// No description provided for @nodedexFieldNoteAnchor5.
  ///
  /// In en, this message translates to:
  /// **'Gravitational center. Other nodes cluster around this one.'**
  String get nodedexFieldNoteAnchor5;

  /// No description provided for @nodedexFieldNoteAnchor6.
  ///
  /// In en, this message translates to:
  /// **'Infrastructure anchor. {coSeen} peers linked.'**
  String nodedexFieldNoteAnchor6(int coSeen);

  /// No description provided for @nodedexFieldNoteAnchor7.
  ///
  /// In en, this message translates to:
  /// **'Mesh nexus. Stable presence with broad connectivity.'**
  String get nodedexFieldNoteAnchor7;

  /// No description provided for @nodedexFieldNoteBeacon0.
  ///
  /// In en, this message translates to:
  /// **'Steady signal. {rate} sightings per day.'**
  String nodedexFieldNoteBeacon0(String rate);

  /// No description provided for @nodedexFieldNoteBeacon1.
  ///
  /// In en, this message translates to:
  /// **'Persistent presence on the mesh. Always broadcasting.'**
  String get nodedexFieldNoteBeacon1;

  /// No description provided for @nodedexFieldNoteBeacon2.
  ///
  /// In en, this message translates to:
  /// **'Reliable and consistent. Last heard {lastSeen}.'**
  String nodedexFieldNoteBeacon2(String lastSeen);

  /// No description provided for @nodedexFieldNoteBeacon3.
  ///
  /// In en, this message translates to:
  /// **'High availability. {encounters} encounters recorded.'**
  String nodedexFieldNoteBeacon3(int encounters);

  /// No description provided for @nodedexFieldNoteBeacon4.
  ///
  /// In en, this message translates to:
  /// **'Continuous operation confirmed. Signal rarely drops.'**
  String get nodedexFieldNoteBeacon4;

  /// No description provided for @nodedexFieldNoteBeacon5.
  ///
  /// In en, this message translates to:
  /// **'Always-on presence. Dependable reference point.'**
  String get nodedexFieldNoteBeacon5;

  /// No description provided for @nodedexFieldNoteBeacon6.
  ///
  /// In en, this message translates to:
  /// **'Broadcasting consistently. {rate} daily observations.'**
  String nodedexFieldNoteBeacon6(String rate);

  /// No description provided for @nodedexFieldNoteBeacon7.
  ///
  /// In en, this message translates to:
  /// **'Fixed rhythm. Predictable timing across sessions.'**
  String get nodedexFieldNoteBeacon7;

  /// No description provided for @nodedexFieldNoteCourier0.
  ///
  /// In en, this message translates to:
  /// **'High message volume. {messages} messages across {encounters} encounters.'**
  String nodedexFieldNoteCourier0(int messages, int encounters);

  /// No description provided for @nodedexFieldNoteCourier1.
  ///
  /// In en, this message translates to:
  /// **'Data carrier. Message-to-encounter ratio elevated.'**
  String get nodedexFieldNoteCourier1;

  /// No description provided for @nodedexFieldNoteCourier2.
  ///
  /// In en, this message translates to:
  /// **'Active in message exchange. Courier behavior likely.'**
  String get nodedexFieldNoteCourier2;

  /// No description provided for @nodedexFieldNoteCourier3.
  ///
  /// In en, this message translates to:
  /// **'Carries data between mesh segments. {messages} messages logged.'**
  String nodedexFieldNoteCourier3(int messages);

  /// No description provided for @nodedexFieldNoteCourier4.
  ///
  /// In en, this message translates to:
  /// **'Message density suggests deliberate data transport.'**
  String get nodedexFieldNoteCourier4;

  /// No description provided for @nodedexFieldNoteCourier5.
  ///
  /// In en, this message translates to:
  /// **'Communication-heavy node. {messages} exchanges recorded.'**
  String nodedexFieldNoteCourier5(int messages);

  /// No description provided for @nodedexFieldNoteCourier6.
  ///
  /// In en, this message translates to:
  /// **'Frequent messenger. Moves data across the network.'**
  String get nodedexFieldNoteCourier6;

  /// No description provided for @nodedexFieldNoteCourier7.
  ///
  /// In en, this message translates to:
  /// **'Delivery pattern observed. Messages outpace encounters.'**
  String get nodedexFieldNoteCourier7;

  /// No description provided for @nodedexFieldNoteDrifter0.
  ///
  /// In en, this message translates to:
  /// **'Timing unpredictable. Appears and fades without pattern.'**
  String get nodedexFieldNoteDrifter0;

  /// No description provided for @nodedexFieldNoteDrifter1.
  ///
  /// In en, this message translates to:
  /// **'Irregular intervals between sightings.'**
  String get nodedexFieldNoteDrifter1;

  /// No description provided for @nodedexFieldNoteDrifter2.
  ///
  /// In en, this message translates to:
  /// **'No consistent schedule. Drift behavior confirmed.'**
  String get nodedexFieldNoteDrifter2;

  /// No description provided for @nodedexFieldNoteDrifter3.
  ///
  /// In en, this message translates to:
  /// **'Appears sporadically but not rarely. Timing erratic.'**
  String get nodedexFieldNoteDrifter3;

  /// No description provided for @nodedexFieldNoteDrifter4.
  ///
  /// In en, this message translates to:
  /// **'Signal comes and goes. No rhythm detected.'**
  String get nodedexFieldNoteDrifter4;

  /// No description provided for @nodedexFieldNoteDrifter5.
  ///
  /// In en, this message translates to:
  /// **'Present but unreliable. Intervals vary widely.'**
  String get nodedexFieldNoteDrifter5;

  /// No description provided for @nodedexFieldNoteDrifter6.
  ///
  /// In en, this message translates to:
  /// **'Observation timing scattered. No periodicity found.'**
  String get nodedexFieldNoteDrifter6;

  /// No description provided for @nodedexFieldNoteDrifter7.
  ///
  /// In en, this message translates to:
  /// **'Intermittent but active. Schedule defies prediction.'**
  String get nodedexFieldNoteDrifter7;

  /// No description provided for @nodedexFieldNoteGhost0.
  ///
  /// In en, this message translates to:
  /// **'Rarely observed. Last confirmed sighting {lastSeen}.'**
  String nodedexFieldNoteGhost0(String lastSeen);

  /// No description provided for @nodedexFieldNoteGhost1.
  ///
  /// In en, this message translates to:
  /// **'Elusive. {encounters} encounters over {age} days.'**
  String nodedexFieldNoteGhost1(int encounters, int age);

  /// No description provided for @nodedexFieldNoteGhost2.
  ///
  /// In en, this message translates to:
  /// **'Signal appears briefly then vanishes. Pattern unknown.'**
  String get nodedexFieldNoteGhost2;

  /// No description provided for @nodedexFieldNoteGhost3.
  ///
  /// In en, this message translates to:
  /// **'Intermittent trace only. Insufficient data for profile.'**
  String get nodedexFieldNoteGhost3;

  /// No description provided for @nodedexFieldNoteGhost4.
  ///
  /// In en, this message translates to:
  /// **'Faint and sporadic. Presence cannot be relied upon.'**
  String get nodedexFieldNoteGhost4;

  /// No description provided for @nodedexFieldNoteGhost5.
  ///
  /// In en, this message translates to:
  /// **'Appears without warning. Disappears without trace.'**
  String get nodedexFieldNoteGhost5;

  /// No description provided for @nodedexFieldNoteGhost6.
  ///
  /// In en, this message translates to:
  /// **'Low encounter density. Behavior difficult to classify.'**
  String get nodedexFieldNoteGhost6;

  /// No description provided for @nodedexFieldNoteGhost7.
  ///
  /// In en, this message translates to:
  /// **'Detected at the margins. Observation window narrow.'**
  String get nodedexFieldNoteGhost7;

  /// No description provided for @nodedexFieldNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Field Note'**
  String get nodedexFieldNoteLabel;

  /// No description provided for @nodedexFieldNoteRelay0.
  ///
  /// In en, this message translates to:
  /// **'Forwarding traffic. Router role confirmed.'**
  String get nodedexFieldNoteRelay0;

  /// No description provided for @nodedexFieldNoteRelay1.
  ///
  /// In en, this message translates to:
  /// **'Active relay node. Channel utilization elevated.'**
  String get nodedexFieldNoteRelay1;

  /// No description provided for @nodedexFieldNoteRelay2.
  ///
  /// In en, this message translates to:
  /// **'Infrastructure role: traffic forwarding observed.'**
  String get nodedexFieldNoteRelay2;

  /// No description provided for @nodedexFieldNoteRelay3.
  ///
  /// In en, this message translates to:
  /// **'Router signature detected. High airtime usage.'**
  String get nodedexFieldNoteRelay3;

  /// No description provided for @nodedexFieldNoteRelay4.
  ///
  /// In en, this message translates to:
  /// **'Mesh backbone element. Facilitates connectivity.'**
  String get nodedexFieldNoteRelay4;

  /// No description provided for @nodedexFieldNoteRelay5.
  ///
  /// In en, this message translates to:
  /// **'Relay behavior consistent across {encounters} sessions.'**
  String nodedexFieldNoteRelay5(int encounters);

  /// No description provided for @nodedexFieldNoteRelay6.
  ///
  /// In en, this message translates to:
  /// **'Traffic handler. Forwarding pattern stable.'**
  String get nodedexFieldNoteRelay6;

  /// No description provided for @nodedexFieldNoteRelay7.
  ///
  /// In en, this message translates to:
  /// **'Network infrastructure. Routing confirmed by role.'**
  String get nodedexFieldNoteRelay7;

  /// No description provided for @nodedexFieldNoteSentinel0.
  ///
  /// In en, this message translates to:
  /// **'Fixed position. Monitoring for {age} days.'**
  String nodedexFieldNoteSentinel0(int age);

  /// No description provided for @nodedexFieldNoteSentinel1.
  ///
  /// In en, this message translates to:
  /// **'Stationary installation. Signal consistent and strong.'**
  String get nodedexFieldNoteSentinel1;

  /// No description provided for @nodedexFieldNoteSentinel2.
  ///
  /// In en, this message translates to:
  /// **'Guardian presence. {encounters} observations from one location.'**
  String nodedexFieldNoteSentinel2(int encounters);

  /// No description provided for @nodedexFieldNoteSentinel3.
  ///
  /// In en, this message translates to:
  /// **'Long-lived post. First observed {firstSeen}.'**
  String nodedexFieldNoteSentinel3(String firstSeen);

  /// No description provided for @nodedexFieldNoteSentinel4.
  ///
  /// In en, this message translates to:
  /// **'No position variance. Infrastructure signature confirmed.'**
  String get nodedexFieldNoteSentinel4;

  /// No description provided for @nodedexFieldNoteSentinel5.
  ///
  /// In en, this message translates to:
  /// **'Holding position. Reliable since first contact.'**
  String get nodedexFieldNoteSentinel5;

  /// No description provided for @nodedexFieldNoteSentinel6.
  ///
  /// In en, this message translates to:
  /// **'Static deployment. Best signal {snr} dB SNR.'**
  String nodedexFieldNoteSentinel6(int snr);

  /// No description provided for @nodedexFieldNoteSentinel7.
  ///
  /// In en, this message translates to:
  /// **'Permanent fixture. Observed continuously for {age} days.'**
  String nodedexFieldNoteSentinel7(int age);

  /// No description provided for @nodedexFieldNoteUnknown0.
  ///
  /// In en, this message translates to:
  /// **'Recently discovered. Observation in progress.'**
  String get nodedexFieldNoteUnknown0;

  /// No description provided for @nodedexFieldNoteUnknown1.
  ///
  /// In en, this message translates to:
  /// **'New contact. Insufficient data for classification.'**
  String get nodedexFieldNoteUnknown1;

  /// No description provided for @nodedexFieldNoteUnknown2.
  ///
  /// In en, this message translates to:
  /// **'First logged {firstSeen}. Awaiting further signals.'**
  String nodedexFieldNoteUnknown2(String firstSeen);

  /// No description provided for @nodedexFieldNoteUnknown3.
  ///
  /// In en, this message translates to:
  /// **'Identity recorded. Behavioral profile pending.'**
  String get nodedexFieldNoteUnknown3;

  /// No description provided for @nodedexFieldNoteUnknown4.
  ///
  /// In en, this message translates to:
  /// **'Initial entry. More encounters needed for assessment.'**
  String get nodedexFieldNoteUnknown4;

  /// No description provided for @nodedexFieldNoteUnknown5.
  ///
  /// In en, this message translates to:
  /// **'Cataloged. No behavioral pattern yet established.'**
  String get nodedexFieldNoteUnknown5;

  /// No description provided for @nodedexFieldNoteUnknown6.
  ///
  /// In en, this message translates to:
  /// **'Signal acknowledged. Classification deferred.'**
  String get nodedexFieldNoteUnknown6;

  /// No description provided for @nodedexFieldNoteUnknown7.
  ///
  /// In en, this message translates to:
  /// **'Entry created. Monitoring initiated.'**
  String get nodedexFieldNoteUnknown7;

  /// No description provided for @nodedexFieldNoteWanderer0.
  ///
  /// In en, this message translates to:
  /// **'Recorded across {regions} regions. No fixed bearing.'**
  String nodedexFieldNoteWanderer0(int regions);

  /// No description provided for @nodedexFieldNoteWanderer1.
  ///
  /// In en, this message translates to:
  /// **'Passes through without settling. {positions} positions logged.'**
  String nodedexFieldNoteWanderer1(int positions);

  /// No description provided for @nodedexFieldNoteWanderer2.
  ///
  /// In en, this message translates to:
  /// **'Transient signal. Observed moving through {regions} zones.'**
  String nodedexFieldNoteWanderer2(int regions);

  /// No description provided for @nodedexFieldNoteWanderer3.
  ///
  /// In en, this message translates to:
  /// **'Migratory pattern suspected. Range up to {distance}.'**
  String nodedexFieldNoteWanderer3(String distance);

  /// No description provided for @nodedexFieldNoteWanderer4.
  ///
  /// In en, this message translates to:
  /// **'Appears at different coordinates each session.'**
  String get nodedexFieldNoteWanderer4;

  /// No description provided for @nodedexFieldNoteWanderer5.
  ///
  /// In en, this message translates to:
  /// **'No anchor point detected. Drift confirmed across {regions} regions.'**
  String nodedexFieldNoteWanderer5(int regions);

  /// No description provided for @nodedexFieldNoteWanderer6.
  ///
  /// In en, this message translates to:
  /// **'Logged at {positions} positions. Path unclear.'**
  String nodedexFieldNoteWanderer6(int positions);

  /// No description provided for @nodedexFieldNoteWanderer7.
  ///
  /// In en, this message translates to:
  /// **'Signal origin shifts between sessions.'**
  String get nodedexFieldNoteWanderer7;

  /// No description provided for @nodedexFileTransferStarted.
  ///
  /// In en, this message translates to:
  /// **'File transfer started: {filename}'**
  String nodedexFileTransferStarted(String filename);

  /// No description provided for @nodedexFileTransfersTitle.
  ///
  /// In en, this message translates to:
  /// **'File Transfers'**
  String get nodedexFileTransfersTitle;

  /// No description provided for @nodedexFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get nodedexFilterAll;

  /// No description provided for @nodedexFilterByDateHelp.
  ///
  /// In en, this message translates to:
  /// **'Filter encounters by date'**
  String get nodedexFilterByDateHelp;

  /// No description provided for @nodedexFilterRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get nodedexFilterRecent;

  /// No description provided for @nodedexFilterTagged.
  ///
  /// In en, this message translates to:
  /// **'Tagged'**
  String get nodedexFilterTagged;

  /// No description provided for @nodedexFirmwareLabel.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get nodedexFirmwareLabel;

  /// No description provided for @nodedexFirstDiscovered.
  ///
  /// In en, this message translates to:
  /// **'First Discovered'**
  String get nodedexFirstDiscovered;

  /// No description provided for @nodedexFirstSeenStatLabel.
  ///
  /// In en, this message translates to:
  /// **'First Seen'**
  String get nodedexFirstSeenStatLabel;

  /// No description provided for @nodedexFirstSighting.
  ///
  /// In en, this message translates to:
  /// **'First Sighting'**
  String get nodedexFirstSighting;

  /// No description provided for @nodedexGalleryHint.
  ///
  /// In en, this message translates to:
  /// **'Tap card to flip • Swipe to browse'**
  String get nodedexGalleryHint;

  /// No description provided for @nodedexGalleryLinksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} links'**
  String nodedexGalleryLinksCount(int count);

  /// No description provided for @nodedexGalleryPositionCounter.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String nodedexGalleryPositionCounter(int current, int total);

  /// No description provided for @nodedexGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get nodedexGotIt;

  /// No description provided for @nodedexGroupByLabel.
  ///
  /// In en, this message translates to:
  /// **'GROUP BY'**
  String get nodedexGroupByLabel;

  /// No description provided for @nodedexGroupByRarity.
  ///
  /// In en, this message translates to:
  /// **'Rarity'**
  String get nodedexGroupByRarity;

  /// No description provided for @nodedexGroupByRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get nodedexGroupByRegion;

  /// No description provided for @nodedexGroupByTrait.
  ///
  /// In en, this message translates to:
  /// **'Trait'**
  String get nodedexGroupByTrait;

  /// No description provided for @nodedexHardwareLabel.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get nodedexHardwareLabel;

  /// No description provided for @nodedexHelpActivityTimeline.
  ///
  /// In en, this message translates to:
  /// **'Activity Timeline'**
  String get nodedexHelpActivityTimeline;

  /// No description provided for @nodedexHelpClassification.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get nodedexHelpClassification;

  /// No description provided for @nodedexHelpConstellationLinks.
  ///
  /// In en, this message translates to:
  /// **'Constellation Links'**
  String get nodedexHelpConstellationLinks;

  /// No description provided for @nodedexHelpDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get nodedexHelpDeviceInfo;

  /// No description provided for @nodedexHelpDiscoveryStats.
  ///
  /// In en, this message translates to:
  /// **'Discovery Stats'**
  String get nodedexHelpDiscoveryStats;

  /// No description provided for @nodedexHelpInfoDefault.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get nodedexHelpInfoDefault;

  /// No description provided for @nodedexHelpNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get nodedexHelpNote;

  /// No description provided for @nodedexHelpPersonalityTrait.
  ///
  /// In en, this message translates to:
  /// **'Personality Trait'**
  String get nodedexHelpPersonalityTrait;

  /// No description provided for @nodedexHelpRecentEncounters.
  ///
  /// In en, this message translates to:
  /// **'Recent Encounters'**
  String get nodedexHelpRecentEncounters;

  /// No description provided for @nodedexHelpRegionHistory.
  ///
  /// In en, this message translates to:
  /// **'Region History'**
  String get nodedexHelpRegionHistory;

  /// No description provided for @nodedexHelpSigil.
  ///
  /// In en, this message translates to:
  /// **'Sigil'**
  String get nodedexHelpSigil;

  /// No description provided for @nodedexHelpSignalRecords.
  ///
  /// In en, this message translates to:
  /// **'Signal Records'**
  String get nodedexHelpSignalRecords;

  /// No description provided for @nodedexImportButtonLabelPlural.
  ///
  /// In en, this message translates to:
  /// **'Import {count} entries'**
  String nodedexImportButtonLabelPlural(int count);

  /// No description provided for @nodedexImportButtonLabelSingular.
  ///
  /// In en, this message translates to:
  /// **'Import {count} entry'**
  String nodedexImportButtonLabelSingular(int count);

  /// No description provided for @nodedexImportClassificationConflictPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} classification conflicts'**
  String nodedexImportClassificationConflictPlural(int count);

  /// No description provided for @nodedexImportClassificationConflictSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} classification conflict'**
  String nodedexImportClassificationConflictSingular(int count);

  /// No description provided for @nodedexImportConflictingDataMessage.
  ///
  /// In en, this message translates to:
  /// **'Some entries have conflicting data'**
  String get nodedexImportConflictingDataMessage;

  /// No description provided for @nodedexImportConflictingEntriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Conflicting Entries'**
  String get nodedexImportConflictingEntriesLabel;

  /// No description provided for @nodedexImportConflictsFallback.
  ///
  /// In en, this message translates to:
  /// **'Conflicts detected in user-owned fields.'**
  String get nodedexImportConflictsFallback;

  /// No description provided for @nodedexImportConflictsResolveBelow.
  ///
  /// In en, this message translates to:
  /// **'{details}. Choose how to resolve below.'**
  String nodedexImportConflictsResolveBelow(String details);

  /// No description provided for @nodedexImportEntriesInFile.
  ///
  /// In en, this message translates to:
  /// **'{count} entries in file'**
  String nodedexImportEntriesInFile(int count);

  /// No description provided for @nodedexImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String nodedexImportFailed(String error);

  /// No description provided for @nodedexImportFailedToReadFile.
  ///
  /// In en, this message translates to:
  /// **'Failed to read file'**
  String get nodedexImportFailedToReadFile;

  /// No description provided for @nodedexImportFieldClassification.
  ///
  /// In en, this message translates to:
  /// **'Classification'**
  String get nodedexImportFieldClassification;

  /// No description provided for @nodedexImportFieldNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get nodedexImportFieldNote;

  /// No description provided for @nodedexImportHideDetails.
  ///
  /// In en, this message translates to:
  /// **'Hide details'**
  String get nodedexImportHideDetails;

  /// No description provided for @nodedexImportImportLabel.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get nodedexImportImportLabel;

  /// No description provided for @nodedexImportImportingLabel.
  ///
  /// In en, this message translates to:
  /// **'Importing...'**
  String get nodedexImportImportingLabel;

  /// No description provided for @nodedexImportLocalLabel.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get nodedexImportLocalLabel;

  /// No description provided for @nodedexImportMergeStrategyLabel.
  ///
  /// In en, this message translates to:
  /// **'Merge Strategy'**
  String get nodedexImportMergeStrategyLabel;

  /// No description provided for @nodedexImportNoValidEntries.
  ///
  /// In en, this message translates to:
  /// **'No valid NodeDex entries found in file'**
  String get nodedexImportNoValidEntries;

  /// No description provided for @nodedexImportNoneValue.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get nodedexImportNoneValue;

  /// No description provided for @nodedexImportNoteConflictPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} note conflicts'**
  String nodedexImportNoteConflictPlural(int count);

  /// No description provided for @nodedexImportNoteConflictSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} note conflict'**
  String nodedexImportNoteConflictSingular(int count);

  /// No description provided for @nodedexImportNothingNewToImport.
  ///
  /// In en, this message translates to:
  /// **'Nothing new to import'**
  String get nodedexImportNothingNewToImport;

  /// No description provided for @nodedexImportNothingToImportDescription.
  ///
  /// In en, this message translates to:
  /// **'The file contains no valid NodeDex entries.'**
  String get nodedexImportNothingToImportDescription;

  /// No description provided for @nodedexImportNothingToImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing to import'**
  String get nodedexImportNothingToImportTitle;

  /// No description provided for @nodedexImportPreviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review before applying'**
  String get nodedexImportPreviewSubtitle;

  /// No description provided for @nodedexImportPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Preview'**
  String get nodedexImportPreviewTitle;

  /// No description provided for @nodedexImportShowDetails.
  ///
  /// In en, this message translates to:
  /// **'Show details'**
  String get nodedexImportShowDetails;

  /// No description provided for @nodedexImportStrategyKeepLocalDescription.
  ///
  /// In en, this message translates to:
  /// **'Your classifications and notes stay unchanged'**
  String get nodedexImportStrategyKeepLocalDescription;

  /// No description provided for @nodedexImportStrategyKeepLocalTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep Local'**
  String get nodedexImportStrategyKeepLocalTitle;

  /// No description provided for @nodedexImportStrategyPreferImportDescription.
  ///
  /// In en, this message translates to:
  /// **'Use imported classifications and notes where different'**
  String get nodedexImportStrategyPreferImportDescription;

  /// No description provided for @nodedexImportStrategyPreferImportTitle.
  ///
  /// In en, this message translates to:
  /// **'Prefer Import'**
  String get nodedexImportStrategyPreferImportTitle;

  /// No description provided for @nodedexImportStrategyReviewEachDescription.
  ///
  /// In en, this message translates to:
  /// **'Decide per conflict which value to keep'**
  String get nodedexImportStrategyReviewEachDescription;

  /// No description provided for @nodedexImportStrategyReviewEachTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Each'**
  String get nodedexImportStrategyReviewEachTitle;

  /// No description provided for @nodedexImportSuccessPlural.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} entries'**
  String nodedexImportSuccessPlural(int count);

  /// No description provided for @nodedexImportSuccessSingular.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} entry'**
  String nodedexImportSuccessSingular(int count);

  /// No description provided for @nodedexImportSummaryConflicts.
  ///
  /// In en, this message translates to:
  /// **'Conflicts'**
  String get nodedexImportSummaryConflicts;

  /// No description provided for @nodedexImportSummaryMerge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get nodedexImportSummaryMerge;

  /// No description provided for @nodedexImportSummaryNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get nodedexImportSummaryNew;

  /// No description provided for @nodedexImportUnresolvedConflictsPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} conflicts unresolved — using \"Keep Local\" as default'**
  String nodedexImportUnresolvedConflictsPlural(int count);

  /// No description provided for @nodedexImportUnresolvedConflictsSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} conflict unresolved — using \"Keep Local\" as default'**
  String nodedexImportUnresolvedConflictsSingular(int count);

  /// No description provided for @nodedexKnownFor.
  ///
  /// In en, this message translates to:
  /// **'Known For'**
  String get nodedexKnownFor;

  /// No description provided for @nodedexKnownForDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String nodedexKnownForDaysAgo(int days);

  /// No description provided for @nodedexKnownForHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String nodedexKnownForHoursAgo(int hours);

  /// No description provided for @nodedexKnownForOneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get nodedexKnownForOneDayAgo;

  /// No description provided for @nodedexLastLogged.
  ///
  /// In en, this message translates to:
  /// **'Last Logged'**
  String get nodedexLastLogged;

  /// No description provided for @nodedexLastReadings.
  ///
  /// In en, this message translates to:
  /// **'Last {count} readings'**
  String nodedexLastReadings(int count);

  /// No description provided for @nodedexLastRelative.
  ///
  /// In en, this message translates to:
  /// **'last {relative}'**
  String nodedexLastRelative(String relative);

  /// No description provided for @nodedexLastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last Seen'**
  String get nodedexLastSeen;

  /// No description provided for @nodedexLastSeenStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Seen'**
  String get nodedexLastSeenStatLabel;

  /// No description provided for @nodedexLegendFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get nodedexLegendFair;

  /// No description provided for @nodedexLegendNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get nodedexLegendNoData;

  /// No description provided for @nodedexLegendStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get nodedexLegendStrong;

  /// No description provided for @nodedexLegendWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get nodedexLegendWeak;

  /// No description provided for @nodedexLinkCountPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} links'**
  String nodedexLinkCountPlural(int count);

  /// No description provided for @nodedexLinkCountSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} link'**
  String nodedexLinkCountSingular(int count);

  /// No description provided for @nodedexLinkStrengthLabel.
  ///
  /// In en, this message translates to:
  /// **'Link Strength'**
  String get nodedexLinkStrengthLabel;

  /// No description provided for @nodedexLinkedForDuration.
  ///
  /// In en, this message translates to:
  /// **'Linked for {duration}'**
  String nodedexLinkedForDuration(String duration);

  /// No description provided for @nodedexMaxDistanceStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Distance'**
  String get nodedexMaxDistanceStatLabel;

  /// No description provided for @nodedexMaxRange.
  ///
  /// In en, this message translates to:
  /// **'Max range: {distance}'**
  String nodedexMaxRange(String distance);

  /// No description provided for @nodedexMaxRangeLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Range'**
  String get nodedexMaxRangeLabel;

  /// No description provided for @nodedexMessageActivity.
  ///
  /// In en, this message translates to:
  /// **'Message Activity'**
  String get nodedexMessageActivity;

  /// No description provided for @nodedexMessagesExchangedCoPresent.
  ///
  /// In en, this message translates to:
  /// **'{count} messages exchanged while co-present'**
  String nodedexMessagesExchangedCoPresent(int count);

  /// No description provided for @nodedexMessagesLabel.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get nodedexMessagesLabel;

  /// No description provided for @nodedexMessagesStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get nodedexMessagesStatLabel;

  /// No description provided for @nodedexMilestoneEncounterN.
  ///
  /// In en, this message translates to:
  /// **'Encounter #{count}'**
  String nodedexMilestoneEncounterN(int count);

  /// No description provided for @nodedexMilestoneFirstDiscovered.
  ///
  /// In en, this message translates to:
  /// **'First discovered'**
  String get nodedexMilestoneFirstDiscovered;

  /// No description provided for @nodedexNicknameHint.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nodedexNicknameHint;

  /// No description provided for @nodedexNoClassification.
  ///
  /// In en, this message translates to:
  /// **'No classification assigned. Tap \"Classify\" to add one.'**
  String get nodedexNoClassification;

  /// No description provided for @nodedexNoEncountersOnDate.
  ///
  /// In en, this message translates to:
  /// **'No encounters on this date'**
  String get nodedexNoEncountersOnDate;

  /// No description provided for @nodedexNoEncountersRecorded.
  ///
  /// In en, this message translates to:
  /// **'No encounters recorded'**
  String get nodedexNoEncountersRecorded;

  /// No description provided for @nodedexNoNoteYet.
  ///
  /// In en, this message translates to:
  /// **'No note yet. Tap \"Add Note\" to write one.'**
  String get nodedexNoNoteYet;

  /// No description provided for @nodedexNoRelationshipDataDescription.
  ///
  /// In en, this message translates to:
  /// **'These nodes have not been observed together.'**
  String get nodedexNoRelationshipDataDescription;

  /// No description provided for @nodedexNoRelationshipDataTitle.
  ///
  /// In en, this message translates to:
  /// **'No relationship data'**
  String get nodedexNoRelationshipDataTitle;

  /// No description provided for @nodedexNodeCountPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes'**
  String nodedexNodeCountPlural(int count);

  /// No description provided for @nodedexNodeCountSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} node'**
  String nodedexNodeCountSingular(int count);

  /// No description provided for @nodedexNoteAdd.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get nodedexNoteAdd;

  /// No description provided for @nodedexNoteCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get nodedexNoteCancel;

  /// No description provided for @nodedexNoteEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get nodedexNoteEdit;

  /// No description provided for @nodedexNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Write a note about this node...'**
  String get nodedexNoteHint;

  /// No description provided for @nodedexNoteSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get nodedexNoteSave;

  /// No description provided for @nodedexNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get nodedexNoteTitle;

  /// No description provided for @nodedexObservationTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Observation Timeline'**
  String get nodedexObservationTimelineTitle;

  /// No description provided for @nodedexObservedDate.
  ///
  /// In en, this message translates to:
  /// **'Observed {date}'**
  String nodedexObservedDate(String date);

  /// No description provided for @nodedexPaletteColorPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get nodedexPaletteColorPrimary;

  /// No description provided for @nodedexPaletteColorSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get nodedexPaletteColorSecondary;

  /// No description provided for @nodedexPaletteColorTertiary.
  ///
  /// In en, this message translates to:
  /// **'Tertiary'**
  String get nodedexPaletteColorTertiary;

  /// No description provided for @nodedexPatinaAxisEncounters.
  ///
  /// In en, this message translates to:
  /// **'Encounters'**
  String get nodedexPatinaAxisEncounters;

  /// No description provided for @nodedexPatinaAxisEncountersDescription.
  ///
  /// In en, this message translates to:
  /// **'Number of distinct observations'**
  String get nodedexPatinaAxisEncountersDescription;

  /// No description provided for @nodedexPatinaAxisReach.
  ///
  /// In en, this message translates to:
  /// **'Reach'**
  String get nodedexPatinaAxisReach;

  /// No description provided for @nodedexPatinaAxisReachDescription.
  ///
  /// In en, this message translates to:
  /// **'Geographic spread across regions'**
  String get nodedexPatinaAxisReachDescription;

  /// No description provided for @nodedexPatinaAxisRecency.
  ///
  /// In en, this message translates to:
  /// **'Recency'**
  String get nodedexPatinaAxisRecency;

  /// No description provided for @nodedexPatinaAxisRecencyDescription.
  ///
  /// In en, this message translates to:
  /// **'How recently this node was active'**
  String get nodedexPatinaAxisRecencyDescription;

  /// No description provided for @nodedexPatinaAxisSignalDepth.
  ///
  /// In en, this message translates to:
  /// **'Signal Depth'**
  String get nodedexPatinaAxisSignalDepth;

  /// No description provided for @nodedexPatinaAxisSignalDepthDescription.
  ///
  /// In en, this message translates to:
  /// **'Quality of signal records collected'**
  String get nodedexPatinaAxisSignalDepthDescription;

  /// No description provided for @nodedexPatinaAxisSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get nodedexPatinaAxisSocial;

  /// No description provided for @nodedexPatinaAxisSocialDescription.
  ///
  /// In en, this message translates to:
  /// **'Co-seen relationships and messages'**
  String get nodedexPatinaAxisSocialDescription;

  /// No description provided for @nodedexPatinaAxisTenure.
  ///
  /// In en, this message translates to:
  /// **'Tenure'**
  String get nodedexPatinaAxisTenure;

  /// No description provided for @nodedexPatinaAxisTenureDescription.
  ///
  /// In en, this message translates to:
  /// **'How long this node has been known'**
  String get nodedexPatinaAxisTenureDescription;

  /// No description provided for @nodedexPatinaBreakdownSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Accumulated history across six dimensions'**
  String get nodedexPatinaBreakdownSubtitle;

  /// No description provided for @nodedexPatinaBreakdownTitle.
  ///
  /// In en, this message translates to:
  /// **'Patina Breakdown'**
  String get nodedexPatinaBreakdownTitle;

  /// No description provided for @nodedexPatinaEncounters.
  ///
  /// In en, this message translates to:
  /// **'Encounters'**
  String get nodedexPatinaEncounters;

  /// No description provided for @nodedexPatinaLabel.
  ///
  /// In en, this message translates to:
  /// **'PATINA'**
  String get nodedexPatinaLabel;

  /// No description provided for @nodedexPatinaReach.
  ///
  /// In en, this message translates to:
  /// **'Reach'**
  String get nodedexPatinaReach;

  /// No description provided for @nodedexPatinaRecency.
  ///
  /// In en, this message translates to:
  /// **'Recency'**
  String get nodedexPatinaRecency;

  /// No description provided for @nodedexPatinaSignal.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get nodedexPatinaSignal;

  /// No description provided for @nodedexPatinaSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get nodedexPatinaSocial;

  /// No description provided for @nodedexPatinaStampArchival.
  ///
  /// In en, this message translates to:
  /// **'Archival'**
  String get nodedexPatinaStampArchival;

  /// No description provided for @nodedexPatinaStampCanonical.
  ///
  /// In en, this message translates to:
  /// **'Canonical'**
  String get nodedexPatinaStampCanonical;

  /// No description provided for @nodedexPatinaStampEtched.
  ///
  /// In en, this message translates to:
  /// **'Etched'**
  String get nodedexPatinaStampEtched;

  /// No description provided for @nodedexPatinaStampFaint.
  ///
  /// In en, this message translates to:
  /// **'Faint'**
  String get nodedexPatinaStampFaint;

  /// No description provided for @nodedexPatinaStampInked.
  ///
  /// In en, this message translates to:
  /// **'Inked'**
  String get nodedexPatinaStampInked;

  /// No description provided for @nodedexPatinaStampLogged.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get nodedexPatinaStampLogged;

  /// No description provided for @nodedexPatinaStampNoted.
  ///
  /// In en, this message translates to:
  /// **'Noted'**
  String get nodedexPatinaStampNoted;

  /// No description provided for @nodedexPatinaStampTrace.
  ///
  /// In en, this message translates to:
  /// **'Trace'**
  String get nodedexPatinaStampTrace;

  /// No description provided for @nodedexPatinaTenure.
  ///
  /// In en, this message translates to:
  /// **'Tenure'**
  String get nodedexPatinaTenure;

  /// No description provided for @nodedexPerDay.
  ///
  /// In en, this message translates to:
  /// **'/day'**
  String get nodedexPerDay;

  /// No description provided for @nodedexPositionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Positions'**
  String get nodedexPositionsLabel;

  /// No description provided for @nodedexPresenceActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get nodedexPresenceActive;

  /// No description provided for @nodedexPresenceFading.
  ///
  /// In en, this message translates to:
  /// **'Fading'**
  String get nodedexPresenceFading;

  /// No description provided for @nodedexPresenceStale.
  ///
  /// In en, this message translates to:
  /// **'Stale'**
  String get nodedexPresenceStale;

  /// No description provided for @nodedexPresenceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodedexPresenceUnknown;

  /// No description provided for @nodedexProfileButton.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get nodedexProfileButton;

  /// No description provided for @nodedexRarityCardsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'{rarityLabel} Cards'**
  String nodedexRarityCardsPageTitle(String rarityLabel);

  /// No description provided for @nodedexRecentLabel.
  ///
  /// In en, this message translates to:
  /// **'RECENT'**
  String get nodedexRecentLabel;

  /// No description provided for @nodedexRegionEncounterCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 encounter} other{{count} encounters}}'**
  String nodedexRegionEncounterCount(int count);

  /// No description provided for @nodedexRegionsCompactLabel.
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get nodedexRegionsCompactLabel;

  /// No description provided for @nodedexRegionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Regions'**
  String get nodedexRegionsLabel;

  /// No description provided for @nodedexRelationshipTimeline.
  ///
  /// In en, this message translates to:
  /// **'Relationship Timeline'**
  String get nodedexRelationshipTimeline;

  /// No description provided for @nodedexRelativeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String nodedexRelativeDaysAgo(int days);

  /// No description provided for @nodedexRelativeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String nodedexRelativeHoursAgo(int hours);

  /// No description provided for @nodedexRelativeJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get nodedexRelativeJustNow;

  /// No description provided for @nodedexRelativeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String nodedexRelativeMinutesAgo(int minutes);

  /// No description provided for @nodedexRelativeMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{months}mo ago'**
  String nodedexRelativeMonthsAgo(int months);

  /// No description provided for @nodedexRelativeTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String nodedexRelativeTimeDaysAgo(int days);

  /// No description provided for @nodedexRelativeTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String nodedexRelativeTimeHoursAgo(int hours);

  /// No description provided for @nodedexRelativeTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String nodedexRelativeTimeMinutesAgo(int minutes);

  /// No description provided for @nodedexRelativeTimeMomentsAgo.
  ///
  /// In en, this message translates to:
  /// **'moments ago'**
  String get nodedexRelativeTimeMomentsAgo;

  /// No description provided for @nodedexRelativeTimeMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{months} months ago'**
  String nodedexRelativeTimeMonthsAgo(int months);

  /// No description provided for @nodedexRelativeTimeOneMonthAgo.
  ///
  /// In en, this message translates to:
  /// **'1 month ago'**
  String get nodedexRelativeTimeOneMonthAgo;

  /// No description provided for @nodedexRelativeTimeYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get nodedexRelativeTimeYesterday;

  /// No description provided for @nodedexRemoveClassification.
  ///
  /// In en, this message translates to:
  /// **'Remove Classification'**
  String get nodedexRemoveClassification;

  /// No description provided for @nodedexResetViewTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reset view'**
  String get nodedexResetViewTooltip;

  /// No description provided for @nodedexSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Find a node'**
  String get nodedexSearchHint;

  /// No description provided for @nodedexSectionDiscoveredNodes.
  ///
  /// In en, this message translates to:
  /// **'Discovered Nodes'**
  String get nodedexSectionDiscoveredNodes;

  /// No description provided for @nodedexSectionYourDevice.
  ///
  /// In en, this message translates to:
  /// **'Your Device'**
  String get nodedexSectionYourDevice;

  /// No description provided for @nodedexSeenTogetherCount.
  ///
  /// In en, this message translates to:
  /// **'Seen together {count} times'**
  String nodedexSeenTogetherCount(int count);

  /// No description provided for @nodedexSelectedLinksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} links'**
  String nodedexSelectedLinksCount(int count);

  /// No description provided for @nodedexSendFile.
  ///
  /// In en, this message translates to:
  /// **'Send file'**
  String get nodedexSendFile;

  /// No description provided for @nodedexSetNickname.
  ///
  /// In en, this message translates to:
  /// **'Set nickname'**
  String get nodedexSetNickname;

  /// No description provided for @nodedexSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nodedexSettingsTooltip;

  /// No description provided for @nodedexShareCardCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check out the Sigil Card for {name} on Socialmesh!'**
  String nodedexShareCardCheckOut(String name);

  /// No description provided for @nodedexShareCardImageFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture card image'**
  String get nodedexShareCardImageFailed;

  /// No description provided for @nodedexShareCouldNotShare.
  ///
  /// In en, this message translates to:
  /// **'Could not share card'**
  String get nodedexShareCouldNotShare;

  /// No description provided for @nodedexShareGetSocialmesh.
  ///
  /// In en, this message translates to:
  /// **'Get Socialmesh:'**
  String get nodedexShareGetSocialmesh;

  /// No description provided for @nodedexShareSigilCard.
  ///
  /// In en, this message translates to:
  /// **'Share Sigil Card'**
  String get nodedexShareSigilCard;

  /// No description provided for @nodedexSightingsPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} sightings'**
  String nodedexSightingsPlural(int count);

  /// No description provided for @nodedexSightingsSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} sighting'**
  String nodedexSightingsSingular(int count);

  /// No description provided for @nodedexSigilCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Sigil Card'**
  String get nodedexSigilCardTitle;

  /// No description provided for @nodedexSignalRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'Signal Records'**
  String get nodedexSignalRecordsTitle;

  /// No description provided for @nodedexSnrTrend.
  ///
  /// In en, this message translates to:
  /// **'SNR TREND'**
  String get nodedexSnrTrend;

  /// No description provided for @nodedexSocialTagContactDescription.
  ///
  /// In en, this message translates to:
  /// **'A person you communicate with'**
  String get nodedexSocialTagContactDescription;

  /// No description provided for @nodedexSocialTagFrequentPeerDescription.
  ///
  /// In en, this message translates to:
  /// **'Regularly seen on the mesh'**
  String get nodedexSocialTagFrequentPeerDescription;

  /// No description provided for @nodedexSocialTagKnownRelayDescription.
  ///
  /// In en, this message translates to:
  /// **'A node that forwards traffic reliably'**
  String get nodedexSocialTagKnownRelayDescription;

  /// No description provided for @nodedexSocialTagTrustedNodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Verified infrastructure you trust'**
  String get nodedexSocialTagTrustedNodeDescription;

  /// No description provided for @nodedexSortDiscovered.
  ///
  /// In en, this message translates to:
  /// **'Discovered'**
  String get nodedexSortDiscovered;

  /// No description provided for @nodedexSortEncounters.
  ///
  /// In en, this message translates to:
  /// **'Encounters'**
  String get nodedexSortEncounters;

  /// No description provided for @nodedexSortFirstDiscovered.
  ///
  /// In en, this message translates to:
  /// **'First Discovered'**
  String get nodedexSortFirstDiscovered;

  /// No description provided for @nodedexSortLastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last Seen'**
  String get nodedexSortLastSeen;

  /// No description provided for @nodedexSortLongestRange.
  ///
  /// In en, this message translates to:
  /// **'Longest Range'**
  String get nodedexSortLongestRange;

  /// No description provided for @nodedexSortMostEncounters.
  ///
  /// In en, this message translates to:
  /// **'Most Encounters'**
  String get nodedexSortMostEncounters;

  /// No description provided for @nodedexSortName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nodedexSortName;

  /// No description provided for @nodedexSortRange.
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get nodedexSortRange;

  /// No description provided for @nodedexStatCoSeen.
  ///
  /// In en, this message translates to:
  /// **'Co-seen'**
  String get nodedexStatCoSeen;

  /// No description provided for @nodedexStatDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get nodedexStatDuration;

  /// No description provided for @nodedexStatFirstLink.
  ///
  /// In en, this message translates to:
  /// **'First Link'**
  String get nodedexStatFirstLink;

  /// No description provided for @nodedexStatLastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last Seen'**
  String get nodedexStatLastSeen;

  /// No description provided for @nodedexStatMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get nodedexStatMessages;

  /// No description provided for @nodedexStatsDays.
  ///
  /// In en, this message translates to:
  /// **'DAYS'**
  String get nodedexStatsDays;

  /// No description provided for @nodedexStatsEncounters.
  ///
  /// In en, this message translates to:
  /// **'ENCOUNTERS'**
  String get nodedexStatsEncounters;

  /// No description provided for @nodedexStatsNodes.
  ///
  /// In en, this message translates to:
  /// **'NODES'**
  String get nodedexStatsNodes;

  /// No description provided for @nodedexStatsRegions.
  ///
  /// In en, this message translates to:
  /// **'REGIONS'**
  String get nodedexStatsRegions;

  /// No description provided for @nodedexStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String nodedexStreakDays(int count);

  /// No description provided for @nodedexStrengthEmerging.
  ///
  /// In en, this message translates to:
  /// **'Emerging'**
  String get nodedexStrengthEmerging;

  /// No description provided for @nodedexStrengthModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get nodedexStrengthModerate;

  /// No description provided for @nodedexStrengthNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get nodedexStrengthNew;

  /// No description provided for @nodedexStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get nodedexStrengthStrong;

  /// No description provided for @nodedexStrengthVeryStrong.
  ///
  /// In en, this message translates to:
  /// **'Very Strong'**
  String get nodedexStrengthVeryStrong;

  /// No description provided for @nodedexSummaryCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get nodedexSummaryCardTitle;

  /// No description provided for @nodedexSummaryEncountersRecorded.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters recorded'**
  String nodedexSummaryEncountersRecorded(int count);

  /// No description provided for @nodedexSummaryKeepObserving.
  ///
  /// In en, this message translates to:
  /// **'Keep observing to build a profile'**
  String get nodedexSummaryKeepObserving;

  /// No description provided for @nodedexSummaryMostActiveIn.
  ///
  /// In en, this message translates to:
  /// **'Most active in the {bucket}'**
  String nodedexSummaryMostActiveIn(String bucket);

  /// No description provided for @nodedexSummarySeenDaysOf14.
  ///
  /// In en, this message translates to:
  /// **'Seen {activeDays} of the last 14 days'**
  String nodedexSummarySeenDaysOf14(int activeDays);

  /// No description provided for @nodedexSummarySpottedDaysOf14.
  ///
  /// In en, this message translates to:
  /// **'Spotted on {activeDays} of the last 14 days'**
  String nodedexSummarySpottedDaysOf14(int activeDays);

  /// No description provided for @nodedexSummaryUsuallyOnDay.
  ///
  /// In en, this message translates to:
  /// **'Usually on {day}s'**
  String nodedexSummaryUsuallyOnDay(String day);

  /// No description provided for @nodedexSwitchToAlbumView.
  ///
  /// In en, this message translates to:
  /// **'Switch to album view'**
  String get nodedexSwitchToAlbumView;

  /// No description provided for @nodedexSwitchToListView.
  ///
  /// In en, this message translates to:
  /// **'Switch to list view'**
  String get nodedexSwitchToListView;

  /// Display label for the Contact social tag.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get nodedexTagContact;

  /// Display label for the Frequent Peer social tag.
  ///
  /// In en, this message translates to:
  /// **'Frequent Peer'**
  String get nodedexTagFrequentPeer;

  /// Display label for the Known Relay social tag.
  ///
  /// In en, this message translates to:
  /// **'Known Relay'**
  String get nodedexTagKnownRelay;

  /// Display label for the Trusted Node social tag.
  ///
  /// In en, this message translates to:
  /// **'Trusted Node'**
  String get nodedexTagTrustedNode;

  /// No description provided for @nodedexTapCardToFlipSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Tap card to flip'**
  String get nodedexTapCardToFlipSemanticLabel;

  /// No description provided for @nodedexTapToFlip.
  ///
  /// In en, this message translates to:
  /// **'TAP TO FLIP'**
  String get nodedexTapToFlip;

  /// No description provided for @nodedexTimeBucketDawn.
  ///
  /// In en, this message translates to:
  /// **'Dawn'**
  String get nodedexTimeBucketDawn;

  /// No description provided for @nodedexTimeBucketDawnRange.
  ///
  /// In en, this message translates to:
  /// **'5 AM – 11 AM'**
  String get nodedexTimeBucketDawnRange;

  /// No description provided for @nodedexTimeBucketEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get nodedexTimeBucketEvening;

  /// No description provided for @nodedexTimeBucketEveningRange.
  ///
  /// In en, this message translates to:
  /// **'5 PM – 11 PM'**
  String get nodedexTimeBucketEveningRange;

  /// No description provided for @nodedexTimeBucketMidday.
  ///
  /// In en, this message translates to:
  /// **'Midday'**
  String get nodedexTimeBucketMidday;

  /// No description provided for @nodedexTimeBucketMiddayRange.
  ///
  /// In en, this message translates to:
  /// **'11 AM – 5 PM'**
  String get nodedexTimeBucketMiddayRange;

  /// No description provided for @nodedexTimeBucketNight.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get nodedexTimeBucketNight;

  /// No description provided for @nodedexTimeBucketNightRange.
  ///
  /// In en, this message translates to:
  /// **'11 PM – 5 AM'**
  String get nodedexTimeBucketNightRange;

  /// No description provided for @nodedexTimelineChannel.
  ///
  /// In en, this message translates to:
  /// **'Channel {channel}'**
  String nodedexTimelineChannel(String channel);

  /// No description provided for @nodedexTimelineCouldNotLoad.
  ///
  /// In en, this message translates to:
  /// **'Could not load timeline'**
  String get nodedexTimelineCouldNotLoad;

  /// No description provided for @nodedexTimelineEncounterBestSnr.
  ///
  /// In en, this message translates to:
  /// **', best SNR {snr}dB'**
  String nodedexTimelineEncounterBestSnr(int snr);

  /// No description provided for @nodedexTimelineEncounterClosest.
  ///
  /// In en, this message translates to:
  /// **', closest {distance}'**
  String nodedexTimelineEncounterClosest(String distance);

  /// No description provided for @nodedexTimelineEncounterSession.
  ///
  /// In en, this message translates to:
  /// **'{count} encounters over {duration}{detail}'**
  String nodedexTimelineEncounterSession(
    int count,
    String duration,
    String detail,
  );

  /// No description provided for @nodedexTimelineEncountered.
  ///
  /// In en, this message translates to:
  /// **'Encountered'**
  String get nodedexTimelineEncountered;

  /// No description provided for @nodedexTimelineEncounteredAtDistance.
  ///
  /// In en, this message translates to:
  /// **'Encountered at {distance}'**
  String nodedexTimelineEncounteredAtDistance(String distance);

  /// No description provided for @nodedexTimelineEncounteredSnr.
  ///
  /// In en, this message translates to:
  /// **'Encountered (SNR {snr}dB)'**
  String nodedexTimelineEncounteredSnr(int snr);

  /// No description provided for @nodedexTimelineEventsAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Events will appear here as you interact with this node.'**
  String get nodedexTimelineEventsAppearHere;

  /// No description provided for @nodedexTimelineFirst.
  ///
  /// In en, this message translates to:
  /// **'First'**
  String get nodedexTimelineFirst;

  /// No description provided for @nodedexTimelineHoursUnit.
  ///
  /// In en, this message translates to:
  /// **'{hours} hr'**
  String nodedexTimelineHoursUnit(String hours);

  /// No description provided for @nodedexTimelineJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get nodedexTimelineJustNow;

  /// No description provided for @nodedexTimelineLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get nodedexTimelineLatest;

  /// No description provided for @nodedexTimelineLessThanOneMin.
  ///
  /// In en, this message translates to:
  /// **'<1 min'**
  String get nodedexTimelineLessThanOneMin;

  /// No description provided for @nodedexTimelineMinutesUnit.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String nodedexTimelineMinutesUnit(int minutes);

  /// No description provided for @nodedexTimelineNoActivityYet.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get nodedexTimelineNoActivityYet;

  /// No description provided for @nodedexTimelineReceived.
  ///
  /// In en, this message translates to:
  /// **'Received: {text}'**
  String nodedexTimelineReceived(String text);

  /// No description provided for @nodedexTimelineSent.
  ///
  /// In en, this message translates to:
  /// **'Sent: {text}'**
  String nodedexTimelineSent(String text);

  /// No description provided for @nodedexTimelineSignal.
  ///
  /// In en, this message translates to:
  /// **'Signal: {content}'**
  String nodedexTimelineSignal(String content);

  /// No description provided for @nodedexTitle.
  ///
  /// In en, this message translates to:
  /// **'NodeDex'**
  String get nodedexTitle;

  /// No description provided for @nodedexTotalCount.
  ///
  /// In en, this message translates to:
  /// **'{count} total'**
  String nodedexTotalCount(int count);

  /// Display label for the Anchor node trait.
  ///
  /// In en, this message translates to:
  /// **'Anchor'**
  String get nodedexTraitAnchor;

  /// Description for the Anchor node trait.
  ///
  /// In en, this message translates to:
  /// **'Persistent hub with many connections'**
  String get nodedexTraitAnchorDescription;

  /// Display label for the Beacon node trait.
  ///
  /// In en, this message translates to:
  /// **'Beacon'**
  String get nodedexTraitBeacon;

  /// Description for the Beacon node trait.
  ///
  /// In en, this message translates to:
  /// **'Always active, high availability'**
  String get nodedexTraitBeaconDescription;

  /// No description provided for @nodedexTraitCollectionLabel.
  ///
  /// In en, this message translates to:
  /// **'TRAIT COLLECTION'**
  String get nodedexTraitCollectionLabel;

  /// Display label for the Courier node trait.
  ///
  /// In en, this message translates to:
  /// **'Courier'**
  String get nodedexTraitCourier;

  /// Description for the Courier node trait.
  ///
  /// In en, this message translates to:
  /// **'Carries messages across the mesh'**
  String get nodedexTraitCourierDescription;

  /// Display label for the Drifter node trait.
  ///
  /// In en, this message translates to:
  /// **'Drifter'**
  String get nodedexTraitDrifter;

  /// Description for the Drifter node trait.
  ///
  /// In en, this message translates to:
  /// **'Irregular timing, fades in and out'**
  String get nodedexTraitDrifterDescription;

  /// No description provided for @nodedexTraitEvidenceNotFound.
  ///
  /// In en, this message translates to:
  /// **'Node not found in NodeDex'**
  String get nodedexTraitEvidenceNotFound;

  /// Display label for the Ghost node trait.
  ///
  /// In en, this message translates to:
  /// **'Ghost'**
  String get nodedexTraitGhost;

  /// Description for the Ghost node trait.
  ///
  /// In en, this message translates to:
  /// **'Rarely seen, elusive presence'**
  String get nodedexTraitGhostDescription;

  /// No description provided for @nodedexTraitNodesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'{traitLabel} Nodes'**
  String nodedexTraitNodesPageTitle(String traitLabel);

  /// Display label for the Relay node trait.
  ///
  /// In en, this message translates to:
  /// **'Relay'**
  String get nodedexTraitRelay;

  /// Description for the Relay node trait.
  ///
  /// In en, this message translates to:
  /// **'High throughput, forwards traffic'**
  String get nodedexTraitRelayDescription;

  /// Display label for the Sentinel node trait.
  ///
  /// In en, this message translates to:
  /// **'Sentinel'**
  String get nodedexTraitSentinel;

  /// Description for the Sentinel node trait.
  ///
  /// In en, this message translates to:
  /// **'Fixed position, long-lived guardian'**
  String get nodedexTraitSentinelDescription;

  /// Display label for the Unknown (unclassified) node trait.
  ///
  /// In en, this message translates to:
  /// **'Newcomer'**
  String get nodedexTraitUnknown;

  /// Description for the Unknown (unclassified) node trait.
  ///
  /// In en, this message translates to:
  /// **'Recently discovered'**
  String get nodedexTraitUnknownDescription;

  /// Display label for the Wanderer node trait.
  ///
  /// In en, this message translates to:
  /// **'Wanderer'**
  String get nodedexTraitWanderer;

  /// Description for the Wanderer node trait.
  ///
  /// In en, this message translates to:
  /// **'Seen across multiple locations'**
  String get nodedexTraitWandererDescription;

  /// No description provided for @nodedexTrustDescriptionEstablished.
  ///
  /// In en, this message translates to:
  /// **'Deep history across all dimensions'**
  String get nodedexTrustDescriptionEstablished;

  /// No description provided for @nodedexTrustDescriptionFamiliar.
  ///
  /// In en, this message translates to:
  /// **'Regular presence with some history'**
  String get nodedexTrustDescriptionFamiliar;

  /// No description provided for @nodedexTrustDescriptionObserved.
  ///
  /// In en, this message translates to:
  /// **'Seen a few times on the mesh'**
  String get nodedexTrustDescriptionObserved;

  /// No description provided for @nodedexTrustDescriptionTrusted.
  ///
  /// In en, this message translates to:
  /// **'Frequent, long-lived, communicative'**
  String get nodedexTrustDescriptionTrusted;

  /// No description provided for @nodedexTrustDescriptionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not enough data to assess'**
  String get nodedexTrustDescriptionUnknown;

  /// No description provided for @nodedexTrustLevelEstablished.
  ///
  /// In en, this message translates to:
  /// **'Established'**
  String get nodedexTrustLevelEstablished;

  /// No description provided for @nodedexTrustLevelFamiliar.
  ///
  /// In en, this message translates to:
  /// **'Familiar'**
  String get nodedexTrustLevelFamiliar;

  /// No description provided for @nodedexTrustLevelObserved.
  ///
  /// In en, this message translates to:
  /// **'Observed'**
  String get nodedexTrustLevelObserved;

  /// No description provided for @nodedexTrustLevelTrusted.
  ///
  /// In en, this message translates to:
  /// **'Trusted'**
  String get nodedexTrustLevelTrusted;

  /// No description provided for @nodedexTrustLevelUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodedexTrustLevelUnknown;

  /// No description provided for @nodedexUnknownRegion.
  ///
  /// In en, this message translates to:
  /// **'Unknown Region'**
  String get nodedexUnknownRegion;

  /// No description provided for @nodedexUptimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Uptime'**
  String get nodedexUptimeLabel;

  /// No description provided for @nodedexViewProfile.
  ///
  /// In en, this message translates to:
  /// **'View profile'**
  String get nodedexViewProfile;

  /// No description provided for @nodedexWalletCouldNotAdd.
  ///
  /// In en, this message translates to:
  /// **'Could not add to Apple Wallet'**
  String get nodedexWalletCouldNotAdd;

  /// No description provided for @nodedexWalletCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open Apple Wallet'**
  String get nodedexWalletCouldNotOpen;

  /// No description provided for @nodedexWalletCouldNotPublish.
  ///
  /// In en, this message translates to:
  /// **'Could not publish sigil card'**
  String get nodedexWalletCouldNotPublish;

  /// Label in long-press menu for the connected device.
  ///
  /// In en, this message translates to:
  /// **'Connected Device'**
  String get nodesScreenConnectedDevice;

  /// Long-press menu action to disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get nodesScreenDisconnect;

  /// Distance label in kilometers on node card.
  ///
  /// In en, this message translates to:
  /// **'{km} km away'**
  String nodesScreenDistanceKilometers(String km);

  /// Distance label in meters on node card.
  ///
  /// In en, this message translates to:
  /// **'{meters} m away'**
  String nodesScreenDistanceMeters(String meters);

  /// Empty state message when no nodes exist.
  ///
  /// In en, this message translates to:
  /// **'No nodes discovered yet'**
  String get nodesScreenEmptyAll;

  /// Empty state message when filter returns no results.
  ///
  /// In en, this message translates to:
  /// **'No nodes match this filter'**
  String get nodesScreenEmptyFiltered;

  /// Filter chip label for active nodes.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get nodesScreenFilterActive;

  /// Filter chip label showing all nodes.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get nodesScreenFilterAll;

  /// Filter chip label for favorite nodes.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get nodesScreenFilterFavorites;

  /// Filter chip label for inactive nodes.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get nodesScreenFilterInactive;

  /// Filter chip label for MQTT-connected nodes.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get nodesScreenFilterMqtt;

  /// Filter chip label for newly discovered nodes.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get nodesScreenFilterNew;

  /// Filter chip label for RF-connected nodes.
  ///
  /// In en, this message translates to:
  /// **'RF'**
  String get nodesScreenFilterRf;

  /// Filter chip label for nodes with GPS position.
  ///
  /// In en, this message translates to:
  /// **'With Position'**
  String get nodesScreenFilterWithPosition;

  /// Badge label for nodes with GPS position.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get nodesScreenGps;

  /// Overflow menu item for help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get nodesScreenHelpMenu;

  /// Hop count label for multi-hop nodes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hop} other{{count} hops}}'**
  String nodesScreenHopCount(int count);

  /// Hop count label for directly connected nodes.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get nodesScreenHopDirect;

  /// Label prefix for node log count.
  ///
  /// In en, this message translates to:
  /// **'Logs:'**
  String get nodesScreenLogsLabel;

  /// Badge label for nodes without GPS position.
  ///
  /// In en, this message translates to:
  /// **'No GPS'**
  String get nodesScreenNoGps;

  /// Tooltip for the QR code scan button.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get nodesScreenScanQrCodeTooltip;

  /// Search bar placeholder text.
  ///
  /// In en, this message translates to:
  /// **'Find a node'**
  String get nodesScreenSearchHint;

  /// Section header for active nodes.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get nodesScreenSectionActive;

  /// Section header for Aether flight nodes.
  ///
  /// In en, this message translates to:
  /// **'Aether Flights Nearby'**
  String get nodesScreenSectionAetherFlights;

  /// Section header for nodes with critical battery.
  ///
  /// In en, this message translates to:
  /// **'Critical (<20%)'**
  String get nodesScreenSectionBatteryCritical;

  /// Section header for nodes with full battery.
  ///
  /// In en, this message translates to:
  /// **'Full (80-100%)'**
  String get nodesScreenSectionBatteryFull;

  /// Section header for nodes with good battery.
  ///
  /// In en, this message translates to:
  /// **'Good (50-80%)'**
  String get nodesScreenSectionBatteryGood;

  /// Section header for nodes with low battery.
  ///
  /// In en, this message translates to:
  /// **'Low (20-50%)'**
  String get nodesScreenSectionBatteryLow;

  /// Section header for nodes currently charging.
  ///
  /// In en, this message translates to:
  /// **'Charging'**
  String get nodesScreenSectionCharging;

  /// Section header for nodes currently being discovered.
  ///
  /// In en, this message translates to:
  /// **'Discovering'**
  String get nodesScreenSectionDiscovering;

  /// Section header for favorite nodes.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get nodesScreenSectionFavorites;

  /// Section header for inactive nodes.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get nodesScreenSectionInactive;

  /// Section header for recently seen nodes.
  ///
  /// In en, this message translates to:
  /// **'Seen Recently'**
  String get nodesScreenSectionSeenRecently;

  /// Section header for nodes with medium signal.
  ///
  /// In en, this message translates to:
  /// **'Medium (-10 to 0 dB)'**
  String get nodesScreenSectionSignalMedium;

  /// Section header for nodes with strong signal.
  ///
  /// In en, this message translates to:
  /// **'Strong (>0 dB)'**
  String get nodesScreenSectionSignalStrong;

  /// Section header for nodes with weak signal.
  ///
  /// In en, this message translates to:
  /// **'Weak (<-10 dB)'**
  String get nodesScreenSectionSignalWeak;

  /// Section header for nodes with unknown status.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get nodesScreenSectionUnknown;

  /// Section header for the user's own device.
  ///
  /// In en, this message translates to:
  /// **'Your Device'**
  String get nodesScreenSectionYourDevice;

  /// Overflow menu item for settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get nodesScreenSettingsMenu;

  /// Button to clear filters and show all nodes.
  ///
  /// In en, this message translates to:
  /// **'Show all nodes'**
  String get nodesScreenShowAllButton;

  /// Sort chip label for battery sort.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get nodesScreenSortBattery;

  /// Sort menu option for battery level sort.
  ///
  /// In en, this message translates to:
  /// **'Battery Level'**
  String get nodesScreenSortMenuBatteryLevel;

  /// Sort menu option for most recent.
  ///
  /// In en, this message translates to:
  /// **'Most Recent'**
  String get nodesScreenSortMenuMostRecent;

  /// Sort menu option for alphabetical name sort.
  ///
  /// In en, this message translates to:
  /// **'Name (A-Z)'**
  String get nodesScreenSortMenuNameAZ;

  /// Sort menu option for signal strength sort.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get nodesScreenSortMenuSignalStrength;

  /// Sort chip label for name sort.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nodesScreenSortName;

  /// Sort chip label for most recent sort.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get nodesScreenSortRecent;

  /// Sort chip label for signal sort.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get nodesScreenSortSignal;

  /// Subtitle on the user's own node card.
  ///
  /// In en, this message translates to:
  /// **'This Device'**
  String get nodesScreenThisDevice;

  /// App bar title showing node count.
  ///
  /// In en, this message translates to:
  /// **'Nodes ({count})'**
  String nodesScreenTitle(int count);

  /// Transport badge for MQTT nodes.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get nodesScreenTransportMqtt;

  /// Transport badge for RF nodes.
  ///
  /// In en, this message translates to:
  /// **'RF'**
  String get nodesScreenTransportRf;

  /// Badge label on the user's own node card.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get nodesScreenYouBadge;

  /// No description provided for @paxCounterAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter passively listens for WiFi and Bluetooth probe requests from nearby devices. It does not store MAC addresses or any personal data.'**
  String get paxCounterAboutSubtitle;

  /// No description provided for @paxCounterAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About PAX Counter'**
  String get paxCounterAboutTitle;

  /// No description provided for @paxCounterCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Counts nearby WiFi and Bluetooth devices'**
  String get paxCounterCardSubtitle;

  /// No description provided for @paxCounterCardTitle.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter'**
  String get paxCounterCardTitle;

  /// No description provided for @paxCounterEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable PAX Counter'**
  String get paxCounterEnable;

  /// No description provided for @paxCounterEnableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Count nearby devices and report to mesh'**
  String get paxCounterEnableSubtitle;

  /// No description provided for @paxCounterIntervalMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes'**
  String paxCounterIntervalMinutes(int minutes);

  /// No description provided for @paxCounterMaxLabel.
  ///
  /// In en, this message translates to:
  /// **'60 min'**
  String get paxCounterMaxLabel;

  /// No description provided for @paxCounterMinLabel.
  ///
  /// In en, this message translates to:
  /// **'1 min'**
  String get paxCounterMinLabel;

  /// No description provided for @paxCounterSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get paxCounterSave;

  /// No description provided for @paxCounterSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String paxCounterSaveError(String error);

  /// No description provided for @paxCounterSaved.
  ///
  /// In en, this message translates to:
  /// **'PAX counter config saved'**
  String get paxCounterSaved;

  /// No description provided for @paxCounterTitle.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter'**
  String get paxCounterTitle;

  /// No description provided for @paxCounterUpdateInterval.
  ///
  /// In en, this message translates to:
  /// **'Update Interval'**
  String get paxCounterUpdateInterval;

  /// No description provided for @presenceAllNodes.
  ///
  /// In en, this message translates to:
  /// **'All Nodes'**
  String get presenceAllNodes;

  /// No description provided for @presenceBackNearby.
  ///
  /// In en, this message translates to:
  /// **'Back nearby'**
  String get presenceBackNearby;

  /// No description provided for @presenceBroadcastInfo.
  ///
  /// In en, this message translates to:
  /// **'Your intent and status are broadcast with your signals.'**
  String get presenceBroadcastInfo;

  /// No description provided for @presenceClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get presenceClear;

  /// No description provided for @presenceEmptyTagline1.
  ///
  /// In en, this message translates to:
  /// **'No nodes discovered yet.\nConnect to a mesh device to see nearby presence.'**
  String get presenceEmptyTagline1;

  /// No description provided for @presenceEmptyTagline2.
  ///
  /// In en, this message translates to:
  /// **'Presence shows who is active on your mesh.\nNodes appear as they broadcast.'**
  String get presenceEmptyTagline2;

  /// No description provided for @presenceEmptyTagline3.
  ///
  /// In en, this message translates to:
  /// **'Watch nodes come and go in real time.\nActive, fading, and offline states.'**
  String get presenceEmptyTagline3;

  /// No description provided for @presenceEmptyTagline4.
  ///
  /// In en, this message translates to:
  /// **'Familiar faces are highlighted.\nBuild your mesh community over time.'**
  String get presenceEmptyTagline4;

  /// No description provided for @presenceEmptyTitleKeyword.
  ///
  /// In en, this message translates to:
  /// **'presence'**
  String get presenceEmptyTitleKeyword;

  /// No description provided for @presenceEmptyTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'No '**
  String get presenceEmptyTitlePrefix;

  /// No description provided for @presenceEmptyTitleSuffix.
  ///
  /// In en, this message translates to:
  /// **' detected'**
  String get presenceEmptyTitleSuffix;

  /// No description provided for @presenceFamiliarBadge.
  ///
  /// In en, this message translates to:
  /// **'Familiar'**
  String get presenceFamiliarBadge;

  /// No description provided for @presenceFilterActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get presenceFilterActive;

  /// No description provided for @presenceFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get presenceFilterAll;

  /// No description provided for @presenceFilterFading.
  ///
  /// In en, this message translates to:
  /// **'Seen recently'**
  String get presenceFilterFading;

  /// No description provided for @presenceFilterFamiliar.
  ///
  /// In en, this message translates to:
  /// **'Familiar'**
  String get presenceFilterFamiliar;

  /// No description provided for @presenceFilterInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get presenceFilterInactive;

  /// No description provided for @presenceFilterUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get presenceFilterUnknown;

  /// No description provided for @presenceIntentLabel.
  ///
  /// In en, this message translates to:
  /// **'Intent'**
  String get presenceIntentLabel;

  /// No description provided for @presenceIntentUpdated.
  ///
  /// In en, this message translates to:
  /// **'Presence intent updated'**
  String get presenceIntentUpdated;

  /// No description provided for @presenceLegendMedium.
  ///
  /// In en, this message translates to:
  /// **'2-10 min'**
  String get presenceLegendMedium;

  /// No description provided for @presenceLegendShort.
  ///
  /// In en, this message translates to:
  /// **'< 2 min'**
  String get presenceLegendShort;

  /// No description provided for @presenceMyPresence.
  ///
  /// In en, this message translates to:
  /// **'My Presence'**
  String get presenceMyPresence;

  /// No description provided for @presenceNoMatchFilter.
  ///
  /// In en, this message translates to:
  /// **'No nodes match this filter'**
  String get presenceNoMatchFilter;

  /// No description provided for @presenceNoMatchSearch.
  ///
  /// In en, this message translates to:
  /// **'No nodes match your search'**
  String get presenceNoMatchSearch;

  /// No description provided for @presenceNodeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} {noun}'**
  String presenceNodeCount(int count, String noun);

  /// No description provided for @presenceNodePlural.
  ///
  /// In en, this message translates to:
  /// **'nodes'**
  String get presenceNodePlural;

  /// No description provided for @presenceNodeSingular.
  ///
  /// In en, this message translates to:
  /// **'node'**
  String get presenceNodeSingular;

  /// No description provided for @presenceQuietMesh.
  ///
  /// In en, this message translates to:
  /// **'Mesh is quiet right now — nodes appear as they come online.'**
  String get presenceQuietMesh;

  /// No description provided for @presenceRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get presenceRecentActivity;

  /// No description provided for @presenceSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get presenceSave;

  /// No description provided for @presenceSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search nodes'**
  String get presenceSearchHint;

  /// No description provided for @presenceSectionActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get presenceSectionActive;

  /// No description provided for @presenceSectionInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get presenceSectionInactive;

  /// No description provided for @presenceSectionSeenRecently.
  ///
  /// In en, this message translates to:
  /// **'Seen Recently'**
  String get presenceSectionSeenRecently;

  /// No description provided for @presenceSectionUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get presenceSectionUnknown;

  /// No description provided for @presenceSelectIntent.
  ///
  /// In en, this message translates to:
  /// **'Select Intent'**
  String get presenceSelectIntent;

  /// No description provided for @presenceSetStatus.
  ///
  /// In en, this message translates to:
  /// **'Set Status'**
  String get presenceSetStatus;

  /// No description provided for @presenceShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all nodes'**
  String get presenceShowAll;

  /// No description provided for @presenceStatusHint.
  ///
  /// In en, this message translates to:
  /// **'What are you up to?'**
  String get presenceStatusHint;

  /// No description provided for @presenceStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get presenceStatusLabel;

  /// No description provided for @presenceStatusNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get presenceStatusNotSet;

  /// No description provided for @presenceStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Status updated'**
  String get presenceStatusUpdated;

  /// No description provided for @presenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Presence'**
  String get presenceTitle;

  /// No description provided for @presenceTryDifferent.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or filter'**
  String get presenceTryDifferent;

  /// No description provided for @presenceWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Nodes will appear here as they are discovered'**
  String get presenceWillAppear;

  /// No description provided for @productDetailAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get productDetailAnonymous;

  /// No description provided for @productDetailBattery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get productDetailBattery;

  /// No description provided for @productDetailBeFirstReviewer.
  ///
  /// In en, this message translates to:
  /// **'Be the first to review this product!'**
  String get productDetailBeFirstReviewer;

  /// No description provided for @productDetailBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get productDetailBluetooth;

  /// No description provided for @productDetailBuyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get productDetailBuyNow;

  /// No description provided for @productDetailBySeller.
  ///
  /// In en, this message translates to:
  /// **'by {seller}'**
  String productDetailBySeller(String seller);

  /// No description provided for @productDetailCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get productDetailCancel;

  /// No description provided for @productDetailChipset.
  ///
  /// In en, this message translates to:
  /// **'Chipset'**
  String get productDetailChipset;

  /// No description provided for @productDetailContactSeller.
  ///
  /// In en, this message translates to:
  /// **'Contact Seller'**
  String get productDetailContactSeller;

  /// No description provided for @productDetailContactToPurchase.
  ///
  /// In en, this message translates to:
  /// **'Contact the seller to purchase this product.'**
  String get productDetailContactToPurchase;

  /// No description provided for @productDetailDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String productDetailDaysAgo(int count);

  /// No description provided for @productDetailDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get productDetailDescription;

  /// No description provided for @productDetailDimensions.
  ///
  /// In en, this message translates to:
  /// **'Dimensions'**
  String get productDetailDimensions;

  /// No description provided for @productDetailDiscountBadge.
  ///
  /// In en, this message translates to:
  /// **'-{percent}% OFF'**
  String productDetailDiscountBadge(int percent);

  /// No description provided for @productDetailDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get productDetailDisplay;

  /// No description provided for @productDetailEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get productDetailEdit;

  /// No description provided for @productDetailErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading product'**
  String get productDetailErrorLoading;

  /// No description provided for @productDetailEstimatedDelivery.
  ///
  /// In en, this message translates to:
  /// **'Estimated {days} days'**
  String productDetailEstimatedDelivery(int days);

  /// No description provided for @productDetailFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get productDetailFeatures;

  /// No description provided for @productDetailFirmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get productDetailFirmware;

  /// No description provided for @productDetailFreeShipping.
  ///
  /// In en, this message translates to:
  /// **'Free Shipping'**
  String get productDetailFreeShipping;

  /// No description provided for @productDetailFrequencyBands.
  ///
  /// In en, this message translates to:
  /// **'Frequency Bands'**
  String get productDetailFrequencyBands;

  /// No description provided for @productDetailGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get productDetailGoBack;

  /// No description provided for @productDetailGps.
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get productDetailGps;

  /// No description provided for @productDetailHardwareVersion.
  ///
  /// In en, this message translates to:
  /// **'Hardware Version'**
  String get productDetailHardwareVersion;

  /// No description provided for @productDetailImageCounter.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String productDetailImageCounter(int current, int total);

  /// No description provided for @productDetailInStockCount.
  ///
  /// In en, this message translates to:
  /// **'In Stock ({quantity} available)'**
  String productDetailInStockCount(int quantity);

  /// No description provided for @productDetailIncludedAccessories.
  ///
  /// In en, this message translates to:
  /// **'Included Accessories'**
  String get productDetailIncludedAccessories;

  /// No description provided for @productDetailLoraChip.
  ///
  /// In en, this message translates to:
  /// **'LoRa Chip'**
  String get productDetailLoraChip;

  /// No description provided for @productDetailMeshtasticCompatible.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic Compatible'**
  String get productDetailMeshtasticCompatible;

  /// No description provided for @productDetailMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} months ago'**
  String productDetailMonthsAgo(int count);

  /// No description provided for @productDetailNoReviews.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get productDetailNoReviews;

  /// No description provided for @productDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found'**
  String get productDetailNotFound;

  /// No description provided for @productDetailOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get productDetailOutOfStock;

  /// No description provided for @productDetailOutOfStockButton.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get productDetailOutOfStockButton;

  /// No description provided for @productDetailPurchaseDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Purchases completed on seller\'s official store'**
  String get productDetailPurchaseDisclaimer;

  /// No description provided for @productDetailPurchaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get productDetailPurchaseTitle;

  /// No description provided for @productDetailReadMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get productDetailReadMore;

  /// No description provided for @productDetailRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get productDetailRetry;

  /// No description provided for @productDetailReviewCount.
  ///
  /// In en, this message translates to:
  /// **'({count} reviews)'**
  String productDetailReviewCount(int count);

  /// No description provided for @productDetailReviewHint.
  ///
  /// In en, this message translates to:
  /// **'Share your experience with this product...'**
  String get productDetailReviewHint;

  /// No description provided for @productDetailReviewPrivacyNotice.
  ///
  /// In en, this message translates to:
  /// **'Your review will be public and posted as \"{userName}\". Reviews are moderated before appearing on the product page.'**
  String productDetailReviewPrivacyNotice(String userName);

  /// No description provided for @productDetailReviewSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Review submitted for moderation. Thank you!'**
  String get productDetailReviewSubmitted;

  /// No description provided for @productDetailReviewTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title (optional)'**
  String get productDetailReviewTitleLabel;

  /// No description provided for @productDetailReviewValidation.
  ///
  /// In en, this message translates to:
  /// **'Please write a review description'**
  String get productDetailReviewValidation;

  /// No description provided for @productDetailReviewVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get productDetailReviewVerified;

  /// No description provided for @productDetailReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get productDetailReviews;

  /// No description provided for @productDetailSelectedPrice.
  ///
  /// In en, this message translates to:
  /// **'Selected: \${price}'**
  String productDetailSelectedPrice(String price);

  /// No description provided for @productDetailSellerResponse.
  ///
  /// In en, this message translates to:
  /// **'Seller Response'**
  String get productDetailSellerResponse;

  /// No description provided for @productDetailShipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get productDetailShipping;

  /// No description provided for @productDetailShippingCost.
  ///
  /// In en, this message translates to:
  /// **'Shipping: \${cost}'**
  String productDetailShippingCost(String cost);

  /// No description provided for @productDetailShipsTo.
  ///
  /// In en, this message translates to:
  /// **'Ships to: {countries}'**
  String productDetailShipsTo(String countries);

  /// No description provided for @productDetailShowLess.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get productDetailShowLess;

  /// No description provided for @productDetailSignInFavorites.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save favorites'**
  String get productDetailSignInFavorites;

  /// No description provided for @productDetailSoldCount.
  ///
  /// In en, this message translates to:
  /// **'{count} sold'**
  String productDetailSoldCount(int count);

  /// No description provided for @productDetailSubmitReview.
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get productDetailSubmitReview;

  /// No description provided for @productDetailTechSpecs.
  ///
  /// In en, this message translates to:
  /// **'Technical Specifications'**
  String get productDetailTechSpecs;

  /// No description provided for @productDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get productDetailTitle;

  /// No description provided for @productDetailToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get productDetailToday;

  /// No description provided for @productDetailTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get productDetailTotal;

  /// No description provided for @productDetailUnableToLoadPage.
  ///
  /// In en, this message translates to:
  /// **'Unable to load page'**
  String get productDetailUnableToLoadPage;

  /// No description provided for @productDetailUnableToLoadReviews.
  ///
  /// In en, this message translates to:
  /// **'Unable to load reviews'**
  String get productDetailUnableToLoadReviews;

  /// No description provided for @productDetailVendorVerified.
  ///
  /// In en, this message translates to:
  /// **'Vendor Verified'**
  String get productDetailVendorVerified;

  /// No description provided for @productDetailVerifiedOn.
  ///
  /// In en, this message translates to:
  /// **'Verified on {date}'**
  String productDetailVerifiedOn(String date);

  /// No description provided for @productDetailWebviewOffline.
  ///
  /// In en, this message translates to:
  /// **'This content requires an internet connection. Please check your connection and try again.'**
  String get productDetailWebviewOffline;

  /// No description provided for @productDetailWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} weeks ago'**
  String productDetailWeeksAgo(int count);

  /// No description provided for @productDetailWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get productDetailWeight;

  /// No description provided for @productDetailWifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get productDetailWifi;

  /// No description provided for @productDetailWriteReview.
  ///
  /// In en, this message translates to:
  /// **'Write Review'**
  String get productDetailWriteReview;

  /// No description provided for @productDetailWriteReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get productDetailWriteReviewTitle;

  /// No description provided for @productDetailYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} years ago'**
  String productDetailYearsAgo(int count);

  /// No description provided for @productDetailYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get productDetailYesterday;

  /// No description provided for @productDetailYourRating.
  ///
  /// In en, this message translates to:
  /// **'Your Rating'**
  String get productDetailYourRating;

  /// No description provided for @productDetailYourReview.
  ///
  /// In en, this message translates to:
  /// **'Your Review *'**
  String get productDetailYourReview;

  /// No description provided for @profileAvatarRemoveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove avatar: {error}'**
  String profileAvatarRemoveFailed(String error);

  /// No description provided for @profileAvatarRemoved.
  ///
  /// In en, this message translates to:
  /// **'Avatar removed'**
  String get profileAvatarRemoved;

  /// No description provided for @profileAvatarRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Uploading avatars requires an internet connection.'**
  String get profileAvatarRequiresInternet;

  /// No description provided for @profileAvatarUpdated.
  ///
  /// In en, this message translates to:
  /// **'Avatar updated'**
  String get profileAvatarUpdated;

  /// No description provided for @profileAvatarUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload avatar: {error}'**
  String profileAvatarUploadFailed(String error);

  /// No description provided for @profileBannerRemoveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove banner: {error}'**
  String profileBannerRemoveFailed(String error);

  /// No description provided for @profileBannerRemoved.
  ///
  /// In en, this message translates to:
  /// **'Banner removed'**
  String get profileBannerRemoved;

  /// No description provided for @profileBannerRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Uploading banners requires an internet connection.'**
  String get profileBannerRequiresInternet;

  /// No description provided for @profileBannerUpdated.
  ///
  /// In en, this message translates to:
  /// **'Banner updated'**
  String get profileBannerUpdated;

  /// No description provided for @profileBannerUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload banner: {error}'**
  String profileBannerUploadFailed(String error);

  /// No description provided for @profileBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get profileBasicInfo;

  /// No description provided for @profileBioHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get profileBioHint;

  /// No description provided for @profileBioLabel.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get profileBioLabel;

  /// No description provided for @profileCallsignHint.
  ///
  /// In en, this message translates to:
  /// **'Amateur radio callsign or identifier'**
  String get profileCallsignHint;

  /// No description provided for @profileCallsignInappropriate.
  ///
  /// In en, this message translates to:
  /// **'Callsign cannot contain inappropriate content'**
  String get profileCallsignInappropriate;

  /// No description provided for @profileCallsignLabel.
  ///
  /// In en, this message translates to:
  /// **'Callsign'**
  String get profileCallsignLabel;

  /// No description provided for @profileCallsignMax.
  ///
  /// In en, this message translates to:
  /// **'Max 10 characters'**
  String get profileCallsignMax;

  /// No description provided for @profileCloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get profileCloudBackup;

  /// No description provided for @profileCloudStartingUp.
  ///
  /// In en, this message translates to:
  /// **'Cloud services starting up — try again shortly'**
  String get profileCloudStartingUp;

  /// No description provided for @profileContinueApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get profileContinueApple;

  /// No description provided for @profileContinueGitHub.
  ///
  /// In en, this message translates to:
  /// **'Continue with GitHub'**
  String get profileContinueGitHub;

  /// No description provided for @profileContinueGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get profileContinueGoogle;

  /// No description provided for @profileCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'{label} copied to clipboard'**
  String profileCopiedToClipboard(String label);

  /// No description provided for @profileCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Profile'**
  String get profileCreate;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteConfirmMsg.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all associated data. This action cannot be undone.'**
  String get profileDeleteConfirmMsg;

  /// No description provided for @profileDeleteRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account requires an internet connection.'**
  String get profileDeleteRequiresInternet;

  /// No description provided for @profileDeletingAccount.
  ///
  /// In en, this message translates to:
  /// **'Deleting account...'**
  String get profileDeletingAccount;

  /// No description provided for @profileDeletionFailed.
  ///
  /// In en, this message translates to:
  /// **'Deletion failed. Please try again or contact support.'**
  String get profileDeletionFailed;

  /// No description provided for @profileDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get profileDetailsSection;

  /// No description provided for @profileDiscordHint.
  ///
  /// In en, this message translates to:
  /// **'username#0000'**
  String get profileDiscordHint;

  /// No description provided for @profileDiscordLabel.
  ///
  /// In en, this message translates to:
  /// **'Discord'**
  String get profileDiscordLabel;

  /// No description provided for @profileDisplayNameHint.
  ///
  /// In en, this message translates to:
  /// **'How you want to be known'**
  String get profileDisplayNameHint;

  /// No description provided for @profileDisplayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Display Name'**
  String get profileDisplayNameLabel;

  /// No description provided for @profileDisplayNameTaken.
  ///
  /// In en, this message translates to:
  /// **'This display name is already taken. Please choose a different one.'**
  String get profileDisplayNameTaken;

  /// No description provided for @profileEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditButton;

  /// No description provided for @profileEditSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditSheetTitle;

  /// No description provided for @profileEditTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditTooltip;

  /// No description provided for @profileEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmailLabel;

  /// No description provided for @profileGitHubHint.
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get profileGitHubHint;

  /// No description provided for @profileGitHubLabel.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get profileGitHubLabel;

  /// No description provided for @profileGitHubLinked.
  ///
  /// In en, this message translates to:
  /// **'GitHub account linked successfully!'**
  String get profileGitHubLinked;

  /// No description provided for @profileHelpTooltip.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get profileHelpTooltip;

  /// No description provided for @profileImageAccessError.
  ///
  /// In en, this message translates to:
  /// **'Could not access the selected image. Try saving it to your device first.'**
  String get profileImageAccessError;

  /// No description provided for @profileImageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the selected image. Make sure the file is downloaded locally and try again.'**
  String get profileImageLoadError;

  /// No description provided for @profileLinkFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to link accounts'**
  String get profileLinkFailed;

  /// No description provided for @profileLinkGitHub.
  ///
  /// In en, this message translates to:
  /// **'Link GitHub Account'**
  String get profileLinkGitHub;

  /// No description provided for @profileLinkGitHubMsg.
  ///
  /// In en, this message translates to:
  /// **'An account with {email} already exists using {provider}.\n\nSign in with {provider} to link your GitHub account?'**
  String profileLinkGitHubMsg(String email, String provider);

  /// No description provided for @profileLinkedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Linked accounts'**
  String get profileLinkedAccounts;

  /// No description provided for @profileLinksSection.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get profileLinksSection;

  /// No description provided for @profileMastodonHint.
  ///
  /// In en, this message translates to:
  /// **'@user@instance.social'**
  String get profileMastodonHint;

  /// No description provided for @profileMastodonLabel.
  ///
  /// In en, this message translates to:
  /// **'Mastodon'**
  String get profileMastodonLabel;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get profileMemberSince;

  /// No description provided for @profileNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get profileNoInternet;

  /// No description provided for @profileNotBackedUp.
  ///
  /// In en, this message translates to:
  /// **'Not backed up'**
  String get profileNotBackedUp;

  /// No description provided for @profileRemoveAvatar.
  ///
  /// In en, this message translates to:
  /// **'Remove Avatar'**
  String get profileRemoveAvatar;

  /// No description provided for @profileRemoveAvatarRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Removing avatars requires an internet connection.'**
  String get profileRemoveAvatarRequiresInternet;

  /// No description provided for @profileRemoveBanner.
  ///
  /// In en, this message translates to:
  /// **'Remove Banner'**
  String get profileRemoveBanner;

  /// No description provided for @profileRemoveBannerRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Removing banners requires an internet connection.'**
  String get profileRemoveBannerRequiresInternet;

  /// No description provided for @profileSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileSave;

  /// No description provided for @profileSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save profile: {error}'**
  String profileSaveFailed(String error);

  /// No description provided for @profileSaveRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Saving your profile requires an internet connection.'**
  String get profileSaveRequiresInternet;

  /// No description provided for @profileSetup.
  ///
  /// In en, this message translates to:
  /// **'Set up your profile'**
  String get profileSetup;

  /// No description provided for @profileSetupDesc.
  ///
  /// In en, this message translates to:
  /// **'Add your name, photo, and bio to personalize your mesh presence.'**
  String get profileSetupDesc;

  /// No description provided for @profileSignInDesc.
  ///
  /// In en, this message translates to:
  /// **'Sign in to backup your profile to the cloud and sync across devices.'**
  String get profileSignInDesc;

  /// No description provided for @profileSignInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed'**
  String get profileSignInFailed;

  /// No description provided for @profileSignInRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Sign-in requires an internet connection.'**
  String get profileSignInRequiresInternet;

  /// No description provided for @profileSignInServicesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to sign-in services. Check your internet connection and try again.'**
  String get profileSignInServicesUnavailable;

  /// No description provided for @profileSignInWithProvider.
  ///
  /// In en, this message translates to:
  /// **'Sign in with {provider}'**
  String profileSignInWithProvider(String provider);

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// No description provided for @profileSignOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get profileSignOutConfirm;

  /// No description provided for @profileSignOutRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Signing out requires an internet connection.'**
  String get profileSignOutRequiresInternet;

  /// No description provided for @profileSignedInApple.
  ///
  /// In en, this message translates to:
  /// **'Signed in with Apple'**
  String get profileSignedInApple;

  /// No description provided for @profileSignedInGitHub.
  ///
  /// In en, this message translates to:
  /// **'Signed in with GitHub'**
  String get profileSignedInGitHub;

  /// No description provided for @profileSignedInGoogle.
  ///
  /// In en, this message translates to:
  /// **'Signed in with Google'**
  String get profileSignedInGoogle;

  /// No description provided for @profileSigningIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get profileSigningIn;

  /// No description provided for @profileSocialSection.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get profileSocialSection;

  /// No description provided for @profileSyncError.
  ///
  /// In en, this message translates to:
  /// **'Sync error • Tap to retry'**
  String get profileSyncError;

  /// No description provided for @profileSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get profileSyncFailed;

  /// No description provided for @profileSyncPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Sync permission denied'**
  String get profileSyncPermissionDenied;

  /// No description provided for @profileSyncRequiresInternet.
  ///
  /// In en, this message translates to:
  /// **'Syncing requires an internet connection.'**
  String get profileSyncRequiresInternet;

  /// No description provided for @profileSyncTempUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sync temporarily unavailable'**
  String get profileSyncTempUnavailable;

  /// No description provided for @profileSyncTempUnavailable2.
  ///
  /// In en, this message translates to:
  /// **'Cloud sync temporarily unavailable'**
  String get profileSyncTempUnavailable2;

  /// No description provided for @profileSyncTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Sync timed out — try again'**
  String get profileSyncTimedOut;

  /// No description provided for @profileSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced • {email}'**
  String profileSynced(String email);

  /// No description provided for @profileSynced2.
  ///
  /// In en, this message translates to:
  /// **'Profile synced!'**
  String get profileSynced2;

  /// No description provided for @profileSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get profileSyncing;

  /// No description provided for @profileTelegramHint.
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get profileTelegramHint;

  /// No description provided for @profileTelegramLabel.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get profileTelegramLabel;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileTwitterHint.
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get profileTwitterHint;

  /// No description provided for @profileTwitterLabel.
  ///
  /// In en, this message translates to:
  /// **'Twitter'**
  String get profileTwitterLabel;

  /// No description provided for @profileUidLabel.
  ///
  /// In en, this message translates to:
  /// **'UID'**
  String get profileUidLabel;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @profileUrlInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get profileUrlInvalid;

  /// No description provided for @profileUrlMustStartHttp.
  ///
  /// In en, this message translates to:
  /// **'URL must start with http:// or https://'**
  String get profileUrlMustStartHttp;

  /// No description provided for @profileWebsiteHint.
  ///
  /// In en, this message translates to:
  /// **'https://example.com'**
  String get profileWebsiteHint;

  /// No description provided for @profileWebsiteLabel.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get profileWebsiteLabel;

  /// No description provided for @reachabilityAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Reachability'**
  String get reachabilityAboutTitle;

  /// No description provided for @reachabilityAboutTooltip.
  ///
  /// In en, this message translates to:
  /// **'About Reachability'**
  String get reachabilityAboutTooltip;

  /// No description provided for @reachabilityBetaBadge.
  ///
  /// In en, this message translates to:
  /// **'BETA'**
  String get reachabilityBetaBadge;

  /// No description provided for @reachabilityDisclaimerBanner.
  ///
  /// In en, this message translates to:
  /// **'Likelihood estimates only. Delivery is never guaranteed in a mesh network.'**
  String get reachabilityDisclaimerBanner;

  /// No description provided for @reachabilityEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Nodes will appear as they\'re observed\non the mesh network.'**
  String get reachabilityEmptyDescription;

  /// No description provided for @reachabilityEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No nodes discovered yet'**
  String get reachabilityEmptyTitle;

  /// No description provided for @reachabilityGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get reachabilityGotIt;

  /// No description provided for @reachabilityHowCalculatedContent.
  ///
  /// In en, this message translates to:
  /// **'The likelihood score combines several factors:\n• Freshness: How recently we heard from the node\n• Path Depth: Number of hops observed\n• Signal Quality: RSSI and SNR when available\n• Observation Pattern: Direct vs relayed packets\n• ACK History: DM acknowledgement success rate'**
  String get reachabilityHowCalculatedContent;

  /// No description provided for @reachabilityHowCalculatedTitle.
  ///
  /// In en, this message translates to:
  /// **'How is it calculated?'**
  String get reachabilityHowCalculatedTitle;

  /// No description provided for @reachabilityLevelHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get reachabilityLevelHigh;

  /// No description provided for @reachabilityLevelLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get reachabilityLevelLow;

  /// No description provided for @reachabilityLevelMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get reachabilityLevelMedium;

  /// No description provided for @reachabilityLevelsMeanContent.
  ///
  /// In en, this message translates to:
  /// **'• High: Strong recent indicators, but not guaranteed\n• Medium: Moderate confidence based on available data\n• Low: Weak or stale indicators, delivery unlikely'**
  String get reachabilityLevelsMeanContent;

  /// No description provided for @reachabilityLevelsMeanTitle.
  ///
  /// In en, this message translates to:
  /// **'What the levels mean'**
  String get reachabilityLevelsMeanTitle;

  /// No description provided for @reachabilityLimitationsContent.
  ///
  /// In en, this message translates to:
  /// **'• Meshtastic has no true routing tables\n• No end-to-end acknowledgements exist\n• Forwarding is opportunistic\n• Mesh topology changes constantly\n• All estimates based on passive observation only'**
  String get reachabilityLimitationsContent;

  /// No description provided for @reachabilityLimitationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Important limitations'**
  String get reachabilityLimitationsTitle;

  /// No description provided for @reachabilityScorePercent.
  ///
  /// In en, this message translates to:
  /// **'{percentage}%'**
  String reachabilityScorePercent(String percentage);

  /// No description provided for @reachabilityScoringModelContent.
  ///
  /// In en, this message translates to:
  /// **'Opportunistic Mesh Reach Likelihood Model (v1) — BETA\n\nA heuristic scoring model that estimates likelihood of reaching a node based on observed RF metrics and packet history. This score represents likelihood, not reachability. Meshtastic forwards packets opportunistically without routing. A high score does not guarantee delivery.'**
  String get reachabilityScoringModelContent;

  /// No description provided for @reachabilityScoringModelTitle.
  ///
  /// In en, this message translates to:
  /// **'Scoring Model'**
  String get reachabilityScoringModelTitle;

  /// No description provided for @reachabilityScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Reachability'**
  String get reachabilityScreenTitle;

  /// No description provided for @reachabilitySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search nodes'**
  String get reachabilitySearchHint;

  /// No description provided for @reachabilityWhatIsThisContent.
  ///
  /// In en, this message translates to:
  /// **'This screen shows a probabilistic estimate of how likely your messages will reach each node. It is NOT a guarantee of delivery.'**
  String get reachabilityWhatIsThisContent;

  /// No description provided for @reachabilityWhatIsThisTitle.
  ///
  /// In en, this message translates to:
  /// **'What is this?'**
  String get reachabilityWhatIsThisTitle;

  /// No description provided for @regionSelectionApplyDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get regionSelectionApplyDialogConfirm;

  /// No description provided for @regionSelectionApplyDialogMessageChange.
  ///
  /// In en, this message translates to:
  /// **'Changing the region will cause your device to reboot. This may take up to 30 seconds.\n\nYou will be briefly disconnected while the device restarts.'**
  String get regionSelectionApplyDialogMessageChange;

  /// No description provided for @regionSelectionApplyDialogMessageInitial.
  ///
  /// In en, this message translates to:
  /// **'Your device will reboot to apply the region settings. This may take up to 30 seconds.\n\nThe app will automatically reconnect when ready.'**
  String get regionSelectionApplyDialogMessageInitial;

  /// No description provided for @regionSelectionApplyDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply Region'**
  String get regionSelectionApplyDialogTitle;

  /// No description provided for @regionSelectionApplying.
  ///
  /// In en, this message translates to:
  /// **'Applying...'**
  String get regionSelectionApplying;

  /// No description provided for @regionSelectionBannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the correct frequency for your location to comply with local regulations.'**
  String get regionSelectionBannerSubtitle;

  /// No description provided for @regionSelectionBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Important: Select Your Region'**
  String get regionSelectionBannerTitle;

  /// No description provided for @regionSelectionBluetoothSettings.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Settings'**
  String get regionSelectionBluetoothSettings;

  /// No description provided for @regionSelectionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get regionSelectionContinue;

  /// No description provided for @regionSelectionCurrentBadge.
  ///
  /// In en, this message translates to:
  /// **'CURRENT'**
  String get regionSelectionCurrentBadge;

  /// No description provided for @regionSelectionDeviceDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Device disconnected. Please reconnect and try again.'**
  String get regionSelectionDeviceDisconnected;

  /// No description provided for @regionSelectionOpenBluetoothSettingsError.
  ///
  /// In en, this message translates to:
  /// **'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.'**
  String get regionSelectionOpenBluetoothSettingsError;

  /// No description provided for @regionSelectionPairingHintMessage.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth pairing was removed. Forget \"Meshtastic_XXXX\" in Settings > Bluetooth and reconnect to continue.'**
  String get regionSelectionPairingHintMessage;

  /// No description provided for @regionSelectionPairingInvalidation.
  ///
  /// In en, this message translates to:
  /// **'Your phone removed the stored pairing info for this device.\nGo to Settings > Bluetooth, forget the Meshtastic device, and try again.'**
  String get regionSelectionPairingInvalidation;

  /// No description provided for @regionSelectionReconnectTimeout.
  ///
  /// In en, this message translates to:
  /// **'Reconnect timed out. Please try again.'**
  String get regionSelectionReconnectTimeout;

  /// No description provided for @regionSelectionRegionAnz.
  ///
  /// In en, this message translates to:
  /// **'Australia/NZ'**
  String get regionSelectionRegionAnz;

  /// No description provided for @regionSelectionRegionAnzDesc.
  ///
  /// In en, this message translates to:
  /// **'Australia and New Zealand'**
  String get regionSelectionRegionAnzDesc;

  /// No description provided for @regionSelectionRegionAnzFreq.
  ///
  /// In en, this message translates to:
  /// **'915 MHz'**
  String get regionSelectionRegionAnzFreq;

  /// No description provided for @regionSelectionRegionCn.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get regionSelectionRegionCn;

  /// No description provided for @regionSelectionRegionCnDesc.
  ///
  /// In en, this message translates to:
  /// **'China'**
  String get regionSelectionRegionCnDesc;

  /// No description provided for @regionSelectionRegionCnFreq.
  ///
  /// In en, this message translates to:
  /// **'470 MHz'**
  String get regionSelectionRegionCnFreq;

  /// No description provided for @regionSelectionRegionEu433.
  ///
  /// In en, this message translates to:
  /// **'Europe 433'**
  String get regionSelectionRegionEu433;

  /// No description provided for @regionSelectionRegionEu433Desc.
  ///
  /// In en, this message translates to:
  /// **'EU alternate frequency'**
  String get regionSelectionRegionEu433Desc;

  /// No description provided for @regionSelectionRegionEu433Freq.
  ///
  /// In en, this message translates to:
  /// **'433 MHz'**
  String get regionSelectionRegionEu433Freq;

  /// No description provided for @regionSelectionRegionEu868.
  ///
  /// In en, this message translates to:
  /// **'Europe 868'**
  String get regionSelectionRegionEu868;

  /// No description provided for @regionSelectionRegionEu868Desc.
  ///
  /// In en, this message translates to:
  /// **'EU, UK, and most of Europe'**
  String get regionSelectionRegionEu868Desc;

  /// No description provided for @regionSelectionRegionEu868Freq.
  ///
  /// In en, this message translates to:
  /// **'868 MHz'**
  String get regionSelectionRegionEu868Freq;

  /// No description provided for @regionSelectionRegionIn.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get regionSelectionRegionIn;

  /// No description provided for @regionSelectionRegionInDesc.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get regionSelectionRegionInDesc;

  /// No description provided for @regionSelectionRegionInFreq.
  ///
  /// In en, this message translates to:
  /// **'865 MHz'**
  String get regionSelectionRegionInFreq;

  /// No description provided for @regionSelectionRegionJp.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get regionSelectionRegionJp;

  /// No description provided for @regionSelectionRegionJpDesc.
  ///
  /// In en, this message translates to:
  /// **'Japan'**
  String get regionSelectionRegionJpDesc;

  /// No description provided for @regionSelectionRegionJpFreq.
  ///
  /// In en, this message translates to:
  /// **'920 MHz'**
  String get regionSelectionRegionJpFreq;

  /// No description provided for @regionSelectionRegionKr.
  ///
  /// In en, this message translates to:
  /// **'Korea'**
  String get regionSelectionRegionKr;

  /// No description provided for @regionSelectionRegionKrDesc.
  ///
  /// In en, this message translates to:
  /// **'South Korea'**
  String get regionSelectionRegionKrDesc;

  /// No description provided for @regionSelectionRegionKrFreq.
  ///
  /// In en, this message translates to:
  /// **'920 MHz'**
  String get regionSelectionRegionKrFreq;

  /// No description provided for @regionSelectionRegionLora24.
  ///
  /// In en, this message translates to:
  /// **'2.4 GHz'**
  String get regionSelectionRegionLora24;

  /// No description provided for @regionSelectionRegionLora24Desc.
  ///
  /// In en, this message translates to:
  /// **'Worldwide 2.4GHz band'**
  String get regionSelectionRegionLora24Desc;

  /// No description provided for @regionSelectionRegionLora24Freq.
  ///
  /// In en, this message translates to:
  /// **'2.4 GHz'**
  String get regionSelectionRegionLora24Freq;

  /// No description provided for @regionSelectionRegionMy433.
  ///
  /// In en, this message translates to:
  /// **'Malaysia 433'**
  String get regionSelectionRegionMy433;

  /// No description provided for @regionSelectionRegionMy433Desc.
  ///
  /// In en, this message translates to:
  /// **'Malaysia'**
  String get regionSelectionRegionMy433Desc;

  /// No description provided for @regionSelectionRegionMy433Freq.
  ///
  /// In en, this message translates to:
  /// **'433 MHz'**
  String get regionSelectionRegionMy433Freq;

  /// No description provided for @regionSelectionRegionMy919.
  ///
  /// In en, this message translates to:
  /// **'Malaysia 919'**
  String get regionSelectionRegionMy919;

  /// No description provided for @regionSelectionRegionMy919Desc.
  ///
  /// In en, this message translates to:
  /// **'Malaysia'**
  String get regionSelectionRegionMy919Desc;

  /// No description provided for @regionSelectionRegionMy919Freq.
  ///
  /// In en, this message translates to:
  /// **'919 MHz'**
  String get regionSelectionRegionMy919Freq;

  /// No description provided for @regionSelectionRegionNz865.
  ///
  /// In en, this message translates to:
  /// **'New Zealand 865'**
  String get regionSelectionRegionNz865;

  /// No description provided for @regionSelectionRegionNz865Desc.
  ///
  /// In en, this message translates to:
  /// **'New Zealand alternate'**
  String get regionSelectionRegionNz865Desc;

  /// No description provided for @regionSelectionRegionNz865Freq.
  ///
  /// In en, this message translates to:
  /// **'865 MHz'**
  String get regionSelectionRegionNz865Freq;

  /// No description provided for @regionSelectionRegionRu.
  ///
  /// In en, this message translates to:
  /// **'Russia'**
  String get regionSelectionRegionRu;

  /// No description provided for @regionSelectionRegionRuDesc.
  ///
  /// In en, this message translates to:
  /// **'Russia'**
  String get regionSelectionRegionRuDesc;

  /// No description provided for @regionSelectionRegionRuFreq.
  ///
  /// In en, this message translates to:
  /// **'868 MHz'**
  String get regionSelectionRegionRuFreq;

  /// No description provided for @regionSelectionRegionSg923.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get regionSelectionRegionSg923;

  /// No description provided for @regionSelectionRegionSg923Desc.
  ///
  /// In en, this message translates to:
  /// **'Singapore'**
  String get regionSelectionRegionSg923Desc;

  /// No description provided for @regionSelectionRegionSg923Freq.
  ///
  /// In en, this message translates to:
  /// **'923 MHz'**
  String get regionSelectionRegionSg923Freq;

  /// No description provided for @regionSelectionRegionTh.
  ///
  /// In en, this message translates to:
  /// **'Thailand'**
  String get regionSelectionRegionTh;

  /// No description provided for @regionSelectionRegionThDesc.
  ///
  /// In en, this message translates to:
  /// **'Thailand'**
  String get regionSelectionRegionThDesc;

  /// No description provided for @regionSelectionRegionThFreq.
  ///
  /// In en, this message translates to:
  /// **'920 MHz'**
  String get regionSelectionRegionThFreq;

  /// No description provided for @regionSelectionRegionTw.
  ///
  /// In en, this message translates to:
  /// **'Taiwan'**
  String get regionSelectionRegionTw;

  /// No description provided for @regionSelectionRegionTwDesc.
  ///
  /// In en, this message translates to:
  /// **'Taiwan'**
  String get regionSelectionRegionTwDesc;

  /// No description provided for @regionSelectionRegionTwFreq.
  ///
  /// In en, this message translates to:
  /// **'923 MHz'**
  String get regionSelectionRegionTwFreq;

  /// No description provided for @regionSelectionRegionUa433.
  ///
  /// In en, this message translates to:
  /// **'Ukraine 433'**
  String get regionSelectionRegionUa433;

  /// No description provided for @regionSelectionRegionUa433Desc.
  ///
  /// In en, this message translates to:
  /// **'Ukraine'**
  String get regionSelectionRegionUa433Desc;

  /// No description provided for @regionSelectionRegionUa433Freq.
  ///
  /// In en, this message translates to:
  /// **'433 MHz'**
  String get regionSelectionRegionUa433Freq;

  /// No description provided for @regionSelectionRegionUa868.
  ///
  /// In en, this message translates to:
  /// **'Ukraine 868'**
  String get regionSelectionRegionUa868;

  /// No description provided for @regionSelectionRegionUa868Desc.
  ///
  /// In en, this message translates to:
  /// **'Ukraine'**
  String get regionSelectionRegionUa868Desc;

  /// No description provided for @regionSelectionRegionUa868Freq.
  ///
  /// In en, this message translates to:
  /// **'868 MHz'**
  String get regionSelectionRegionUa868Freq;

  /// No description provided for @regionSelectionRegionUs.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get regionSelectionRegionUs;

  /// No description provided for @regionSelectionRegionUsDesc.
  ///
  /// In en, this message translates to:
  /// **'US, Canada, Mexico'**
  String get regionSelectionRegionUsDesc;

  /// No description provided for @regionSelectionRegionUsFreq.
  ///
  /// In en, this message translates to:
  /// **'915 MHz'**
  String get regionSelectionRegionUsFreq;

  /// No description provided for @regionSelectionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get regionSelectionSave;

  /// No description provided for @regionSelectionSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search regions...'**
  String get regionSelectionSearchHint;

  /// No description provided for @regionSelectionSetRegionError.
  ///
  /// In en, this message translates to:
  /// **'Failed to set region: {error}'**
  String regionSelectionSetRegionError(String error);

  /// No description provided for @regionSelectionTitleChange.
  ///
  /// In en, this message translates to:
  /// **'Change Region'**
  String get regionSelectionTitleChange;

  /// No description provided for @regionSelectionTitleInitial.
  ///
  /// In en, this message translates to:
  /// **'Select Your Region'**
  String get regionSelectionTitleInitial;

  /// No description provided for @regionSelectionViewScanner.
  ///
  /// In en, this message translates to:
  /// **'View Scanner'**
  String get regionSelectionViewScanner;

  /// No description provided for @reviewModerationAllCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'All caught up!'**
  String get reviewModerationAllCaughtUp;

  /// No description provided for @reviewModerationAllReviews.
  ///
  /// In en, this message translates to:
  /// **'All Reviews'**
  String get reviewModerationAllReviews;

  /// No description provided for @reviewModerationAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get reviewModerationAnonymous;

  /// No description provided for @reviewModerationApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get reviewModerationApprove;

  /// No description provided for @reviewModerationApproved.
  ///
  /// In en, this message translates to:
  /// **'Review approved'**
  String get reviewModerationApproved;

  /// No description provided for @reviewModerationCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get reviewModerationCancel;

  /// No description provided for @reviewModerationDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get reviewModerationDelete;

  /// No description provided for @reviewModerationDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently delete this review?'**
  String get reviewModerationDeleteMessage;

  /// No description provided for @reviewModerationDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Review'**
  String get reviewModerationDeleteTitle;

  /// No description provided for @reviewModerationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Review deleted'**
  String get reviewModerationDeleted;

  /// No description provided for @reviewModerationErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading reviews'**
  String get reviewModerationErrorLoading;

  /// No description provided for @reviewModerationLegacy.
  ///
  /// In en, this message translates to:
  /// **'Legacy (no status)'**
  String get reviewModerationLegacy;

  /// No description provided for @reviewModerationNoDatabase.
  ///
  /// In en, this message translates to:
  /// **'No reviews in database'**
  String get reviewModerationNoDatabase;

  /// No description provided for @reviewModerationNoPending.
  ///
  /// In en, this message translates to:
  /// **'No pending reviews to moderate'**
  String get reviewModerationNoPending;

  /// No description provided for @reviewModerationNoReviews.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get reviewModerationNoReviews;

  /// No description provided for @reviewModerationPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get reviewModerationPending;

  /// No description provided for @reviewModerationReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reviewModerationReject;

  /// No description provided for @reviewModerationRejectReasonHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Inappropriate content, spam, etc.'**
  String get reviewModerationRejectReasonHint;

  /// No description provided for @reviewModerationRejectReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason for rejection'**
  String get reviewModerationRejectReasonLabel;

  /// No description provided for @reviewModerationRejectTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject Review'**
  String get reviewModerationRejectTitle;

  /// No description provided for @reviewModerationRejected.
  ///
  /// In en, this message translates to:
  /// **'Review rejected'**
  String get reviewModerationRejected;

  /// No description provided for @reviewModerationTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Management'**
  String get reviewModerationTitle;

  /// No description provided for @reviewModerationVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get reviewModerationVerified;

  /// No description provided for @routeDetailCenterOnNodeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Center on node'**
  String get routeDetailCenterOnNodeTooltip;

  /// No description provided for @routeDetailDistanceKilometers.
  ///
  /// In en, this message translates to:
  /// **'{km}km'**
  String routeDetailDistanceKilometers(String km);

  /// No description provided for @routeDetailDistanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get routeDetailDistanceLabel;

  /// No description provided for @routeDetailDistanceMeters.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String routeDetailDistanceMeters(String meters);

  /// No description provided for @routeDetailDurationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String routeDetailDurationHoursMinutes(int hours, int minutes);

  /// No description provided for @routeDetailDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get routeDetailDurationLabel;

  /// No description provided for @routeDetailDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}min'**
  String routeDetailDurationMinutes(int minutes);

  /// No description provided for @routeDetailElevationLabel.
  ///
  /// In en, this message translates to:
  /// **'Elevation'**
  String get routeDetailElevationLabel;

  /// No description provided for @routeDetailElevationValue.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String routeDetailElevationValue(String meters);

  /// No description provided for @routeDetailExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String routeDetailExportFailed(String error);

  /// No description provided for @routeDetailNoData.
  ///
  /// In en, this message translates to:
  /// **'--'**
  String get routeDetailNoData;

  /// No description provided for @routeDetailNoGpsPoints.
  ///
  /// In en, this message translates to:
  /// **'No GPS Points'**
  String get routeDetailNoGpsPoints;

  /// No description provided for @routeDetailPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get routeDetailPointsLabel;

  /// No description provided for @routeDetailShareText.
  ///
  /// In en, this message translates to:
  /// **'Route: {name}'**
  String routeDetailShareText(String name);

  /// No description provided for @routeDetailStorageUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Storage not available'**
  String get routeDetailStorageUnavailable;

  /// No description provided for @routeDetailYouBadge.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get routeDetailYouBadge;

  /// No description provided for @routesCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get routesCancel;

  /// No description provided for @routesCancelRecording.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get routesCancelRecording;

  /// No description provided for @routesCardDurationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String routesCardDurationHoursMinutes(int hours, int minutes);

  /// No description provided for @routesCardDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}min'**
  String routesCardDurationMinutes(int minutes);

  /// No description provided for @routesColorLabel.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get routesColorLabel;

  /// No description provided for @routesDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get routesDeleteAction;

  /// No description provided for @routesDeleteConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get routesDeleteConfirmAction;

  /// No description provided for @routesDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This cannot be undone.'**
  String routesDeleteConfirmMessage(String name);

  /// No description provided for @routesDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Route?'**
  String get routesDeleteConfirmTitle;

  /// No description provided for @routesDistanceDuration.
  ///
  /// In en, this message translates to:
  /// **'{distance} • {duration}'**
  String routesDistanceDuration(String distance, String duration);

  /// No description provided for @routesDistanceKilometers.
  ///
  /// In en, this message translates to:
  /// **'{km}km'**
  String routesDistanceKilometers(String km);

  /// No description provided for @routesDistanceMeters.
  ///
  /// In en, this message translates to:
  /// **'{meters}m'**
  String routesDistanceMeters(String meters);

  /// No description provided for @routesDurationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours}h {minutes}m'**
  String routesDurationHoursMinutes(int hours, int minutes);

  /// No description provided for @routesDurationMinutesSeconds.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m {seconds}s'**
  String routesDurationMinutesSeconds(int minutes, int seconds);

  /// No description provided for @routesDurationSeconds.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String routesDurationSeconds(int seconds);

  /// No description provided for @routesElevationGain.
  ///
  /// In en, this message translates to:
  /// **'{meters}m ↑'**
  String routesElevationGain(String meters);

  /// No description provided for @routesEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Record your first route or import a GPX file'**
  String get routesEmptyDescription;

  /// No description provided for @routesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Routes Yet'**
  String get routesEmptyTitle;

  /// No description provided for @routesExportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed: {error}'**
  String routesExportFailed(String error);

  /// No description provided for @routesExportGpx.
  ///
  /// In en, this message translates to:
  /// **'Export GPX'**
  String get routesExportGpx;

  /// No description provided for @routesFileReadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to read file'**
  String get routesFileReadFailed;

  /// No description provided for @routesImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String routesImportFailed(String error);

  /// No description provided for @routesImportGpx.
  ///
  /// In en, this message translates to:
  /// **'Import GPX'**
  String get routesImportGpx;

  /// No description provided for @routesImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Imported: {name}'**
  String routesImportSuccess(String name);

  /// No description provided for @routesInvalidGpxFile.
  ///
  /// In en, this message translates to:
  /// **'Invalid GPX file'**
  String get routesInvalidGpxFile;

  /// No description provided for @routesNewRouteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start recording your GPS track'**
  String get routesNewRouteSubtitle;

  /// No description provided for @routesNewRouteTitle.
  ///
  /// In en, this message translates to:
  /// **'New Route'**
  String get routesNewRouteTitle;

  /// No description provided for @routesNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Trail conditions, weather, etc.'**
  String get routesNotesHint;

  /// No description provided for @routesNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get routesNotesLabel;

  /// No description provided for @routesPointCount.
  ///
  /// In en, this message translates to:
  /// **'{count} points'**
  String routesPointCount(int count);

  /// No description provided for @routesPointsShort.
  ///
  /// In en, this message translates to:
  /// **'{count} pts'**
  String routesPointsShort(int count);

  /// No description provided for @routesRecordingLabel.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get routesRecordingLabel;

  /// No description provided for @routesRouteNameHint.
  ///
  /// In en, this message translates to:
  /// **'Morning hike'**
  String get routesRouteNameHint;

  /// No description provided for @routesRouteNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Route Name'**
  String get routesRouteNameLabel;

  /// No description provided for @routesScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get routesScreenTitle;

  /// No description provided for @routesShareText.
  ///
  /// In en, this message translates to:
  /// **'Route: {name}'**
  String routesShareText(String name);

  /// No description provided for @routesStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get routesStart;

  /// No description provided for @routesStartRoute.
  ///
  /// In en, this message translates to:
  /// **'Start Route'**
  String get routesStartRoute;

  /// No description provided for @routesStopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get routesStopRecording;

  /// Error message shown when BLE authentication fails during auto-reconnect.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. The device may need to be re-paired. Go to Settings > Bluetooth, forget the Meshtastic device, then tap it below to reconnect.'**
  String get scannerAuthFailedError;

  /// Subtitle of the auto-reconnect hint when no saved device name is available.
  ///
  /// In en, this message translates to:
  /// **'Select a device below to connect manually.'**
  String get scannerAutoReconnectDisabledSubtitle;

  /// Subtitle of the auto-reconnect hint when a saved device name is known.
  ///
  /// In en, this message translates to:
  /// **'Select \"{name}\" below, or enable auto-reconnect.'**
  String scannerAutoReconnectDisabledSubtitleWithDevice(String name);

  /// Title of the info banner shown when auto-reconnect is off.
  ///
  /// In en, this message translates to:
  /// **'Auto-reconnect is disabled'**
  String get scannerAutoReconnectDisabledTitle;

  /// Header label above the list of discovered BLE/USB devices.
  ///
  /// In en, this message translates to:
  /// **'Available Devices'**
  String get scannerAvailableDevices;

  /// Label for the button that opens the OS Bluetooth settings.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Settings'**
  String get scannerBluetoothSettings;

  /// Error snackbar when the OS deep link to Bluetooth settings fails.
  ///
  /// In en, this message translates to:
  /// **'Could not open Bluetooth Settings. Please open Settings > Bluetooth manually.'**
  String get scannerBluetoothSettingsOpenFailed;

  /// Title of the scanner screen in onboarding mode.
  ///
  /// In en, this message translates to:
  /// **'Connect Device'**
  String get scannerConnectDeviceTitle;

  /// Default status text shown on the connecting animation.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get scannerConnectingStatus;

  /// Error message set when a BLE/MeshCore connection fails with an exception.
  ///
  /// In en, this message translates to:
  /// **'Connection failed: {error}'**
  String scannerConnectionFailedWithError(String error);

  /// User-friendly error message for BLE connection timeout errors.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. The device may be out of range, powered off, or connected to another phone.'**
  String get scannerConnectionTimedOut;

  /// Copyright notice at the bottom of the scanner screen.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Socialmesh. All rights reserved.'**
  String get scannerCopyright;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get scannerDetailAddress;

  /// Connection type value for BLE devices in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Low Energy'**
  String get scannerDetailBluetoothLowEnergy;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Connection Type'**
  String get scannerDetailConnectionType;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get scannerDetailDeviceName;

  /// Column header in the device details table (dev mode only).
  ///
  /// In en, this message translates to:
  /// **'Manufacturer Data'**
  String get scannerDetailManufacturerData;

  /// Column header in the device details table (dev mode only).
  ///
  /// In en, this message translates to:
  /// **'Service UUIDs'**
  String get scannerDetailServiceUuids;

  /// Column header in the device details table.
  ///
  /// In en, this message translates to:
  /// **'Signal Strength'**
  String get scannerDetailSignalStrength;

  /// Connection type value for USB devices in the device details table.
  ///
  /// In en, this message translates to:
  /// **'USB Serial'**
  String get scannerDetailUsbSerial;

  /// User-friendly error message when the device disconnects unexpectedly during connection.
  ///
  /// In en, this message translates to:
  /// **'The device disconnected unexpectedly. It may have gone out of range or lost power.'**
  String get scannerDeviceDisconnectedUnexpectedly;

  /// Banner subtitle explaining why the saved device was not found.
  ///
  /// In en, this message translates to:
  /// **'If another app is connected to this device, disconnect from it first. Only one app can use Bluetooth at a time.'**
  String get scannerDeviceNotFoundSubtitle;

  /// Banner title when the saved device was not found during scan.
  ///
  /// In en, this message translates to:
  /// **'{name} not found'**
  String scannerDeviceNotFoundTitle(String name);

  /// Banner subtitle showing how many devices were found during an active scan.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} device found so far} other{{count} devices found so far}}'**
  String scannerDevicesFoundCount(int count);

  /// Title of the scanner screen in normal mode.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get scannerDevicesTitle;

  /// Auto-reconnect confirmation body when no saved device name is available.
  ///
  /// In en, this message translates to:
  /// **'This will automatically connect to your last used device whenever you open the app.'**
  String get scannerEnableAutoReconnectMessage;

  /// Auto-reconnect confirmation body when a saved device name is known.
  ///
  /// In en, this message translates to:
  /// **'This will automatically connect to \"{name}\" now and whenever you open the app.'**
  String scannerEnableAutoReconnectMessageWithDevice(String name);

  /// Title of the confirmation sheet for enabling auto-reconnect.
  ///
  /// In en, this message translates to:
  /// **'Enable Auto-Reconnect?'**
  String get scannerEnableAutoReconnectTitle;

  /// Helper text shown below the looking-for-devices message.
  ///
  /// In en, this message translates to:
  /// **'Make sure Bluetooth is enabled and your Meshtastic device is powered on'**
  String get scannerEnableBluetoothHint;

  /// Confirm label for the enable auto-reconnect sheet.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get scannerEnableLabel;

  /// User-friendly error message for GATT_ERROR 133 or discovery failed BLE errors.
  ///
  /// In en, this message translates to:
  /// **'Connection failed. This can happen if the device was previously paired with another app. Go to Settings > Bluetooth, find the Meshtastic device, tap \"Forget\", then try again.'**
  String get scannerGattConnectionFailed;

  /// Large text shown when scan is not active and no devices are listed.
  ///
  /// In en, this message translates to:
  /// **'Looking for devices…'**
  String get scannerLookingForDevices;

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

  /// Error message when the OS removes stored BLE pairing data for the device.
  ///
  /// In en, this message translates to:
  /// **'Your phone removed the stored pairing info for this device. Return to Settings > Bluetooth, forget \"Meshtastic_XXXX\", and try again.'**
  String get scannerPairingInvalidatedError;

  /// Hint shown when BLE pairing was invalidated (e.g. factory reset).
  ///
  /// In en, this message translates to:
  /// **'Bluetooth pairing was removed. Forget \"Meshtastic\" in Settings > Bluetooth and reconnect to continue.'**
  String get scannerPairingRemovedHint;

  /// Error thrown when Meshtastic config is not received, indicating a PIN/auth issue.
  ///
  /// In en, this message translates to:
  /// **'Connection failed - please try again and enter the PIN when prompted'**
  String get scannerPinRequiredError;

  /// Protocol badge label for MeshCore devices.
  ///
  /// In en, this message translates to:
  /// **'MeshCore'**
  String get scannerProtocolMeshCore;

  /// Protocol badge label for Meshtastic devices.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic'**
  String get scannerProtocolMeshtastic;

  /// Protocol badge label for devices with an unrecognised protocol.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get scannerProtocolUnknown;

  /// Label for the retry scan button.
  ///
  /// In en, this message translates to:
  /// **'Retry Scan'**
  String get scannerRetryScan;

  /// Fallback name used when the last connected device has no stored name.
  ///
  /// In en, this message translates to:
  /// **'Your saved device'**
  String get scannerSavedDeviceFallbackName;

  /// Banner subtitle shown when the device list is empty during scan.
  ///
  /// In en, this message translates to:
  /// **'Looking for Meshtastic devices...'**
  String get scannerScanningSubtitle;

  /// Banner title shown while actively scanning for BLE devices.
  ///
  /// In en, this message translates to:
  /// **'Scanning for nearby devices'**
  String get scannerScanningTitle;

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

  /// Body text in the unknown-protocol warning sheet.
  ///
  /// In en, this message translates to:
  /// **'This device was not detected as Meshtastic or MeshCore.'**
  String get scannerUnknownDeviceDescription;

  /// Title of the bottom sheet warning for an unrecognised BLE device.
  ///
  /// In en, this message translates to:
  /// **'Unknown Protocol'**
  String get scannerUnknownProtocol;

  /// Second paragraph in the unknown-protocol warning sheet.
  ///
  /// In en, this message translates to:
  /// **'This device cannot be connected automatically. Only Meshtastic and MeshCore devices are supported.'**
  String get scannerUnsupportedDeviceMessage;

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

  /// No description provided for @searchProductsBrowseByCategory.
  ///
  /// In en, this message translates to:
  /// **'Browse by Category'**
  String get searchProductsBrowseByCategory;

  /// No description provided for @searchProductsClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get searchProductsClear;

  /// No description provided for @searchProductsHint.
  ///
  /// In en, this message translates to:
  /// **'Search devices, modules, antennas...'**
  String get searchProductsHint;

  /// No description provided for @searchProductsNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String searchProductsNoResults(String query);

  /// No description provided for @searchProductsOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get searchProductsOutOfStock;

  /// No description provided for @searchProductsRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get searchProductsRecentSearches;

  /// No description provided for @searchProductsResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result for \"{query}\"} other{{count} results for \"{query}\"}}'**
  String searchProductsResultCount(int count, String query);

  /// No description provided for @searchProductsRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get searchProductsRetry;

  /// No description provided for @searchProductsSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Search failed'**
  String get searchProductsSearchFailed;

  /// No description provided for @searchProductsTrending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get searchProductsTrending;

  /// No description provided for @searchProductsTryDifferent.
  ///
  /// In en, this message translates to:
  /// **'Try different keywords or browse categories'**
  String get searchProductsTryDifferent;

  /// No description provided for @sellerProfileAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sellerProfileAbout;

  /// No description provided for @sellerProfileApplyCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Apply this code at checkout on the seller\'s store'**
  String get sellerProfileApplyCodeHint;

  /// No description provided for @sellerProfileCodeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied to clipboard'**
  String get sellerProfileCodeCopied;

  /// No description provided for @sellerProfileContactShipping.
  ///
  /// In en, this message translates to:
  /// **'Contact & Shipping'**
  String get sellerProfileContactShipping;

  /// No description provided for @sellerProfileDiscountExclusive.
  ///
  /// In en, this message translates to:
  /// **'Exclusive discount code for Socialmesh users'**
  String get sellerProfileDiscountExclusive;

  /// No description provided for @sellerProfileEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get sellerProfileEmail;

  /// No description provided for @sellerProfileErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading seller'**
  String get sellerProfileErrorLoading;

  /// No description provided for @sellerProfileFoundedStat.
  ///
  /// In en, this message translates to:
  /// **'Founded'**
  String get sellerProfileFoundedStat;

  /// No description provided for @sellerProfileGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get sellerProfileGoBack;

  /// No description provided for @sellerProfileNoProducts.
  ///
  /// In en, this message translates to:
  /// **'No products listed yet'**
  String get sellerProfileNoProducts;

  /// No description provided for @sellerProfileNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No products match \"{query}\"'**
  String sellerProfileNoSearchResults(String query);

  /// No description provided for @sellerProfileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Seller not found'**
  String get sellerProfileNotFound;

  /// No description provided for @sellerProfileOfficialPartner.
  ///
  /// In en, this message translates to:
  /// **'Official Partner'**
  String get sellerProfileOfficialPartner;

  /// No description provided for @sellerProfilePartnerDiscount.
  ///
  /// In en, this message translates to:
  /// **'Partner Discount'**
  String get sellerProfilePartnerDiscount;

  /// No description provided for @sellerProfileProductsCount.
  ///
  /// In en, this message translates to:
  /// **'Products ({count})'**
  String sellerProfileProductsCount(int count);

  /// No description provided for @sellerProfileProductsStat.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get sellerProfileProductsStat;

  /// No description provided for @sellerProfileRevealCode.
  ///
  /// In en, this message translates to:
  /// **'Reveal Code'**
  String get sellerProfileRevealCode;

  /// No description provided for @sellerProfileReviewCount.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String sellerProfileReviewCount(int count);

  /// No description provided for @sellerProfileSalesStat.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sellerProfileSalesStat;

  /// No description provided for @sellerProfileSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get sellerProfileSearchHint;

  /// No description provided for @sellerProfileShipsTo.
  ///
  /// In en, this message translates to:
  /// **'Ships to'**
  String get sellerProfileShipsTo;

  /// No description provided for @sellerProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get sellerProfileTitle;

  /// No description provided for @sellerProfileUnableToLoad.
  ///
  /// In en, this message translates to:
  /// **'Unable to load products'**
  String get sellerProfileUnableToLoad;

  /// No description provided for @sellerProfileWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get sellerProfileWebsite;

  /// No description provided for @serialConfigBaudRate.
  ///
  /// In en, this message translates to:
  /// **'Baud Rate'**
  String get serialConfigBaudRate;

  /// No description provided for @serialConfigBaudRateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Serial communication speed'**
  String get serialConfigBaudRateSubtitle;

  /// No description provided for @serialConfigEcho.
  ///
  /// In en, this message translates to:
  /// **'Echo'**
  String get serialConfigEcho;

  /// No description provided for @serialConfigEchoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Echo sent packets back to the serial port'**
  String get serialConfigEchoSubtitle;

  /// No description provided for @serialConfigEnabled.
  ///
  /// In en, this message translates to:
  /// **'Serial Enabled'**
  String get serialConfigEnabled;

  /// No description provided for @serialConfigEnabledSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable serial port communication'**
  String get serialConfigEnabledSubtitle;

  /// No description provided for @serialConfigGpioPin.
  ///
  /// In en, this message translates to:
  /// **'Pin {pin}'**
  String serialConfigGpioPin(int pin);

  /// No description provided for @serialConfigGpioUnset.
  ///
  /// In en, this message translates to:
  /// **'Unset'**
  String get serialConfigGpioUnset;

  /// No description provided for @serialConfigModeCaltopoDesc.
  ///
  /// In en, this message translates to:
  /// **'CalTopo format for mapping applications'**
  String get serialConfigModeCaltopoDesc;

  /// No description provided for @serialConfigModeNmeaDesc.
  ///
  /// In en, this message translates to:
  /// **'NMEA GPS sentence output for GPS applications'**
  String get serialConfigModeNmeaDesc;

  /// No description provided for @serialConfigModeProtoDesc.
  ///
  /// In en, this message translates to:
  /// **'Protobuf binary protocol for programmatic access'**
  String get serialConfigModeProtoDesc;

  /// No description provided for @serialConfigModeSimpleDesc.
  ///
  /// In en, this message translates to:
  /// **'Simple serial output for basic terminal usage'**
  String get serialConfigModeSimpleDesc;

  /// No description provided for @serialConfigModeTextmsgDesc.
  ///
  /// In en, this message translates to:
  /// **'Text message mode for SMS-style communication'**
  String get serialConfigModeTextmsgDesc;

  /// No description provided for @serialConfigOverrideConsole.
  ///
  /// In en, this message translates to:
  /// **'Override Console Serial'**
  String get serialConfigOverrideConsole;

  /// No description provided for @serialConfigOverrideConsoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use serial module instead of console'**
  String get serialConfigOverrideConsoleSubtitle;

  /// No description provided for @serialConfigRxdGpio.
  ///
  /// In en, this message translates to:
  /// **'RXD GPIO Pin'**
  String get serialConfigRxdGpio;

  /// No description provided for @serialConfigRxdGpioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Receive data GPIO pin number'**
  String get serialConfigRxdGpioSubtitle;

  /// No description provided for @serialConfigSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get serialConfigSave;

  /// No description provided for @serialConfigSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error saving config: {error}'**
  String serialConfigSaveError(String error);

  /// No description provided for @serialConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Serial configuration saved'**
  String get serialConfigSaved;

  /// No description provided for @serialConfigSectionBaudRate.
  ///
  /// In en, this message translates to:
  /// **'Baud Rate'**
  String get serialConfigSectionBaudRate;

  /// No description provided for @serialConfigSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get serialConfigSectionGeneral;

  /// No description provided for @serialConfigSectionSerialMode.
  ///
  /// In en, this message translates to:
  /// **'Serial Mode'**
  String get serialConfigSectionSerialMode;

  /// No description provided for @serialConfigSectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get serialConfigSectionTimeout;

  /// No description provided for @serialConfigTimeout.
  ///
  /// In en, this message translates to:
  /// **'Timeout'**
  String get serialConfigTimeout;

  /// No description provided for @serialConfigTimeoutValue.
  ///
  /// In en, this message translates to:
  /// **'{seconds} seconds'**
  String serialConfigTimeoutValue(int seconds);

  /// No description provided for @serialConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Serial Config'**
  String get serialConfigTitle;

  /// No description provided for @serialConfigTxdGpio.
  ///
  /// In en, this message translates to:
  /// **'TXD GPIO Pin'**
  String get serialConfigTxdGpio;

  /// No description provided for @serialConfigTxdGpioSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Transmit data GPIO pin number'**
  String get serialConfigTxdGpioSubtitle;

  /// Error snackbar when clearing all data only partially succeeds.
  ///
  /// In en, this message translates to:
  /// **'Failed to clear some data: {error}'**
  String settingsClearAllDataFailed(String error);

  /// Confirm label for the clear all data sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get settingsClearAllDataLabel;

  /// Body of the clear all data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will delete ALL app data: messages, nodes, channels, settings, keys, signals, bookmarks, automations, widgets, and saved preferences. This action cannot be undone.'**
  String get settingsClearAllDataMessage;

  /// Success snackbar after clearing all app data.
  ///
  /// In en, this message translates to:
  /// **'All data cleared successfully'**
  String get settingsClearAllDataSuccess;

  /// Title of the clear all data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get settingsClearAllDataTitle;

  /// Confirm label for the clear messages sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsClearMessagesLabel;

  /// Body of the clear messages confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will delete all stored messages. This action cannot be undone.'**
  String get settingsClearMessagesMessage;

  /// Success snackbar after clearing all messages.
  ///
  /// In en, this message translates to:
  /// **'Messages cleared'**
  String get settingsClearMessagesSuccess;

  /// Title of the clear messages confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Clear Messages'**
  String get settingsClearMessagesTitle;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get settingsDeviceInfoConnection;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get settingsDeviceInfoDeviceName;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get settingsDeviceInfoHardware;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Long Name'**
  String get settingsDeviceInfoLongName;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Node Number'**
  String get settingsDeviceInfoNodeNumber;

  /// Fallback value for the connection row in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get settingsDeviceInfoNone;

  /// Fallback value in the device information sheet when not connected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get settingsDeviceInfoNotConnected;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Short Name'**
  String get settingsDeviceInfoShortName;

  /// Header title in the device information bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get settingsDeviceInfoTitle;

  /// Fallback value for unknown fields in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get settingsDeviceInfoUnknown;

  /// Row label in the device information sheet.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get settingsDeviceInfoUserId;

  /// Error text shown when the settings screen fails to load.
  ///
  /// In en, this message translates to:
  /// **'Error loading settings: {error}'**
  String settingsErrorLoading(String error);

  /// Error snackbar when force sync fails.
  ///
  /// In en, this message translates to:
  /// **'Sync failed: {error}'**
  String settingsForceSyncFailed(String error);

  /// Confirm label for the force sync sheet.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get settingsForceSyncLabel;

  /// Body of the force sync confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will clear all local messages, nodes, and channels, then re-sync everything from the connected device.\n\nAre you sure you want to continue?'**
  String get settingsForceSyncMessage;

  /// Error snackbar when force sync is triggered without a connected device.
  ///
  /// In en, this message translates to:
  /// **'Not connected to a device'**
  String get settingsForceSyncNotConnected;

  /// Success snackbar after a successful force sync.
  ///
  /// In en, this message translates to:
  /// **'Sync complete'**
  String get settingsForceSyncSuccess;

  /// Title of the force sync confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Force Sync'**
  String get settingsForceSyncTitle;

  /// Loading text shown inside the sync-in-progress bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Syncing from device…'**
  String get settingsForceSyncingStatus;

  /// Title of the haptic intensity picker bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Haptic Intensity'**
  String get settingsHapticIntensityTitle;

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

  /// Description for the light/subtle haptic intensity option.
  ///
  /// In en, this message translates to:
  /// **'Subtle feedback for a gentle touch'**
  String get settingsHapticSubtleDescription;

  /// Tooltip for the help icon button in the settings app bar.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get settingsHelpTooltip;

  /// List tile label for a message history limit option.
  ///
  /// In en, this message translates to:
  /// **'{limit} messages'**
  String settingsHistoryLimitOption(int limit);

  /// Title of the message history limit picker bottom sheet.
  ///
  /// In en, this message translates to:
  /// **'Message History Limit'**
  String get settingsHistoryLimitTitle;

  /// Generic loading subtitle used across several settings tiles.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get settingsLoadingStatus;

  /// Tooltip for the back navigation button in the Meshtastic web view.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get settingsMeshtasticGoBack;

  /// Error body in the offline placeholder of the Meshtastic web view.
  ///
  /// In en, this message translates to:
  /// **'This content requires an internet connection. Please check your connection and try again.'**
  String get settingsMeshtasticOfflineMessage;

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

  /// Initial title of the Meshtastic web view screen.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic'**
  String get settingsMeshtasticWebViewTitle;

  /// Empty state title in the settings search results.
  ///
  /// In en, this message translates to:
  /// **'No settings found'**
  String get settingsNoSettingsFound;

  /// Subtitle shown for the region tile when no region has been configured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get settingsNotConfigured;

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

  /// Subtitle in the premium card when all features are owned.
  ///
  /// In en, this message translates to:
  /// **'All features unlocked!'**
  String get settingsPremiumAllUnlocked;

  /// Fallback badge label on a premium feature tile that is locked.
  ///
  /// In en, this message translates to:
  /// **'LOCKED'**
  String get settingsPremiumBadgeLocked;

  /// Badge label on a premium feature tile that has been purchased.
  ///
  /// In en, this message translates to:
  /// **'OWNED'**
  String get settingsPremiumBadgeOwned;

  /// Badge label on a premium feature tile in trial state.
  ///
  /// In en, this message translates to:
  /// **'TRY IT'**
  String get settingsPremiumBadgeTry;

  /// Subtitle in the premium card showing how many features are unlocked.
  ///
  /// In en, this message translates to:
  /// **'{owned} of {total} unlocked'**
  String settingsPremiumPartiallyUnlocked(int owned, int total);

  /// Heading in the premium card when some features are locked.
  ///
  /// In en, this message translates to:
  /// **'Unlock Features'**
  String get settingsPremiumUnlockFeaturesTitle;

  /// Tag text on the profile tile when the profile exists only locally.
  ///
  /// In en, this message translates to:
  /// **'Local only'**
  String get settingsProfileLocalOnly;

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

  /// Title of the profile tile when no profile is loaded.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settingsProfileTitle;

  /// Fallback subtitle for the Region tile when the region configuration fails to load.
  ///
  /// In en, this message translates to:
  /// **'Configure device radio frequency'**
  String get settingsRegionConfigureSubtitle;

  /// Title of the remote admin tile when viewing the local device.
  ///
  /// In en, this message translates to:
  /// **'Configure Device'**
  String get settingsRemoteAdminConfigureTitle;

  /// Title of the remote admin tile when a remote node is selected.
  ///
  /// In en, this message translates to:
  /// **'Configuring Remote Node'**
  String get settingsRemoteAdminConfiguringTitle;

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

  /// Confirm label for the reset local data sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get settingsResetLocalDataLabel;

  /// Body of the reset local data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'This will clear all messages and node data, forcing a fresh sync from your device on next connection.\n\nYour settings, theme, and preferences will be kept.\n\nUse this if nodes show incorrect status or messages appear wrong.'**
  String get settingsResetLocalDataMessage;

  /// Success snackbar after resetting local data.
  ///
  /// In en, this message translates to:
  /// **'Local data reset. Reconnect to sync fresh data.'**
  String get settingsResetLocalDataSuccess;

  /// Title of the reset local data confirmation sheet.
  ///
  /// In en, this message translates to:
  /// **'Reset Local Data'**
  String get settingsResetLocalDataTitle;

  /// Subtitle for the auto-accept transfers search item.
  ///
  /// In en, this message translates to:
  /// **'Automatically accept incoming file offers'**
  String get settingsSearchAutoAcceptTransfersSubtitle;

  /// Title for the auto-accept transfers search item.
  ///
  /// In en, this message translates to:
  /// **'Auto-accept transfers'**
  String get settingsSearchAutoAcceptTransfersTitle;

  /// Subtitle for the automations pack search item.
  ///
  /// In en, this message translates to:
  /// **'Automated actions and triggers'**
  String get settingsSearchAutomationsPackSubtitle;

  /// Fallback title for the automations pack search item.
  ///
  /// In en, this message translates to:
  /// **'Automations Pack'**
  String get settingsSearchAutomationsPackTitle;

  /// Subtitle for the Bluetooth config search item.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth settings and PIN'**
  String get settingsSearchBluetoothConfigSubtitle;

  /// Title for the Bluetooth config search item.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth config'**
  String get settingsSearchBluetoothConfigTitle;

  /// Subtitle for the canned messages search item.
  ///
  /// In en, this message translates to:
  /// **'Pre-configured device messages'**
  String get settingsSearchCannedMessagesSubtitle;

  /// Title for the canned messages search item.
  ///
  /// In en, this message translates to:
  /// **'Canned Messages'**
  String get settingsSearchCannedMessagesTitle;

  /// Subtitle for the channel message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Notify for channel broadcasts'**
  String get settingsSearchChannelNotificationsSubtitle;

  /// Title for the channel message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Channel message notifications'**
  String get settingsSearchChannelNotificationsTitle;

  /// Subtitle for the clear all data search item.
  ///
  /// In en, this message translates to:
  /// **'Delete messages, settings, and keys'**
  String get settingsSearchClearAllDataSubtitle;

  /// Subtitle for the clear all messages search item.
  ///
  /// In en, this message translates to:
  /// **'Delete all stored messages'**
  String get settingsSearchClearAllMessagesSubtitle;

  /// Title for the clear all messages search item.
  ///
  /// In en, this message translates to:
  /// **'Clear all messages'**
  String get settingsSearchClearAllMessagesTitle;

  /// Subtitle for the Comments & mentions search item.
  ///
  /// In en, this message translates to:
  /// **'Push notifications for comments and @mentions'**
  String get settingsSearchCommentsSubtitle;

  /// Subtitle for the device config search item.
  ///
  /// In en, this message translates to:
  /// **'Device name, role, and behavior'**
  String get settingsSearchDeviceConfigSubtitle;

  /// Title for the device config search item.
  ///
  /// In en, this message translates to:
  /// **'Device config'**
  String get settingsSearchDeviceConfigTitle;

  /// Subtitle for the display config search item.
  ///
  /// In en, this message translates to:
  /// **'Screen brightness and timeout'**
  String get settingsSearchDisplayConfigSubtitle;

  /// Title for the display config search item.
  ///
  /// In en, this message translates to:
  /// **'Display config'**
  String get settingsSearchDisplayConfigTitle;

  /// Subtitle for the direct message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Notify for private messages'**
  String get settingsSearchDmNotificationsSubtitle;

  /// Title for the direct message notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Direct message notifications'**
  String get settingsSearchDmNotificationsTitle;

  /// Subtitle for the export data search item.
  ///
  /// In en, this message translates to:
  /// **'Export messages and settings'**
  String get settingsSearchExportDataSubtitle;

  /// Title for the export data search item (lowercase variant).
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get settingsSearchExportDataTitle;

  /// Subtitle for the file transfer search item.
  ///
  /// In en, this message translates to:
  /// **'Send and receive small files over mesh'**
  String get settingsSearchFileTransferSubtitle;

  /// Title for the file transfer search item.
  ///
  /// In en, this message translates to:
  /// **'File transfer'**
  String get settingsSearchFileTransferTitle;

  /// Subtitle for the force sync search item.
  ///
  /// In en, this message translates to:
  /// **'Force configuration sync'**
  String get settingsSearchForceSyncSubtitle;

  /// Title for the force sync search item (lowercase variant).
  ///
  /// In en, this message translates to:
  /// **'Force sync'**
  String get settingsSearchForceSyncTitle;

  /// Subtitle for the Haptic Intensity search item.
  ///
  /// In en, this message translates to:
  /// **'Light, medium, or heavy feedback'**
  String get settingsSearchHapticIntensitySubtitle;

  /// Subtitle for the Help & Support search item.
  ///
  /// In en, this message translates to:
  /// **'FAQ, troubleshooting, and contact info'**
  String get settingsSearchHelpSupportSubtitle;

  /// Hint text in the settings search field.
  ///
  /// In en, this message translates to:
  /// **'Find a setting'**
  String get settingsSearchHint;

  /// Subtitle for the message history limit search item.
  ///
  /// In en, this message translates to:
  /// **'Maximum messages to keep'**
  String get settingsSearchHistoryLimitSubtitle;

  /// Title for the message history limit search item.
  ///
  /// In en, this message translates to:
  /// **'Message history limit'**
  String get settingsSearchHistoryLimitTitle;

  /// Subtitle for the IFTTT pack search item.
  ///
  /// In en, this message translates to:
  /// **'Integration with external services'**
  String get settingsSearchIftttPackSubtitle;

  /// Fallback title for the IFTTT pack search item.
  ///
  /// In en, this message translates to:
  /// **'IFTTT Pack'**
  String get settingsSearchIftttPackTitle;

  /// Subtitle for the import channel via QR search item.
  ///
  /// In en, this message translates to:
  /// **'Scan a Meshtastic channel QR code'**
  String get settingsSearchImportChannelSubtitle;

  /// Title for the import channel via QR search item.
  ///
  /// In en, this message translates to:
  /// **'Import channel via QR'**
  String get settingsSearchImportChannelTitle;

  /// Subtitle for the Likes search item.
  ///
  /// In en, this message translates to:
  /// **'Push notifications for post likes'**
  String get settingsSearchLikesSubtitle;

  /// Subtitle for the Linked Devices search item.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic devices connected to your profile'**
  String get settingsSearchLinkedDevicesSubtitle;

  /// Title for the Linked Devices search item.
  ///
  /// In en, this message translates to:
  /// **'Linked Devices'**
  String get settingsSearchLinkedDevicesTitle;

  /// Subtitle for the network config search item.
  ///
  /// In en, this message translates to:
  /// **'WiFi and network settings'**
  String get settingsSearchNetworkConfigSubtitle;

  /// Title for the network config search item.
  ///
  /// In en, this message translates to:
  /// **'Network config'**
  String get settingsSearchNetworkConfigTitle;

  /// Subtitle for the New followers search item.
  ///
  /// In en, this message translates to:
  /// **'Push notifications when someone follows you'**
  String get settingsSearchNewFollowersSubtitle;

  /// Subtitle for the new nodes notifications search item.
  ///
  /// In en, this message translates to:
  /// **'Notify when new nodes join the mesh'**
  String get settingsSearchNewNodesNotificationsSubtitle;

  /// Title for the new nodes notifications search item.
  ///
  /// In en, this message translates to:
  /// **'New nodes notifications'**
  String get settingsSearchNewNodesNotificationsTitle;

  /// Subtitle for the notification sound search item.
  ///
  /// In en, this message translates to:
  /// **'Play sound for notifications'**
  String get settingsSearchNotificationSoundSubtitle;

  /// Title for the notification sound search item.
  ///
  /// In en, this message translates to:
  /// **'Notification sound'**
  String get settingsSearchNotificationSoundTitle;

  /// Subtitle for the notification vibration search item.
  ///
  /// In en, this message translates to:
  /// **'Vibrate for notifications'**
  String get settingsSearchNotificationVibrationSubtitle;

  /// Title for the notification vibration search item.
  ///
  /// In en, this message translates to:
  /// **'Notification vibration'**
  String get settingsSearchNotificationVibrationTitle;

  /// Subtitle for the position config search item.
  ///
  /// In en, this message translates to:
  /// **'GPS and position sharing'**
  String get settingsSearchPositionConfigSubtitle;

  /// Title for the position config search item.
  ///
  /// In en, this message translates to:
  /// **'Position config'**
  String get settingsSearchPositionConfigTitle;

  /// Subtitle for the power config search item.
  ///
  /// In en, this message translates to:
  /// **'Power saving and sleep settings'**
  String get settingsSearchPowerConfigSubtitle;

  /// Title for the power config search item.
  ///
  /// In en, this message translates to:
  /// **'Power config'**
  String get settingsSearchPowerConfigTitle;

  /// Subtitle for the Unlock Features search item in the premium section.
  ///
  /// In en, this message translates to:
  /// **'Ringtones, themes, automations, IFTTT, widgets'**
  String get settingsSearchPremiumSubtitle;

  /// Subtitle for the Privacy Policy search item.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get settingsSearchPrivacySubtitle;

  /// Subtitle for the Profile search item.
  ///
  /// In en, this message translates to:
  /// **'Your display name, avatar, and bio'**
  String get settingsSearchProfileSubtitle;

  /// Subtitle for the radio config search item.
  ///
  /// In en, this message translates to:
  /// **'LoRa, modem, channel settings'**
  String get settingsSearchRadioConfigSubtitle;

  /// Title for the radio config search item (lowercase variant).
  ///
  /// In en, this message translates to:
  /// **'Radio config'**
  String get settingsSearchRadioConfigTitle;

  /// Subtitle for the region search item.
  ///
  /// In en, this message translates to:
  /// **'Device radio frequency region'**
  String get settingsSearchRegionSubtitle;

  /// Title for the region search item.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get settingsSearchRegionTitle;

  /// Subtitle for the remote administration search item.
  ///
  /// In en, this message translates to:
  /// **'Configure remote nodes via PKI admin'**
  String get settingsSearchRemoteAdminSubtitle;

  /// Title for the remote administration search item.
  ///
  /// In en, this message translates to:
  /// **'Remote Administration'**
  String get settingsSearchRemoteAdminTitle;

  /// Subtitle for the reset local data search item.
  ///
  /// In en, this message translates to:
  /// **'Clear all local app data'**
  String get settingsSearchResetLocalDataSubtitle;

  /// Title for the reset local data search item.
  ///
  /// In en, this message translates to:
  /// **'Reset local data'**
  String get settingsSearchResetLocalDataTitle;

  /// Subtitle for the ringtone pack search item.
  ///
  /// In en, this message translates to:
  /// **'Custom notification sounds'**
  String get settingsSearchRingtonePackSubtitle;

  /// Fallback title for the ringtone pack search item.
  ///
  /// In en, this message translates to:
  /// **'Ringtone Pack'**
  String get settingsSearchRingtonePackTitle;

  /// Subtitle for the scan for device search item.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code for easy setup'**
  String get settingsSearchScanForDeviceSubtitle;

  /// Title for the scan for device search item.
  ///
  /// In en, this message translates to:
  /// **'Scan for device'**
  String get settingsSearchScanForDeviceTitle;

  /// Subtitle for the Socialmesh search item in the About section.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic companion app'**
  String get settingsSearchSocialmeshSubtitle;

  /// Subtitle for the TAK Gateway search item.
  ///
  /// In en, this message translates to:
  /// **'Gateway URL, position publishing, callsign'**
  String get settingsSearchTakGatewaySubtitle;

  /// Title for the TAK Gateway search item in the Connection section.
  ///
  /// In en, this message translates to:
  /// **'TAK Gateway'**
  String get settingsSearchTakGatewayTitle;

  /// Subtitle for the Terms of Service search item.
  ///
  /// In en, this message translates to:
  /// **'Legal terms and conditions'**
  String get settingsSearchTermsSubtitle;

  /// Subtitle for the theme pack search item.
  ///
  /// In en, this message translates to:
  /// **'Accent colors and visual customization'**
  String get settingsSearchThemePackSubtitle;

  /// Fallback title for the theme pack search item.
  ///
  /// In en, this message translates to:
  /// **'Theme Pack'**
  String get settingsSearchThemePackTitle;

  /// Subtitle for the widget pack search item.
  ///
  /// In en, this message translates to:
  /// **'Home screen widgets'**
  String get settingsSearchWidgetPackSubtitle;

  /// Fallback title for the widget pack search item.
  ///
  /// In en, this message translates to:
  /// **'Widget Pack'**
  String get settingsSearchWidgetPackTitle;

  /// Section header label for the About section in settings.
  ///
  /// In en, this message translates to:
  /// **'ABOUT'**
  String get settingsSectionAbout;

  /// Section header label for the Account section in settings.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get settingsSectionAccount;

  /// Section header label for the Animations section in settings.
  ///
  /// In en, this message translates to:
  /// **'ANIMATIONS'**
  String get settingsSectionAnimations;

  /// Section header label for the Appearance section in settings.
  ///
  /// In en, this message translates to:
  /// **'APPEARANCE'**
  String get settingsSectionAppearance;

  /// Section header label for the Connection section in settings.
  ///
  /// In en, this message translates to:
  /// **'CONNECTION'**
  String get settingsSectionConnection;

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

  /// Section header label for the Feedback section in settings.
  ///
  /// In en, this message translates to:
  /// **'FEEDBACK'**
  String get settingsSectionFeedback;

  /// Section header label for the Haptic Feedback section in settings.
  ///
  /// In en, this message translates to:
  /// **'HAPTIC FEEDBACK'**
  String get settingsSectionHapticFeedback;

  /// Section header label for the Messaging section in settings.
  ///
  /// In en, this message translates to:
  /// **'MESSAGING'**
  String get settingsSectionMessaging;

  /// Section header label for the Modules section in settings.
  ///
  /// In en, this message translates to:
  /// **'MODULES'**
  String get settingsSectionModules;

  /// Section header label for the Notifications section in settings.
  ///
  /// In en, this message translates to:
  /// **'NOTIFICATIONS'**
  String get settingsSectionNotifications;

  /// Section header label for the Premium section in settings.
  ///
  /// In en, this message translates to:
  /// **'PREMIUM'**
  String get settingsSectionPremium;

  /// Section header label for the Remote Administration section in settings.
  ///
  /// In en, this message translates to:
  /// **'REMOTE ADMINISTRATION'**
  String get settingsSectionRemoteAdmin;

  /// Section header label for the Social Notifications section in settings.
  ///
  /// In en, this message translates to:
  /// **'SOCIAL NOTIFICATIONS'**
  String get settingsSectionSocialNotifications;

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

  /// Section header label for the What's New section in settings.
  ///
  /// In en, this message translates to:
  /// **'WHAT’S NEW'**
  String get settingsSectionWhatsNew;

  /// Subtitle of the comments & mentions social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'When someone comments or @mentions you'**
  String get settingsSocialCommentsSubtitle;

  /// Title of the comments & mentions social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'Comments & mentions'**
  String get settingsSocialCommentsTitle;

  /// Subtitle of the likes social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'When someone likes your posts'**
  String get settingsSocialLikesSubtitle;

  /// Title of the likes social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get settingsSocialLikesTitle;

  /// Subtitle of the new followers social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'When someone follows you or sends a request'**
  String get settingsSocialNewFollowersSubtitle;

  /// Title of the new followers social notification toggle.
  ///
  /// In en, this message translates to:
  /// **'New followers'**
  String get settingsSocialNewFollowersTitle;

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

  /// Snackbar text shown when tapping the Socialmesh about tile.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh v{version}'**
  String settingsSocialmeshVersionSnackbar(String version);

  /// Subtitle of the 3D effects toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Perspective transforms and depth effects'**
  String get settingsTile3dEffectsSubtitle;

  /// Title of the 3D effects toggle tile.
  ///
  /// In en, this message translates to:
  /// **'3D effects'**
  String get settingsTile3dEffectsTitle;

  /// Subtitle of the air quality telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'PM2.5, PM10, CO2 readings'**
  String get settingsTileAirQualitySubtitle;

  /// Title of the air quality telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get settingsTileAirQualityTitle;

  /// Subtitle of the ambient lighting module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure LED and RGB settings'**
  String get settingsTileAmbientLightingSubtitle;

  /// Title of the ambient lighting module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Ambient Lighting'**
  String get settingsTileAmbientLightingTitle;

  /// Subtitle of the app log tools tile.
  ///
  /// In en, this message translates to:
  /// **'View application debug logs'**
  String get settingsTileAppLogSubtitle;

  /// Title of the app log tools tile.
  ///
  /// In en, this message translates to:
  /// **'App Log'**
  String get settingsTileAppLogTitle;

  /// Subtitle of the appearance and accessibility settings tile.
  ///
  /// In en, this message translates to:
  /// **'Font, text size, density, contrast, motion'**
  String get settingsTileAppearanceSubtitle;

  /// Title of the appearance and accessibility settings tile.
  ///
  /// In en, this message translates to:
  /// **'Appearance & Accessibility'**
  String get settingsTileAppearanceTitle;

  /// Subtitle of the auto-reconnect settings tile.
  ///
  /// In en, this message translates to:
  /// **'Automatically reconnect to last device'**
  String get settingsTileAutoReconnectSubtitle;

  /// Title of the auto-reconnect settings tile.
  ///
  /// In en, this message translates to:
  /// **'Auto-reconnect'**
  String get settingsTileAutoReconnectTitle;

  /// Subtitle of the background connection settings tile.
  ///
  /// In en, this message translates to:
  /// **'Background BLE, notifications, and power settings'**
  String get settingsTileBackgroundConnectionSubtitle;

  /// Title of the background connection settings tile.
  ///
  /// In en, this message translates to:
  /// **'Background connection'**
  String get settingsTileBackgroundConnectionTitle;

  /// Subtitle of the Bluetooth device settings tile.
  ///
  /// In en, this message translates to:
  /// **'Pairing mode, PIN settings'**
  String get settingsTileBluetoothSubtitle;

  /// Title of the Bluetooth device settings tile.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth'**
  String get settingsTileBluetoothTitle;

  /// Subtitle of the canned messages module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device-side canned message settings'**
  String get settingsTileCannedMessagesSubtitle;

  /// Title of the canned messages module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Canned Messages Module'**
  String get settingsTileCannedMessagesTitle;

  /// Subtitle of the channel messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Notify for channel broadcasts'**
  String get settingsTileChannelMessagesSubtitle;

  /// Title of the channel messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Channel messages'**
  String get settingsTileChannelMessagesTitle;

  /// Subtitle of the clear all data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Delete messages, settings, and keys'**
  String get settingsTileClearAllDataSubtitle;

  /// Title of the clear all data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Clear all data'**
  String get settingsTileClearAllDataTitle;

  /// Subtitle of the clear message history settings tile.
  ///
  /// In en, this message translates to:
  /// **'Delete all stored messages'**
  String get settingsTileClearMessageHistorySubtitle;

  /// Title of the clear message history settings tile.
  ///
  /// In en, this message translates to:
  /// **'Clear message history'**
  String get settingsTileClearMessageHistoryTitle;

  /// Subtitle of the detection sensor logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'Sensor event history'**
  String get settingsTileDetectionSensorLogsSubtitle;

  /// Title of the detection sensor logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'Detection Sensor Logs'**
  String get settingsTileDetectionSensorLogsTitle;

  /// Subtitle of the detection sensor module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure GPIO-based motion/door sensors'**
  String get settingsTileDetectionSensorSubtitle;

  /// Title of the detection sensor module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Detection Sensor'**
  String get settingsTileDetectionSensorTitle;

  /// Subtitle of the device info settings tile.
  ///
  /// In en, this message translates to:
  /// **'View connected device details'**
  String get settingsTileDeviceInfoSubtitle;

  /// Title of the device info settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device info'**
  String get settingsTileDeviceInfoTitle;

  /// Subtitle of the device management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Reboot, shutdown, factory reset'**
  String get settingsTileDeviceManagementSubtitle;

  /// Title of the device management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device Management'**
  String get settingsTileDeviceManagementTitle;

  /// Subtitle of the device metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Battery, voltage, utilization history'**
  String get settingsTileDeviceMetricsSubtitle;

  /// Title of the device metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get settingsTileDeviceMetricsTitle;

  /// Subtitle of the device role settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure device behavior and role'**
  String get settingsTileDeviceRoleSubtitle;

  /// Title of the device role settings tile.
  ///
  /// In en, this message translates to:
  /// **'Device Role & Settings'**
  String get settingsTileDeviceRoleTitle;

  /// Subtitle of the direct messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Notify for private messages'**
  String get settingsTileDirectMessagesSubtitle;

  /// Title of the direct messages notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Direct messages'**
  String get settingsTileDirectMessagesTitle;

  /// Subtitle of the display settings tile.
  ///
  /// In en, this message translates to:
  /// **'Screen timeout, units, display mode'**
  String get settingsTileDisplaySettingsSubtitle;

  /// Title of the display settings tile.
  ///
  /// In en, this message translates to:
  /// **'Display Settings'**
  String get settingsTileDisplaySettingsTitle;

  /// Subtitle of the environment metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Temperature, humidity, pressure logs'**
  String get settingsTileEnvironmentMetricsSubtitle;

  /// Title of the environment metrics telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Environment Metrics'**
  String get settingsTileEnvironmentMetricsTitle;

  /// Subtitle of the export data tools tile.
  ///
  /// In en, this message translates to:
  /// **'Export messages, telemetry, routes'**
  String get settingsTileExportDataSubtitle;

  /// Title of the export data tools tile.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get settingsTileExportDataTitle;

  /// Subtitle of the export messages settings tile.
  ///
  /// In en, this message translates to:
  /// **'Export messages to PDF or CSV'**
  String get settingsTileExportMessagesSubtitle;

  /// Title of the export messages settings tile.
  ///
  /// In en, this message translates to:
  /// **'Export Messages'**
  String get settingsTileExportMessagesTitle;

  /// Subtitle of the external notification module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure buzzers, LEDs, and vibration alerts'**
  String get settingsTileExternalNotificationSubtitle;

  /// Title of the external notification module settings tile.
  ///
  /// In en, this message translates to:
  /// **'External Notification'**
  String get settingsTileExternalNotificationTitle;

  /// Subtitle of the firmware update tools tile.
  ///
  /// In en, this message translates to:
  /// **'Check for device firmware updates'**
  String get settingsTileFirmwareUpdateSubtitle;

  /// Title of the firmware update tools tile.
  ///
  /// In en, this message translates to:
  /// **'Firmware Update'**
  String get settingsTileFirmwareUpdateTitle;

  /// Subtitle of the force sync settings tile.
  ///
  /// In en, this message translates to:
  /// **'Re-sync all data from connected device'**
  String get settingsTileForceSyncSubtitle;

  /// Title of the force sync settings tile.
  ///
  /// In en, this message translates to:
  /// **'Force Sync'**
  String get settingsTileForceSyncTitle;

  /// Subtitle of the glyph matrix test tile.
  ///
  /// In en, this message translates to:
  /// **'Nothing Phone 3 LED patterns'**
  String get settingsTileGlyphMatrixSubtitle;

  /// Title of the glyph matrix test tile (Nothing Phone 3 only).
  ///
  /// In en, this message translates to:
  /// **'Glyph Matrix Test'**
  String get settingsTileGlyphMatrixTitle;

  /// Subtitle of the GPS status tools tile.
  ///
  /// In en, this message translates to:
  /// **'View detailed GPS information'**
  String get settingsTileGpsStatusSubtitle;

  /// Title of the GPS status tools tile.
  ///
  /// In en, this message translates to:
  /// **'GPS Status'**
  String get settingsTileGpsStatusTitle;

  /// Subtitle of the haptic feedback toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Vibration feedback for interactions'**
  String get settingsTileHapticFeedbackSubtitle;

  /// Title of the haptic feedback toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Haptic feedback'**
  String get settingsTileHapticFeedbackTitle;

  /// Subtitle of the Help Center tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Interactive guides with Ico, your mesh guide'**
  String get settingsTileHelpCenterSubtitle;

  /// Title of the Help Center tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get settingsTileHelpCenterTitle;

  /// Subtitle of the Help & Support tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'FAQ, troubleshooting, and contact info'**
  String get settingsTileHelpSupportSubtitle;

  /// Title of the Help & Support tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get settingsTileHelpSupportTitle;

  /// Title of the haptic intensity tile (shown when haptic feedback is enabled).
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get settingsTileIntensityTitle;

  /// Subtitle of the list animations toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Slide and bounce effects on lists'**
  String get settingsTileListAnimationsSubtitle;

  /// Title of the list animations toggle tile.
  ///
  /// In en, this message translates to:
  /// **'List animations'**
  String get settingsTileListAnimationsTitle;

  /// Subtitle of the message history limit tile showing the current limit.
  ///
  /// In en, this message translates to:
  /// **'{count} messages stored'**
  String settingsTileMessageHistorySubtitle(int count);

  /// Title of the message history limit settings tile.
  ///
  /// In en, this message translates to:
  /// **'Message history'**
  String get settingsTileMessageHistoryTitle;

  /// Subtitle of the MQTT module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure mesh-to-internet bridge'**
  String get settingsTileMqttSubtitle;

  /// Title of the MQTT module settings tile.
  ///
  /// In en, this message translates to:
  /// **'MQTT'**
  String get settingsTileMqttTitle;

  /// Subtitle of the my bug reports tile when the user is not signed in.
  ///
  /// In en, this message translates to:
  /// **'Sign in to track your reports and receive replies'**
  String get settingsTileMyBugReportsNotSignedIn;

  /// Subtitle of the my bug reports tile (when signed in).
  ///
  /// In en, this message translates to:
  /// **'View your reports and responses'**
  String get settingsTileMyBugReportsSubtitle;

  /// Title of the my bug reports settings tile.
  ///
  /// In en, this message translates to:
  /// **'My bug reports'**
  String get settingsTileMyBugReportsTitle;

  /// Subtitle of the network settings tile.
  ///
  /// In en, this message translates to:
  /// **'WiFi, Ethernet, NTP settings'**
  String get settingsTileNetworkSubtitle;

  /// Title of the network settings tile.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get settingsTileNetworkTitle;

  /// Subtitle of the new-nodes notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Notify when new nodes join the mesh'**
  String get settingsTileNewNodesSubtitle;

  /// Title of the new-nodes notification toggle tile.
  ///
  /// In en, this message translates to:
  /// **'New nodes'**
  String get settingsTileNewNodesTitle;

  /// Subtitle of the Open Source Licenses tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Third-party libraries and attributions'**
  String get settingsTileOpenSourceSubtitle;

  /// Title of the Open Source Licenses tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Open Source Licenses'**
  String get settingsTileOpenSourceTitle;

  /// Subtitle of the PAX counter logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'Device detection history'**
  String get settingsTilePaxCounterLogsSubtitle;

  /// Title of the PAX counter logs telemetry tile.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter Logs'**
  String get settingsTilePaxCounterLogsTitle;

  /// Subtitle of the PAX counter module settings tile.
  ///
  /// In en, this message translates to:
  /// **'WiFi/BLE device detection settings'**
  String get settingsTilePaxCounterSubtitle;

  /// Title of the PAX counter module settings tile.
  ///
  /// In en, this message translates to:
  /// **'PAX Counter'**
  String get settingsTilePaxCounterTitle;

  /// Subtitle of the position history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'GPS position logs'**
  String get settingsTilePositionHistorySubtitle;

  /// Title of the position history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Position History'**
  String get settingsTilePositionHistoryTitle;

  /// Subtitle of the position & GPS settings tile.
  ///
  /// In en, this message translates to:
  /// **'GPS mode, broadcast intervals, fixed position'**
  String get settingsTilePositionSubtitle;

  /// Title of the position & GPS settings tile.
  ///
  /// In en, this message translates to:
  /// **'Position & GPS'**
  String get settingsTilePositionTitle;

  /// Subtitle of the power management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Power saving, sleep settings'**
  String get settingsTilePowerManagementSubtitle;

  /// Title of the power management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Power Management'**
  String get settingsTilePowerManagementTitle;

  /// Subtitle of the Privacy Policy tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'How we handle your data'**
  String get settingsTilePrivacyPolicySubtitle;

  /// Title of the Privacy Policy tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsTilePrivacyPolicyTitle;

  /// Subtitle of the Privacy settings tile in the Account section.
  ///
  /// In en, this message translates to:
  /// **'Analytics, crash reporting, and data controls'**
  String get settingsTilePrivacySubtitle;

  /// Title of the Privacy settings tile in the Account section.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsTilePrivacyTitle;

  /// Subtitle of the provide phone location settings tile.
  ///
  /// In en, this message translates to:
  /// **'Send phone GPS to mesh for devices without GPS hardware'**
  String get settingsTileProvideLocationSubtitle;

  /// Title of the provide phone location settings tile.
  ///
  /// In en, this message translates to:
  /// **'Provide phone location'**
  String get settingsTileProvideLocationTitle;

  /// Subtitle of the push notifications master toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Master toggle for all notifications'**
  String get settingsTilePushNotificationsSubtitle;

  /// Title of the push notifications master toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settingsTilePushNotificationsTitle;

  /// Subtitle of the quick responses settings tile.
  ///
  /// In en, this message translates to:
  /// **'Manage canned responses for fast messaging'**
  String get settingsTileQuickResponsesSubtitle;

  /// Title of the quick responses settings tile.
  ///
  /// In en, this message translates to:
  /// **'Quick responses'**
  String get settingsTileQuickResponsesTitle;

  /// Subtitle of the radio configuration settings tile.
  ///
  /// In en, this message translates to:
  /// **'LoRa settings, modem preset, power'**
  String get settingsTileRadioConfigSubtitle;

  /// Title of the radio configuration settings tile.
  ///
  /// In en, this message translates to:
  /// **'Radio Configuration'**
  String get settingsTileRadioConfigTitle;

  /// Subtitle of the range test module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Test signal range with other nodes'**
  String get settingsTileRangeTestSubtitle;

  /// Title of the range test module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Range Test'**
  String get settingsTileRangeTestTitle;

  /// Title of the region/frequency settings tile.
  ///
  /// In en, this message translates to:
  /// **'Region / Frequency'**
  String get settingsTileRegionTitle;

  /// Subtitle of the reset local data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Clear messages and nodes, keep settings'**
  String get settingsTileResetLocalDataSubtitle;

  /// Title of the reset local data settings tile.
  ///
  /// In en, this message translates to:
  /// **'Reset local data'**
  String get settingsTileResetLocalDataTitle;

  /// Subtitle of the routes tools tile.
  ///
  /// In en, this message translates to:
  /// **'Record and manage GPS routes'**
  String get settingsTileRoutesSubtitle;

  /// Title of the routes tools tile.
  ///
  /// In en, this message translates to:
  /// **'Routes'**
  String get settingsTileRoutesTitle;

  /// Subtitle of the scan QR code settings tile.
  ///
  /// In en, this message translates to:
  /// **'Import nodes, channels, or automations'**
  String get settingsTileScanQrCodeSubtitle;

  /// Title of the scan QR code settings tile.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get settingsTileScanQrCodeTitle;

  /// Subtitle of the security settings tile.
  ///
  /// In en, this message translates to:
  /// **'Access controls, managed mode'**
  String get settingsTileSecuritySubtitle;

  /// Title of the security settings tile.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsTileSecurityTitle;

  /// Subtitle of the serial module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Serial port configuration'**
  String get settingsTileSerialSubtitle;

  /// Title of the serial module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Serial'**
  String get settingsTileSerialTitle;

  /// Subtitle of the shake-to-report settings tile.
  ///
  /// In en, this message translates to:
  /// **'Shake your device to open the bug report flow'**
  String get settingsTileShakeToReportSubtitle;

  /// Title of the shake-to-report settings tile.
  ///
  /// In en, this message translates to:
  /// **'Shake to report a bug'**
  String get settingsTileShakeToReportTitle;

  /// Subtitle of the Socialmesh about tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Meshtastic companion app'**
  String get settingsTileSocialmeshSubtitle;

  /// Title of the Socialmesh about tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Socialmesh'**
  String get settingsTileSocialmeshTitle;

  /// Subtitle of the notification sound toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Play sound with notifications'**
  String get settingsTileSoundSubtitle;

  /// Title of the notification sound toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get settingsTileSoundTitle;

  /// Subtitle of the store & forward module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Store and relay messages for offline nodes'**
  String get settingsTileStoreForwardSubtitle;

  /// Title of the store & forward module settings tile.
  ///
  /// In en, this message translates to:
  /// **'Store & Forward'**
  String get settingsTileStoreForwardTitle;

  /// Subtitle of the telemetry intervals settings tile.
  ///
  /// In en, this message translates to:
  /// **'Configure telemetry update frequency'**
  String get settingsTileTelemetryIntervalsSubtitle;

  /// Title of the telemetry intervals settings tile.
  ///
  /// In en, this message translates to:
  /// **'Telemetry Intervals'**
  String get settingsTileTelemetryIntervalsTitle;

  /// Subtitle of the Terms of Service tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Legal terms and conditions'**
  String get settingsTileTermsOfServiceSubtitle;

  /// Title of the Terms of Service tile in the About section.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get settingsTileTermsOfServiceTitle;

  /// Subtitle of the traceroute history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Network path analysis logs'**
  String get settingsTileTracerouteHistorySubtitle;

  /// Title of the traceroute history telemetry log tile.
  ///
  /// In en, this message translates to:
  /// **'Traceroute History'**
  String get settingsTileTracerouteHistoryTitle;

  /// Subtitle of the traffic management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Mesh traffic optimization and filtering'**
  String get settingsTileTrafficManagementSubtitle;

  /// Title of the traffic management settings tile.
  ///
  /// In en, this message translates to:
  /// **'Traffic Management'**
  String get settingsTileTrafficManagementTitle;

  /// Subtitle of the notification vibration toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Vibrate with notifications'**
  String get settingsTileVibrationSubtitle;

  /// Title of the notification vibration toggle tile.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsTileVibrationTitle;

  /// Subtitle of the what's new settings tile.
  ///
  /// In en, this message translates to:
  /// **'Browse recent features and updates'**
  String get settingsTileWhatsNewSubtitle;

  /// Title of the what's new settings tile.
  ///
  /// In en, this message translates to:
  /// **'What’s New'**
  String get settingsTileWhatsNewTitle;

  /// Title of the settings screen.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Empty state subtitle in the settings search results.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term'**
  String get settingsTryDifferentSearch;

  /// App version label in the About section.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsVersionString(String version);

  /// No description provided for @shopAdminDashboardAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get shopAdminDashboardAccessDenied;

  /// No description provided for @shopAdminDashboardAccessRequired.
  ///
  /// In en, this message translates to:
  /// **'Admin Access Required'**
  String get shopAdminDashboardAccessRequired;

  /// No description provided for @shopAdminDashboardActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String shopAdminDashboardActiveCount(int count);

  /// No description provided for @shopAdminDashboardAddProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get shopAdminDashboardAddProduct;

  /// No description provided for @shopAdminDashboardAddSeller.
  ///
  /// In en, this message translates to:
  /// **'Add Seller'**
  String get shopAdminDashboardAddSeller;

  /// No description provided for @shopAdminDashboardError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get shopAdminDashboardError;

  /// No description provided for @shopAdminDashboardEstRevenue.
  ///
  /// In en, this message translates to:
  /// **'Est. Revenue'**
  String get shopAdminDashboardEstRevenue;

  /// No description provided for @shopAdminDashboardFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured Products'**
  String get shopAdminDashboardFeatured;

  /// No description provided for @shopAdminDashboardFeaturedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage featured product display order'**
  String get shopAdminDashboardFeaturedSubtitle;

  /// No description provided for @shopAdminDashboardInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get shopAdminDashboardInactive;

  /// No description provided for @shopAdminDashboardManagement.
  ///
  /// In en, this message translates to:
  /// **'Management'**
  String get shopAdminDashboardManagement;

  /// No description provided for @shopAdminDashboardNoPermission.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access this area.'**
  String get shopAdminDashboardNoPermission;

  /// No description provided for @shopAdminDashboardOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get shopAdminDashboardOutOfStock;

  /// No description provided for @shopAdminDashboardProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get shopAdminDashboardProducts;

  /// No description provided for @shopAdminDashboardProductsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage all product listings'**
  String get shopAdminDashboardProductsSubtitle;

  /// No description provided for @shopAdminDashboardQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get shopAdminDashboardQuickActions;

  /// No description provided for @shopAdminDashboardRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get shopAdminDashboardRefresh;

  /// No description provided for @shopAdminDashboardReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get shopAdminDashboardReviews;

  /// No description provided for @shopAdminDashboardReviewsMgmt.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get shopAdminDashboardReviewsMgmt;

  /// No description provided for @shopAdminDashboardReviewsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Moderate product reviews'**
  String get shopAdminDashboardReviewsSubtitle;

  /// No description provided for @shopAdminDashboardSellers.
  ///
  /// In en, this message translates to:
  /// **'Sellers'**
  String get shopAdminDashboardSellers;

  /// No description provided for @shopAdminDashboardSellersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage seller profiles and partnerships'**
  String get shopAdminDashboardSellersSubtitle;

  /// No description provided for @shopAdminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Shop Admin'**
  String get shopAdminDashboardTitle;

  /// No description provided for @shopAdminDashboardTotalProducts.
  ///
  /// In en, this message translates to:
  /// **'Total Products'**
  String get shopAdminDashboardTotalProducts;

  /// No description provided for @shopAdminDashboardTotalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get shopAdminDashboardTotalSales;

  /// No description provided for @shopAdminDashboardTotalSellers.
  ///
  /// In en, this message translates to:
  /// **'Total Sellers'**
  String get shopAdminDashboardTotalSellers;

  /// No description provided for @shopAdminDashboardTotalViews.
  ///
  /// In en, this message translates to:
  /// **'Total Views'**
  String get shopAdminDashboardTotalViews;

  /// No description provided for @shopFavoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get shopFavoritesEmpty;

  /// No description provided for @shopFavoritesEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on products to save them'**
  String get shopFavoritesEmptySubtitle;

  /// No description provided for @shopFavoritesErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading favorites'**
  String get shopFavoritesErrorLoading;

  /// No description provided for @shopFavoritesInStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get shopFavoritesInStock;

  /// No description provided for @shopFavoritesOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get shopFavoritesOutOfStock;

  /// No description provided for @shopFavoritesProductRemoved.
  ///
  /// In en, this message translates to:
  /// **'Product no longer available'**
  String get shopFavoritesProductRemoved;

  /// No description provided for @shopFavoritesRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get shopFavoritesRetry;

  /// No description provided for @shopFavoritesSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save favorites'**
  String get shopFavoritesSignIn;

  /// No description provided for @shopFavoritesSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your favorite devices will appear here'**
  String get shopFavoritesSignInSubtitle;

  /// No description provided for @shopFavoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get shopFavoritesTitle;

  /// No description provided for @shopFavoritesUnableToLoad.
  ///
  /// In en, this message translates to:
  /// **'Unable to load product'**
  String get shopFavoritesUnableToLoad;

  /// No description provided for @shopModelBandAu915.
  ///
  /// In en, this message translates to:
  /// **'AU 915MHz'**
  String get shopModelBandAu915;

  /// No description provided for @shopModelBandAu915Range.
  ///
  /// In en, this message translates to:
  /// **'915-928 MHz'**
  String get shopModelBandAu915Range;

  /// No description provided for @shopModelBandCn470.
  ///
  /// In en, this message translates to:
  /// **'CN 470MHz'**
  String get shopModelBandCn470;

  /// No description provided for @shopModelBandCn470Range.
  ///
  /// In en, this message translates to:
  /// **'470-510 MHz'**
  String get shopModelBandCn470Range;

  /// No description provided for @shopModelBandEu868.
  ///
  /// In en, this message translates to:
  /// **'EU 868MHz'**
  String get shopModelBandEu868;

  /// No description provided for @shopModelBandEu868Range.
  ///
  /// In en, this message translates to:
  /// **'863-870 MHz'**
  String get shopModelBandEu868Range;

  /// No description provided for @shopModelBandIn865.
  ///
  /// In en, this message translates to:
  /// **'IN 865MHz'**
  String get shopModelBandIn865;

  /// No description provided for @shopModelBandIn865Range.
  ///
  /// In en, this message translates to:
  /// **'865-867 MHz'**
  String get shopModelBandIn865Range;

  /// No description provided for @shopModelBandJp920.
  ///
  /// In en, this message translates to:
  /// **'JP 920MHz'**
  String get shopModelBandJp920;

  /// No description provided for @shopModelBandJp920Range.
  ///
  /// In en, this message translates to:
  /// **'920-925 MHz'**
  String get shopModelBandJp920Range;

  /// No description provided for @shopModelBandKr920.
  ///
  /// In en, this message translates to:
  /// **'KR 920MHz'**
  String get shopModelBandKr920;

  /// No description provided for @shopModelBandKr920Range.
  ///
  /// In en, this message translates to:
  /// **'920-923 MHz'**
  String get shopModelBandKr920Range;

  /// No description provided for @shopModelBandMulti.
  ///
  /// In en, this message translates to:
  /// **'Multi-band'**
  String get shopModelBandMulti;

  /// No description provided for @shopModelBandMultiRange.
  ///
  /// In en, this message translates to:
  /// **'Multiple frequencies'**
  String get shopModelBandMultiRange;

  /// No description provided for @shopModelBandUs915.
  ///
  /// In en, this message translates to:
  /// **'US 915MHz'**
  String get shopModelBandUs915;

  /// No description provided for @shopModelBandUs915Range.
  ///
  /// In en, this message translates to:
  /// **'902-928 MHz'**
  String get shopModelBandUs915Range;

  /// No description provided for @shopModelCategoryAccessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get shopModelCategoryAccessories;

  /// No description provided for @shopModelCategoryAccessoriesDescription.
  ///
  /// In en, this message translates to:
  /// **'Cables, batteries, and more'**
  String get shopModelCategoryAccessoriesDescription;

  /// No description provided for @shopModelCategoryAntennas.
  ///
  /// In en, this message translates to:
  /// **'Antennas'**
  String get shopModelCategoryAntennas;

  /// No description provided for @shopModelCategoryAntennasDescription.
  ///
  /// In en, this message translates to:
  /// **'Antennas and RF accessories'**
  String get shopModelCategoryAntennasDescription;

  /// No description provided for @shopModelCategoryEnclosures.
  ///
  /// In en, this message translates to:
  /// **'Enclosures'**
  String get shopModelCategoryEnclosures;

  /// No description provided for @shopModelCategoryEnclosuresDescription.
  ///
  /// In en, this message translates to:
  /// **'Cases and enclosures'**
  String get shopModelCategoryEnclosuresDescription;

  /// No description provided for @shopModelCategoryKits.
  ///
  /// In en, this message translates to:
  /// **'Kits'**
  String get shopModelCategoryKits;

  /// No description provided for @shopModelCategoryKitsDescription.
  ///
  /// In en, this message translates to:
  /// **'DIY kits and bundles'**
  String get shopModelCategoryKitsDescription;

  /// No description provided for @shopModelCategoryModules.
  ///
  /// In en, this message translates to:
  /// **'Modules'**
  String get shopModelCategoryModules;

  /// No description provided for @shopModelCategoryModulesDescription.
  ///
  /// In en, this message translates to:
  /// **'Add-on modules and boards'**
  String get shopModelCategoryModulesDescription;

  /// No description provided for @shopModelCategoryNodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get shopModelCategoryNodes;

  /// No description provided for @shopModelCategoryNodesDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete Meshtastic devices'**
  String get shopModelCategoryNodesDescription;

  /// No description provided for @shopModelCategorySolar.
  ///
  /// In en, this message translates to:
  /// **'Solar'**
  String get shopModelCategorySolar;

  /// No description provided for @shopModelCategorySolarDescription.
  ///
  /// In en, this message translates to:
  /// **'Solar panels and power solutions'**
  String get shopModelCategorySolarDescription;

  /// No description provided for @shopModelPriceFrom.
  ///
  /// In en, this message translates to:
  /// **'From \${price}'**
  String shopModelPriceFrom(String price);

  /// No description provided for @sigilStageHeraldic.
  ///
  /// In en, this message translates to:
  /// **'Heraldic'**
  String get sigilStageHeraldic;

  /// No description provided for @sigilStageInscribed.
  ///
  /// In en, this message translates to:
  /// **'Inscribed'**
  String get sigilStageInscribed;

  /// No description provided for @sigilStageLegacy.
  ///
  /// In en, this message translates to:
  /// **'Legacy'**
  String get sigilStageLegacy;

  /// No description provided for @sigilStageMarked.
  ///
  /// In en, this message translates to:
  /// **'Marked'**
  String get sigilStageMarked;

  /// No description provided for @sigilStageSeed.
  ///
  /// In en, this message translates to:
  /// **'Seed'**
  String get sigilStageSeed;

  /// No description provided for @signalAcquiringDeviceLocation.
  ///
  /// In en, this message translates to:
  /// **'Acquiring device location...'**
  String get signalAcquiringDeviceLocation;

  /// No description provided for @signalActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 signal} other{{count} signals}} active'**
  String signalActiveCount(int count);

  /// No description provided for @signalActiveDays.
  ///
  /// In en, this message translates to:
  /// **'Active {days}d'**
  String signalActiveDays(int days);

  /// No description provided for @signalActiveHours.
  ///
  /// In en, this message translates to:
  /// **'Active {hours}h'**
  String signalActiveHours(int hours);

  /// No description provided for @signalActiveMinutes.
  ///
  /// In en, this message translates to:
  /// **'Active {minutes}m'**
  String signalActiveMinutes(int minutes);

  /// No description provided for @signalActiveNow.
  ///
  /// In en, this message translates to:
  /// **'Active now'**
  String get signalActiveNow;

  /// No description provided for @signalAddLocation.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get signalAddLocation;

  /// No description provided for @signalAddPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add Photos'**
  String get signalAddPhotos;

  /// No description provided for @signalAnonAuthor.
  ///
  /// In en, this message translates to:
  /// **'Anon'**
  String get signalAnonAuthor;

  /// No description provided for @signalAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get signalAnonymous;

  /// No description provided for @signalAnonymousAuthor.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get signalAnonymousAuthor;

  /// No description provided for @signalAnonymousFeed.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get signalAnonymousFeed;

  /// No description provided for @signalApproxArea.
  ///
  /// In en, this message translates to:
  /// **'Approx. area (~{radiusMeters}m)'**
  String signalApproxArea(int radiusMeters);

  /// No description provided for @signalAttachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach file'**
  String get signalAttachFile;

  /// No description provided for @signalBackNearby.
  ///
  /// In en, this message translates to:
  /// **'Back nearby'**
  String get signalBackNearby;

  /// No description provided for @signalBeFirstToRespond.
  ///
  /// In en, this message translates to:
  /// **'Be the first to respond to this signal'**
  String get signalBeFirstToRespond;

  /// No description provided for @signalBleNoMeshTrafficIos.
  ///
  /// In en, this message translates to:
  /// **'Connected to BLE but no mesh traffic detected. On iOS, Airplane Mode can block BLE traffic even when connected. Turn off Airplane Mode or toggle Bluetooth.'**
  String get signalBleNoMeshTrafficIos;

  /// No description provided for @signalBroadcastYourSignal.
  ///
  /// In en, this message translates to:
  /// **'Broadcast your signal'**
  String get signalBroadcastYourSignal;

  /// No description provided for @signalBroadcastingOverMesh.
  ///
  /// In en, this message translates to:
  /// **'Broadcasting over mesh...'**
  String get signalBroadcastingOverMesh;

  /// No description provided for @signalCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get signalCancel;

  /// No description provided for @signalChooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get signalChooseFromGallery;

  /// No description provided for @signalCloudBadge.
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get signalCloudBadge;

  /// No description provided for @signalCloudFeaturesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Cloud features unavailable.'**
  String get signalCloudFeaturesUnavailable;

  /// No description provided for @signalCommentCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 comment} other{{count} comments}}'**
  String signalCommentCount(int count);

  /// No description provided for @signalCommentReported.
  ///
  /// In en, this message translates to:
  /// **'Comment reported. Thank you.'**
  String get signalCommentReported;

  /// No description provided for @signalConnectToAddLocation.
  ///
  /// In en, this message translates to:
  /// **'Connect a device to add location to your signal.'**
  String get signalConnectToAddLocation;

  /// No description provided for @signalConnectToGoActive.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to go active'**
  String get signalConnectToGoActive;

  /// No description provided for @signalConnectToSend.
  ///
  /// In en, this message translates to:
  /// **'Connect to a device to send signals'**
  String get signalConnectToSend;

  /// No description provided for @signalConversation.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get signalConversation;

  /// No description provided for @signalCreateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create signal'**
  String get signalCreateFailed;

  /// No description provided for @signalCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get signalCurrentLocation;

  /// No description provided for @signalDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get signalDelete;

  /// No description provided for @signalDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This signal will fade immediately.'**
  String get signalDeleteMessage;

  /// No description provided for @signalDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Signal?'**
  String get signalDeleteTitle;

  /// No description provided for @signalDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get signalDetailTitle;

  /// No description provided for @signalDeviceNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Device not connected'**
  String get signalDeviceNotConnected;

  /// No description provided for @signalDiscardConfirm.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get signalDiscardConfirm;

  /// No description provided for @signalDiscardMessage.
  ///
  /// In en, this message translates to:
  /// **'Your draft will be lost.'**
  String get signalDiscardMessage;

  /// No description provided for @signalDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard signal?'**
  String get signalDiscardTitle;

  /// No description provided for @signalDuration.
  ///
  /// In en, this message translates to:
  /// **'Signal Duration'**
  String get signalDuration;

  /// No description provided for @signalDurationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How long until your signal fades'**
  String get signalDurationSubtitle;

  /// No description provided for @signalEmptyTagline1.
  ///
  /// In en, this message translates to:
  /// **'Nothing active here right now.\nSignals appear when someone nearby goes active.'**
  String get signalEmptyTagline1;

  /// No description provided for @signalEmptyTagline2.
  ///
  /// In en, this message translates to:
  /// **'Signals are mesh-first and ephemeral.\nThey dissolve when their timer ends.'**
  String get signalEmptyTagline2;

  /// No description provided for @signalEmptyTagline3.
  ///
  /// In en, this message translates to:
  /// **'Share a quick status or photo.\nNearby nodes will see it in real time.'**
  String get signalEmptyTagline3;

  /// No description provided for @signalEmptyTagline4.
  ///
  /// In en, this message translates to:
  /// **'Go active to broadcast your presence.\nOff-grid, device to device.'**
  String get signalEmptyTagline4;

  /// No description provided for @signalEmptyTitleKeyword.
  ///
  /// In en, this message translates to:
  /// **'signals'**
  String get signalEmptyTitleKeyword;

  /// No description provided for @signalEmptyTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'No active '**
  String get signalEmptyTitlePrefix;

  /// No description provided for @signalEmptyTitleSuffix.
  ///
  /// In en, this message translates to:
  /// **' nearby'**
  String get signalEmptyTitleSuffix;

  /// No description provided for @signalEnableGpsOrFixedPosition.
  ///
  /// In en, this message translates to:
  /// **'Device has no location yet. Enable GPS or set a fixed position.'**
  String get signalEnableGpsOrFixedPosition;

  /// No description provided for @signalExpiredBadge.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get signalExpiredBadge;

  /// No description provided for @signalFaded.
  ///
  /// In en, this message translates to:
  /// **'Faded'**
  String get signalFaded;

  /// No description provided for @signalFadesIn.
  ///
  /// In en, this message translates to:
  /// **'Fades in'**
  String get signalFadesIn;

  /// No description provided for @signalFadesInDays.
  ///
  /// In en, this message translates to:
  /// **'Fades in {days}d'**
  String signalFadesInDays(int days);

  /// No description provided for @signalFadesInHours.
  ///
  /// In en, this message translates to:
  /// **'Fades in {hours}h'**
  String signalFadesInHours(int hours);

  /// No description provided for @signalFadesInMinutes.
  ///
  /// In en, this message translates to:
  /// **'Fades in {minutes}m'**
  String signalFadesInMinutes(int minutes);

  /// No description provided for @signalFadesInMinutesSeconds.
  ///
  /// In en, this message translates to:
  /// **'Fades in {minutes}m {seconds}s'**
  String signalFadesInMinutesSeconds(int minutes, int seconds);

  /// No description provided for @signalFadesInSeconds.
  ///
  /// In en, this message translates to:
  /// **'Fades in {seconds}s'**
  String signalFadesInSeconds(int seconds);

  /// No description provided for @signalFallbackContent.
  ///
  /// In en, this message translates to:
  /// **'Signal'**
  String get signalFallbackContent;

  /// No description provided for @signalFileTooLarge.
  ///
  /// In en, this message translates to:
  /// **'File too large. Mesh transfer is limited to {size} KB.'**
  String signalFileTooLarge(int size);

  /// No description provided for @signalFileTransferFailed.
  ///
  /// In en, this message translates to:
  /// **'File transfer failed to start'**
  String get signalFileTransferFailed;

  /// No description provided for @signalFileTransfers.
  ///
  /// In en, this message translates to:
  /// **'File Transfers'**
  String get signalFileTransfers;

  /// No description provided for @signalFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get signalFilterAll;

  /// No description provided for @signalFilterExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring'**
  String get signalFilterExpiring;

  /// No description provided for @signalFilterHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get signalFilterHidden;

  /// No description provided for @signalFilterLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get signalFilterLocation;

  /// No description provided for @signalFilterMedia.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get signalFilterMedia;

  /// No description provided for @signalFilterMesh.
  ///
  /// In en, this message translates to:
  /// **'Mesh'**
  String get signalFilterMesh;

  /// No description provided for @signalFilterNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get signalFilterNearby;

  /// No description provided for @signalFilterReplies.
  ///
  /// In en, this message translates to:
  /// **'Replies'**
  String get signalFilterReplies;

  /// No description provided for @signalFilterSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get signalFilterSaved;

  /// No description provided for @signalFitAllSignals.
  ///
  /// In en, this message translates to:
  /// **'Fit all signals'**
  String get signalFitAllSignals;

  /// No description provided for @signalGetLocationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location'**
  String get signalGetLocationFailed;

  /// No description provided for @signalGoActive.
  ///
  /// In en, this message translates to:
  /// **'Go Active'**
  String get signalGoActive;

  /// No description provided for @signalGoActiveAction.
  ///
  /// In en, this message translates to:
  /// **'Go Active'**
  String get signalGoActiveAction;

  /// No description provided for @signalHasFaded.
  ///
  /// In en, this message translates to:
  /// **'This signal has faded'**
  String get signalHasFaded;

  /// No description provided for @signalHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get signalHelp;

  /// No description provided for @signalHidden.
  ///
  /// In en, this message translates to:
  /// **'Signal hidden'**
  String get signalHidden;

  /// No description provided for @signalHide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get signalHide;

  /// No description provided for @signalHopSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} hop'**
  String signalHopSingular(int count);

  /// No description provided for @signalHopsBadge.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hop} other{{count} hops}}'**
  String signalHopsBadge(int count);

  /// No description provided for @signalHopsPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} hops'**
  String signalHopsPlural(int count);

  /// No description provided for @signalImageBlockedSingular.
  ///
  /// In en, this message translates to:
  /// **'Image violates content guidelines and was blocked'**
  String get signalImageBlockedSingular;

  /// No description provided for @signalImagesAddedCount.
  ///
  /// In en, this message translates to:
  /// **'{passedCount} images added'**
  String signalImagesAddedCount(int passedCount);

  /// No description provided for @signalImagesBlockedAndAdded.
  ///
  /// In en, this message translates to:
  /// **'{failedCount} image(s) blocked, {passedCount} added'**
  String signalImagesBlockedAndAdded(int failedCount, int passedCount);

  /// No description provided for @signalImagesBlockedPlural.
  ///
  /// In en, this message translates to:
  /// **'{failedCount} images blocked by content guidelines'**
  String signalImagesBlockedPlural(int failedCount);

  /// No description provided for @signalImagesHiddenOffline.
  ///
  /// In en, this message translates to:
  /// **'Images hidden while offline. They will return when back online.'**
  String get signalImagesHiddenOffline;

  /// No description provided for @signalImagesRequireInternet.
  ///
  /// In en, this message translates to:
  /// **'Images require internet. Images removed.'**
  String get signalImagesRequireInternet;

  /// No description provided for @signalImagesRestored.
  ///
  /// In en, this message translates to:
  /// **'Images restored!'**
  String get signalImagesRestored;

  /// No description provided for @signalIntentLabel.
  ///
  /// In en, this message translates to:
  /// **'Intent'**
  String get signalIntentLabel;

  /// No description provided for @signalIosAirplaneModeWarning.
  ///
  /// In en, this message translates to:
  /// **'iOS Airplane Mode can pause BLE mesh traffic even when connected. If signals stop, turn off Airplane Mode or toggle Bluetooth.'**
  String get signalIosAirplaneModeWarning;

  /// No description provided for @signalKeepEditing.
  ///
  /// In en, this message translates to:
  /// **'Keep editing'**
  String get signalKeepEditing;

  /// No description provided for @signalLegendFiveMin.
  ///
  /// In en, this message translates to:
  /// **'< 5 min'**
  String get signalLegendFiveMin;

  /// No description provided for @signalLegendOverTwoHrs.
  ///
  /// In en, this message translates to:
  /// **'> 2 hrs'**
  String get signalLegendOverTwoHrs;

  /// No description provided for @signalLegendThirtyMin.
  ///
  /// In en, this message translates to:
  /// **'< 30 min'**
  String get signalLegendThirtyMin;

  /// No description provided for @signalLegendTwoHrs.
  ///
  /// In en, this message translates to:
  /// **'< 2 hrs'**
  String get signalLegendTwoHrs;

  /// No description provided for @signalLetOthersKnowIntent.
  ///
  /// In en, this message translates to:
  /// **'Let others know why you\'re active'**
  String get signalLetOthersKnowIntent;

  /// No description provided for @signalLoadingComments.
  ///
  /// In en, this message translates to:
  /// **'Loading comments...'**
  String get signalLoadingComments;

  /// No description provided for @signalLocal.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get signalLocal;

  /// No description provided for @signalLocalBadge.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get signalLocalBadge;

  /// No description provided for @signalLocalBadgeGallery.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get signalLocalBadgeGallery;

  /// No description provided for @signalLocationBadge.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get signalLocationBadge;

  /// No description provided for @signalLocationPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Signal location uses mesh device position, rounded to ~{radiusMeters}m.'**
  String signalLocationPrivacyNote(int radiusMeters);

  /// No description provided for @signalLocationUnavailableSent.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable, sent without location.'**
  String get signalLocationUnavailableSent;

  /// No description provided for @signalMaxFileSize.
  ///
  /// In en, this message translates to:
  /// **'Max {size} KB'**
  String signalMaxFileSize(int size);

  /// No description provided for @signalMaxImagesAllowed.
  ///
  /// In en, this message translates to:
  /// **'Maximum of {maxImages} images allowed'**
  String signalMaxImagesAllowed(int maxImages);

  /// No description provided for @signalMeshOnlyDebugBanner.
  ///
  /// In en, this message translates to:
  /// **'Mesh-only debug mode enabled. Signals use local DB + mesh only.'**
  String get signalMeshOnlyDebugBanner;

  /// No description provided for @signalMeshOnlyDebugCloudDisabled.
  ///
  /// In en, this message translates to:
  /// **'Mesh-only debug mode enabled. Cloud features disabled.'**
  String get signalMeshOnlyDebugCloudDisabled;

  /// No description provided for @signalNoCommentsYet.
  ///
  /// In en, this message translates to:
  /// **'No comments yet'**
  String get signalNoCommentsYet;

  /// No description provided for @signalNoDeviceConnectedTooltip.
  ///
  /// In en, this message translates to:
  /// **'No device connected'**
  String get signalNoDeviceConnectedTooltip;

  /// No description provided for @signalNoDeviceLocation.
  ///
  /// In en, this message translates to:
  /// **'No connected device location available'**
  String get signalNoDeviceLocation;

  /// No description provided for @signalNoFilterMatch.
  ///
  /// In en, this message translates to:
  /// **'No signals match this filter'**
  String get signalNoFilterMatch;

  /// No description provided for @signalNoIntent.
  ///
  /// In en, this message translates to:
  /// **'No intent'**
  String get signalNoIntent;

  /// No description provided for @signalNoLocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Signals will appear here when they include GPS coordinates'**
  String get signalNoLocationDescription;

  /// No description provided for @signalNoLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'No signals with location'**
  String get signalNoLocationTitle;

  /// No description provided for @signalNoSignals.
  ///
  /// In en, this message translates to:
  /// **'No signals'**
  String get signalNoSignals;

  /// No description provided for @signalOfflineCloudUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Offline: images and cloud features unavailable.'**
  String get signalOfflineCloudUnavailable;

  /// No description provided for @signalOnMapCount.
  ///
  /// In en, this message translates to:
  /// **'{count} on map'**
  String signalOnMapCount(int count);

  /// No description provided for @signalOriginCloud.
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get signalOriginCloud;

  /// No description provided for @signalOriginMesh.
  ///
  /// In en, this message translates to:
  /// **'Mesh'**
  String get signalOriginMesh;

  /// No description provided for @signalPeopleActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person} other{{count} people}} active'**
  String signalPeopleActiveCount(int count);

  /// No description provided for @signalProcessingImage.
  ///
  /// In en, this message translates to:
  /// **'Processing image...'**
  String get signalProcessingImage;

  /// No description provided for @signalProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get signalProfile;

  /// No description provided for @signalProximityDirect.
  ///
  /// In en, this message translates to:
  /// **'direct'**
  String get signalProximityDirect;

  /// No description provided for @signalProximityHops.
  ///
  /// In en, this message translates to:
  /// **'{count} hops'**
  String signalProximityHops(int count);

  /// No description provided for @signalProximityNearby.
  ///
  /// In en, this message translates to:
  /// **'nearby'**
  String get signalProximityNearby;

  /// No description provided for @signalProximityOneHop.
  ///
  /// In en, this message translates to:
  /// **'1 hop'**
  String get signalProximityOneHop;

  /// No description provided for @signalRemoveLocation.
  ///
  /// In en, this message translates to:
  /// **'Remove location'**
  String get signalRemoveLocation;

  /// No description provided for @signalRemoveVoteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove vote'**
  String get signalRemoveVoteFailed;

  /// No description provided for @signalRemovedFromSaved.
  ///
  /// In en, this message translates to:
  /// **'Removed from saved'**
  String get signalRemovedFromSaved;

  /// No description provided for @signalReplyAction.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get signalReplyAction;

  /// No description provided for @signalReplyWithCount.
  ///
  /// In en, this message translates to:
  /// **'Reply ({count})'**
  String signalReplyWithCount(int count);

  /// No description provided for @signalReplyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to {author}'**
  String signalReplyingTo(String author);

  /// No description provided for @signalReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get signalReport;

  /// No description provided for @signalReportCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright violation'**
  String get signalReportCopyright;

  /// No description provided for @signalReportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to report: {error}'**
  String signalReportFailed(String error);

  /// No description provided for @signalReportHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment or bullying'**
  String get signalReportHarassment;

  /// No description provided for @signalReportNudity.
  ///
  /// In en, this message translates to:
  /// **'Nudity or sexual content'**
  String get signalReportNudity;

  /// No description provided for @signalReportOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get signalReportOther;

  /// No description provided for @signalReportSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or misleading'**
  String get signalReportSpam;

  /// No description provided for @signalReportSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted. Thank you.'**
  String get signalReportSubmitted;

  /// No description provided for @signalReportViolence.
  ///
  /// In en, this message translates to:
  /// **'Violence or dangerous content'**
  String get signalReportViolence;

  /// No description provided for @signalRespondToSignalHint.
  ///
  /// In en, this message translates to:
  /// **'Respond to this signal...'**
  String get signalRespondToSignalHint;

  /// No description provided for @signalRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get signalRestore;

  /// No description provided for @signalRestored.
  ///
  /// In en, this message translates to:
  /// **'Signal restored'**
  String get signalRestored;

  /// No description provided for @signalRetrievingDeviceLocation.
  ///
  /// In en, this message translates to:
  /// **'Retrieving device location...'**
  String get signalRetrievingDeviceLocation;

  /// No description provided for @signalSaved.
  ///
  /// In en, this message translates to:
  /// **'Signal saved'**
  String get signalSaved;

  /// No description provided for @signalSavedBadge.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get signalSavedBadge;

  /// No description provided for @signalSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search signals'**
  String get signalSearchHint;

  /// No description provided for @signalSeenCount.
  ///
  /// In en, this message translates to:
  /// **'Seen {formattedCount}'**
  String signalSeenCount(String formattedCount);

  /// No description provided for @signalSelectUpToFourPhotos.
  ///
  /// In en, this message translates to:
  /// **'Select up to 4 photos'**
  String get signalSelectUpToFourPhotos;

  /// No description provided for @signalSendASignal.
  ///
  /// In en, this message translates to:
  /// **'Send a signal...'**
  String get signalSendASignal;

  /// No description provided for @signalSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Signal'**
  String get signalSendButton;

  /// No description provided for @signalSendResponseFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send response'**
  String get signalSendResponseFailed;

  /// No description provided for @signalSendSignal.
  ///
  /// In en, this message translates to:
  /// **'Send signal'**
  String get signalSendSignal;

  /// No description provided for @signalSending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get signalSending;

  /// No description provided for @signalSendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get signalSendingLabel;

  /// No description provided for @signalSent.
  ///
  /// In en, this message translates to:
  /// **'Signal sent'**
  String get signalSent;

  /// No description provided for @signalSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get signalSettings;

  /// No description provided for @signalShortStatusHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. \"On the trail near summit\"'**
  String get signalShortStatusHint;

  /// No description provided for @signalShortStatusOptional.
  ///
  /// In en, this message translates to:
  /// **'Short Status (optional)'**
  String get signalShortStatusOptional;

  /// No description provided for @signalShowAll.
  ///
  /// In en, this message translates to:
  /// **'Show all signals'**
  String get signalShowAll;

  /// No description provided for @signalSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signalSignIn;

  /// No description provided for @signalSignInForCloudFeatures.
  ///
  /// In en, this message translates to:
  /// **'Sign in to enable images and cloud features.'**
  String get signalSignInForCloudFeatures;

  /// No description provided for @signalSignInForImagesAndComments.
  ///
  /// In en, this message translates to:
  /// **'Sign in for images and comments'**
  String get signalSignInForImagesAndComments;

  /// No description provided for @signalSignInRequiredToComment.
  ///
  /// In en, this message translates to:
  /// **'Sign in required to comment'**
  String get signalSignInRequiredToComment;

  /// No description provided for @signalSignInToViewMedia.
  ///
  /// In en, this message translates to:
  /// **'Sign in to view attached media'**
  String get signalSignInToViewMedia;

  /// No description provided for @signalSignInToVote.
  ///
  /// In en, this message translates to:
  /// **'Sign in to vote on responses'**
  String get signalSignInToVote;

  /// No description provided for @signalSignalsNearbyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 signal} other{{count} signals}} nearby'**
  String signalSignalsNearbyCount(int count);

  /// No description provided for @signalSomeone.
  ///
  /// In en, this message translates to:
  /// **'Someone'**
  String get signalSomeone;

  /// No description provided for @signalSortByProximity.
  ///
  /// In en, this message translates to:
  /// **'By Proximity'**
  String get signalSortByProximity;

  /// No description provided for @signalSortClosest.
  ///
  /// In en, this message translates to:
  /// **'Closest'**
  String get signalSortClosest;

  /// No description provided for @signalSortExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring'**
  String get signalSortExpiring;

  /// No description provided for @signalSortExpiringSoon.
  ///
  /// In en, this message translates to:
  /// **'Expiring Soon'**
  String get signalSortExpiringSoon;

  /// No description provided for @signalSortMostRecent.
  ///
  /// In en, this message translates to:
  /// **'Most Recent'**
  String get signalSortMostRecent;

  /// No description provided for @signalSortNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get signalSortNewest;

  /// No description provided for @signalSwipeHide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get signalSwipeHide;

  /// No description provided for @signalSwipeSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get signalSwipeSave;

  /// No description provided for @signalSwipeUnsave.
  ///
  /// In en, this message translates to:
  /// **'Unsave'**
  String get signalSwipeUnsave;

  /// No description provided for @signalSyncingMedia.
  ///
  /// In en, this message translates to:
  /// **'Syncing media'**
  String get signalSyncingMedia;

  /// No description provided for @signalTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get signalTakePhoto;

  /// No description provided for @signalTapToSet.
  ///
  /// In en, this message translates to:
  /// **'Tap to set'**
  String get signalTapToSet;

  /// No description provided for @signalTapToView.
  ///
  /// In en, this message translates to:
  /// **'Tap to view'**
  String get signalTapToView;

  /// No description provided for @signalTemporaryBanner.
  ///
  /// In en, this message translates to:
  /// **'Signals are temporary. They fade automatically and exist only while active.'**
  String get signalTemporaryBanner;

  /// No description provided for @signalTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String signalTimeDaysAgo(int days);

  /// No description provided for @signalTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String signalTimeHoursAgo(int hours);

  /// No description provided for @signalTimeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get signalTimeJustNow;

  /// No description provided for @signalTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String signalTimeMinutesAgo(int minutes);

  /// No description provided for @signalTimeNowCompact.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get signalTimeNowCompact;

  /// No description provided for @signalTimeWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{weeks}w ago'**
  String signalTimeWeeksAgo(int weeks);

  /// No description provided for @signalTtlDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{days}d left'**
  String signalTtlDaysLeft(int days);

  /// No description provided for @signalTtlExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get signalTtlExpired;

  /// No description provided for @signalTtlHoursLeft.
  ///
  /// In en, this message translates to:
  /// **'{hours}h left'**
  String signalTtlHoursLeft(int hours);

  /// No description provided for @signalTtlMinutesLeft.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m left'**
  String signalTtlMinutesLeft(int minutes);

  /// No description provided for @signalTtlSecondsLeft.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s left'**
  String signalTtlSecondsLeft(int seconds);

  /// No description provided for @signalUnknownAuthor.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get signalUnknownAuthor;

  /// No description provided for @signalUseCamera.
  ///
  /// In en, this message translates to:
  /// **'Use camera'**
  String get signalUseCamera;

  /// No description provided for @signalValidateImagesFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to validate images'**
  String get signalValidateImagesFailed;

  /// No description provided for @signalValidatingImages.
  ///
  /// In en, this message translates to:
  /// **'Validating {count} images...'**
  String signalValidatingImages(int count);

  /// No description provided for @signalViewButton.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get signalViewButton;

  /// No description provided for @signalViewGallery.
  ///
  /// In en, this message translates to:
  /// **'View gallery'**
  String get signalViewGallery;

  /// No description provided for @signalViewGrid.
  ///
  /// In en, this message translates to:
  /// **'Grid view'**
  String get signalViewGrid;

  /// No description provided for @signalViewList.
  ///
  /// In en, this message translates to:
  /// **'List view'**
  String get signalViewList;

  /// No description provided for @signalViewLocation.
  ///
  /// In en, this message translates to:
  /// **'View Location'**
  String get signalViewLocation;

  /// No description provided for @signalViewMap.
  ///
  /// In en, this message translates to:
  /// **'Map view'**
  String get signalViewMap;

  /// No description provided for @signalVoteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit vote'**
  String get signalVoteFailed;

  /// No description provided for @signalWhatAreYouSignaling.
  ///
  /// In en, this message translates to:
  /// **'What are you signaling?'**
  String get signalWhatAreYouSignaling;

  /// No description provided for @signalWhyReportComment.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this comment?'**
  String get signalWhyReportComment;

  /// No description provided for @signalWhyReportSignal.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this signal?'**
  String get signalWhyReportSignal;

  /// No description provided for @signalWriteReplyHint.
  ///
  /// In en, this message translates to:
  /// **'Write a reply...'**
  String get signalWriteReplyHint;

  /// No description provided for @signalYouBadge.
  ///
  /// In en, this message translates to:
  /// **'you'**
  String get signalYouBadge;

  /// No description provided for @signalYourIntent.
  ///
  /// In en, this message translates to:
  /// **'Your Intent'**
  String get signalYourIntent;

  /// No description provided for @signalYourResponsibility.
  ///
  /// In en, this message translates to:
  /// **'Your Responsibility'**
  String get signalYourResponsibility;

  /// No description provided for @signalsFadeAutomatically.
  ///
  /// In en, this message translates to:
  /// **'Signals fade automatically. Only what\'s still active can be seen.'**
  String get signalsFadeAutomatically;

  /// No description provided for @signalsFeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Signals'**
  String get signalsFeedTitle;

  /// No description provided for @signalsPanelTitle.
  ///
  /// In en, this message translates to:
  /// **'Signals'**
  String get signalsPanelTitle;

  /// No description provided for @socialAboutSensitiveContent.
  ///
  /// In en, this message translates to:
  /// **'About Sensitive Content'**
  String get socialAboutSensitiveContent;

  /// No description provided for @socialAccountGoodStanding.
  ///
  /// In en, this message translates to:
  /// **'Account in Good Standing'**
  String get socialAccountGoodStanding;

  /// No description provided for @socialAccountGoodStandingDesc.
  ///
  /// In en, this message translates to:
  /// **'You have no active warnings or strikes.'**
  String get socialAccountGoodStandingDesc;

  /// No description provided for @socialAccountGoodStandingLabel.
  ///
  /// In en, this message translates to:
  /// **'Good Standing'**
  String get socialAccountGoodStandingLabel;

  /// No description provided for @socialAccountMaxStrikes.
  ///
  /// In en, this message translates to:
  /// **'Max Strikes'**
  String get socialAccountMaxStrikes;

  /// No description provided for @socialAccountRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get socialAccountRecentActivity;

  /// No description provided for @socialAccountStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get socialAccountStatusActive;

  /// No description provided for @socialAccountStatusError.
  ///
  /// In en, this message translates to:
  /// **'Error loading status: {error}'**
  String socialAccountStatusError(String error);

  /// No description provided for @socialAccountStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Status'**
  String get socialAccountStatusLabel;

  /// No description provided for @socialAccountStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Status'**
  String get socialAccountStatusTitle;

  /// No description provided for @socialAccountStrike1.
  ///
  /// In en, this message translates to:
  /// **'First offense. Review our guidelines.'**
  String get socialAccountStrike1;

  /// No description provided for @socialAccountStrike2.
  ///
  /// In en, this message translates to:
  /// **'Second offense. One more and your account will be suspended.'**
  String get socialAccountStrike2;

  /// No description provided for @socialAccountStrike3.
  ///
  /// In en, this message translates to:
  /// **'Account will be suspended.'**
  String get socialAccountStrike3;

  /// No description provided for @socialAccountStrikeMeter.
  ///
  /// In en, this message translates to:
  /// **'Strike Meter'**
  String get socialAccountStrikeMeter;

  /// No description provided for @socialAccountStrikes.
  ///
  /// In en, this message translates to:
  /// **'Strikes'**
  String get socialAccountStrikes;

  /// No description provided for @socialAccountSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get socialAccountSuspended;

  /// No description provided for @socialAccountSuspendedTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Suspended'**
  String get socialAccountSuspendedTitle;

  /// No description provided for @socialAccountWarningStrikesActive.
  ///
  /// In en, this message translates to:
  /// **'Warning: Strikes Active'**
  String get socialAccountWarningStrikesActive;

  /// No description provided for @socialAccountWarnings.
  ///
  /// In en, this message translates to:
  /// **'Warnings'**
  String get socialAccountWarnings;

  /// No description provided for @socialAccountWarningsActive.
  ///
  /// In en, this message translates to:
  /// **'Warnings Active'**
  String get socialAccountWarningsActive;

  /// No description provided for @socialActiveStrikes.
  ///
  /// In en, this message translates to:
  /// **'Active Strikes'**
  String get socialActiveStrikes;

  /// No description provided for @socialActiveWarnings.
  ///
  /// In en, this message translates to:
  /// **'Active Warnings'**
  String get socialActiveWarnings;

  /// No description provided for @socialActivityAllRead.
  ///
  /// In en, this message translates to:
  /// **'All activity marked as read'**
  String get socialActivityAllRead;

  /// No description provided for @socialActivityClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get socialActivityClearAll;

  /// No description provided for @socialActivityClearConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get socialActivityClearConfirmLabel;

  /// No description provided for @socialActivityClearConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove all activity items. This cannot be undone.'**
  String get socialActivityClearConfirmMessage;

  /// No description provided for @socialActivityClearConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear all activity?'**
  String get socialActivityClearConfirmTitle;

  /// No description provided for @socialActivityCleared.
  ///
  /// In en, this message translates to:
  /// **'Activity cleared'**
  String get socialActivityCleared;

  /// No description provided for @socialActivityCommentedPost.
  ///
  /// In en, this message translates to:
  /// **' commented on your post'**
  String get socialActivityCommentedPost;

  /// No description provided for @socialActivityCommentedSignal.
  ///
  /// In en, this message translates to:
  /// **' commented on your signal'**
  String get socialActivityCommentedSignal;

  /// No description provided for @socialActivityErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Failed to load activity'**
  String get socialActivityErrorLoading;

  /// No description provided for @socialActivityFollowRequest.
  ///
  /// In en, this message translates to:
  /// **' requested to follow you'**
  String get socialActivityFollowRequest;

  /// No description provided for @socialActivityFollowed.
  ///
  /// In en, this message translates to:
  /// **' started following you'**
  String get socialActivityFollowed;

  /// No description provided for @socialActivityGroupEarlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get socialActivityGroupEarlier;

  /// No description provided for @socialActivityGroupThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get socialActivityGroupThisMonth;

  /// No description provided for @socialActivityGroupThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get socialActivityGroupThisWeek;

  /// No description provided for @socialActivityGroupToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get socialActivityGroupToday;

  /// No description provided for @socialActivityGroupYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get socialActivityGroupYesterday;

  /// No description provided for @socialActivityInteracted.
  ///
  /// In en, this message translates to:
  /// **' interacted with your content'**
  String get socialActivityInteracted;

  /// No description provided for @socialActivityLikedComment.
  ///
  /// In en, this message translates to:
  /// **' liked your comment'**
  String get socialActivityLikedComment;

  /// No description provided for @socialActivityLikedPost.
  ///
  /// In en, this message translates to:
  /// **' liked your post'**
  String get socialActivityLikedPost;

  /// No description provided for @socialActivityLikedSignal.
  ///
  /// In en, this message translates to:
  /// **' liked your signal'**
  String get socialActivityLikedSignal;

  /// No description provided for @socialActivityLikedStory.
  ///
  /// In en, this message translates to:
  /// **' liked your story'**
  String get socialActivityLikedStory;

  /// No description provided for @socialActivityLoadingSignal.
  ///
  /// In en, this message translates to:
  /// **'Loading Signal...'**
  String get socialActivityLoadingSignal;

  /// No description provided for @socialActivityMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get socialActivityMarkAllRead;

  /// No description provided for @socialActivityRepliedComment.
  ///
  /// In en, this message translates to:
  /// **' replied to your comment'**
  String get socialActivityRepliedComment;

  /// No description provided for @socialActivitySignalNotFound.
  ///
  /// In en, this message translates to:
  /// **'Signal not found'**
  String get socialActivitySignalNotFound;

  /// No description provided for @socialActivityTagline1.
  ///
  /// In en, this message translates to:
  /// **'No activity yet.\nInteractions with your posts appear here.'**
  String get socialActivityTagline1;

  /// No description provided for @socialActivityTagline2.
  ///
  /// In en, this message translates to:
  /// **'Likes, comments, follows — all in one place.\nPost something to get started.'**
  String get socialActivityTagline2;

  /// No description provided for @socialActivityTagline3.
  ///
  /// In en, this message translates to:
  /// **'Your social pulse starts here.\nConnect with others to see activity.'**
  String get socialActivityTagline3;

  /// No description provided for @socialActivityTagline4.
  ///
  /// In en, this message translates to:
  /// **'Nothing yet. Activity appears as others\ninteract with your content.'**
  String get socialActivityTagline4;

  /// No description provided for @socialActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get socialActivityTitle;

  /// No description provided for @socialActivityTitleKeyword.
  ///
  /// In en, this message translates to:
  /// **'activity'**
  String get socialActivityTitleKeyword;

  /// No description provided for @socialActivityTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'No '**
  String get socialActivityTitlePrefix;

  /// No description provided for @socialActivityTitleSuffix.
  ///
  /// In en, this message translates to:
  /// **' yet'**
  String get socialActivityTitleSuffix;

  /// No description provided for @socialActivityViewedStory.
  ///
  /// In en, this message translates to:
  /// **' viewed your story'**
  String get socialActivityViewedStory;

  /// No description provided for @socialAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get socialAdd;

  /// No description provided for @socialAddBanner.
  ///
  /// In en, this message translates to:
  /// **'Add banner'**
  String get socialAddBanner;

  /// No description provided for @socialAlbumAll.
  ///
  /// In en, this message translates to:
  /// **'All Albums'**
  String get socialAlbumAll;

  /// No description provided for @socialAlbumFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get socialAlbumFavorites;

  /// No description provided for @socialAlbumRecents.
  ///
  /// In en, this message translates to:
  /// **'Recents'**
  String get socialAlbumRecents;

  /// No description provided for @socialAlbumVideos.
  ///
  /// In en, this message translates to:
  /// **'Videos'**
  String get socialAlbumVideos;

  /// No description provided for @socialAppealDecision.
  ///
  /// In en, this message translates to:
  /// **'Appeal Decision'**
  String get socialAppealDecision;

  /// No description provided for @socialAuthorLabel.
  ///
  /// In en, this message translates to:
  /// **'Author: '**
  String get socialAuthorLabel;

  /// No description provided for @socialBanReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment / Bullying'**
  String get socialBanReasonHarassment;

  /// No description provided for @socialBanReasonHateSpeech.
  ///
  /// In en, this message translates to:
  /// **'Hate speech / Discrimination'**
  String get socialBanReasonHateSpeech;

  /// No description provided for @socialBanReasonIllegal.
  ///
  /// In en, this message translates to:
  /// **'Illegal activity'**
  String get socialBanReasonIllegal;

  /// No description provided for @socialBanReasonImpersonation.
  ///
  /// In en, this message translates to:
  /// **'Impersonation'**
  String get socialBanReasonImpersonation;

  /// No description provided for @socialBanReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other violation'**
  String get socialBanReasonOther;

  /// No description provided for @socialBanReasonPornography.
  ///
  /// In en, this message translates to:
  /// **'Pornography / Sexual content'**
  String get socialBanReasonPornography;

  /// No description provided for @socialBanReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam / Scam'**
  String get socialBanReasonSpam;

  /// No description provided for @socialBanReasonViolence.
  ///
  /// In en, this message translates to:
  /// **'Violence / Threats'**
  String get socialBanReasonViolence;

  /// No description provided for @socialBanSelectReason.
  ///
  /// In en, this message translates to:
  /// **'Select ban reason'**
  String get socialBanSelectReason;

  /// No description provided for @socialBanSendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send notification email to user'**
  String get socialBanSendEmail;

  /// No description provided for @socialBanSendEmailDesc.
  ///
  /// In en, this message translates to:
  /// **'Inform them why their account was banned'**
  String get socialBanSendEmailDesc;

  /// No description provided for @socialBanUserAndDelete.
  ///
  /// In en, this message translates to:
  /// **'Ban User & Delete'**
  String get socialBanUserAndDelete;

  /// No description provided for @socialBanUserButton.
  ///
  /// In en, this message translates to:
  /// **'Ban User'**
  String get socialBanUserButton;

  /// No description provided for @socialBanUserDesc.
  ///
  /// In en, this message translates to:
  /// **'This will permanently disable their account'**
  String get socialBanUserDesc;

  /// No description provided for @socialBanUserFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to ban user: {error}'**
  String socialBanUserFailed(String error);

  /// No description provided for @socialBanUserIdLabel.
  ///
  /// In en, this message translates to:
  /// **'User ID: '**
  String get socialBanUserIdLabel;

  /// No description provided for @socialBanUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Ban User'**
  String get socialBanUserTitle;

  /// No description provided for @socialBannerRemoveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove banner: {error}'**
  String socialBannerRemoveFailed(String error);

  /// No description provided for @socialBannerRemoved.
  ///
  /// In en, this message translates to:
  /// **'Banner removed'**
  String get socialBannerRemoved;

  /// No description provided for @socialBannerUpdated.
  ///
  /// In en, this message translates to:
  /// **'Banner updated'**
  String get socialBannerUpdated;

  /// No description provided for @socialBannerUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload banner: {error}'**
  String socialBannerUploadFailed(String error);

  /// No description provided for @socialBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get socialBlock;

  /// No description provided for @socialBlockUser.
  ///
  /// In en, this message translates to:
  /// **'Block User'**
  String get socialBlockUser;

  /// No description provided for @socialBlockUserConfirm.
  ///
  /// In en, this message translates to:
  /// **'You will no longer see posts from this user.'**
  String get socialBlockUserConfirm;

  /// No description provided for @socialBlurSensitiveDesc.
  ///
  /// In en, this message translates to:
  /// **'Blur potentially sensitive images and videos until you tap to reveal'**
  String get socialBlurSensitiveDesc;

  /// No description provided for @socialBlurSensitiveMedia.
  ///
  /// In en, this message translates to:
  /// **'Blur Sensitive Media'**
  String get socialBlurSensitiveMedia;

  /// No description provided for @socialCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get socialCancel;

  /// No description provided for @socialCannotIdentifyUser.
  ///
  /// In en, this message translates to:
  /// **'Cannot identify user to ban'**
  String get socialCannotIdentifyUser;

  /// No description provided for @socialChangeBanner.
  ///
  /// In en, this message translates to:
  /// **'Change banner'**
  String get socialChangeBanner;

  /// No description provided for @socialClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get socialClose;

  /// No description provided for @socialCommentActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed: {error}'**
  String socialCommentActionFailed(String error);

  /// No description provided for @socialCommentDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this comment?'**
  String get socialCommentDeleteConfirm;

  /// No description provided for @socialCommentDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete: {error}'**
  String socialCommentDeleteFailed(String error);

  /// No description provided for @socialCommentDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Comment'**
  String get socialCommentDeleteTitle;

  /// No description provided for @socialCommentHintAdd.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get socialCommentHintAdd;

  /// No description provided for @socialCommentHintReply.
  ///
  /// In en, this message translates to:
  /// **'Write a reply...'**
  String get socialCommentHintReply;

  /// No description provided for @socialCommentReply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get socialCommentReply;

  /// No description provided for @socialCommentReportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to report: {error}'**
  String socialCommentReportFailed(String error);

  /// No description provided for @socialCommentReported.
  ///
  /// In en, this message translates to:
  /// **'Comment reported'**
  String get socialCommentReported;

  /// No description provided for @socialCommentUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get socialCommentUnknown;

  /// No description provided for @socialComments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get socialComments;

  /// No description provided for @socialCommunityGuidelines.
  ///
  /// In en, this message translates to:
  /// **'Community Guidelines'**
  String get socialCommunityGuidelines;

  /// No description provided for @socialConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get socialConfirm;

  /// No description provided for @socialConnectionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get socialConnectionsTitle;

  /// No description provided for @socialContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Questions? Contact Support'**
  String get socialContactSupport;

  /// No description provided for @socialContactSupportButton.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get socialContactSupportButton;

  /// No description provided for @socialContentIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Content ID not found'**
  String get socialContentIdNotFound;

  /// No description provided for @socialContentNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Content not available'**
  String get socialContentNotAvailable;

  /// No description provided for @socialContentRemoved.
  ///
  /// In en, this message translates to:
  /// **'Content Removed'**
  String get socialContentRemoved;

  /// No description provided for @socialContentType.
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get socialContentType;

  /// No description provided for @socialContentUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Content unavailable'**
  String get socialContentUnavailable;

  /// No description provided for @socialCreatePostAction.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get socialCreatePostAction;

  /// No description provided for @socialCreatePostAddImage.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get socialCreatePostAddImage;

  /// No description provided for @socialCreatePostAddLocation.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get socialCreatePostAddLocation;

  /// No description provided for @socialCreatePostButton.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get socialCreatePostButton;

  /// No description provided for @socialCreatePostCreated.
  ///
  /// In en, this message translates to:
  /// **'Post created!'**
  String get socialCreatePostCreated;

  /// No description provided for @socialCreatePostCurrentDesc.
  ///
  /// In en, this message translates to:
  /// **'Share your GPS coordinates'**
  String get socialCreatePostCurrentDesc;

  /// No description provided for @socialCreatePostCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get socialCreatePostCurrentLocation;

  /// No description provided for @socialCreatePostDiscardMsgDraft.
  ///
  /// In en, this message translates to:
  /// **'Your draft will be lost.'**
  String get socialCreatePostDiscardMsgDraft;

  /// No description provided for @socialCreatePostDiscardMsgImages.
  ///
  /// In en, this message translates to:
  /// **'Your uploaded images will be deleted.'**
  String get socialCreatePostDiscardMsgImages;

  /// No description provided for @socialCreatePostDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard post?'**
  String get socialCreatePostDiscardTitle;

  /// No description provided for @socialCreatePostEnterLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter Location'**
  String get socialCreatePostEnterLocation;

  /// No description provided for @socialCreatePostEnterManually.
  ///
  /// In en, this message translates to:
  /// **'Enter Location Manually'**
  String get socialCreatePostEnterManually;

  /// No description provided for @socialCreatePostFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create post: {error}'**
  String socialCreatePostFailed(String error);

  /// No description provided for @socialCreatePostHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s happening on the mesh?'**
  String get socialCreatePostHint;

  /// No description provided for @socialCreatePostImageCount.
  ///
  /// In en, this message translates to:
  /// **'{count}/{max} images'**
  String socialCreatePostImageCount(int count, int max);

  /// No description provided for @socialCreatePostImageViolation.
  ///
  /// In en, this message translates to:
  /// **'One or more images violated content policy.'**
  String get socialCreatePostImageViolation;

  /// No description provided for @socialCreatePostLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied'**
  String get socialCreatePostLocationDenied;

  /// No description provided for @socialCreatePostLocationHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., San Francisco, CA'**
  String get socialCreatePostLocationHint;

  /// No description provided for @socialCreatePostLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get socialCreatePostLocationLabel;

  /// No description provided for @socialCreatePostLocationSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Location'**
  String get socialCreatePostLocationSheetTitle;

  /// No description provided for @socialCreatePostManualDesc.
  ///
  /// In en, this message translates to:
  /// **'Type in a place name'**
  String get socialCreatePostManualDesc;

  /// No description provided for @socialCreatePostMaxImages.
  ///
  /// In en, this message translates to:
  /// **'Maximum {max} images allowed'**
  String socialCreatePostMaxImages(int max);

  /// No description provided for @socialCreatePostNoNodes.
  ///
  /// In en, this message translates to:
  /// **'No nodes available. Connect to a mesh first.'**
  String get socialCreatePostNoNodes;

  /// No description provided for @socialCreatePostNodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Node {nodeId}'**
  String socialCreatePostNodeLabel(String nodeId);

  /// No description provided for @socialCreatePostSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to create posts'**
  String get socialCreatePostSignIn;

  /// No description provided for @socialCreatePostTagNode.
  ///
  /// In en, this message translates to:
  /// **'Tag node'**
  String get socialCreatePostTagNode;

  /// No description provided for @socialCreatePostTagNodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Tag a Node'**
  String get socialCreatePostTagNodeTitle;

  /// No description provided for @socialCreatePostTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get socialCreatePostTitle;

  /// No description provided for @socialCreatePostUseCurrent.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get socialCreatePostUseCurrent;

  /// No description provided for @socialCreateStoryCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get socialCreateStoryCamera;

  /// No description provided for @socialCreateStoryCloseFriends.
  ///
  /// In en, this message translates to:
  /// **'Close Friends'**
  String get socialCreateStoryCloseFriends;

  /// No description provided for @socialCreateStoryDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get socialCreateStoryDelete;

  /// No description provided for @socialCreateStoryDragInstructions.
  ///
  /// In en, this message translates to:
  /// **'Drag to move • Pinch to resize • Long press to delete'**
  String get socialCreateStoryDragInstructions;

  /// No description provided for @socialCreateStoryEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get socialCreateStoryEdit;

  /// No description provided for @socialCreateStoryFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create story'**
  String get socialCreateStoryFailed;

  /// No description provided for @socialCreateStoryFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get socialCreateStoryFollowers;

  /// No description provided for @socialCreateStoryItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String socialCreateStoryItemsCount(int count);

  /// No description provided for @socialCreateStoryLinkNode.
  ///
  /// In en, this message translates to:
  /// **'Link to Node'**
  String get socialCreateStoryLinkNode;

  /// No description provided for @socialCreateStoryLocationFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not get location'**
  String get socialCreateStoryLocationFailed;

  /// No description provided for @socialCreateStoryLocationRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission required'**
  String get socialCreateStoryLocationRequired;

  /// No description provided for @socialCreateStoryPublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get socialCreateStoryPublic;

  /// No description provided for @socialCreateStoryShared.
  ///
  /// In en, this message translates to:
  /// **'Story shared!'**
  String get socialCreateStoryShared;

  /// No description provided for @socialCreateStorySignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to create stories'**
  String get socialCreateStorySignIn;

  /// No description provided for @socialCreateStoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add to Story'**
  String get socialCreateStoryTitle;

  /// No description provided for @socialCreateStoryTypeSomething.
  ///
  /// In en, this message translates to:
  /// **'Type something...'**
  String get socialCreateStoryTypeSomething;

  /// No description provided for @socialCreateStoryUntitledAlbum.
  ///
  /// In en, this message translates to:
  /// **'Untitled Album'**
  String get socialCreateStoryUntitledAlbum;

  /// No description provided for @socialDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get socialDate;

  /// No description provided for @socialDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get socialDefault;

  /// No description provided for @socialDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get socialDelete;

  /// No description provided for @socialDeleteComment.
  ///
  /// In en, this message translates to:
  /// **'Delete Comment'**
  String get socialDeleteComment;

  /// No description provided for @socialDeleteCommentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this comment?'**
  String get socialDeleteCommentConfirm;

  /// No description provided for @socialDeletePost.
  ///
  /// In en, this message translates to:
  /// **'Delete Post'**
  String get socialDeletePost;

  /// No description provided for @socialDeletePostConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this post?'**
  String get socialDeletePostConfirm;

  /// No description provided for @socialDeleteStory.
  ///
  /// In en, this message translates to:
  /// **'Delete story'**
  String get socialDeleteStory;

  /// No description provided for @socialDeleteStoryConfirm.
  ///
  /// In en, this message translates to:
  /// **'This story will be permanently deleted.'**
  String get socialDeleteStoryConfirm;

  /// No description provided for @socialDeleteType.
  ///
  /// In en, this message translates to:
  /// **'Delete {type}'**
  String socialDeleteType(String type);

  /// No description provided for @socialDeleteTypeConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete the reported {type}. Continue?'**
  String socialDeleteTypeConfirm(String type);

  /// No description provided for @socialDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get socialDiscard;

  /// No description provided for @socialDiscordCopied.
  ///
  /// In en, this message translates to:
  /// **'Discord username copied: {username}'**
  String socialDiscordCopied(String username);

  /// No description provided for @socialDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get socialDismiss;

  /// No description provided for @socialDisplayOptions.
  ///
  /// In en, this message translates to:
  /// **'Display Options'**
  String get socialDisplayOptions;

  /// No description provided for @socialDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get socialDone;

  /// No description provided for @socialEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get socialEditProfile;

  /// No description provided for @socialEmailCopied.
  ///
  /// In en, this message translates to:
  /// **'Email copied to clipboard'**
  String get socialEmailCopied;

  /// No description provided for @socialEmptyPostsTagline1.
  ///
  /// In en, this message translates to:
  /// **'Share photos and stories about your mesh adventures.'**
  String get socialEmptyPostsTagline1;

  /// No description provided for @socialEmptyPostsTagline2.
  ///
  /// In en, this message translates to:
  /// **'Post about your node setups, range tests, and discoveries.'**
  String get socialEmptyPostsTagline2;

  /// No description provided for @socialEmptyPostsTagline3.
  ///
  /// In en, this message translates to:
  /// **'Your mesh community is waiting to see what you build.'**
  String get socialEmptyPostsTagline3;

  /// No description provided for @socialEmptyPostsTagline4.
  ///
  /// In en, this message translates to:
  /// **'Document your adventures and share them with the mesh.'**
  String get socialEmptyPostsTagline4;

  /// No description provided for @socialErrorLoadingReports.
  ///
  /// In en, this message translates to:
  /// **'Error loading reports'**
  String get socialErrorLoadingReports;

  /// No description provided for @socialErrorLoadingViewers.
  ///
  /// In en, this message translates to:
  /// **'Error loading viewers'**
  String get socialErrorLoadingViewers;

  /// No description provided for @socialExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get socialExpires;

  /// No description provided for @socialFeedLocationFallback.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get socialFeedLocationFallback;

  /// No description provided for @socialFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get socialFilterAll;

  /// No description provided for @socialFilterLevelLess.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get socialFilterLevelLess;

  /// No description provided for @socialFilterLevelLessDesc.
  ///
  /// In en, this message translates to:
  /// **'You may see some content that could be upsetting or offensive. This setting errs on the side of showing more content.'**
  String get socialFilterLevelLessDesc;

  /// No description provided for @socialFilterLevelStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get socialFilterLevelStandard;

  /// No description provided for @socialFilterLevelStandardDesc.
  ///
  /// In en, this message translates to:
  /// **'Content that may be upsetting or offensive is filtered. You may still see some borderline content.'**
  String get socialFilterLevelStandardDesc;

  /// No description provided for @socialFilterLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get socialFilterLocation;

  /// No description provided for @socialFilterNodes.
  ///
  /// In en, this message translates to:
  /// **'Nodes'**
  String get socialFilterNodes;

  /// No description provided for @socialFilterPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get socialFilterPhotos;

  /// No description provided for @socialFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get socialFollow;

  /// No description provided for @socialFollowActionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed: {error}'**
  String socialFollowActionFailed(String error);

  /// No description provided for @socialFollowFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update follow: {error}'**
  String socialFollowFailed(String error);

  /// No description provided for @socialFollowRequestAcceptFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to accept request'**
  String get socialFollowRequestAcceptFailed;

  /// No description provided for @socialFollowRequestAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted {name}\'s request'**
  String socialFollowRequestAccepted(String name);

  /// No description provided for @socialFollowRequestDeclineFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to decline request'**
  String get socialFollowRequestDeclineFailed;

  /// No description provided for @socialFollowRequestDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined {name}\'s request'**
  String socialFollowRequestDeclined(String name);

  /// No description provided for @socialFollowRequestsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No pending requests'**
  String get socialFollowRequestsEmpty;

  /// No description provided for @socialFollowRequestsEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'When someone requests to follow you, it will appear here.'**
  String get socialFollowRequestsEmptyDesc;

  /// No description provided for @socialFollowRequestsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load: {error}'**
  String socialFollowRequestsError(String error);

  /// No description provided for @socialFollowRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Follow Requests'**
  String get socialFollowRequestsTitle;

  /// No description provided for @socialFollowersAndPosts.
  ///
  /// In en, this message translates to:
  /// **'{followers} followers • {posts} posts'**
  String socialFollowersAndPosts(String followers, String posts);

  /// No description provided for @socialFollowersError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load: {error}'**
  String socialFollowersError(String error);

  /// No description provided for @socialFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get socialFollowing;

  /// No description provided for @socialGuidelineNoExplicit.
  ///
  /// In en, this message translates to:
  /// **'No explicit or adult content'**
  String get socialGuidelineNoExplicit;

  /// No description provided for @socialGuidelineNoHarassment.
  ///
  /// In en, this message translates to:
  /// **'No harassment, threats, or hate speech'**
  String get socialGuidelineNoHarassment;

  /// No description provided for @socialGuidelineNoSpam.
  ///
  /// In en, this message translates to:
  /// **'No spam, scams, or misleading content'**
  String get socialGuidelineNoSpam;

  /// No description provided for @socialGuidelineRespectful.
  ///
  /// In en, this message translates to:
  /// **'Be respectful and constructive'**
  String get socialGuidelineRespectful;

  /// No description provided for @socialGuidelinesWarning.
  ///
  /// In en, this message translates to:
  /// **'Community Guidelines Warning'**
  String get socialGuidelinesWarning;

  /// No description provided for @socialHubSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access Social'**
  String get socialHubSignIn;

  /// No description provided for @socialHubSignInDesc.
  ///
  /// In en, this message translates to:
  /// **'Create posts, follow users, and connect with the mesh community.'**
  String get socialHubSignInDesc;

  /// No description provided for @socialHubTitle.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get socialHubTitle;

  /// No description provided for @socialIUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get socialIUnderstand;

  /// No description provided for @socialImageUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Image unavailable'**
  String get socialImageUnavailable;

  /// No description provided for @socialJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined {date}'**
  String socialJoined(String date);

  /// No description provided for @socialLike.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get socialLike;

  /// No description provided for @socialLiked.
  ///
  /// In en, this message translates to:
  /// **'Liked'**
  String get socialLiked;

  /// No description provided for @socialLinkNodeHint.
  ///
  /// In en, this message translates to:
  /// **'Link a mesh node to your next post'**
  String get socialLinkNodeHint;

  /// No description provided for @socialLocationFallback.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get socialLocationFallback;

  /// No description provided for @socialMediaLabel.
  ///
  /// In en, this message translates to:
  /// **'Media ({type})'**
  String socialMediaLabel(String type);

  /// No description provided for @socialModerationAdditionalNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional notes (optional)'**
  String get socialModerationAdditionalNotes;

  /// No description provided for @socialModerationApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get socialModerationApprove;

  /// No description provided for @socialModerationApproved.
  ///
  /// In en, this message translates to:
  /// **'Content approved'**
  String get socialModerationApproved;

  /// No description provided for @socialModerationErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading queue'**
  String get socialModerationErrorLoading;

  /// No description provided for @socialModerationNoPending.
  ///
  /// In en, this message translates to:
  /// **'No items pending review'**
  String get socialModerationNoPending;

  /// No description provided for @socialModerationNoStatus.
  ///
  /// In en, this message translates to:
  /// **'No {status} items'**
  String socialModerationNoStatus(String status);

  /// No description provided for @socialModerationQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Moderation Queue'**
  String get socialModerationQueueTitle;

  /// No description provided for @socialModerationReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment or bullying'**
  String get socialModerationReasonHarassment;

  /// No description provided for @socialModerationReasonHateSpeech.
  ///
  /// In en, this message translates to:
  /// **'Hate speech or discrimination'**
  String get socialModerationReasonHateSpeech;

  /// No description provided for @socialModerationReasonIP.
  ///
  /// In en, this message translates to:
  /// **'Intellectual property violation'**
  String get socialModerationReasonIP;

  /// No description provided for @socialModerationReasonNudity.
  ///
  /// In en, this message translates to:
  /// **'Nudity or sexual content'**
  String get socialModerationReasonNudity;

  /// No description provided for @socialModerationReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other policy violation'**
  String get socialModerationReasonOther;

  /// No description provided for @socialModerationReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or misleading content'**
  String get socialModerationReasonSpam;

  /// No description provided for @socialModerationReasonViolence.
  ///
  /// In en, this message translates to:
  /// **'Violence or dangerous content'**
  String get socialModerationReasonViolence;

  /// No description provided for @socialModerationReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get socialModerationReject;

  /// No description provided for @socialModerationRejected.
  ///
  /// In en, this message translates to:
  /// **'Content rejected'**
  String get socialModerationRejected;

  /// No description provided for @socialModerationRejectionReason.
  ///
  /// In en, this message translates to:
  /// **'Rejection Reason'**
  String get socialModerationRejectionReason;

  /// No description provided for @socialModerationReviewedBy.
  ///
  /// In en, this message translates to:
  /// **'Reviewed by {reviewedBy}'**
  String socialModerationReviewedBy(String reviewedBy);

  /// No description provided for @socialModerationTabApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get socialModerationTabApproved;

  /// No description provided for @socialModerationTabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get socialModerationTabPending;

  /// No description provided for @socialModerationTabRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get socialModerationTabRejected;

  /// No description provided for @socialModerationUserLabel.
  ///
  /// In en, this message translates to:
  /// **'User: {userId}'**
  String socialModerationUserLabel(String userId);

  /// No description provided for @socialNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get socialNext;

  /// No description provided for @socialNoAlbumsFound.
  ///
  /// In en, this message translates to:
  /// **'No albums found'**
  String get socialNoAlbumsFound;

  /// No description provided for @socialNoCommentsYet.
  ///
  /// In en, this message translates to:
  /// **'No comments yet. Be the first!'**
  String get socialNoCommentsYet;

  /// No description provided for @socialNoContent.
  ///
  /// In en, this message translates to:
  /// **'No content'**
  String get socialNoContent;

  /// No description provided for @socialNoFollowersYet.
  ///
  /// In en, this message translates to:
  /// **'No followers yet'**
  String get socialNoFollowersYet;

  /// No description provided for @socialNoLocationPosts.
  ///
  /// In en, this message translates to:
  /// **'No location posts'**
  String get socialNoLocationPosts;

  /// No description provided for @socialNoNodePosts.
  ///
  /// In en, this message translates to:
  /// **'No node posts'**
  String get socialNoNodePosts;

  /// No description provided for @socialNoPendingFilterReports.
  ///
  /// In en, this message translates to:
  /// **'No pending {filter} reports'**
  String socialNoPendingFilterReports(String filter);

  /// No description provided for @socialNoPendingReports.
  ///
  /// In en, this message translates to:
  /// **'No pending reports'**
  String get socialNoPendingReports;

  /// No description provided for @socialNoPhotoPosts.
  ///
  /// In en, this message translates to:
  /// **'No photo posts'**
  String get socialNoPhotoPosts;

  /// No description provided for @socialNoPosts.
  ///
  /// In en, this message translates to:
  /// **'No posts'**
  String get socialNoPosts;

  /// No description provided for @socialNoPostsYet.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get socialNoPostsYet;

  /// No description provided for @socialNoReasonProvided.
  ///
  /// In en, this message translates to:
  /// **'No reason provided'**
  String get socialNoReasonProvided;

  /// No description provided for @socialNoRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'No recent activity'**
  String get socialNoRecentActivity;

  /// No description provided for @socialNoSuggestions.
  ///
  /// In en, this message translates to:
  /// **'No suggestions available'**
  String get socialNoSuggestions;

  /// No description provided for @socialNoUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get socialNoUsersFound;

  /// No description provided for @socialNoViewsYet.
  ///
  /// In en, this message translates to:
  /// **'No views yet'**
  String get socialNoViewsYet;

  /// No description provided for @socialNodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Node {nodeId}'**
  String socialNodeLabel(String nodeId);

  /// No description provided for @socialNotFollowingAnyone.
  ///
  /// In en, this message translates to:
  /// **'Not following anyone yet'**
  String get socialNotFollowingAnyone;

  /// No description provided for @socialNoticesCount.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total} notices'**
  String socialNoticesCount(int current, int total);

  /// No description provided for @socialOK.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get socialOK;

  /// No description provided for @socialOnline.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get socialOnline;

  /// No description provided for @socialOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get socialOpenSettings;

  /// No description provided for @socialPermanentlyBanned.
  ///
  /// In en, this message translates to:
  /// **'Permanently Banned'**
  String get socialPermanentlyBanned;

  /// No description provided for @socialPhotoAccessDesc.
  ///
  /// In en, this message translates to:
  /// **'To create stories, we need access to your photo library.'**
  String get socialPhotoAccessDesc;

  /// No description provided for @socialPhotoAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow access to your photos'**
  String get socialPhotoAccessTitle;

  /// No description provided for @socialPostCardLocationFallback.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get socialPostCardLocationFallback;

  /// No description provided for @socialPostCardNodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Node {nodeId}'**
  String socialPostCardNodeLabel(String nodeId);

  /// No description provided for @socialPostCardUnknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown User'**
  String get socialPostCardUnknownUser;

  /// No description provided for @socialPostDeleted.
  ///
  /// In en, this message translates to:
  /// **'Post deleted'**
  String get socialPostDeleted;

  /// No description provided for @socialPostDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get socialPostDetailTitle;

  /// No description provided for @socialPostNotFound.
  ///
  /// In en, this message translates to:
  /// **'Post not found'**
  String get socialPostNotFound;

  /// No description provided for @socialPostNotFoundForComment.
  ///
  /// In en, this message translates to:
  /// **'Post not found for this comment'**
  String get socialPostNotFoundForComment;

  /// No description provided for @socialPrivateAccount.
  ///
  /// In en, this message translates to:
  /// **'This Account is Private'**
  String get socialPrivateAccount;

  /// No description provided for @socialPrivateAccountDesc.
  ///
  /// In en, this message translates to:
  /// **'Follow {name} to see their posts and linked devices.'**
  String socialPrivateAccountDesc(String name);

  /// No description provided for @socialProfileBlockLabel.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get socialProfileBlockLabel;

  /// No description provided for @socialProfileLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get socialProfileLoadFailed;

  /// No description provided for @socialProfileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Profile not found'**
  String get socialProfileNotFound;

  /// No description provided for @socialProfileNotFoundDesc.
  ///
  /// In en, this message translates to:
  /// **'This profile may have been removed or is temporarily unavailable.'**
  String get socialProfileNotFoundDesc;

  /// No description provided for @socialProfileReportLabel.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get socialProfileReportLabel;

  /// No description provided for @socialProfileShareLabel.
  ///
  /// In en, this message translates to:
  /// **'Share Profile'**
  String get socialProfileShareLabel;

  /// No description provided for @socialReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get socialReason;

  /// No description provided for @socialRecentFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load recent users'**
  String get socialRecentFailed;

  /// No description provided for @socialRecentlyActive.
  ///
  /// In en, this message translates to:
  /// **'Recently active'**
  String get socialRecentlyActive;

  /// No description provided for @socialRejectDelete.
  ///
  /// In en, this message translates to:
  /// **'Reject & Delete'**
  String get socialRejectDelete;

  /// No description provided for @socialRejectDeleteMsg.
  ///
  /// In en, this message translates to:
  /// **'This will delete the {contentType} and warn the user.'**
  String socialRejectDeleteMsg(String contentType);

  /// No description provided for @socialRemoveBanner.
  ///
  /// In en, this message translates to:
  /// **'Remove banner'**
  String get socialRemoveBanner;

  /// No description provided for @socialReply.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get socialReply;

  /// No description provided for @socialReplyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to {name}'**
  String socialReplyingTo(String name);

  /// No description provided for @socialReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get socialReport;

  /// No description provided for @socialReportCommentTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Comment'**
  String get socialReportCommentTitle;

  /// No description provided for @socialReportCommentWhy.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this comment?'**
  String get socialReportCommentWhy;

  /// No description provided for @socialReportDescribeIssue.
  ///
  /// In en, this message translates to:
  /// **'Describe the issue...'**
  String get socialReportDescribeIssue;

  /// No description provided for @socialReportDismissed.
  ///
  /// In en, this message translates to:
  /// **'Report dismissed'**
  String get socialReportDismissed;

  /// No description provided for @socialReportPost.
  ///
  /// In en, this message translates to:
  /// **'Report Post'**
  String get socialReportPost;

  /// No description provided for @socialReportPostWhy.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this post?'**
  String get socialReportPostWhy;

  /// No description provided for @socialReportProfileSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted'**
  String get socialReportProfileSubmitted;

  /// No description provided for @socialReportReasonFalseInfo.
  ///
  /// In en, this message translates to:
  /// **'False information'**
  String get socialReportReasonFalseInfo;

  /// No description provided for @socialReportReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment or bullying'**
  String get socialReportReasonHarassment;

  /// No description provided for @socialReportReasonHateSpeech.
  ///
  /// In en, this message translates to:
  /// **'Hate speech'**
  String get socialReportReasonHateSpeech;

  /// No description provided for @socialReportReasonNudity.
  ///
  /// In en, this message translates to:
  /// **'Nudity or sexual content'**
  String get socialReportReasonNudity;

  /// No description provided for @socialReportReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get socialReportReasonOther;

  /// No description provided for @socialReportReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam'**
  String get socialReportReasonSpam;

  /// No description provided for @socialReportReasonViolence.
  ///
  /// In en, this message translates to:
  /// **'Violence or threats'**
  String get socialReportReasonViolence;

  /// No description provided for @socialReportStory.
  ///
  /// In en, this message translates to:
  /// **'Report story'**
  String get socialReportStory;

  /// No description provided for @socialReportStoryReasonCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright violation'**
  String get socialReportStoryReasonCopyright;

  /// No description provided for @socialReportStoryReasonHarassment.
  ///
  /// In en, this message translates to:
  /// **'Harassment or bullying'**
  String get socialReportStoryReasonHarassment;

  /// No description provided for @socialReportStoryReasonNudity.
  ///
  /// In en, this message translates to:
  /// **'Nudity or sexual content'**
  String get socialReportStoryReasonNudity;

  /// No description provided for @socialReportStoryReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get socialReportStoryReasonOther;

  /// No description provided for @socialReportStoryReasonSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or misleading'**
  String get socialReportStoryReasonSpam;

  /// No description provided for @socialReportStoryReasonViolence.
  ///
  /// In en, this message translates to:
  /// **'Violence or dangerous content'**
  String get socialReportStoryReasonViolence;

  /// No description provided for @socialReportStoryWhy.
  ///
  /// In en, this message translates to:
  /// **'Why are you reporting this story?'**
  String get socialReportStoryWhy;

  /// No description provided for @socialReportSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Report submitted. Thank you.'**
  String get socialReportSubmitted;

  /// No description provided for @socialReportedContentApproved.
  ///
  /// In en, this message translates to:
  /// **'Content approved'**
  String get socialReportedContentApproved;

  /// No description provided for @socialReportedContentRejected.
  ///
  /// In en, this message translates to:
  /// **'Content rejected and user warned'**
  String get socialReportedContentRejected;

  /// No description provided for @socialReportedContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Reported Content'**
  String get socialReportedContentTitle;

  /// No description provided for @socialReportedErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading moderation queue'**
  String get socialReportedErrorLoading;

  /// No description provided for @socialReportedNoFlagged.
  ///
  /// In en, this message translates to:
  /// **'No flagged content'**
  String get socialReportedNoFlagged;

  /// No description provided for @socialReportedNoFlaggedDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto-moderation has not flagged any content'**
  String get socialReportedNoFlaggedDesc;

  /// No description provided for @socialReportedTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get socialReportedTabAll;

  /// No description provided for @socialReportedTabAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get socialReportedTabAuto;

  /// No description provided for @socialReportedTabComments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get socialReportedTabComments;

  /// No description provided for @socialReportedTabPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get socialReportedTabPosts;

  /// No description provided for @socialReportedTabSigComments.
  ///
  /// In en, this message translates to:
  /// **'Sig. Comments'**
  String get socialReportedTabSigComments;

  /// No description provided for @socialReportedTabSignals.
  ///
  /// In en, this message translates to:
  /// **'Signals'**
  String get socialReportedTabSignals;

  /// No description provided for @socialRequested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get socialRequested;

  /// No description provided for @socialRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get socialRetry;

  /// No description provided for @socialSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Search failed: {error}'**
  String socialSearchFailed(String error);

  /// No description provided for @socialSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search users...'**
  String get socialSearchHint;

  /// No description provided for @socialSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get socialSearchTitle;

  /// No description provided for @socialSearchTooltip.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get socialSearchTooltip;

  /// No description provided for @socialSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get socialSendMessage;

  /// No description provided for @socialSensitiveContentControl.
  ///
  /// In en, this message translates to:
  /// **'Sensitive Content Control'**
  String get socialSensitiveContentControl;

  /// No description provided for @socialSensitiveContentExplanation.
  ///
  /// In en, this message translates to:
  /// **'Control what type of content you see in your feed. This affects AI-moderated content filtering across posts, signals, and stories.'**
  String get socialSensitiveContentExplanation;

  /// No description provided for @socialSensitiveContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Sensitive Content'**
  String get socialSensitiveContentTitle;

  /// No description provided for @socialSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get socialSettingsTooltip;

  /// No description provided for @socialShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get socialShare;

  /// No description provided for @socialShareFirstPostKeyword.
  ///
  /// In en, this message translates to:
  /// **'post'**
  String get socialShareFirstPostKeyword;

  /// No description provided for @socialShareFirstPostPrefix.
  ///
  /// In en, this message translates to:
  /// **'Share your first '**
  String get socialShareFirstPostPrefix;

  /// No description provided for @socialSharePhotoHint.
  ///
  /// In en, this message translates to:
  /// **'Share a photo post to see it here'**
  String get socialSharePhotoHint;

  /// No description provided for @socialSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get socialSignIn;

  /// No description provided for @socialSignInSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage subscriptions'**
  String get socialSignInSubscriptions;

  /// No description provided for @socialSignalCommentLabel.
  ///
  /// In en, this message translates to:
  /// **'SIGNAL COMMENT'**
  String get socialSignalCommentLabel;

  /// No description provided for @socialSignalContentNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Signal content not available'**
  String get socialSignalContentNotAvailable;

  /// No description provided for @socialSignalIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Signal: {id}'**
  String socialSignalIdLabel(String id);

  /// No description provided for @socialSignalLabel.
  ///
  /// In en, this message translates to:
  /// **'SIGNAL'**
  String get socialSignalLabel;

  /// No description provided for @socialStatFollower.
  ///
  /// In en, this message translates to:
  /// **'Follower'**
  String get socialStatFollower;

  /// No description provided for @socialStatFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get socialStatFollowers;

  /// No description provided for @socialStatFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get socialStatFollowing;

  /// No description provided for @socialStatPost.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get socialStatPost;

  /// No description provided for @socialStatPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get socialStatPosts;

  /// No description provided for @socialStatsBarFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get socialStatsBarFollowers;

  /// No description provided for @socialStatsBarFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get socialStatsBarFollowing;

  /// No description provided for @socialStatsBarPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get socialStatsBarPosts;

  /// No description provided for @socialStatusFlagged.
  ///
  /// In en, this message translates to:
  /// **'FLAGGED'**
  String get socialStatusFlagged;

  /// No description provided for @socialStatusPending.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get socialStatusPending;

  /// No description provided for @socialStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'REJECTED'**
  String get socialStatusRejected;

  /// No description provided for @socialStatusStrike.
  ///
  /// In en, this message translates to:
  /// **'STRIKE'**
  String get socialStatusStrike;

  /// No description provided for @socialStatusSuspended.
  ///
  /// In en, this message translates to:
  /// **'SUSPENDED'**
  String get socialStatusSuspended;

  /// No description provided for @socialStoryBarAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get socialStoryBarAdd;

  /// No description provided for @socialStoryContentUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Content unavailable'**
  String get socialStoryContentUnavailable;

  /// No description provided for @socialStoryDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete story: {error}'**
  String socialStoryDeleteFailed(String error);

  /// No description provided for @socialStoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Story deleted'**
  String get socialStoryDeleted;

  /// No description provided for @socialStoryLabel.
  ///
  /// In en, this message translates to:
  /// **'STORY'**
  String get socialStoryLabel;

  /// No description provided for @socialStoryMayBeRemoved.
  ///
  /// In en, this message translates to:
  /// **'This story may have been removed'**
  String get socialStoryMayBeRemoved;

  /// No description provided for @socialStoryReported.
  ///
  /// In en, this message translates to:
  /// **'Story reported. We\'ll review it soon.'**
  String get socialStoryReported;

  /// No description provided for @socialStoryUserFallback.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get socialStoryUserFallback;

  /// No description provided for @socialStrike3Suspension.
  ///
  /// In en, this message translates to:
  /// **'3 strikes result in account suspension'**
  String get socialStrike3Suspension;

  /// No description provided for @socialStrikeAcknowledge.
  ///
  /// In en, this message translates to:
  /// **'I Understand'**
  String get socialStrikeAcknowledge;

  /// No description provided for @socialStrikeAgainstAccount.
  ///
  /// In en, this message translates to:
  /// **'Strike Against Your Account'**
  String get socialStrikeAgainstAccount;

  /// No description provided for @socialStrikeContentLabel.
  ///
  /// In en, this message translates to:
  /// **'Content: {type}'**
  String socialStrikeContentLabel(String type);

  /// No description provided for @socialStrikeContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Content {typeDisplayName}'**
  String socialStrikeContentTitle(String typeDisplayName);

  /// No description provided for @socialStrikeError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String socialStrikeError(String error);

  /// No description provided for @socialStrikeNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get socialStrikeNext;

  /// No description provided for @socialStrikeOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{current} of {total}'**
  String socialStrikeOfTotal(int current, int total);

  /// No description provided for @socialStrikeReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get socialStrikeReasonLabel;

  /// No description provided for @socialStrikeReceivedStrike.
  ///
  /// In en, this message translates to:
  /// **'You have received a strike on your account due to a community guideline violation.'**
  String get socialStrikeReceivedStrike;

  /// No description provided for @socialStrikeReceivedWarning.
  ///
  /// In en, this message translates to:
  /// **'You have received a warning. Please review our community guidelines.'**
  String get socialStrikeReceivedWarning;

  /// No description provided for @socialStrikeTapReview.
  ///
  /// In en, this message translates to:
  /// **'You have {count} strike(s) - tap to review'**
  String socialStrikeTapReview(int count);

  /// No description provided for @socialStrikesExpireInfo.
  ///
  /// In en, this message translates to:
  /// **'Strikes expire after 90 days of no violations.'**
  String get socialStrikesExpireInfo;

  /// No description provided for @socialStrikesOnAccount.
  ///
  /// In en, this message translates to:
  /// **'{count} active strike(s) on your account'**
  String socialStrikesOnAccount(int count);

  /// No description provided for @socialSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get socialSubscribe;

  /// No description provided for @socialSubscribed.
  ///
  /// In en, this message translates to:
  /// **'Subscribed'**
  String get socialSubscribed;

  /// No description provided for @socialSubscriptionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update subscription: {error}'**
  String socialSubscriptionFailed(String error);

  /// No description provided for @socialSuggestedForYou.
  ///
  /// In en, this message translates to:
  /// **'Suggested for you'**
  String get socialSuggestedForYou;

  /// No description provided for @socialSuggestionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load suggestions'**
  String get socialSuggestionsFailed;

  /// No description provided for @socialSuspendedContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support to appeal this decision'**
  String get socialSuspendedContactSupport;

  /// No description provided for @socialSuspendedDaysPlural.
  ///
  /// In en, this message translates to:
  /// **'{n} days'**
  String socialSuspendedDaysPlural(int n);

  /// No description provided for @socialSuspendedDaysSingular.
  ///
  /// In en, this message translates to:
  /// **'{n} day'**
  String socialSuspendedDaysSingular(int n);

  /// No description provided for @socialSuspendedDefaultReason.
  ///
  /// In en, this message translates to:
  /// **'Your account has been suspended due to repeated violations of our community guidelines.'**
  String get socialSuspendedDefaultReason;

  /// No description provided for @socialSuspendedGoBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get socialSuspendedGoBack;

  /// No description provided for @socialSuspendedHoursPlural.
  ///
  /// In en, this message translates to:
  /// **'{n} hours'**
  String socialSuspendedHoursPlural(int n);

  /// No description provided for @socialSuspendedHoursSingular.
  ///
  /// In en, this message translates to:
  /// **'{n} hour'**
  String socialSuspendedHoursSingular(int n);

  /// No description provided for @socialSuspendedIndefinite.
  ///
  /// In en, this message translates to:
  /// **'Indefinite suspension'**
  String get socialSuspendedIndefinite;

  /// No description provided for @socialSuspendedIndefinitely.
  ///
  /// In en, this message translates to:
  /// **'indefinitely'**
  String get socialSuspendedIndefinitely;

  /// No description provided for @socialSuspendedLabel.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get socialSuspendedLabel;

  /// No description provided for @socialSuspendedMinutesPlural.
  ///
  /// In en, this message translates to:
  /// **'{n} minutes'**
  String socialSuspendedMinutesPlural(int n);

  /// No description provided for @socialSuspendedMinutesSingular.
  ///
  /// In en, this message translates to:
  /// **'{n} minute'**
  String socialSuspendedMinutesSingular(int n);

  /// No description provided for @socialSuspendedPermanent.
  ///
  /// In en, this message translates to:
  /// **'Account Suspended'**
  String get socialSuspendedPermanent;

  /// No description provided for @socialSuspendedRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining: {duration}'**
  String socialSuspendedRemaining(String duration);

  /// No description provided for @socialSuspendedReviewGuidelines.
  ///
  /// In en, this message translates to:
  /// **'Review our community guidelines'**
  String get socialSuspendedReviewGuidelines;

  /// No description provided for @socialSuspendedShortly.
  ///
  /// In en, this message translates to:
  /// **'shortly'**
  String get socialSuspendedShortly;

  /// No description provided for @socialSuspendedStrikesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} strike(s) on your account'**
  String socialSuspendedStrikesCount(int count);

  /// No description provided for @socialSuspendedTemporary.
  ///
  /// In en, this message translates to:
  /// **'Posting Temporarily Suspended'**
  String get socialSuspendedTemporary;

  /// No description provided for @socialSuspendedWaitAppeal.
  ///
  /// In en, this message translates to:
  /// **'Wait for your appeal to be reviewed'**
  String get socialSuspendedWaitAppeal;

  /// No description provided for @socialSuspendedWaitPeriod.
  ///
  /// In en, this message translates to:
  /// **'Wait for the suspension period to end'**
  String get socialSuspendedWaitPeriod;

  /// No description provided for @socialSuspendedWhatCanIDo.
  ///
  /// In en, this message translates to:
  /// **'What can I do?'**
  String get socialSuspendedWhatCanIDo;

  /// No description provided for @socialSuspendedWhyTitle.
  ///
  /// In en, this message translates to:
  /// **'Why am I seeing this?'**
  String get socialSuspendedWhyTitle;

  /// No description provided for @socialSuspensionEnds.
  ///
  /// In en, this message translates to:
  /// **'Suspension Ends'**
  String get socialSuspensionEnds;

  /// No description provided for @socialTabFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get socialTabFollowers;

  /// No description provided for @socialTabFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get socialTabFollowing;

  /// No description provided for @socialTagLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Tag a location in your next post'**
  String get socialTagLocationHint;

  /// No description provided for @socialTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{n}d ago'**
  String socialTimeDaysAgo(int n);

  /// No description provided for @socialTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{n}h ago'**
  String socialTimeHoursAgo(int n);

  /// No description provided for @socialTimeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get socialTimeJustNow;

  /// No description provided for @socialTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{n}m ago'**
  String socialTimeMinutesAgo(int n);

  /// No description provided for @socialTryDifferentFilter.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different filter'**
  String get socialTryDifferentFilter;

  /// No description provided for @socialTryDifferentSearch.
  ///
  /// In en, this message translates to:
  /// **'Try a different search term'**
  String get socialTryDifferentSearch;

  /// No description provided for @socialTypeDeleted.
  ///
  /// In en, this message translates to:
  /// **'{type} deleted'**
  String socialTypeDeleted(String type);

  /// No description provided for @socialUnfollow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get socialUnfollow;

  /// No description provided for @socialUnknownUser.
  ///
  /// In en, this message translates to:
  /// **'Unknown User'**
  String get socialUnknownUser;

  /// No description provided for @socialUnsubscribed.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribed'**
  String get socialUnsubscribed;

  /// No description provided for @socialUnsuspend.
  ///
  /// In en, this message translates to:
  /// **'Unsuspend'**
  String get socialUnsuspend;

  /// No description provided for @socialUnsuspendConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to lift the suspension on this user?'**
  String get socialUnsuspendConfirm;

  /// No description provided for @socialUnsuspendUser.
  ///
  /// In en, this message translates to:
  /// **'Unsuspend User'**
  String get socialUnsuspendUser;

  /// No description provided for @socialUserBannedAndDeleted.
  ///
  /// In en, this message translates to:
  /// **'User banned and {type} deleted'**
  String socialUserBannedAndDeleted(String type);

  /// No description provided for @socialUserBlocked.
  ///
  /// In en, this message translates to:
  /// **'User blocked'**
  String get socialUserBlocked;

  /// No description provided for @socialUserBlockedName.
  ///
  /// In en, this message translates to:
  /// **'{name} blocked'**
  String socialUserBlockedName(String name);

  /// No description provided for @socialUserFallback.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get socialUserFallback;

  /// No description provided for @socialUserUnsuspended.
  ///
  /// In en, this message translates to:
  /// **'User unsuspended successfully'**
  String get socialUserUnsuspended;

  /// No description provided for @socialVideoContent.
  ///
  /// In en, this message translates to:
  /// **'Video content'**
  String get socialVideoContent;

  /// No description provided for @socialView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get socialView;

  /// No description provided for @socialViewLabel.
  ///
  /// In en, this message translates to:
  /// **'view'**
  String get socialViewLabel;

  /// No description provided for @socialViewLocation.
  ///
  /// In en, this message translates to:
  /// **'View location'**
  String get socialViewLocation;

  /// No description provided for @socialViewOnMap.
  ///
  /// In en, this message translates to:
  /// **'View on Map'**
  String get socialViewOnMap;

  /// No description provided for @socialViewersTitle.
  ///
  /// In en, this message translates to:
  /// **'Viewers'**
  String get socialViewersTitle;

  /// No description provided for @socialViewsLabel.
  ///
  /// In en, this message translates to:
  /// **'views'**
  String get socialViewsLabel;

  /// No description provided for @socialViolationsDetected.
  ///
  /// In en, this message translates to:
  /// **'Violations Detected'**
  String get socialViolationsDetected;

  /// No description provided for @socialVisibilityFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get socialVisibilityFollowers;

  /// No description provided for @socialVisibilityFollowersDesc.
  ///
  /// In en, this message translates to:
  /// **'Only your followers can see this'**
  String get socialVisibilityFollowersDesc;

  /// No description provided for @socialVisibilityOnlyMe.
  ///
  /// In en, this message translates to:
  /// **'Only me'**
  String get socialVisibilityOnlyMe;

  /// No description provided for @socialVisibilityOnlyMeDesc.
  ///
  /// In en, this message translates to:
  /// **'Only you can see this post'**
  String get socialVisibilityOnlyMeDesc;

  /// No description provided for @socialVisibilityPublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get socialVisibilityPublic;

  /// No description provided for @socialVisibilityPublicDesc.
  ///
  /// In en, this message translates to:
  /// **'Anyone can see this post'**
  String get socialVisibilityPublicDesc;

  /// No description provided for @socialVisibilityWhoCanSee.
  ///
  /// In en, this message translates to:
  /// **'Who can see this?'**
  String get socialVisibilityWhoCanSee;

  /// No description provided for @socialWarningsOnAccount.
  ///
  /// In en, this message translates to:
  /// **'{count} active warning(s) on your account'**
  String socialWarningsOnAccount(int count);

  /// No description provided for @socialWarningsTapReview.
  ///
  /// In en, this message translates to:
  /// **'You have {count} warning(s) - tap to review'**
  String socialWarningsTapReview(int count);

  /// No description provided for @socialYourStory.
  ///
  /// In en, this message translates to:
  /// **'Your story'**
  String get socialYourStory;

  /// Header label in the tapback reaction picker.
  ///
  /// In en, this message translates to:
  /// **'React'**
  String get tapbackReact;

  /// No description provided for @telemetryConfigAirQualityDesc.
  ///
  /// In en, this message translates to:
  /// **'PM1.0, PM2.5, PM10, particle counts, CO2'**
  String get telemetryConfigAirQualityDesc;

  /// No description provided for @telemetryConfigAirtimeWarning.
  ///
  /// In en, this message translates to:
  /// **'Telemetry data is shared with all nodes on the mesh network. Shorter intervals increase airtime usage.'**
  String get telemetryConfigAirtimeWarning;

  /// No description provided for @telemetryConfigDeviceMetricsDesc.
  ///
  /// In en, this message translates to:
  /// **'Battery level, voltage, channel utilization, air util TX'**
  String get telemetryConfigDeviceMetricsDesc;

  /// No description provided for @telemetryConfigDisplayFahrenheit.
  ///
  /// In en, this message translates to:
  /// **'Display Fahrenheit'**
  String get telemetryConfigDisplayFahrenheit;

  /// No description provided for @telemetryConfigDisplayFahrenheitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show temperature in Fahrenheit instead of Celsius'**
  String get telemetryConfigDisplayFahrenheitSubtitle;

  /// No description provided for @telemetryConfigDisplayOnScreen.
  ///
  /// In en, this message translates to:
  /// **'Display on Screen'**
  String get telemetryConfigDisplayOnScreen;

  /// No description provided for @telemetryConfigDisplayOnScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show environment data on device screen'**
  String get telemetryConfigDisplayOnScreenSubtitle;

  /// No description provided for @telemetryConfigEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get telemetryConfigEnabled;

  /// No description provided for @telemetryConfigEnvironmentMetricsDesc.
  ///
  /// In en, this message translates to:
  /// **'Temperature, humidity, barometric pressure, gas resistance'**
  String get telemetryConfigEnvironmentMetricsDesc;

  /// No description provided for @telemetryConfigMinutes.
  ///
  /// In en, this message translates to:
  /// **' minutes'**
  String get telemetryConfigMinutes;

  /// No description provided for @telemetryConfigPowerMetricsDesc.
  ///
  /// In en, this message translates to:
  /// **'Voltage and current for channels 1-3'**
  String get telemetryConfigPowerMetricsDesc;

  /// No description provided for @telemetryConfigSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get telemetryConfigSave;

  /// No description provided for @telemetryConfigSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save: {error}'**
  String telemetryConfigSaveError(String error);

  /// No description provided for @telemetryConfigSaved.
  ///
  /// In en, this message translates to:
  /// **'Telemetry config saved'**
  String get telemetryConfigSaved;

  /// No description provided for @telemetryConfigSectionAirQuality.
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get telemetryConfigSectionAirQuality;

  /// No description provided for @telemetryConfigSectionDeviceMetrics.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get telemetryConfigSectionDeviceMetrics;

  /// No description provided for @telemetryConfigSectionEnvironmentMetrics.
  ///
  /// In en, this message translates to:
  /// **'Environment Metrics'**
  String get telemetryConfigSectionEnvironmentMetrics;

  /// No description provided for @telemetryConfigSectionPowerMetrics.
  ///
  /// In en, this message translates to:
  /// **'Power Metrics'**
  String get telemetryConfigSectionPowerMetrics;

  /// No description provided for @telemetryConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Telemetry'**
  String get telemetryConfigTitle;

  /// No description provided for @telemetryConfigUpdateInterval.
  ///
  /// In en, this message translates to:
  /// **'Update Interval'**
  String get telemetryConfigUpdateInterval;

  /// No description provided for @worldMeshAddToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get worldMeshAddToFavorites;

  /// No description provided for @worldMeshAddedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get worldMeshAddedToFavorites;

  /// No description provided for @worldMeshBadgeActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get worldMeshBadgeActive;

  /// No description provided for @worldMeshCoordinatesCopied.
  ///
  /// In en, this message translates to:
  /// **'Coordinates copied to clipboard'**
  String get worldMeshCoordinatesCopied;

  /// No description provided for @worldMeshCopyCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Copy Coordinates'**
  String get worldMeshCopyCoordinates;

  /// No description provided for @worldMeshCopyCoordinatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Both A and B coordinates'**
  String get worldMeshCopyCoordinatesSubtitle;

  /// No description provided for @worldMeshCopyId.
  ///
  /// In en, this message translates to:
  /// **'Copy ID'**
  String get worldMeshCopyId;

  /// No description provided for @worldMeshCopySummary.
  ///
  /// In en, this message translates to:
  /// **'Copy Summary'**
  String get worldMeshCopySummary;

  /// No description provided for @worldMeshErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Unable to load mesh map'**
  String get worldMeshErrorTitle;

  /// No description provided for @worldMeshExitMeasureMode.
  ///
  /// In en, this message translates to:
  /// **'Exit measure mode'**
  String get worldMeshExitMeasureMode;

  /// No description provided for @worldMeshFavoritesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get worldMeshFavoritesTooltip;

  /// No description provided for @worldMeshFilterActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 filter} other{{count} filters}}'**
  String worldMeshFilterActiveCount(int count);

  /// No description provided for @worldMeshFilterAny.
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get worldMeshFilterAny;

  /// No description provided for @worldMeshFilterBatteryInfo.
  ///
  /// In en, this message translates to:
  /// **'Battery Info'**
  String get worldMeshFilterBatteryInfo;

  /// No description provided for @worldMeshFilterCatBatteryInfo.
  ///
  /// In en, this message translates to:
  /// **'Battery Info'**
  String get worldMeshFilterCatBatteryInfo;

  /// No description provided for @worldMeshFilterCatEnvSensors.
  ///
  /// In en, this message translates to:
  /// **'Environment Sensors'**
  String get worldMeshFilterCatEnvSensors;

  /// No description provided for @worldMeshFilterCatFirmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get worldMeshFilterCatFirmware;

  /// No description provided for @worldMeshFilterCatHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get worldMeshFilterCatHardware;

  /// No description provided for @worldMeshFilterCatModemPreset.
  ///
  /// In en, this message translates to:
  /// **'Modem Preset'**
  String get worldMeshFilterCatModemPreset;

  /// No description provided for @worldMeshFilterCatRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get worldMeshFilterCatRegion;

  /// No description provided for @worldMeshFilterCatRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get worldMeshFilterCatRole;

  /// No description provided for @worldMeshFilterCatStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get worldMeshFilterCatStatus;

  /// No description provided for @worldMeshFilterClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get worldMeshFilterClearAll;

  /// No description provided for @worldMeshFilterEnvironmentSensors.
  ///
  /// In en, this message translates to:
  /// **'Environment Sensors'**
  String get worldMeshFilterEnvironmentSensors;

  /// No description provided for @worldMeshFilterFirmwareVersion.
  ///
  /// In en, this message translates to:
  /// **'Firmware Version'**
  String get worldMeshFilterFirmwareVersion;

  /// No description provided for @worldMeshFilterHardwareModel.
  ///
  /// In en, this message translates to:
  /// **'Hardware Model'**
  String get worldMeshFilterHardwareModel;

  /// No description provided for @worldMeshFilterModemPreset.
  ///
  /// In en, this message translates to:
  /// **'Modem Preset'**
  String get worldMeshFilterModemPreset;

  /// No description provided for @worldMeshFilterNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get worldMeshFilterNo;

  /// No description provided for @worldMeshFilterNoOptions.
  ///
  /// In en, this message translates to:
  /// **'No options available'**
  String get worldMeshFilterNoOptions;

  /// No description provided for @worldMeshFilterNodeCount.
  ///
  /// In en, this message translates to:
  /// **'{filteredCount} of {totalCount} nodes'**
  String worldMeshFilterNodeCount(int filteredCount, int totalCount);

  /// No description provided for @worldMeshFilterNodeRole.
  ///
  /// In en, this message translates to:
  /// **'Node Role'**
  String get worldMeshFilterNodeRole;

  /// No description provided for @worldMeshFilterNodesWithBattery.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes with battery data'**
  String worldMeshFilterNodesWithBattery(int count);

  /// No description provided for @worldMeshFilterNodesWithSensors.
  ///
  /// In en, this message translates to:
  /// **'{count} nodes with sensors'**
  String worldMeshFilterNodesWithSensors(int count);

  /// No description provided for @worldMeshFilterRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get worldMeshFilterRegion;

  /// No description provided for @worldMeshFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get worldMeshFilterStatus;

  /// No description provided for @worldMeshFilterStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active (≤2m)'**
  String get worldMeshFilterStatusActive;

  /// No description provided for @worldMeshFilterStatusFading.
  ///
  /// In en, this message translates to:
  /// **'Fading (2-10m)'**
  String get worldMeshFilterStatusFading;

  /// No description provided for @worldMeshFilterStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive (10-60m)'**
  String get worldMeshFilterStatusInactive;

  /// No description provided for @worldMeshFilterStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown (>60m)'**
  String get worldMeshFilterStatusUnknown;

  /// No description provided for @worldMeshFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Nodes'**
  String get worldMeshFilterTitle;

  /// No description provided for @worldMeshFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter nodes'**
  String get worldMeshFilterTooltip;

  /// No description provided for @worldMeshFilterYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get worldMeshFilterYes;

  /// No description provided for @worldMeshFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get worldMeshFocus;

  /// No description provided for @worldMeshFsplSubtitle.
  ///
  /// In en, this message translates to:
  /// **'FSPL: {db} dB'**
  String worldMeshFsplSubtitle(String db);

  /// No description provided for @worldMeshHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get worldMeshHelp;

  /// No description provided for @worldMeshInfoAltitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get worldMeshInfoAltitude;

  /// No description provided for @worldMeshInfoCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get worldMeshInfoCoordinates;

  /// No description provided for @worldMeshInfoFirmware.
  ///
  /// In en, this message translates to:
  /// **'Firmware'**
  String get worldMeshInfoFirmware;

  /// No description provided for @worldMeshInfoHardware.
  ///
  /// In en, this message translates to:
  /// **'Hardware'**
  String get worldMeshInfoHardware;

  /// No description provided for @worldMeshInfoLocalNodes.
  ///
  /// In en, this message translates to:
  /// **'Local Nodes'**
  String get worldMeshInfoLocalNodes;

  /// No description provided for @worldMeshInfoModem.
  ///
  /// In en, this message translates to:
  /// **'Modem'**
  String get worldMeshInfoModem;

  /// No description provided for @worldMeshInfoPrecision.
  ///
  /// In en, this message translates to:
  /// **'Precision'**
  String get worldMeshInfoPrecision;

  /// No description provided for @worldMeshInfoRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get worldMeshInfoRegion;

  /// No description provided for @worldMeshInfoRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get worldMeshInfoRole;

  /// No description provided for @worldMeshLastSeen.
  ///
  /// In en, this message translates to:
  /// **'Last seen: {time}'**
  String worldMeshLastSeen(String time);

  /// No description provided for @worldMeshLegendActive.
  ///
  /// In en, this message translates to:
  /// **'Active (<1h)'**
  String get worldMeshLegendActive;

  /// No description provided for @worldMeshLegendIdle.
  ///
  /// In en, this message translates to:
  /// **'Idle (1-24h)'**
  String get worldMeshLegendIdle;

  /// No description provided for @worldMeshLegendOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline (>24h)'**
  String get worldMeshLegendOffline;

  /// No description provided for @worldMeshLinkBudgetCopied.
  ///
  /// In en, this message translates to:
  /// **'Link budget copied to clipboard'**
  String get worldMeshLinkBudgetCopied;

  /// No description provided for @worldMeshLoadingNodeInfo.
  ///
  /// In en, this message translates to:
  /// **'Loading node info...'**
  String get worldMeshLoadingNodeInfo;

  /// No description provided for @worldMeshLongPressHint.
  ///
  /// In en, this message translates to:
  /// **'Long-press for actions'**
  String get worldMeshLongPressHint;

  /// No description provided for @worldMeshLosAnalysis.
  ///
  /// In en, this message translates to:
  /// **'LOS Analysis'**
  String get worldMeshLosAnalysis;

  /// No description provided for @worldMeshLosBulgeAndFresnel.
  ///
  /// In en, this message translates to:
  /// **'Bulge: {bulge}m · F1: {fresnel}m'**
  String worldMeshLosBulgeAndFresnel(String bulge, String fresnel);

  /// No description provided for @worldMeshLosSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Earth curvature + Fresnel zone check'**
  String get worldMeshLosSubtitle;

  /// No description provided for @worldMeshLosVerdict.
  ///
  /// In en, this message translates to:
  /// **'LOS: {verdict}'**
  String worldMeshLosVerdict(String verdict);

  /// No description provided for @worldMeshMapStyleDark.
  ///
  /// In en, this message translates to:
  /// **'Dark Map'**
  String get worldMeshMapStyleDark;

  /// No description provided for @worldMeshMapStyleLight.
  ///
  /// In en, this message translates to:
  /// **'Light Map'**
  String get worldMeshMapStyleLight;

  /// No description provided for @worldMeshMapStyleSatellite.
  ///
  /// In en, this message translates to:
  /// **'Satellite'**
  String get worldMeshMapStyleSatellite;

  /// No description provided for @worldMeshMapStyleTerrain.
  ///
  /// In en, this message translates to:
  /// **'Terrain'**
  String get worldMeshMapStyleTerrain;

  /// No description provided for @worldMeshMeasurePointA.
  ///
  /// In en, this message translates to:
  /// **'A'**
  String get worldMeshMeasurePointA;

  /// No description provided for @worldMeshMeasurePointB.
  ///
  /// In en, this message translates to:
  /// **'B'**
  String get worldMeshMeasurePointB;

  /// No description provided for @worldMeshMeasureTapA.
  ///
  /// In en, this message translates to:
  /// **'Tap node or map for point A'**
  String get worldMeshMeasureTapA;

  /// No description provided for @worldMeshMeasureTapB.
  ///
  /// In en, this message translates to:
  /// **'Tap node or map for point B'**
  String get worldMeshMeasureTapB;

  /// No description provided for @worldMeshMeasurementActions.
  ///
  /// In en, this message translates to:
  /// **'Measurement Actions'**
  String get worldMeshMeasurementActions;

  /// No description provided for @worldMeshMeasurementCopied.
  ///
  /// In en, this message translates to:
  /// **'Measurement copied to clipboard'**
  String get worldMeshMeasurementCopied;

  /// No description provided for @worldMeshMoreGateways.
  ///
  /// In en, this message translates to:
  /// **' +{count} more'**
  String worldMeshMoreGateways(int count);

  /// No description provided for @worldMeshNewMeasurement.
  ///
  /// In en, this message translates to:
  /// **'New measurement'**
  String get worldMeshNewMeasurement;

  /// No description provided for @worldMeshNodeIdCopied.
  ///
  /// In en, this message translates to:
  /// **'Node ID copied'**
  String get worldMeshNodeIdCopied;

  /// No description provided for @worldMeshOpenMidpointInMaps.
  ///
  /// In en, this message translates to:
  /// **'Open Midpoint in Maps'**
  String get worldMeshOpenMidpointInMaps;

  /// No description provided for @worldMeshOpenMidpointSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open in external map app'**
  String get worldMeshOpenMidpointSubtitle;

  /// No description provided for @worldMeshRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get worldMeshRefresh;

  /// No description provided for @worldMeshRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing world mesh data...'**
  String get worldMeshRefreshing;

  /// No description provided for @worldMeshRemoveFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get worldMeshRemoveFromFavorites;

  /// No description provided for @worldMeshRemovedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get worldMeshRemovedFromFavorites;

  /// No description provided for @worldMeshRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get worldMeshRetry;

  /// No description provided for @worldMeshRfLinkBudget.
  ///
  /// In en, this message translates to:
  /// **'RF Link Budget'**
  String get worldMeshRfLinkBudget;

  /// No description provided for @worldMeshRfLinkBudgetClipboard.
  ///
  /// In en, this message translates to:
  /// **'RF Link Budget (free-space path loss)\nDistance: {distance}\nFrequency: {frequency}\nPath Loss: {pathLoss}\nLink Margin: {linkMargin}'**
  String worldMeshRfLinkBudgetClipboard(
    String distance,
    String frequency,
    String pathLoss,
    String linkMargin,
  );

  /// No description provided for @worldMeshScrollForMore.
  ///
  /// In en, this message translates to:
  /// **'Scroll for more...'**
  String get worldMeshScrollForMore;

  /// No description provided for @worldMeshSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Find a node'**
  String get worldMeshSearchHint;

  /// No description provided for @worldMeshSearchResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 node found} other{{count} nodes found}}'**
  String worldMeshSearchResultCount(int count);

  /// No description provided for @worldMeshSectionDevice.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get worldMeshSectionDevice;

  /// No description provided for @worldMeshSectionDeviceMetrics.
  ///
  /// In en, this message translates to:
  /// **'Device Metrics'**
  String get worldMeshSectionDeviceMetrics;

  /// No description provided for @worldMeshSectionEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get worldMeshSectionEnvironment;

  /// No description provided for @worldMeshSectionNeighbors.
  ///
  /// In en, this message translates to:
  /// **'Neighbors ({count})'**
  String worldMeshSectionNeighbors(int count);

  /// No description provided for @worldMeshSectionPosition.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get worldMeshSectionPosition;

  /// No description provided for @worldMeshSectionSeenBy.
  ///
  /// In en, this message translates to:
  /// **'Seen By ({count} gateways)'**
  String worldMeshSectionSeenBy(int count);

  /// No description provided for @worldMeshStatsFiltered.
  ///
  /// In en, this message translates to:
  /// **'filtered'**
  String get worldMeshStatsFiltered;

  /// No description provided for @worldMeshStatsTotal.
  ///
  /// In en, this message translates to:
  /// **'total'**
  String get worldMeshStatsTotal;

  /// No description provided for @worldMeshStatsVisible.
  ///
  /// In en, this message translates to:
  /// **'visible'**
  String get worldMeshStatsVisible;

  /// No description provided for @worldMeshSwapAB.
  ///
  /// In en, this message translates to:
  /// **'Swap A ↔ B'**
  String get worldMeshSwapAB;

  /// No description provided for @worldMeshSwapSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reverse measurement direction'**
  String get worldMeshSwapSubtitle;

  /// No description provided for @worldMeshTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String worldMeshTimeHoursAgo(int hours);

  /// No description provided for @worldMeshTimeJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get worldMeshTimeJustNow;

  /// No description provided for @worldMeshTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String worldMeshTimeMinutesAgo(int minutes);

  /// No description provided for @worldMeshTitle.
  ///
  /// In en, this message translates to:
  /// **'World Map'**
  String get worldMeshTitle;

  /// No description provided for @worldMeshUptimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Uptime: {uptime}'**
  String worldMeshUptimeLabel(String uptime);
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
