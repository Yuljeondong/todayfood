
class History {
  int hid;
  int fid;
  DateTime date;

  History(this.hid, this.fid, this.date);

  History.fromJson(Map<String, dynamic> json)
      : hid = json['hid'],
        fid = json['fid'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        'hid': hid,
        'fid': fid,
        'date': date,
      };
}