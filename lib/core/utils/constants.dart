import 'package:donation_management_system/core/widgets/table_header.dart';
import 'package:donation_management_system/features/donors/data/models/donor_model.dart';

/// Application Constants
/// Centralized constant definitions
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  //Donors
  static const String donorsTitle = 'Donors Management';
  static const String donorsDescription =
      'Manage your donor database, track contributions, and maintain relationships with\nindividuals and corporate partners.';
  static const List<TableHeader> donorHeader = [
    TableHeader(text: 'Donor', flex: 2),
    TableHeader(text: 'Phone', flex: 1),
    TableHeader(text: 'Email', flex: 2),
    TableHeader(text: 'Date Joined', flex: 1),
    TableHeader(text: 'Type', flex: 1),
    TableHeader(text: 'Address', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  static final List<DonorModel> sampleDonors = [
  DonorModel(
    id: 1,
    name: "Ibrahim Nasser",
    email: "12baraka34@gmail.com",
    phoneNumber: "01278988474",
    address: "Ismailia, Egypt",
    registDate: DateTime(2023, 1, 1),
    type: DonorType.individual,
  ),
   DonorModel(
    id: 2,
    name: "Abdullah Mohamed",
    email: "worrior@gmail.com",
    phoneNumber: "123-456-7890",
    address: "Ismailia, Egypt",
    registDate: DateTime(2023, 1, 1),
    type: DonorType.individual,
  ),
   DonorModel(
    id: 3,
    name: "Ahmed El-Shazle",
    email: "Comy@gmail.com",
    phoneNumber: "123-456-7890",
    address: "Ismailia, Egypt",
    registDate: DateTime(2023, 1, 1),
    type: DonorType.individual,
  ),
   DonorModel(
    id: 4,
    name: "Mohamed Sayed",
    email: "mohamed.sayed@example.com",
    phoneNumber: "123-456-7890",
    address: "Ismailia, Egypt",
    registDate: DateTime(2023, 1, 1),
    type: DonorType.individual,
  ),
   DonorModel(
    id: 5,
    name: "Sara Ahmed",
    email: "SaraAhmed@gmail.com",
    phoneNumber: '011723469',
    address: 'nassb City',
    registDate: DateTime(2023, 1, 1),
    type: DonorType.organization,
  ),
];
   //End Donors
  // API Configuration
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String onboardingKey = 'onboarding_completed';

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 100;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;

  // Border Radius
  static const double radiusSM = 4.0;
  static const double radiusMD = 8.0;
  static const double radiusLG = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusRound = 999.0;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
  ];
  static const List<String> allowedDocumentExtensions = ['pdf', 'doc', 'docx'];

  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  // Regular Expressions
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
  static final RegExp urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );

  // Error Messages
  static const String genericErrorMessage =
      'Something went wrong. Please try again.';
  static const String networkErrorMessage =
      'No internet connection. Please check your network.';
  static const String timeoutErrorMessage =
      'Request timeout. Please try again.';
  static const String unauthorizedErrorMessage =
      'Unauthorized. Please login again.';
}
