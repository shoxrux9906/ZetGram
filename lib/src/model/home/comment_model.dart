class CommentModel {
  int? id;
  String? userName;
  String? comment;
  DateTime? dateTime;
  int? tapeId;

  CommentModel({
    required this.id,
    required this.userName,
    required this.comment,
    required this.dateTime,
    required this.tapeId,
  });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["_id"] = id;
    map["userName"] = userName;
    map["comment"] = comment;
    map["dateTime"] = dateTime!.toIso8601String();
    map["tapeId"] = tapeId;
    return map;
  }

  CommentModel.fromMap(Map<String, dynamic> map){
    this.id = map["_id"];
    this.userName = map["userName"];
    this.comment = map["comment"];
    this.dateTime = DateTime.parse(map["dateTime"]);
    this.tapeId = map["tapeId"];
  }
}