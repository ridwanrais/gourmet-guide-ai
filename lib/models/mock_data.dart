import 'restaurant.dart';

class MockDataProvider {
  static List<Restaurant> getRestaurants() {
    return [
      Restaurant(
        id: '1',
        name: 'Spice Garden',
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&w=1000&q=80',
        rating: 4.7,
        priceRange: '\$\$',
        cuisineTypes: ['Indian', 'Spicy', 'Vegetarian'],
        address: '123 Spice Lane, Jakarta',
        distance: 1.2,
        aiDescription: 'Spice Garden stands out for its authentic Indian flavors and generous vegetarian options. Their perfectly balanced spice levels cater to both spice enthusiasts and those who prefer milder tastes. The restaurant\'s warm ambiance and attentive service make it ideal for both casual dining and special occasions.',
        popularItems: [
          FoodItem(
            id: '101',
            name: 'Butter Chicken',
            imageUrl: 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=684&q=80',
            price: 85000,
            description: 'Tender chicken in a rich, creamy tomato sauce',
            tags: ['Spicy', 'Popular', 'Meat'],
          ),
          FoodItem(
            id: '102',
            name: 'Vegetable Biryani',
            imageUrl: 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
            price: 65000,
            description: 'Fragrant rice with mixed vegetables and spices',
            tags: ['Vegetarian', 'Rice', 'Flavorful'],
          ),
        ],
      ),
      Restaurant(
        id: '2',
        name: 'Burger Haven',
        imageUrl: 'https://images.unsplash.com/photo-1555992336-03a23c7b20ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YnVyZ2VyJTIwcmVzdGF1cmFudHxlbnwwfHwwfHw%3D&w=1000&q=80',
        rating: 4.5,
        priceRange: '\$',
        cuisineTypes: ['American', 'Fast Food', 'Burgers'],
        address: '456 Burger Street, Jakarta',
        distance: 0.8,
        aiDescription: 'Burger Haven is perfect for those seeking a quick, satisfying meal without breaking the bank. Their burgers feature locally-sourced beef and freshly baked buns. Being just 0.8 km away makes it an excellent choice when you\'re hungry and don\'t want to travel far. Their efficient service ensures you\'ll be enjoying your meal in minutes.',
        popularItems: [
          FoodItem(
            id: '201',
            name: 'Classic Cheeseburger',
            imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
            price: 45000,
            description: 'Juicy beef patty with cheese, lettuce, and special sauce',
            tags: ['Beef', 'Cheese', 'Popular'],
          ),
          FoodItem(
            id: '202',
            name: 'Loaded Fries',
            imageUrl: 'https://images.unsplash.com/photo-1585109649139-366815a0d713?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZnJpZXN8ZW58MHx8MHx8&w=1000&q=80',
            price: 35000,
            description: 'Crispy fries topped with cheese, bacon, and green onions',
            tags: ['Side', 'Cheesy', 'Shareable'],
          ),
        ],
      ),
      Restaurant(
        id: '3',
        name: 'Sushi World',
        imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c3VzaGklMjByZXN0YXVyYW50fGVufDB8fDB8fA%3D%3D&w=1000&q=80',
        rating: 4.8,
        priceRange: '\$\$\$',
        cuisineTypes: ['Japanese', 'Sushi', 'Seafood'],
        address: '789 Ocean Drive, Jakarta',
        distance: 2.5,
        aiDescription: 'With the highest rating in the area (4.8), Sushi World offers an exceptional dining experience for sushi enthusiasts. Their fish is delivered fresh daily, and their skilled chefs have trained in Japan. The premium price point reflects the quality of ingredients and craftsmanship that goes into each dish. Perfect for special occasions or when you\'re craving authentic Japanese cuisine.',
        popularItems: [
          FoodItem(
            id: '301',
            name: 'Rainbow Roll',
            imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3VzaGl8ZW58MHx8MHx8&w=1000&q=80',
            price: 95000,
            description: 'California roll topped with assorted sashimi',
            tags: ['Seafood', 'Raw', 'Colorful'],
          ),
          FoodItem(
            id: '302',
            name: 'Tempura Udon',
            imageUrl: 'https://images.unsplash.com/photo-1618841557871-b4664fbf0cb3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dWRvbnxlbnwwfHwwfHw%3D&w=1000&q=80',
            price: 75000,
            description: 'Thick noodles in savory broth with crispy tempura',
            tags: ['Hot', 'Noodles', 'Comfort Food'],
          ),
        ],
      ),
      Restaurant(
        id: '4',
        name: 'Green Plate',
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80',
        rating: 4.6,
        priceRange: '\$\$',
        cuisineTypes: ['Vegan', 'Healthy', 'Salads'],
        address: '321 Veggie Avenue, Jakarta',
        distance: 1.7,
        aiDescription: 'Green Plate is the perfect choice for health-conscious diners. Their menu features locally-sourced organic ingredients transformed into creative, nutrient-dense dishes that don\'t sacrifice flavor. The moderate price point offers excellent value considering the quality of ingredients. Their commitment to sustainability extends to eco-friendly packaging and a low-waste kitchen.',
        popularItems: [
          FoodItem(
            id: '401',
            name: 'Buddha Bowl',
            imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aGVhbHRoeSUyMGZvb2R8ZW58MHx8MHx8&w=1000&q=80',
            price: 65000,
            description: 'Quinoa, roasted vegetables, avocado, and tahini dressing',
            tags: ['Vegan', 'Nutritious', 'Colorful'],
          ),
          FoodItem(
            id: '402',
            name: 'Green Smoothie Bowl',
            imageUrl: 'https://images.unsplash.com/photo-1490885578174-acda8905c2c6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21vb3RoaWUlMjBib3dsfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
            price: 55000,
            description: 'Spinach, banana, and almond milk topped with granola and berries',
            tags: ['Breakfast', 'Sweet', 'Refreshing'],
          ),
        ],
      ),
      Restaurant(
        id: '5',
        name: 'Noodle House',
        imageUrl: 'https://images.unsplash.com/photo-1526318896980-cf78c088247c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bm9vZGxlJTIwc2hvcHxlbnwwfHwwfHw%3D&w=1000&q=80',
        rating: 4.4,
        priceRange: '\$',
        cuisineTypes: ['Chinese', 'Noodles', 'Soup'],
        address: '567 Noodle Lane, Jakarta',
        distance: 1.1,
        aiDescription: 'Noodle House offers exceptional value with its budget-friendly prices and generous portions. Their hand-pulled noodles are made fresh daily, giving them that perfect chewy texture. At just 1.1 km away, it\'s conveniently located for a quick, satisfying meal. Their soup broths simmer for hours, developing deep, complex flavors that warm you from the inside out.',
        popularItems: [
          FoodItem(
            id: '501',
            name: 'Beef Noodle Soup',
            imageUrl: 'https://images.unsplash.com/photo-1555126634-323283e090fa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bm9vZGxlJTIwc291cHxlbnwwfHwwfHw%3D&w=1000&q=80',
            price: 50000,
            description: 'Rich broth with tender beef slices and chewy noodles',
            tags: ['Hot', 'Beef', 'Comfort Food'],
          ),
          FoodItem(
            id: '502',
            name: 'Dumplings',
            imageUrl: 'https://images.unsplash.com/photo-1563245372-f21724e3856d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZHVtcGxpbmdzfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
            price: 40000,
            description: 'Steamed pork and vegetable dumplings with dipping sauce',
            tags: ['Appetizer', 'Pork', 'Steamed'],
          ),
        ],
      ),
    ];
  }

