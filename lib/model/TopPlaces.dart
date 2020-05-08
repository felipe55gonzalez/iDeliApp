class TopPlaces {
  final List<Place> place;
  TopPlaces({this.place});
  factory TopPlaces.fromJson(List<dynamic> parsedJson) {
    List<Place> places = new List<Place>();
    places = parsedJson.map((i) => Place.fromJson(i)).toList();
    return new TopPlaces(place: places);
  }
}

class Place {
  int id;
  String name;
  String dir;
  String urlimg;
  String urlgit;
  final List<String> tags;
  Place({this.id,this.dir, this.name, this.urlimg, this.urlgit, this.tags});
  factory Place.fromJson(Map<String, dynamic> json) {
    var tagstoConvert = json['Tags'];
    List<String> tagslist = new List<String>.from(tagstoConvert);
    return new Place(
        id: json['ID'],
        name: json['name'],
        dir: json['Dirreccion'],
        urlimg: json['Img'],
        urlgit: json['linkgit'],
        tags: tagslist);
  }
}
