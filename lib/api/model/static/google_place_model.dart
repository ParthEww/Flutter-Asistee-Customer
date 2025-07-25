class GooglePlaceModel {
  double lat;
  double lng;
  String formattedAddress;
  String shortAddressName;
  String locationAddressFull;
  String countryName;
  String cityName;
  String stateName;
  String postalCode;
  String placeId;
  String description;

  @override
  String toString() {
    return 'GooglePlaceModel{lat: $lat, lng: $lng, formattedAddress: $formattedAddress, shortAddressName: $shortAddressName, locationAddressFull: $locationAddressFull, countryName: $countryName, cityName: $cityName, stateName: $stateName, postalCode: $postalCode}';
  }

  factory GooglePlaceModel.fromJson(Map<String, dynamic> json) {
    return GooglePlaceModel(
      shortAddressName: json['structured_formatting']['main_text'] ?? '',
      formattedAddress: json['formatted_address'] ?? '',
      // Note: The following fields would need to be populated from a separate Place Details API call
      lat: 0.0, // Will be set later from place details
      lng: 0.0, // Will be set later from place details
      locationAddressFull: '', // Will be set later from place details
      countryName: _extractComponent(json, 'country') ??"",
      cityName: _extractComponent(json, 'locality') ??
          _extractComponent(json, 'sublocality') ??
          _extractComponent(json, 'administrative_area_level_2') ?? '',
      stateName: _extractComponent(json, 'administrative_area_level_1') ?? '',
      postalCode: _extractComponent(json, 'postal_code') ?? '',
      placeId: json['place_id'] ?? '',
      description: json['description'] ?? '',
    );
  }

  static String? _extractComponent(Map<String, dynamic> json, String type) {
    if (json['address_components'] is List) {
      final components = json['address_components'] as List;
      for (var component in components) {
        if (component['types'] is List &&
            (component['types'] as List).contains(type)) {
          return component['long_name'] ?? component['short_name'];
        }
      }
    }
    return null;
  }

  GooglePlaceModel({
    this.lat = 0.0,
    this.lng = 0.0,
    this.formattedAddress = '',
    this.shortAddressName = '',
    this.locationAddressFull = '',
    this.countryName = '',
    this.cityName = '',
    this.stateName = '',
    this.postalCode = '',
    this.placeId = '',
    this.description = '',
  });

  GooglePlaceModel copyWith({
    double? lat,
    double? lng,
    String? formattedAddress,
    String? shortAddressName,
    String? locationAddressFull,
    String? countryName,
    String? cityName,
    String? stateName,
    String? postalCode,
  }) {
    return GooglePlaceModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      shortAddressName: shortAddressName ?? this.shortAddressName,
      locationAddressFull: locationAddressFull ?? this.locationAddressFull,
      countryName: countryName ?? this.countryName,
      cityName: cityName ?? this.cityName,
      stateName: stateName ?? this.stateName,
      postalCode: postalCode ?? this.postalCode,
    );
  }
}

class LatLong {
  final double latitude;
  final double longitude;

  LatLong({required this.latitude, required this.longitude});
}
