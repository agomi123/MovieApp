class Data {
  String? director;
  String? title;
  String? stars;
  String? genre;
  String? poster;
  int? pageViews;
  int? totalVoted;

  Data({
     this.director,
     this.genre,
     this.pageViews,
     this.poster,
     this.stars,
     this.title,
     this.totalVoted
  });

  Data.fromJson(Map<String, dynamic> json) {
    director = json['director'][0];
    title = json['title'];
    stars = json['stars'][0];
    genre = json['voted']['genre'];
    poster = json['poster'];
    pageViews = json['pageViews'];
    totalVoted = json['totalVoted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['director'][0] = director;
    data['title'] = title;
    data['stars'][0] = stars;
    data['voted']['genre'] = genre;
    data['poster'] = poster;
    data['pageViews'] = pageViews;
    data['totalVoted'] = totalVoted;
    
    return data;
  }
}