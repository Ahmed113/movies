class CastModel{
  String? name;
  String? character;
  String? profilePath;

  CastModel({this.name, this.character, this.profilePath});

  CastModel.fromjson(Map<String, dynamic> json){
    name = json['name'];
    character = json['character'];
    profilePath = json['profile_path'];
  }
}