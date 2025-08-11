class LoginResponse {
  final String status;
  final String? token;
  final List<String>? stores;
  final String? empName;
  final String? userDesignation;
  final String? imageUrl;
  final List<String>? designationName;
  final List<String>? region;
  final String? level;
  final List<String>? zones;
  final List<String>? section;
  final List<String>? masterStoreList;
  final Map<String, dynamic>? storeMapping;
  final List<String>? userPrivileges;

  LoginResponse({
    required this.status,
    this.token,
    this.stores,
    this.empName,
    this.userDesignation,
    this.imageUrl,
    this.designationName,
    this.region,
    this.level,
    this.zones,
    this.section,
    this.masterStoreList,
    this.storeMapping,
    this.userPrivileges,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status:
          json['status'] as String? ?? 'Unknown', // Fallback for null status
      token: json['token'] as String?,
      stores: (json['STORES'] as List<dynamic>?)?.cast<String>(),
      empName: json['emp_name'] as String?,
      userDesignation: json['user_designation'] as String?,
      imageUrl: json['image_url'] as String?,
      designationName:
          (json['desigination_name'] as List<dynamic>?)?.cast<String>(),
      region: (json['REGION'] as List<dynamic>?)?.cast<String>(),
      level: json['user_designation'] as String?,
      zones: (json['zones'] as List<dynamic>?)?.cast<String>(),
      section: (json['section'] as List<dynamic>?)?.cast<String>(),
      masterStoreList:
          (json['master_storelist'] as List<dynamic>?)?.cast<String>(),
      storeMapping: json['store_mapping'] as Map<String, dynamic>?,
      userPrivileges:
          (json['userprivileges'] as List<dynamic>?)?.cast<String>(),
    );
  }
}
