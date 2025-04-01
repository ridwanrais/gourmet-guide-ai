import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gofood_ai/models/restaurant.dart';
import 'package:gofood_ai/services/api_service.dart';
import 'package:gofood_ai/utils/location_service.dart';
import 'package:gofood_ai/widgets/restaurant_card.dart';
import 'package:gofood_ai/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:gofood_ai/utils/theme_provider.dart';

class ResultsScreen extends StatefulWidget {
  final String location;
  final String preference;

  const ResultsScreen({
    super.key,
    required this.location,
    required this.preference,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late List<Restaurant> _recommendations;
  bool _isLoading = true;
  int _currentIndex = 0;
  bool _showingMore = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      // Try to get coordinates from the location string
      Map<String, double>? coordinates;
      if (widget.location.isNotEmpty) {
        coordinates = await LocationService.getCoordinatesFromAddress(widget.location);
      }
      
      // Call the API to get recommendations
      final recommendations = await ApiService.getRestaurantRecommendations(
        prompt: widget.preference,
        latitude: coordinates?['latitude'],
        longitude: coordinates?['longitude'],
      );
      
      setState(() {
        _recommendations = recommendations;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _recommendations = [];
        _errorMessage = "Couldn't load recommendations: $e";
        _isLoading = false;
      });
    }
  }

  void _showNextRecommendation() {
    setState(() {
      if (_currentIndex < _recommendations.length - 1) {
        _currentIndex++;
      } else {
        // Loop back to the first recommendation
        _currentIndex = 0;
      }
      _showingMore = false;
    });
  }

  void _toggleShowMore() {
    setState(() {
      _showingMore = !_showingMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Food Matches'),
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _buildErrorState()
              : _recommendations.isEmpty
                  ? _buildEmptyState()
                  : _buildResults(),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Theme.of(context).colorScheme.error.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              _errorMessage ?? 'Unable to load recommendations',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadRecommendations,
            child: const Text('Try Again'),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No matches found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different preference or location',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    final currentRestaurant = _recommendations[_currentIndex];
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Based on "${widget.preference}"',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'We found ${_recommendations.length} matches for you',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                RestaurantCard(
                  restaurant: currentRestaurant,
                  showDetails: _showingMore,
                  onToggleDetails: _toggleShowMore,
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _showNextRecommendation,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Show me something else'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryColor,
                          elevation: 2,
                          side: const BorderSide(color: AppTheme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 500.ms, delay: 300.ms).slideY(begin: 0.3, end: 0),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // In a real app, this would navigate to GoFood order page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Redirecting to GoFood order page...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Order Now'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: 500.ms).slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
