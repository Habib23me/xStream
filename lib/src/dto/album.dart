import 'package:x_stream/x_stream.dart';
class Album {
  String sId;
  String name;
  String albumImage;
  Artist artist;
  List<Song> songs;

  Album(
      {this.sId, this.name, this.albumImage, this.artist, this.songs});

  Album.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    albumImage = HttpRoutes.IMAGE_URL+json['albumImage'];
    artist =
    json['artist'] != null ? new Artist.fromJson(json['artist']) : null;
    if (json['songs'] != null) {
      songs = new List<Song>();
      json['songs'].forEach((v) {
        songs.add(new Song.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['albumImage'] = this.albumImage;
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    if (this.songs != null) {
      data['songs'] = this.songs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


