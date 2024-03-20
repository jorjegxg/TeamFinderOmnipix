class OrgAdminRegistrationFields {
  final String name;
  final String email;
  final String password;
  final String organizationName;
  final String organizationAddress;

  OrgAdminRegistrationFields({
    required this.name,
    required this.email,
    required this.password,
    required this.organizationName,
    required this.organizationAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "organizationName": organizationName,
      "adress": organizationAddress,
      //scoate-l ca e degeaba
      "url": "url"
    };
  }
}
