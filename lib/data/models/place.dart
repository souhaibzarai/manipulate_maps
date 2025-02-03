class Place {
  late String placeID;
  late String description;

  Place({required this.placeID, required this.description});

  Place.fromJson(Map<String, dynamic> json) {
    placeID = json['place_id'];
    description = json['description'];
  }
}
