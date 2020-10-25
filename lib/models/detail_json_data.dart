class DetailJsonData {
  List<Datum> data;

  DetailJsonData({
    this.data,
  });

  factory DetailJsonData.fromJson(Map<String, dynamic> json) =>
      new DetailJsonData(
        data: new List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Edata edata;
  String id;

  Datum({
    this.edata,
    this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
        edata: Edata.fromJson(json["edata"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "edata": edata.toJson(),
        "id": id,
      };
}

class Edata {
  String guide;
  Inner inner;
  String state;
  String target;
  String unit;
  String value;

  Edata({
    this.guide,
    this.inner,
    this.state,
    this.target,
    this.unit,
    this.value,
  });

  factory Edata.fromJson(Map<String, dynamic> json) => new Edata(
        guide: json["guide"],
        inner: Inner.fromJson(json["inner"]),
        state: json["state"] == null ? null : json["state"],
        target: json["target"],
        unit: json["unit"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "guide": guide,
        "inner": inner.toJson(),
        "state": state == null ? null : state,
        "target": target,
        "unit": unit,
        "value": value,
      };
}

class Inner {
  List<String> desc;
  List<String> inter;
  double num;

  Inner({
    this.desc,
    this.inter,
    this.num,
  });

  factory Inner.fromJson(Map<String, dynamic> json) => new Inner(
        desc: new List<String>.from(json["desc"].map((x) => x)),
        inter: new List<String>.from(json["inter"].map((x) => x)),
        num: json["num"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "desc": new List<dynamic>.from(desc.map((x) => x)),
        "inter": new List<dynamic>.from(inter.map((x) => x)),
        "num": num,
      };
}
