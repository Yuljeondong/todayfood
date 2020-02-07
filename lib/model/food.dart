class Food {
  int fid;
  String name;
  String thumbnail;
  List<String> tag;

  Food(this.fid, this.name, this.tag, this.thumbnail);

  Food.fromJson(Map<String, dynamic> json)
      : fid = json['fid'],
        name = json['name'],
        thumbnail = json['thumbnail'],
        tag = json['tag'];
}
