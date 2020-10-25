class NewWeightRes {
  int age;
  bool exist;
  int weight;
  int electrodeNumber;
  String product;
  // int heartRate;
  int dataType;

  NewWeightRes.fromJson(Map<String, dynamic> data) {
    this.age = data['age'];
    this.exist = data['exist'];
    this.weight = data['weight'];
    this.electrodeNumber = data['electrodeNumber'];
    this.product = data['product'];
    // // this.heartRate = data['heartRate'];
    this.dataType = data['dataType'];
  }
}

class WeightHistory {
  double weight;
  double bfr;
  double height;
  double shapePercent;
  double bmi;
  int electrodeNumber;
  int measureId;
  int createTime;
  String shapeState;
  String healthGuide;
  String rankSuggestion;
  String rankShareSuggestion;

  WeightHistory.fromJson(Map data) {
    bmi = data['bmi'];
    bfr = data['bfr'];
    weight = data['weight'];
    height = data['height'];
    shapePercent = data['shapePercent'];
    electrodeNumber = data['electrodeNumber'];
    measureId = data['measureId'];
    createTime = data['createTime'];
    shapeState = data['shapeState'];
    healthGuide = data['healthGuide'];
    rankSuggestion = data['rankSuggestion'];
    rankShareSuggestion = data['rankShareSuggestion'];
  }
}

class ClaimWeight {
  int rawDataId;
  double weight;
  int timestamp;

  ClaimWeight({
    this.rawDataId,
    this.weight,
    this.timestamp,
  });

  factory ClaimWeight.fromJson(Map<String, dynamic> json) => new ClaimWeight(
        rawDataId: json["rawDataId"],
        weight: json["weight"].toDouble(),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "rawDataId": rawDataId,
        "weight": weight,
        "timestamp": timestamp,
      };
}

class Twitter {
  double id;
  String strId;
  String channel;
  String text;
  dynamic images;
  Publisher publisher;
  DateTime createAt;
  String location;
  dynamic link;
  int commentCount;
  int likeCount;
  bool liked;

  Twitter({
    this.id,
    this.strId,
    this.channel,
    this.text,
    this.images,
    this.publisher,
    this.createAt,
    this.location,
    this.link,
    this.commentCount,
    this.likeCount,
    this.liked,
  });

  factory Twitter.fromJson(Map<String, dynamic> json) => new Twitter(
        id: json["id"].toDouble(),
        strId: json["strId"],
        channel: json["channel"],
        text: json["text"],
        images: new List<TwitterImage>.from(
            json["images"].map((x) => TwitterImage.fromJson(x))),
        publisher: Publisher.fromJson(json["publisher"]),
        createAt: DateTime.parse(json["createAt"]),
        location: json["location"],
        link: json["link"],
        commentCount: json["commentCount"],
        likeCount: json["likeCount"],
        liked: json["liked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "strId": strId,
        "channel": channel,
        "text": text,
        "images": new List<dynamic>.from(images.map((x) => x)),
        "publisher": publisher.toJson(),
        "createAt": createAt.toIso8601String(),
        "location": location,
        "link": link,
        "commentCount": commentCount,
        "likeCount": likeCount,
        "liked": liked,
      };
}

class TwitterImage {
  String url;
  int height;
  int width;

  TwitterImage({
    this.url,
    this.height,
    this.width,
  });

  factory TwitterImage.fromJson(Map<String, dynamic> json) => new TwitterImage(
        url: json["url"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "height": height,
        "width": width,
      };
}

class Publisher {
  String id;
  String username;
  String headPictureUrl;
  int gender;
  bool official;

  Publisher({
    this.id,
    this.username,
    this.headPictureUrl,
    this.gender,
    this.official,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) => new Publisher(
        id: json["id"],
        username: json["username"],
        headPictureUrl: json["headPictureUrl"],
        gender: json["gender"],
        official: json["official"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "headPictureUrl": headPictureUrl,
        "gender": gender,
        "official": official,
      };
}
