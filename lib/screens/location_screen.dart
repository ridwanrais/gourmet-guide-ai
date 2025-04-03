import 'package:flutter/material.dart';
import 'package:gofood_ai/screens/preference_screen.dart';
import 'package:gofood_ai/utils/location_service.dart';
import 'package:gofood_ai/utils/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:gofood_ai/utils/theme_provider.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Don't automatically check permissions on startup
    // Just initialize the UI in a clean state
  }

  Future<void> _checkLocationPermission() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final hasPermission = await LocationService.isLocationPermissionGranted();
      if (hasPermission) {
        _getCurrentLocation();
      } else {
        // If permission not granted, we'll request it when the user taps the button
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error checking location permission: $e');
      setState(() {
        _errorMessage = 'Error checking permissions';
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        final address = await LocationService.getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );
        setState(() {
          _locationController.text = address;
        });
      } else {
        setState(() {
          _errorMessage = 'Unable to get current location';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error getting location: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _requestLocationPermission() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final granted = await LocationService.requestLocationPermission();
      if (granted) {
        _getCurrentLocation();
      } else {
        setState(() {
          _errorMessage = 'Location permission denied';
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error requesting location permission: $e');
      setState(() {
        _errorMessage = 'Error requesting location permission';
        _isLoading = false;
      });
    }
  }

  void _continueToPreferences() async {
    if (_locationController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a location';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Use the geocodeAddress API to validate and get coordinates
      final coordinates = await LocationService.getCoordinatesFromAddress(_locationController.text);
      
      if (coordinates == null) {
        setState(() {
          _errorMessage = 'Could not find this location. Please try again.';
          _isLoading = false;
        });
        return;
      }
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreferenceScreen(
            location: _locationController.text,
            latitude: coordinates['latitude'],
            longitude: coordinates['longitude'],
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Error processing location: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Where are you?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 12),
              Text(
                'We need your location to find the best food options nearby.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
              ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 40),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Enter your location',
                  prefixIcon: const Icon(Icons.location_on_outlined),
                  suffixIcon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.my_location),
                          onPressed: _checkLocationPermission,
                        ),
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.3, end: 0),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: AppTheme.accentColor),
                  ),
                ).animate().fadeIn(duration: 300.ms),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _continueToPreferences,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Text('Continue'),
              ).animate().fadeIn(duration: 500.ms, delay: 600.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 16),
              if (!_isLoading && _locationController.text.isEmpty)
                TextButton.icon(
                  onPressed: _requestLocationPermission,
                  icon: const Icon(Icons.location_searching),
                  label: const Text('Use my current location'),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 800.ms).slideY(begin: 0.3, end: 0),
              const Spacer(),
              Center(
                child: Icon(
                  Icons.location_city,
                  size: 120,
                  color: AppTheme.primaryColor.withOpacity(0.7),
                ),
              ).animate().fadeIn(duration: 800.ms, delay: 1000.ms),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
