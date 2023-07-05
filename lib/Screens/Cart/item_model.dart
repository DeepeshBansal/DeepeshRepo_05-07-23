class Item {
  final String name;
  final String category;
  final String menutype;
  final String restaurant;
  final String itemdescription;
  final String identity;
  final int price;
  final String image;

  Item(
      {required this.name,
      required this.category,
      required this.menutype,
      required this.restaurant,
      required this.itemdescription,
      required this.identity,
      required this.price,
      required this.image});

  Map toJson() {
    return {
      'name': name,
      'category': category,
      'menutype': menutype,
      'restaurant' : restaurant,
      'identity' : identity,
      'itemdescription' : itemdescription,
      'price': price,
      'image': image,
    };
  }
}
