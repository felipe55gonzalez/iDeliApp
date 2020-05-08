class Galeria {
  List<Urls> urls;

  Galeria({this.urls});

  Galeria.fromJson(Map<String, dynamic> json) {
    if (json['Urls'] != null) {
      urls = new List<Urls>();
      json['Urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.urls != null) {
      data['Urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Urls {
  String url;

  Urls({this.url});

  Urls.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Url'] = this.url;
    return data;
  }
}