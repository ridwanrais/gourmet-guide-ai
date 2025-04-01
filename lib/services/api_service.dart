import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gofood_ai/models/restaurant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static String baseUrl = dotenv.env['API_BASE_URL'] ?? 'https://api.gourmetguide.ai/v1';

  // Convert address to geographic coordinates
  static Future<Map<String, dynamic>> geocodeAddress(String address) async {
    final response = await http.post(
      Uri.parse('$baseUrl/location/geocode'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'address': address,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to geocode address: ${response.body}');
    }
  }

  // Convert coordinates to address
  static Future<Map<String, dynamic>> reverseGeocode(double latitude, double longitude) async {
    final response = await http.post(
      Uri.parse('$baseUrl/location/reverse-geocode'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'latitude': latitude,
        'longitude': longitude,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reverse geocode: ${response.body}');
    }
  }

  // Get food preference suggestions
  static Future<List<String>> getFoodPreferenceSuggestions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/preferences/suggestions'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['suggestions']);
    } else {
      throw Exception('Failed to get preference suggestions: ${response.body}');
    }
  }

  // Get restaurant recommendations
  static Future<List<Restaurant>> getRestaurantRecommendations({
    required String prompt,
    double? latitude,
    double? longitude,
    double radius = 5.0,
    int limit = 10,
  }) async {
    final Map<String, dynamic> requestBody = {
      'prompt': prompt,
      'radius': radius,
      'limit': limit,
    };

    if (latitude != null && longitude != null) {
      requestBody['coordinates'] = {
        'latitude': latitude,
        'longitude': longitude,
      };
    }

    final response = await http.post(
      Uri.parse('$baseUrl/restaurants/recommendations'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final restaurants = data['restaurants'] as List;
      
      return restaurants.map((restaurantJson) {
        final popularItemsJson = restaurantJson['popularItems'] as List;
        final popularItems = popularItemsJson.map((itemJson) => FoodItem(
          id: itemJson['id'],
          name: itemJson['name'],
          imageUrl: itemJson['imageUrl'],
          price: itemJson['price'].toDouble(),
          description: itemJson['description'],
          tags: List<String>.from(itemJson['tags']),
        )).toList();

        return Restaurant(
          id: restaurantJson['id'],
          name: restaurantJson['name'],
          imageUrl: restaurantJson['imageUrl'] ?? 'https://via.placeholder.com/400x300?text=No+Image',
          rating: restaurantJson['rating'].toDouble(),
          priceRange: restaurantJson['priceRange'],
          cuisineTypes: List<String>.from(restaurantJson['cuisineTypes']),
          address: restaurantJson['address'] ?? '',
          distance: restaurantJson['distance'].toDouble(),
          popularItems: popularItems,
          aiDescription: restaurantJson['aiDescription'],
        );
      }).toList();
    } else {
      throw Exception('Failed to get recommendations: ${response.body}');
    }
  }

  // Find restaurants using Gofood API
  static Future<Map<String, dynamic>> findGofoodRestaurants({
    required double latitude,
    required double longitude,
    String? query,
  }) async {
    final Uri uri = Uri.parse('$baseUrl/gofood/restaurants').replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        if (query != null && query.isNotEmpty) 'query': query,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to find Gofood restaurants: ${response.body}');
    }
  }
}
