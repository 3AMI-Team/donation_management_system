class ServerStrings {
  static const String baseUrl =
      "http://donationdb.runasp.net/"; // Update if needed

  // Auth
  static const String login = "/api/Account/login";

  // Dashboard
  static const String dashboardKPIs = "api/Dashboard/kpis";
  static const String donationTrends = "api/Dashboard/donationTrends";
  static const String lastDonations = "api/Dashboard/lastDonations";
  static const String lastDistributions = "api/Dashboard/lastDistributions";

  // Donors
  static const String donors = "api/Donors";

  // Cases
  static const String cases = "api/Cases";
}
