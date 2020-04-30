import 'package:monex/models/category.dart';

class Catagories {
  List<Category> _debits = [
    _getItem('General', 'general'),
    _getItem('Card', 'card-payment'),
    _getItem('Bill', 'request-service'),
    _getItem('Home', 'house'),
    _getItem('Food', 'restaurant'),
    _getItem('Grocery', 'shopping-cart'),
    _getItem('Education', 'student-male'),
    _getItem('Fuel', 'charging-station'),
    _getItem('Electricity', 'wall-socket-with-plug'),
    _getItem('Baby', 'baby-bottle'),
//
    _getItem('Tax', 'tax'),
    _getItem('Invest', 'account'),
//
    _getItem('Lend', 'cash-in-hand'),
    _getItem('Savings', 'money-box'),
//
    _getItem('Hair', 'barbershop'),
    _getItem('Fitness', 'barbell'),
    _getItem('Makeup', 'nail-polish'),
    _getItem('Apparel', 't-shirt'),
    _getItem('Fashion', 'women-shoes'),
//
    _getItem('E-Shop', 'online-shopping'),
    _getItem('Shopping', 'online-store'),
//
    _getItem('Mobile', 'phonelink-ring'),
    _getItem('Repairs', 'wrench'),
//
    _getItem('Donation', 'donation'),
    _getItem('Gift', 'gift'),
//
    _getItem('Travel', 'luggage'),
    _getItem('Bike', 'scooter'),
    _getItem('Train', 'subway'),
    _getItem('Flight', 'airplane-take-off'),
    _getItem('Vacation', 'beach-umbrella'),
    _getItem('Taxi', 'taxi-back-view'),
//
    _getItem('Party', 'the-toast'),
    _getItem('Drinks', 'wine'),
//
    _getItem('Network', 'chip-card'),
    _getItem('TV', 'tv-show'),
    _getItem('Streaming', 'laptop-play-video'),
    _getItem('Internet', 'website'),
    _getItem('Movies', 'cinema'),
//
    _getItem('Pet', 'dog'),
    _getItem('Others', 'bill'),
  ];

  List<Category> _credits = [
    _getItem('General', 'general', null, 'credit'),
    _getItem('Salary', 'money-transfer', null, 'credit'),
    _getItem('Returns', 'coin-in-hand', null, 'credit'),
    _getItem('Interest', 'discount', null, 'credit'),
    _getItem('Profit', 'profit', null, 'credit'),
    _getItem('Youtuber', 'youtube', null, 'credit'),
    _getItem('Other', 'stack-of-money', null, 'credit'),
  ];

  List<Category> _categories;

  Catagories() {
    _categories = _mixCategories();
  }

  Category get defaultCategory {
    return _categories[0];
  }

  List<Category> get all {
    return _categories;
  }

  List<Category> filterBy(type) {
    return _categories.where((c) => c.type.toUpperCase() == type).toList();
  }

  Category findCategoryById(String categoryID) {
    return _categories.firstWhere(
      (c) => c.id == categoryID,
      orElse: () => null,
    );
  }

  static Category _getItem(String title, String imgName,
      [String category, String type = 'debit']) {
    return Category(
      id: (category ?? title).toUpperCase(),
      name: title,
      path: _path(imgName, type),
      group: '',
      type: type,
    );
  }

  List<Category> _mixCategories() {
    return [..._debits, ..._credits];
  }

  static String _path(name, [type = 'credit']) {
    return 'assets/icons/$type/icons8-$name-50.png';
  }
}
