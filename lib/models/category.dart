class Category {
  String id;
  String name;
  String path;
  String group;
  String type;

  Category({
    this.id,
    this.name,
    this.path,
    this.group,
    this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      path: json["path"],
      group: json["group"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "name": name,
        "path": path,
        "group": group,
        "type": type,
      };
}
