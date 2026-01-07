class User {
  final String id;
  final String email;
  final String name;
  final String? phone;  
  final String? profilePicture;
  final String? profession;
  final List<String> skills;
  final double? hourlyRate;
  final bool isPremium;
  final bool isEmailVerified;
  final DateTime? premiumExpiry;  
  final DateTime? emailVerificationExpires;
  final DateTime? passwordResetExpires;
  final DateTime? lastLoginAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,  
    this.profilePicture,
    this.profession,
    required this.skills,
    this.hourlyRate,
    required this.isPremium,
    required this.isEmailVerified,
    this.premiumExpiry,  
    this.emailVerificationExpires,
    this.passwordResetExpires,
    this.lastLoginAt,
    required this.createdAt,
    required this.updatedAt,
  });

  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],  // ← Fixed from '_id'!
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      profilePicture: json['profilePicture'],
      profession: json['profession'],
      skills: List<String>.from(json['skills'] ?? []),
      hourlyRate: json['hourlyRate'] != null 
          ? (json['hourlyRate'] as num).toDouble() 
          : null,
      isPremium: json['isPremium'] ?? false,
      isEmailVerified: json['isEmailVerified'] ?? false,
      premiumExpiry: json['premiumExpiry'] != null
          ? DateTime.parse(json['premiumExpiry'])
          : null,
      emailVerificationExpires: json['emailVerificationExpires'] != null
          ? DateTime.parse(json['emailVerificationExpires'])
          : null,
      passwordResetExpires: json['passwordResetExpires'] != null
          ? DateTime.parse(json['passwordResetExpires'])
          : null,
      lastLoginAt: json['lastLoginAt'] != null 
          ? DateTime.parse(json['lastLoginAt']) 
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'profilePicture': profilePicture,
      'profession': profession,
      'skills': skills,
      'hourlyRate': hourlyRate,
      'isPremium': isPremium,
      'isEmailVerified': isEmailVerified,
      'premiumExpiry': premiumExpiry?.toIso8601String(),
      'emailVerificationExpires': emailVerificationExpires?.toIso8601String(),
      'passwordResetExpires': passwordResetExpires?.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}