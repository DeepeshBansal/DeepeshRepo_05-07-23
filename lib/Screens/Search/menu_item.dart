class MenuItem {
  final int id;
  final String restaurant;
  final String dish;
  final String urlImage;
  final String assetLocation;

  const MenuItem({
    required this.id,
    required this.restaurant,
    required this.dish,
    required this.urlImage,
    required this.assetLocation,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json['id'],
        dish: json['dish'],
        restaurant: json['restaurant'],
        urlImage: json['urlImage'],
        assetLocation: json['assetLocation']
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'restaurant': restaurant,
        'dish': dish,
        'urlImage': urlImage,
        'assetLocation' :assetLocation,
      };
}
