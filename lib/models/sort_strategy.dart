import 'package:flutter/material.dart';

class SortStrategy {
  int id;
  String name;
  String desc;
  IconData icon;
  Function keyFn;

  SortStrategy({
    this.id,
    this.name,
    this.desc,
    this.icon,
    this.keyFn,
  });

  factory SortStrategy.fromJson(Map<String, dynamic> json) {
    return SortStrategy(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      icon: json["icon"],
      keyFn: json["keyFn"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'desc': desc,
        'icon': icon,
        'keyFn': keyFn,
      };
}
