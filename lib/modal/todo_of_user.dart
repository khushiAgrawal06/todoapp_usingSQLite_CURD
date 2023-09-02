

class todo_of_user{

  todo_of_user({
    this.title,
    this.description,
    this.id,
    this.date,
    this.userid,
  });

  String? title;
  String? description;
  String? date;
  int? id;
  int? userid;

  factory todo_of_user.fromMap(Map<String, dynamic> json) => todo_of_user(
    title: json["title"],
    description: json["description"],
    date: json["date"],
    id:  json["id"],
    userid:  json["userid"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "date": date,
    "id" : id,
    "userid" : userid
  };
}