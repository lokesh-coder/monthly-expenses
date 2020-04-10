class Catagories {
  List finalCategories = [];
  List<List<String>> _categories = [
    ['beetroot-and-carrot', 'Groceries', 'GROCERIES'],
    ['check-for-payment', 'Cash', 'CASH'],
    ['cinema', 'Movies', 'MOVIES'],
    ['money-box', 'Savings', 'SAVINGS'],
    ['online-store', 'Shopping', 'SHOPPING'],
    ['receipt-approved', 'Bills', 'BILLS'],
    ['restaurant', 'Food', 'FOOD'],
    ['tax', 'Tax', 'TAX'],
    ['taxi-back-view', 'Transport', 'TRANSPORT'],
    ['treatment', 'Medical', 'TREATMENT'],
    ['transaction-approved', 'General', 'TRANS_APPROVED'],
  ];

  List get defaultCategory {
    return all[0];
  }

  List<List<String>> get all {
    if (finalCategories.length == 0)
      finalCategories = _categories.map((icon) {
        return ['assets/icons/icons8-${icon[0]}-100.png', icon[1], icon[2]];
      }).toList();
    return finalCategories;
  }

  List<String> findCategoryById(String categoryID) {
    return all.firstWhere((c) {
      return c[2] == categoryID;
    }, orElse: () => []);
  }
}
