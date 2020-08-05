import 'package:flutter/cupertino.dart';

class Category {
  String id;
  String name;
  IconData icon;
  String group;
  String type;

  Category({
    this.id,
    this.name,
    this.icon,
    this.group,
    this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      group: json['group'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'icon': icon,
        'group': group,
        'type': type,
      };
}
