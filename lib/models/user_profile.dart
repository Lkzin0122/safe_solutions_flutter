class UserProfile {
  // Dados da empresa (visíveis para todos)
  final String companyName;
  final String companyEmail;
  final String companyCnpj;
  final String companyPhone;
  final String companyAddress;
  final String companyDescription;
  final String? companyCep;

  // Dados pessoais (visíveis apenas para o próprio usuário)
  final String? personalName;
  final String? personalCpf;
  final String? personalPhone;
  final String? personalEmail;
  final String? personalAddress;

  UserProfile({
    required this.companyName,
    required this.companyEmail,
    required this.companyCnpj,
    required this.companyPhone,
    required this.companyAddress,
    required this.companyDescription,
    this.companyCep,
    this.personalName,
    this.personalCpf,
    this.personalPhone,
    this.personalEmail,
    this.personalAddress,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      companyName: json['companyName'] ?? '',
      companyEmail: json['companyEmail'] ?? '',
      companyCnpj: json['companyCnpj'] ?? '',
      companyPhone: json['companyPhone'] ?? '',
      companyAddress: json['companyAddress'] ?? '',
      companyDescription: json['companyDescription'] ?? '',
      companyCep: json['companyCep'],
      personalName: json['personalName'],
      personalCpf: json['personalCpf'],
      personalPhone: json['personalPhone'],
      personalEmail: json['personalEmail'],
      personalAddress: json['personalAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyEmail': companyEmail,
      'companyCnpj': companyCnpj,
      'companyPhone': companyPhone,
      'companyAddress': companyAddress,
      'companyDescription': companyDescription,
      'companyCep': companyCep,
      'personalName': personalName,
      'personalCpf': personalCpf,
      'personalPhone': personalPhone,
      'personalEmail': personalEmail,
      'personalAddress': personalAddress,
    };
  }
}