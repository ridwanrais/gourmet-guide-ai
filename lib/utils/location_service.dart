import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gofood_ai/services/api_service.dart';

class LocationService {
  // Get current location
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      return null;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle accordingly
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle accordingly
      return null;
    }

    // When we reach here, permissions are granted and we can
    // access the device's location
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }

  // Request location permission
  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    return status.isGranted;
  }

  // Check if location permission is granted
  static Future<bool> isLocationPermissionGranted() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }

  // Get formatted address from coordinates using API
  static Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      final result = await ApiService.reverseGeocode(latitude, longitude);
      return result['formattedAddress'] ?? "Unknown location";
    } catch (e) {
      // Fallback to default value if API call fails
      print('Error: $e');
      throw Exception('Failed to get address from coordinates: $e');
    }
  }
  
  // Get coordinates from address using API
  static Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
    try {
      final result = await ApiService.geocodeAddress(address);
      return {
        'latitude': result['latitude'],
        'longitude': result['longitude'],
      };
    } catch (e) {
      return null;
    }
  }
}
