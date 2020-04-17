import 'package:flutter/material.dart';

class SortStrategy {
  int id;
  String name;
  String desc;
  IconData icon;

  SortStrategy({
    this.id,
    this.name,
    this.desc,
    this.icon,
  });

  factory SortStrategy.fromJson(Map<String, dynamic> json) {
    return SortStrategy(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'desc': desc,
        'icon': icon,
      };
}
