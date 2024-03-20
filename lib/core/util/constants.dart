class EndpointConstants {
  //base url
  static const String baseUrl = 'https://omnipix.azurewebsites.net';

  //admin endpoints//
  static const String createAdmin = '/admin/create';
  static const String createCustomRole = '/admin/customrole';
  static String deleteAdmin(String email) => '/admin/delete/$email';
  static String updateAdminPassword(String email, String password) =>
      '/admin/updatePassword/$email/$password';

  ///user endpoints///
  static const String assignDepartment = '/employee/assigndepartament';
  static const String assignSkill = '/employee/assignskill';
  static const String createUser = '/employee/create';
  static String getSkills(String userId) => '/employee/getskills/$userId';

  //login endpoints//
  static const String login = '/login/';

  ///organization///
  static const String createOrganization = '/organization/create';

  ///departament endpoints///
  static const String createDepartament = '/departament/create';
  static const String createDepartamentAdditional =
      '/departament/createADDITIONAL';
  static const String createDepartamentDirectlyWithManagerAdditional =
      '/departament/createdirectlywithmanagerADDITIONAL';
  static String deleteDepartament(String departamentId) =>
      '/departament/deletedepartament/$departamentId';
  static const String firstPromoteDepartamentManager =
      '/departament/firstpromotedepartamentmanager';
  static const String promoteDepartamentManagerAdditional =
      '/departament/promotedepartamentmanagerADDITIONAL';
  static String skillsOfDepartament(String departamentId) =>
      '/departament/skillsofdepartament/$departamentId';
  static const String skillToDepartament = '/departament/skilltodepartament';
  static const String updateManager = '/departament/updatemanager';
  static const String updateNameOfDepartament =
      '/departament/updatenameofdepartament';

  ///departamentmanager endpoints///
  static const String createSkill = '/departamentmanager/createskill';
  static const String editSkill = '/departamentmanager/editskill';
  static String getSkillsOfOrganization(String organizationId) =>
      '/departamentmanager/getskills/$organizationId';
  static String managersNoDepartament(String id) =>
      '/departamentmanager/managersnodepartament/$id';
  static String ownedSkills(String authorId) =>
      '/departamentmanager/ownedskills/$authorId';

  ///projectmanager endpoints///
  static String createProjectManager(String id) =>
      '/projectmanager/createprojectmanager/$id';
}

class AuthConstants {
  static const String userId = 'userId';
  static const String name = 'Name';
  static const String email = 'Email';
  static const String phone = 'Phone';
  static const String password = 'Password';
  static const String profileImage = 'ProfileImage';
  static const String organizationName = 'Organization Name';
  static const String organizationId = 'OrganizationId';
  static const String organizationType = 'OrganizationType';
  static const String organizationAddress = 'Organization Address';
  static const String register = 'Register';
  static const String login = 'Login';
  static const String forgotPassword = 'Forgot Password';
  static const String resetPassword = 'Reset Password';
  static const String submit = 'Submit';
  static const String alreadyHaveAnAccount = 'Already have an account?';
  static const String dontHaveAnAccount = 'Don\'t have an account?';
  static const String createAccount = 'Create Account';
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
}

// class AppLightColors {
//   static const surfaceContainer = Color(0xFFF7F2FA);
//   static const primaryColor = Color(0xFF6750A4);
//   static const outlineVariant = Color(0xFFCAC4D0);
//   static const onSurfaceVariant = Color(0xFF49454F);
//   static const appBarSurface = Color(0xFFF3EDF7);
//   static const appBarOnSurface = Color(0xFF1D1B20);
//   static const appBarOnSurfaceVariant = Color(0xFF49454F);
//   static const blockColorFilled = Color(0xFFE6E0E9);
//   static const textField = Color(0xFFEBE4EF);
//   static const surface = Color(0xFFFEF7FF);
//   static const black = Color(0xFF000000);
//   static const white = Color(0xFFFFFFFF);
//   static const shadow = Color(0x3F000000);
//   static const hintTextColor = Color.fromARGB(255, 115, 115, 115);
// }

class AppLists {
  static const List<String> projectStatusList = [
    'Not Started',
    'Starting',
    'In Progress',
    'Closing',
    'Closed',
  ];
}

//One of: 1 – Learns, 2 – Knows, 3 – Does, 4 – Helps, 5 – Teaches
enum SkillLevel {
  learns,
  knows,
  does,
  helps,
  teaches,
}

extension SkillLevelX on SkillLevel {
  static SkillLevel fromString(String level) {
    if (level == 'Learns') {
      return SkillLevel.learns;
    } else if (level == 'Knows') {
      return SkillLevel.knows;
    } else if (level == 'Does') {
      return SkillLevel.does;
    } else if (level == 'Helps') {
      return SkillLevel.helps;
    } else {
      return SkillLevel.teaches;
    }
  }

