// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello World!`
  String get helloWorld {
    return Intl.message(
      'Hello World!',
      name: 'helloWorld',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Selaa`
  String get welcomeToSelaa {
    return Intl.message(
      'Welcome to Selaa',
      name: 'welcomeToSelaa',
      desc: '',
      args: [],
    );
  }

  /// `Effortless Ordering for Your Business`
  String get effortlessOrderingForYourBusiness {
    return Intl.message(
      'Effortless Ordering for Your Business',
      name: 'effortlessOrderingForYourBusiness',
      desc: '',
      args: [],
    );
  }

  /// `Streamlined Deliveries to Your Doorstep!`
  String get streamlinedDeliveriesToYourDoorstep {
    return Intl.message(
      'Streamlined Deliveries to Your Doorstep!',
      name: 'streamlinedDeliveriesToYourDoorstep',
      desc: '',
      args: [],
    );
  }

  /// `Explore Exclusive Deals and Offers`
  String get exploreExclusiveDealsAndOffers {
    return Intl.message(
      'Explore Exclusive Deals and Offers',
      name: 'exploreExclusiveDealsAndOffers',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `The Algerian Commercial Network`
  String get theAlgerianCommercialNetwork {
    return Intl.message(
      'The Algerian Commercial Network',
      name: 'theAlgerianCommercialNetwork',
      desc: '',
      args: [],
    );
  }

  /// `Register as a Buyer`
  String get registerAsABuyer {
    return Intl.message(
      'Register as a Buyer',
      name: 'registerAsABuyer',
      desc: '',
      args: [],
    );
  }

  /// `Register as a Seller`
  String get registerAsASeller {
    return Intl.message(
      'Register as a Seller',
      name: 'registerAsASeller',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry, it occurs. Please enter the email address linked with your account`
  String get dontWorryItOccurs {
    return Intl.message(
      'Don\'t worry, it occurs. Please enter the email address linked with your account',
      name: 'dontWorryItOccurs',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterYourEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `ex: selaa@example.org`
  String get exampleOrg {
    return Intl.message(
      'ex: selaa@example.org',
      name: 'exampleOrg',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Remember Password`
  String get rememberPassword {
    return Intl.message(
      'Remember Password',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all the fields`
  String get pleaseFillAllTheFields {
    return Intl.message(
      'Please fill all the fields',
      name: 'pleaseFillAllTheFields',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back! Glad to see you again`
  String get welcomeBackGladToSeeYouAgain {
    return Intl.message(
      'Welcome back! Glad to see you again',
      name: 'welcomeBackGladToSeeYouAgain',
      desc: '',
      args: [],
    );
  }

  /// `Email is empty`
  String get emailIsEmpty {
    return Intl.message(
      'Email is empty',
      name: 'emailIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `First name is empty`
  String get firstNameIsEmpty {
    return Intl.message(
      'First name is empty',
      name: 'firstNameIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Last name is empty`
  String get lastNameIsEmpty {
    return Intl.message(
      'Last name is empty',
      name: 'lastNameIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Register and start shopping`
  String get helloRegisterAndStartShopping {
    return Intl.message(
      'Hello! Register and start shopping',
      name: 'helloRegisterAndStartShopping',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the terms and conditions`
  String get iAgreeToTheTermsAndConditions {
    return Intl.message(
      'I agree to the terms and conditions',
      name: 'iAgreeToTheTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login Now`
  String get loginNow {
    return Intl.message(
      'Login Now',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Register and start selling`
  String get helloRegisterAndStartSelling {
    return Intl.message(
      'Hello! Register and start selling',
      name: 'helloRegisterAndStartSelling',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `Add Images`
  String get addImages {
    return Intl.message(
      'Add Images',
      name: 'addImages',
      desc: '',
      args: [],
    );
  }

  /// `Delete Image`
  String get deleteImage {
    return Intl.message(
      'Delete Image',
      name: 'deleteImage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this image?`
  String get areYouSureYouWantToDeleteThisImage {
    return Intl.message(
      'Are you sure you want to delete this image?',
      name: 'areYouSureYouWantToDeleteThisImage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Tools`
  String get tools {
    return Intl.message(
      'Tools',
      name: 'tools',
      desc: '',
      args: [],
    );
  }

  /// `Garment`
  String get garment {
    return Intl.message(
      'Garment',
      name: 'garment',
      desc: '',
      args: [],
    );
  }

  /// `Electronics`
  String get electronics {
    return Intl.message(
      'Electronics',
      name: 'electronics',
      desc: '',
      args: [],
    );
  }

  /// `Home Appliance`
  String get homeAppliance {
    return Intl.message(
      'Home Appliance',
      name: 'homeAppliance',
      desc: '',
      args: [],
    );
  }

  /// `House`
  String get house {
    return Intl.message(
      'House',
      name: 'house',
      desc: '',
      args: [],
    );
  }

  /// `Electric`
  String get electric {
    return Intl.message(
      'Electric',
      name: 'electric',
      desc: '',
      args: [],
    );
  }

  /// `Games`
  String get games {
    return Intl.message(
      'Games',
      name: 'games',
      desc: '',
      args: [],
    );
  }

  /// `Various Products`
  String get variousProducts {
    return Intl.message(
      'Various Products',
      name: 'variousProducts',
      desc: '',
      args: [],
    );
  }

  /// `Baby`
  String get baby {
    return Intl.message(
      'Baby',
      name: 'baby',
      desc: '',
      args: [],
    );
  }

  /// `Sports Products`
  String get sportsProducts {
    return Intl.message(
      'Sports Products',
      name: 'sportsProducts',
      desc: '',
      args: [],
    );
  }

  /// `What type`
  String get whatType {
    return Intl.message(
      'What type',
      name: 'whatType',
      desc: '',
      args: [],
    );
  }

  /// `What are you selling`
  String get whatAreYouSelling {
    return Intl.message(
      'What are you selling',
      name: 'whatAreYouSelling',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred`
  String get errorOccurred {
    return Intl.message(
      'Error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get pleaseWait {
    return Intl.message(
      'Please wait',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Change Picture`
  String get changePicture {
    return Intl.message(
      'Change Picture',
      name: 'changePicture',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `On the way`
  String get onTheWay {
    return Intl.message(
      'On the way',
      name: 'onTheWay',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Recent Orders`
  String get recentOrders {
    return Intl.message(
      'Recent Orders',
      name: 'recentOrders',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Search order`
  String get searchOrder {
    return Intl.message(
      'Search order',
      name: 'searchOrder',
      desc: '',
      args: [],
    );
  }

  /// `Error loading user name`
  String get errorLoadingUserName {
    return Intl.message(
      'Error loading user name',
      name: 'errorLoadingUserName',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `No orders available`
  String get noOrdersAvailable {
    return Intl.message(
      'No orders available',
      name: 'noOrdersAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No pending orders`
  String get noPendingOrders {
    return Intl.message(
      'No pending orders',
      name: 'noPendingOrders',
      desc: '',
      args: [],
    );
  }

  /// `No in progress orders`
  String get noInProgressOrders {
    return Intl.message(
      'No in progress orders',
      name: 'noInProgressOrders',
      desc: '',
      args: [],
    );
  }

  /// `No completed orders`
  String get noCompletedOrders {
    return Intl.message(
      'No completed orders',
      name: 'noCompletedOrders',
      desc: '',
      args: [],
    );
  }

  /// `No images available`
  String get noImagesAvailable {
    return Intl.message(
      'No images available',
      name: 'noImagesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message(
      'Add to cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `No posts available`
  String get noPostsAvailable {
    return Intl.message(
      'No posts available',
      name: 'noPostsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Report a Bug`
  String get reportABug {
    return Intl.message(
      'Report a Bug',
      name: 'reportABug',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password updated`
  String get passwordUpdated {
    return Intl.message(
      'Password updated',
      name: 'passwordUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your current password`
  String get enterCurrentPassword {
    return Intl.message(
      'Enter your current password',
      name: 'enterCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter your new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Renter your new password`
  String get reEnterNewPassword {
    return Intl.message(
      'Renter your new password',
      name: 'reEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Update Email`
  String get updateEmail {
    return Intl.message(
      'Update Email',
      name: 'updateEmail',
      desc: '',
      args: [],
    );
  }

  /// `Add Phone Number`
  String get addPhoneNumber {
    return Intl.message(
      'Add Phone Number',
      name: 'addPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Add Your Phone Number`
  String get addYourPhoneNumber {
    return Intl.message(
      'Add Your Phone Number',
      name: 'addYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `We just need your phone number to contact you if there is any problem with your order`
  String get weNeedYourPhoneNumber {
    return Intl.message(
      'We just need your phone number to contact you if there is any problem with your order',
      name: 'weNeedYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone Number`
  String get yourPhoneNumber {
    return Intl.message(
      'Your Phone Number',
      name: 'yourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Press the edit button to change your phone number`
  String get editPhoneNumber {
    return Intl.message(
      'Press the edit button to change your phone number',
      name: 'editPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must have at least 10 digits`
  String get phoneNumberDigits {
    return Intl.message(
      'Phone number must have at least 10 digits',
      name: 'phoneNumberDigits',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Shipping address`
  String get shippingAddress {
    return Intl.message(
      'Shipping address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Current shipping address`
  String get currentShippingAddress {
    return Intl.message(
      'Current shipping address',
      name: 'currentShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code`
  String get zipCode {
    return Intl.message(
      'Zip Code',
      name: 'zipCode',
      desc: '',
      args: [],
    );
  }

  /// `DZD`
  String get dzd {
    return Intl.message(
      'DZD',
      name: 'dzd',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
