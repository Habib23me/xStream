
class Song {
  String sId;
  String name;
  String songPath;
  Duration length;

  Song({this.sId, this.name, this.songPath, this.length});

  Song.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    songPath = json['songPath'];
    String rawLength=json['length'];
    length = Duration(seconds:double.parse(rawLength).ceil());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['songPath'] = this.songPath;
    data['length'] = this.length;
    return data;
  }
}
