import 'package:flutter/material.dart';
import 'package:gofood_ai/services/api_service.dart';
import 'package:gofood_ai/utils/location_service.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  final TextEditingController _locationController = TextEditingController(text: "Jakarta, Indonesia");
  final TextEditingController _preferenceController = TextEditingController(text: "Spicy food");
  
  String _responseText = "No response yet";
  bool _isLoading = false;

  Future<void> _testGeocodeApi() async {
    if (_locationController.text.isEmpty) {
      setState(() {
        _responseText = "Please enter a location";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _responseText = "Loading...";
    });

    try {
      final coordinates = await LocationService.getCoordinatesFromAddress(_locationController.text);
      setState(() {
        _responseText = "Coordinates: $coordinates";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _responseText = "Error: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _testReverseGeocodeApi() async {
    setState(() {
      _isLoading = true;
      _responseText = "Loading...";
    });

    try {
      // Use Jakarta coordinates as a test
      const double latitude = -6.2088;
      const double longitude = 106.8456;
      
      final address = await LocationService.getAddressFromCoordinates(latitude, longitude);
      setState(() {
        _responseText = "Address: $address";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _responseText = "Error: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _testSuggestionsApi() async {
    setState(() {
      _isLoading = true;
      _responseText = "Loading...";
    });

    try {
      final suggestions = await ApiService.getFoodPreferenceSuggestions();
      setState(() {
        _responseText = "Suggestions: $suggestions";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _responseText = "Error: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _testRecommendationsApi() async {
    if (_preferenceController.text.isEmpty) {
      setState(() {
        _responseText = "Please enter a preference";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _responseText = "Loading...";
    });

    try {
      Map<String, double>? coordinates;
      if (_locationController.text.isNotEmpty) {
        coordinates = await LocationService.getCoordinatesFromAddress(_locationController.text);
      }

      final recommendations = await ApiService.getRestaurantRecommendations(
        prompt: _preferenceController.text,
        latitude: coordinates?['latitude'],
        longitude: coordinates?['longitude'],
      );
      
      setState(() {
        _responseText = "Found ${recommendations.length} restaurants:\n" +
            recommendations.map((r) => "- ${r.name} (${r.rating}★)").join("\n");
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _responseText = "Error: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _preferenceController,
              decoration: const InputDecoration(
                labelText: 'Food Preference',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _testGeocodeApi,
                    child: const Text('Test Geocode'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _testReverseGeocodeApi,
                    child: const Text('Test Reverse Geocode'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _testSuggestionsApi,
                    child: const Text('Test Suggestions'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _testRecommendationsApi,
                    child: const Text('Test Recommendations'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'API Response:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SelectableText(_responseText),
            ),
          ],
        ),
      ),
    );
  }
}
