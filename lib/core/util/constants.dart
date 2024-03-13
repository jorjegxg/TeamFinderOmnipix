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

class StorageConstants {
  static const String token = 'token';
}

class HiveConstants {
  static const String authBox = 'authBox';
  //
  static const String userId = 'userId';
  static const String departmentId = 'departmentId';
  static const String organizationId = 'organizationId';
}
