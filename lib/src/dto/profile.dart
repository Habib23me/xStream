class Profile {
  bool premium;
  String sId;
  String phone;
  String username;

  Profile({this.premium, this.sId, this.phone, this.username});

  Profile.fromJson(Map<String, dynamic> json) {
    premium = json['premium'];
    sId = json['_id'];
    phone = json['phone'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['premium'] = this.premium;
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['username'] = this.username;
    return data;
  }
}
