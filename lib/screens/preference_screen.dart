import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gofood_ai/services/api_service.dart';
import 'package:gofood_ai/screens/results_screen.dart';
import 'package:gofood_ai/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:gofood_ai/utils/theme_provider.dart';

class PreferenceScreen extends StatefulWidget {
  final String location;

  const PreferenceScreen({super.key, required this.location});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final TextEditingController _preferenceController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isProcessing = false;
  bool _isLoadingSuggestions = true;
  List<String> _suggestions = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Set focus to the text field after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _focusNode.requestFocus();
    });
    _loadSuggestions();
  }
  
  Future<void> _loadSuggestions() async {
    setState(() {
      _isLoadingSuggestions = true;
      _errorMessage = null;
    });
    
    try {
      final suggestions = await ApiService.getFoodPreferenceSuggestions();
      setState(() {
        _suggestions = suggestions;
        _isLoadingSuggestions = false;
      });
    } catch (e) {
      setState(() {
        // Fallback to default suggestions if API call fails
        _suggestions = [
          "I feel like eating something spicy and cheap",
          "Recommend a healthy lunch option",
          "What's a good vegetarian restaurant nearby?",
          "I want something quick and filling",
          "Show me the best-rated restaurants",
          "I'm in the mood for Asian food",
          "Surprise me!",
        ];
        _errorMessage = "Couldn't load suggestions: $e";
        _isLoadingSuggestions = false;
      });
    }
  }

  void _processPreference() {
    if (_preferenceController.text.isEmpty) {
      // Use default "Surprise me!" if empty
      _preferenceController.text = "Surprise me!";
    }

    setState(() {
      _isProcessing = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          location: widget.location,
          preference: _preferenceController.text,
        ),
      ),
    ).then((_) {
      setState(() {
        _isProcessing = false;
      });
    });
  }

  void _selectSuggestion(String suggestion) {
    setState(() {
      _preferenceController.text = suggestion;
    });
    _processPreference();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Preferences'),
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
              Text(
                'What are you craving today?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 12),
              Text(
                'Tell us what you\'re in the mood for, and our AI will find the perfect meal for you.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                    ),
              ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 40),
              TextField(
                controller: _preferenceController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'e.g., "I feel like eating something spicy and cheap"',
                  prefixIcon: const Icon(Icons.restaurant_menu),
                  suffixIcon: _isProcessing
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
                          icon: const Icon(Icons.send),
                          onPressed: _processPreference,
                        ),
                ),
                onSubmitted: (_) => _processPreference(),
                enabled: !_isProcessing,
                maxLines: 1,
              ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.3, end: 0),
              const SizedBox(height: 24),
              Text(
                'Suggestions:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn(duration: 500.ms, delay: 600.ms),
              const SizedBox(height: 16),
              Expanded(
                child: _isLoadingSuggestions
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(
                            child: Text(
                              _errorMessage!,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                                  ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _suggestions.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  title: Text(_suggestions[index]),
                                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                                  onTap: () => _selectSuggestion(_suggestions[index]),
                                ),
                              ).animate().fadeIn(
                                    duration: 500.ms,
                                    delay: Duration(milliseconds: 700 + (index * 100)),
                                  );
                            },
                          ),
              ),
              const SizedBox(height: 16),
              if (!_isProcessing)
                ElevatedButton(
                  onPressed: _processPreference,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: const Text('Find Food'),
                ).animate().fadeIn(duration: 500.ms, delay: 1200.ms).slideY(begin: 0.3, end: 0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _preferenceController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