  static List<String> getSuggestions() {
    return [
      "I feel like eating something spicy and cheap",
      "Recommend a healthy lunch option",
      "What's a good vegetarian restaurant nearby?",
      "I want something quick and filling",
      "Show me the best-rated restaurants",
      "I'm in the mood for Asian food",
      "Surprise me!",
    ];
  }

  // Simulate AI processing of user input
  static List<Restaurant> getRecommendations(String userInput, String location) {
    final allRestaurants = getRestaurants();
    
    // Simple keyword matching for demo purposes
    if (userInput.toLowerCase().contains('spicy')) {
      return allRestaurants.where((r) => 
        r.cuisineTypes.any((c) => c.toLowerCase().contains('spicy')) ||
        r.popularItems.any((i) => i.tags.any((t) => t.toLowerCase().contains('spicy')))
      ).toList();
    } else if (userInput.toLowerCase().contains('cheap') || userInput.toLowerCase().contains('budget')) {
      return allRestaurants.where((r) => r.priceRange == '\$').toList();
    } else if (userInput.toLowerCase().contains('vegetarian') || userInput.toLowerCase().contains('vegan')) {
      return allRestaurants.where((r) => 
        r.cuisineTypes.any((c) => c.toLowerCase().contains('vegan') || c.toLowerCase().contains('vegetarian'))
      ).toList();
    } else if (userInput.toLowerCase().contains('surprise')) {
      // Shuffle and return random restaurants
      final shuffled = List<Restaurant>.from(allRestaurants)..shuffle();
      return shuffled.take(3).toList();
    } else {
      // Default: return all sorted by rating
      return List<Restaurant>.from(allRestaurants)..sort((a, b) => b.rating.compareTo(a.rating));
    }
  }
}
