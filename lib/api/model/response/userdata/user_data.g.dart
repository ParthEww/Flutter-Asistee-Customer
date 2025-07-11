// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['bank_details'] == null
          ? null
          : UserDataBankDetails.fromJson(
              json['bank_details'] as Map<String, dynamic>),
      json['company_name'] as String?,
      json['country_code'] as String?,
      json['cpr_number'] as String?,
      json['dob'] as String?,
      json['driver_address'] == null
          ? null
          : UserDataDriverAddress.fromJson(
              json['driver_address'] as Map<String, dynamic>),
      json['driver_type'] as String?,
      json['email'] as String?,
      json['full_name'] as String?,
      (json['id'] as num?)?.toInt(),
      (json['id_card_cpr_document'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : UserDataIdCardCprDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['kyc_status'] as num?)?.toInt(),
      json['lat'] as String?,
      (json['license_document'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : UserDataLicenseDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['license_expiry_date'] as String?,
      (json['permit_to_operate_document'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : UserDataPermitToOperateDocument.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      json['lng'] as String?,
      json['mobile_number'] as String?,
      json['nationality'] == null
          ? null
          : UserDataNationality.fromJson(
              json['nationality'] as Map<String, dynamic>),
      json['profile_picture'] as String?,
      json['vehicle_details'] == null
          ? null
          : UserDataVehicleDetails.fromJson(
              json['vehicle_details'] as Map<String, dynamic>),
      (json['unread_message_count'] as num?)?.toInt(),
      json['total_wallet_amount'] as String?,
      json['notification_status'] as String?,
      (json['notification_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'bank_details': instance.bankDetails,
      'company_name': instance.companyName,
      'country_code': instance.countryCode,
      'cpr_number': instance.cprNumber,
      'dob': instance.dob,
      'driver_address': instance.driverAddress,
      'driver_type': instance.driverType,
      'email': instance.email,
      'full_name': instance.fullName,
      'id': instance.id,
      'id_card_cpr_document': instance.idCardCprDocument,
      'kyc_status': instance.kycStatus,
      'lat': instance.lat,
      'license_document': instance.licenseDocument,
      'license_expiry_date': instance.licenseExpiryDate,
      'permit_to_operate_document': instance.permitToOperateDocument,
      'lng': instance.lng,
      'mobile_number': instance.mobileNumber,
      'nationality': instance.nationality,
      'profile_picture': instance.profilePicture,
      'vehicle_details': instance.vehicleDetails,
      'unread_message_count': instance.unreadMessageCount,
      'total_wallet_amount': instance.totalWalletAmount,
      'notification_status': instance.notificationStatus,
      'notification_count': instance.notificationCount,
    };

UserDataBankDetails _$UserDataBankDetailsFromJson(Map<String, dynamic> json) =>
    UserDataBankDetails(
      json['bank_name'] as String?,
      json['benefit_country_code'] as String?,
      json['benefit_mobile_number'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDataBankDetailsToJson(
        UserDataBankDetails instance) =>
    <String, dynamic>{
      'bank_name': instance.bankName,
      'benefit_country_code': instance.benefitCountryCode,
      'benefit_mobile_number': instance.benefitMobileNumber,
      'id': instance.id,
    };

UserDataDriverAddress _$UserDataDriverAddressFromJson(
        Map<String, dynamic> json) =>
    UserDataDriverAddress(
      json['additional_info'] as String?,
      json['block'] as String?,
      json['building_name_number'] as String?,
      json['description'] as String?,
      (json['driver_id'] as num?)?.toInt(),
      json['flat_number'] as String?,
      json['floor'] as String?,
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDataDriverAddressToJson(
        UserDataDriverAddress instance) =>
    <String, dynamic>{
      'additional_info': instance.additionalInfo,
      'block': instance.block,
      'building_name_number': instance.buildingNameNumber,
      'description': instance.description,
      'driver_id': instance.driverId,
      'flat_number': instance.flatNumber,
      'floor': instance.floor,
      'id': instance.id,
    };

UserDataIdCardCprDocument _$UserDataIdCardCprDocumentFromJson(
        Map<String, dynamic> json) =>
    UserDataIdCardCprDocument(
      (json['id'] as num?)?.toInt(),
      json['url'] as String?,
    );

Map<String, dynamic> _$UserDataIdCardCprDocumentToJson(
        UserDataIdCardCprDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

UserDataLicenseDocument _$UserDataLicenseDocumentFromJson(
        Map<String, dynamic> json) =>
    UserDataLicenseDocument(
      (json['id'] as num?)?.toInt(),
      json['url'] as String?,
    );

Map<String, dynamic> _$UserDataLicenseDocumentToJson(
        UserDataLicenseDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

UserDataPermitToOperateDocument _$UserDataPermitToOperateDocumentFromJson(
        Map<String, dynamic> json) =>
    UserDataPermitToOperateDocument(
      (json['id'] as num?)?.toInt(),
      json['url'] as String?,
    );

Map<String, dynamic> _$UserDataPermitToOperateDocumentToJson(
        UserDataPermitToOperateDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

UserDataNationality _$UserDataNationalityFromJson(Map<String, dynamic> json) =>
    UserDataNationality(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
    );

Map<String, dynamic> _$UserDataNationalityToJson(
        UserDataNationality instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

UserDataVehicleDetails _$UserDataVehicleDetailsFromJson(
        Map<String, dynamic> json) =>
    UserDataVehicleDetails(
      (json['id'] as num?)?.toInt(),
      json['vehicle_make'] as String?,
      json['vehicle_model'] as String?,
      json['vehicle_year'] as String?,
      json['vehicle_color'] as String?,
      json['vehicle_plate_number'] as String?,
      json['vehicle_type'] as String?,
    );

Map<String, dynamic> _$UserDataVehicleDetailsToJson(
        UserDataVehicleDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicle_make': instance.vehicleMake,
      'vehicle_model': instance.vehicleModel,
      'vehicle_year': instance.vehicleYear,
      'vehicle_color': instance.vehicleColor,
      'vehicle_plate_number': instance.vehiclePlateNumber,
      'vehicle_type': instance.vehicleType,
    };
