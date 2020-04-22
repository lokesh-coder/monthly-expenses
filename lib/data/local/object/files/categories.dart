import 'package:monex/models/category.dart';

class Catagories {
  List<Category> _categories = [
    Category(
      id: 'GROCERIES',
      name: 'Groceries',
      path: _path('beetroot-and-carrot'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'SALARY',
      name: 'Salary',
      path: _path('check-for-payment'),
      group: '',
      type: ['CREDIT'],
    ),
    Category(
      id: 'MOVIES',
      name: 'Movies',
      path: _path('cinema'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'SAVINGS',
      name: 'Savings',
      path: _path('money-box'),
      group: '',
      type: ['CREDIT'],
    ),
    Category(
      id: 'SHOPPING',
      name: 'Shopping',
      path: _path('online-store'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'BILLS',
      name: 'Bills',
      path: _path('receipt-approved'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'FOOD',
      name: 'Food',
      path: _path('restaurant'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'TAX',
      name: 'Tax',
      path: _path('tax'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'TRANSPORT',
      name: 'Transport',
      path: _path('taxi-back-view'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'TREATMENT',
      name: 'Medical',
      path: _path('treatment'),
      group: '',
      type: ['DEBIT'],
    ),
    Category(
      id: 'TRANS_APPROVED',
      name: 'General',
      path: _path('transaction-approved'),
      group: '',
      type: ['DEBIT'],
    ),
  ];

  Category get defaultCategory {
    return _categories[0];
  }

  List<Category> get all {
    return _categories;
  }

  List<Category> filterBy(type) {
    return _categories.where((c) => c.type.contains(type)).toList();
  }

  Category findCategoryById(String categoryID) {
    return _categories.firstWhere(
      (c) => c.id == categoryID,
      orElse: () => null,
    );
  }

  static String _path(name) {
    return 'assets/icons/icons8-$name-100.png';
  }
}
