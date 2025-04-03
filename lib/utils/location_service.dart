import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gofood_ai/services/api_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
      print('Error getting current position: $e');
      return null;
    }
  }

  // Request location permission
  static Future<bool> requestLocationPermission() async {
    // For web, use Geolocator directly since permission_handler doesn't support web
    if (kIsWeb) {
      try {
        var permission = await Geolocator.requestPermission();
        return permission == LocationPermission.always || 
               permission == LocationPermission.whileInUse;
      } catch (e) {
        print('Error requesting location permission on web: $e');
        return false;
      }
    }
    
    // For mobile platforms, use both permission_handler and Geolocator
    try {
      // Request both precise and approximate location permissions
      Map<Permission, PermissionStatus> statuses = await [
        Permission.locationWhenInUse,
        Permission.location,
      ].request();
      
      print('Location permission statuses: $statuses');
      
      // Check if any of the location permissions are granted
      bool isGranted = statuses[Permission.locationWhenInUse]?.isGranted == true || 
                       statuses[Permission.location]?.isGranted == true;
      
      // Also request through Geolocator for better Android compatibility
      if (isGranted) {
        var geoStatus = await Geolocator.requestPermission();
        print('Geolocator permission status: $geoStatus');
      }
      
      return isGranted;
    } catch (e) {
      print('Error requesting location permission: $e');
      return false;
    }
  }

  // Check if location permission is granted
  static Future<bool> isLocationPermissionGranted() async {
    // For web, use Geolocator directly
    if (kIsWeb) {
      try {
        var permission = await Geolocator.checkPermission();
        return permission == LocationPermission.always || 
               permission == LocationPermission.whileInUse;
      } catch (e) {
        print('Error checking location permission on web: $e');
        return false;
      }
    }
    
    // For mobile platforms
    try {
      // Check both location permissions
      PermissionStatus locationStatus = await Permission.location.status;
      PermissionStatus locationWhenInUseStatus = await Permission.locationWhenInUse.status;
      
      print('Location permission status: $locationStatus');
      print('Location when in use status: $locationWhenInUseStatus');
      
      if (locationStatus.isGranted || locationWhenInUseStatus.isGranted) {
        return true;
      }
      
      // Double-check with Geolocator for Android
      var geoStatus = await Geolocator.checkPermission();
      print('Geolocator permission status: $geoStatus');
      
      return geoStatus == LocationPermission.always || 
             geoStatus == LocationPermission.whileInUse;
    } catch (e) {
      print('Error checking location permission: $e');
      return false;
    }
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
      print('Error getting coordinates from address: $e');
      return null;
    }
  }
}