  String toStringValue() {
    if (this == SkillLevel.learns) {
      return 'Learns';
    } else if (this == SkillLevel.knows) {
      return 'Knows';
    } else if (this == SkillLevel.does) {
      return 'Does';
    } else if (this == SkillLevel.helps) {
      return 'Helps';
    } else {
      return 'Teaches';
    }
  }

  //to int
  int toInt() {
    if (this == SkillLevel.learns) {
      return 1;
    } else if (this == SkillLevel.knows) {
      return 2;
    } else if (this == SkillLevel.does) {
      return 3;
    } else if (this == SkillLevel.helps) {
      return 4;
    } else {
      return 5;
    }
  }

  //from int
  static SkillLevel fromInt(int level) {
    if (level == 1) {
      return SkillLevel.learns;
    } else if (level == 2) {
      return SkillLevel.knows;
    } else if (level == 3) {
      return SkillLevel.does;
    } else if (level == 4) {
      return SkillLevel.helps;
    } else {
      return SkillLevel.teaches;
    }
  }
}

//One of: 0-6 months, 6-12 months, 1-2 years, 2-4 years, 4-7 years, >7 years
enum ExperienceLevel {
  months0_6,
  months6_12,
  years1_2,
  years2_4,
  years4_7,
  years7,
}

extension ExperienceLevelX on ExperienceLevel {
  static ExperienceLevel fromString(String level) {
    if (level == '0-6 months') {
      return ExperienceLevel.months0_6;
    } else if (level == '6-12 months') {
      return ExperienceLevel.months6_12;
    } else if (level == '1-2 years') {
      return ExperienceLevel.years1_2;
    } else if (level == '2-4 years') {
      return ExperienceLevel.years2_4;
    } else if (level == '4-7 years') {
      return ExperienceLevel.years4_7;
    } else {
      return ExperienceLevel.years7;
    }
  }

  String toStringValue() {
    if (this == ExperienceLevel.months0_6) {
      return '0-6 months';
    } else if (this == ExperienceLevel.months6_12) {
      return '6-12 months';
    } else if (this == ExperienceLevel.years1_2) {
      return '1-2 years';
    } else if (this == ExperienceLevel.years2_4) {
      return '2-4 years';
    } else if (this == ExperienceLevel.years4_7) {
      return '4-7 years';
    } else {
      return '>7 years';
    }
  }
}

enum ProjectPeriod { fixed, ongoing }

extension ProjectPeriodX on ProjectPeriod {
  static ProjectPeriod fromString(String period) {
    if (period == 'fixed') {
      return ProjectPeriod.fixed;
    } else {
      return ProjectPeriod.ongoing;
    }
  }

  String toStringValue() {
    if (this == ProjectPeriod.fixed) {
      return 'fixed';
    } else {
      return 'ongoing';
    }
  }
}

enum ProjectStatus {
  NotStarted,
  Starting,
  InProgress,
  Closing,
  Closed,
}

extension ProjectStatusX on ProjectStatus {
  static ProjectStatus fromString(String status) {
    if (status == 'Not Started') {
      return ProjectStatus.NotStarted;
    } else if (status == 'Starting') {
      return ProjectStatus.Starting;
    } else if (status == 'In Progress') {
      return ProjectStatus.InProgress;
    } else if (status == 'Closing') {
      return ProjectStatus.Closing;
    } else {
      return ProjectStatus.Closed;
    }
  }

  // check if project status is not started or starting
  bool isNotStartedOrStarting() {
    return this == ProjectStatus.NotStarted || this == ProjectStatus.Starting;
  }

  String toStringValue() {
    if (this == ProjectStatus.NotStarted) {
      return 'Not Started';
    } else if (this == ProjectStatus.Starting) {
      return 'Starting';
    } else if (this == ProjectStatus.InProgress) {
      return 'In Progress';
    } else if (this == ProjectStatus.Closing) {
      return 'Closing';
    } else {
      return 'Closed';
    }
  }
}

class StorageConstants {
  static const String token = 'token';
}

class HiveConstants {
  static const String authBox = 'authBox';
  //
  static const String userId = 'userId';
  static const String departmentId = 'departmentId';
  static const String organizationId = 'organizationId';
  static const String userEmail = 'userEmail';

  //
  static const String rolesBox = 'rolesBox';
  static const String adminRole = 'adminRole';
  static const String employeeRole = 'employeeRole';
  static const String departamentManagerRole = 'departamentManagerRole';
}

class DynamicLinkConstants {
  static String getAddEmployeeToOrganizationLink(
          {required String organizationId}) =>
      'https://teamfinderio.page.link/?link=https://teamfinder.page.link/register/employee/$organizationId&apn=gxg.vas.alu.team_finder_app';
}
