import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  @JsonKey(name: 'bank_details')
  UserDataBankDetails? bankDetails;
  @JsonKey(name: 'company_name')
  String? companyName;
  @JsonKey(name: 'country_code')
  String? countryCode;
  @JsonKey(name: 'cpr_number')
  String? cprNumber;
  String? dob;
  @JsonKey(name: 'driver_address')
  UserDataDriverAddress? driverAddress;
  @JsonKey(name: 'driver_type')
  String? driverType;
  String? email;
  @JsonKey(name: 'full_name')
  String? fullName;
  int? id;
  @JsonKey(name: 'id_card_cpr_document')
  List<UserDataIdCardCprDocument?>? idCardCprDocument;
  @JsonKey(name: 'kyc_status')
  int? kycStatus;
  String? lat;
  @JsonKey(name: 'license_document')
  List<UserDataLicenseDocument?>? licenseDocument;
  @JsonKey(name: 'license_expiry_date')
  String? licenseExpiryDate;
  @JsonKey(name: 'permit_to_operate_document')
  List<UserDataPermitToOperateDocument?>? permitToOperateDocument;
  String? lng;
  @JsonKey(name: 'mobile_number')
  String? mobileNumber;
  UserDataNationality? nationality;
  @JsonKey(name: 'profile_picture')
  String? profilePicture;
  @JsonKey(name: 'vehicle_details')
  UserDataVehicleDetails? vehicleDetails;
  @JsonKey(name: 'unread_message_count')
  int? unreadMessageCount;
  @JsonKey(name: 'total_wallet_amount')
  String? totalWalletAmount;
  @JsonKey(name: 'notification_status')
  String? notificationStatus;
  @JsonKey(name: 'notification_count')
  int? notificationCount;

  UserData(
      this.bankDetails,
      this.companyName,
      this.countryCode,
      this.cprNumber,
      this.dob,
      this.driverAddress,
      this.driverType,
      this.email,
      this.fullName,
      this.id,
      this.idCardCprDocument,
      this.kycStatus,
      this.lat,
      this.licenseDocument,
      this.licenseExpiryDate,
      this.permitToOperateDocument,
      this.lng,
      this.mobileNumber,
      this.nationality,
      this.profilePicture,
      this.vehicleDetails,
      this.unreadMessageCount,
      this.totalWalletAmount,
      this.notificationStatus,
      this.notificationCount);

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class UserDataBankDetails {
  @JsonKey(name: 'bank_name')
  String? bankName;
  @JsonKey(name: 'benefit_country_code')
  String? benefitCountryCode;
  @JsonKey(name: 'benefit_mobile_number')
  String? benefitMobileNumber;
  int? id;

  UserDataBankDetails(this.bankName, this.benefitCountryCode,
      this.benefitMobileNumber, this.id);

  factory UserDataBankDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDataBankDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataBankDetailsToJson(this);
}

@JsonSerializable()
class UserDataDriverAddress {
  @JsonKey(name: 'additional_info')
  String? additionalInfo;
  String? block;
  @JsonKey(name: 'building_name_number')
  String? buildingNameNumber;
  String? description;
  @JsonKey(name: 'driver_id')
  int? driverId;
  @JsonKey(name: 'flat_number')
  String? flatNumber;
  String? floor;
  int? id;

  UserDataDriverAddress(
      this.additionalInfo,
      this.block,
      this.buildingNameNumber,
      this.description,
      this.driverId,
      this.flatNumber,
      this.floor,
      this.id);

  factory UserDataDriverAddress.fromJson(Map<String, dynamic> json) =>
      _$UserDataDriverAddressFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataDriverAddressToJson(this);
}

@JsonSerializable()
class UserDataIdCardCprDocument {
  int? id;
  String? url;

  UserDataIdCardCprDocument(this.id, this.url);

  factory UserDataIdCardCprDocument.fromJson(Map<String, dynamic> json) =>
      _$UserDataIdCardCprDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataIdCardCprDocumentToJson(this);
}

@JsonSerializable()
class UserDataLicenseDocument {
  int? id;
  String? url;

  UserDataLicenseDocument(this.id, this.url);

  factory UserDataLicenseDocument.fromJson(Map<String, dynamic> json) =>
      _$UserDataLicenseDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataLicenseDocumentToJson(this);
}

@JsonSerializable()
class UserDataPermitToOperateDocument {
  int? id;
  String? url;

  UserDataPermitToOperateDocument(this.id, this.url);

  factory UserDataPermitToOperateDocument.fromJson(Map<String, dynamic> json) =>
      _$UserDataPermitToOperateDocumentFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UserDataPermitToOperateDocumentToJson(this);
}

@JsonSerializable()
class UserDataNationality {
  int? id;
  String? name;

  UserDataNationality(this.id, this.name);

  factory UserDataNationality.fromJson(Map<String, dynamic> json) =>
      _$UserDataNationalityFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataNationalityToJson(this);
}

@JsonSerializable()
class UserDataVehicleDetails {
  int? id;
  @JsonKey(name: 'vehicle_make')
  String? vehicleMake;
  @JsonKey(name: 'vehicle_model')
  String? vehicleModel;
  @JsonKey(name: 'vehicle_year')
  String? vehicleYear;
  @JsonKey(name: 'vehicle_color')
  String? vehicleColor;
  @JsonKey(name: 'vehicle_plate_number')
  String? vehiclePlateNumber;
  @JsonKey(name: 'vehicle_type')
  String? vehicleType;

  UserDataVehicleDetails(
      this.id,
      this.vehicleMake,
      this.vehicleModel,
      this.vehicleYear,
      this.vehicleColor,
      this.vehiclePlateNumber,
      this.vehicleType);

  factory UserDataVehicleDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDataVehicleDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataVehicleDetailsToJson(this);
}
