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
  static const String createDepartamentManager =
      '/departament/createdepartamentmanager';
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
