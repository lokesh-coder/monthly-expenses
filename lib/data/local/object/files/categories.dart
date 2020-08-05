import 'package:flutter/material.dart';
import 'package:monthlyexp/config/monexp_icons.dart';
import 'package:monthlyexp/models/category.dart';

class Catagories {
  final List<Category> _debits = [
    _getItem('General', CatIcons.d_cash),
    _getItem('Card', CatIcons.d_credit_card),
    _getItem('Bill', CatIcons.d_receipt),
    _getItem('Home', CatIcons.d_home),
    _getItem('Food', CatIcons.d_food),
    _getItem('Grocery', CatIcons.d_cart),
    _getItem('Education', CatIcons.d_school),
    _getItem('Fuel', CatIcons.d_fuel),
    _getItem('Electricity', CatIcons.d_electricity),
    _getItem('Baby', CatIcons.d_baby),
//
    _getItem('Tax', CatIcons.d_tax),
    _getItem('Invest', CatIcons.d_invest),
//
    _getItem('Lend', CatIcons.d_lend),
    _getItem('Savings', CatIcons.d_saving),
//
    _getItem('Hair', CatIcons.d_hair),
    _getItem('Fitness', CatIcons.d_fitness),
    _getItem('Makeup', CatIcons.d_lipstick),
    _getItem('Apparel', CatIcons.d_shirt),
    _getItem('Fashion', CatIcons.d_shoe),
//
    _getItem('Shopping', CatIcons.d_shopping),
//
    _getItem('Mobile', CatIcons.d_phone),
    _getItem('Repairs', CatIcons.d_repair),
//
    _getItem('Donation', CatIcons.d_charity),
    _getItem('Gift', CatIcons.d_gift),
//
    _getItem('Travel', CatIcons.d_travel),
    _getItem('Bike', CatIcons.d_bicycle),
    _getItem('Train', CatIcons.d_travel),
    _getItem('Flight', CatIcons.d_flight),
    _getItem('Vacation', CatIcons.d_vacation),
    _getItem('Taxi', CatIcons.d_taxi),
//
    _getItem('Party', CatIcons.d_party),
    _getItem('Drinks', CatIcons.d_drinks),
//
    _getItem('Network', CatIcons.d_network),
    _getItem('TV', CatIcons.d_tv),
    _getItem('Streaming', CatIcons.d_stream),
    _getItem('Internet', CatIcons.d_internet),
    _getItem('Movies', CatIcons.d_movies),
//
    _getItem('Pet', CatIcons.c_pet),
    _getItem('Others', CatIcons.d_banking),
  ];

  final List<Category> _credits = [
    _getItem('General', CatIcons.c_general, 'credit'),
    _getItem('Salary', CatIcons.c_salary, 'credit'),
    _getItem('Returns', CatIcons.c_return, 'credit'),
    _getItem('Interest', CatIcons.c_interest, 'credit'),
    _getItem('Profit', CatIcons.c_profit, 'credit'),
    _getItem('Youtuber', CatIcons.c_youtube, 'credit'),
    _getItem('Other', CatIcons.c_general, 'credit'),
  ];

  List<Category> _categories;

  Catagories() {
    _categories = _mixCategories();
  }

  Category get defaultCategory => _categories[0];

  List<Category> get all => _categories;

  List<Category> filterBy(String type) =>
      _categories.where((c) => c.type.toUpperCase() == type).toList();

  Category findCategoryById(String categoryID) => _categories.firstWhere(
        (c) => c.id == categoryID,
        orElse: () => null,
      );

  static Category _getItem(
    String title, [
    IconData icon,
    String type = 'debit',
  ]) =>
      Category(
        id: title.toUpperCase(),
        name: title,
        icon: icon,
        group: '',
        type: type,
      );

  List<Category> _mixCategories() => [..._debits, ..._credits];
}
