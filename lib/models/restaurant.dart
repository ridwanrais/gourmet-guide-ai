class Restaurant {
  final String id;
  final String name;
  final String? imageUrl;
  final double rating;
  final String priceRange;
  final List<String> cuisineTypes;
  final String? address;
  final double distance;
  final List<FoodItem> popularItems;
  final String? aiDescription;

  Restaurant({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.rating,
    required this.priceRange,
    required this.cuisineTypes,
    this.address = '',
    required this.distance,
    required this.popularItems,
    this.aiDescription = '',
  });
}

class FoodItem {
  final String id;
  final String name;
  final String? imageUrl;
  final double price;
  final String? description;
  final List<String> tags;

  FoodItem({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.price,
    this.description = '',
    required this.tags,
  });
}
