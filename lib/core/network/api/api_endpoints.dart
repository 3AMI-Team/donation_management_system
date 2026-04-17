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

  //Donation
  static const String allDonations = "api/Donations";
  static const String donationKPIs = "api/Donations/kpis"; // Fixed from /stats
  static const String registerDonation = "api/Donations";

  // Donors
  static const String donors = "api/Donors";
  static const String donorKPIs = "api/Donors/kpis";

  // Cases
  static const String cases = "api/Cases";
  static const String caseKPIs = "api/Cases/kpis";

  // Categories
  static const String categories = "api/Categories";
}
