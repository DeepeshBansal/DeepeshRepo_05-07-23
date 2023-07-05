
class Place {
  final String placeId;
  final String name;
  final String lat;
  final String lon;

  Place({
    this.placeId = '',
    this.name = '',
    required this.lat,
    required this.lon,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        placeId: json['place_id'],
        name: json['formatted_address'],
        lat: json['geometry']['location']['lat'],
        lon: json['geometry']['location']['lng']);
  }
}
