import "package:flutter/material.dart";

class SortStrategy {
  int id;
  String name;
  String desc;
  IconData icon;
  Function keyFn;
  String ascLabel;
  String descLabel;

  SortStrategy({
    this.id,
    this.name,
    this.desc,
    this.icon,
    this.keyFn,
    this.ascLabel,
    this.descLabel,
  });

  factory SortStrategy.fromJson(Map<String, dynamic> json) {
    return SortStrategy(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      icon: json["icon"],
      keyFn: json["keyFn"],
      ascLabel: json["ascLabel"],
      descLabel: json["descLabel"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "name": name,
        "desc": desc,
        "icon": icon,
        "keyFn": keyFn,
        "ascLabel": ascLabel,
        "descLabel": ascLabel,
      };
}
