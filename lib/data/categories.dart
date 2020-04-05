class CatagoriesList {
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

  List get categories {
    return _categories.map((icon) {
      icon[0] = 'assets/icons/icons8-${icon[0]}-100.png';
      return icon;
    }).toList();
  }

  findCategoryById(String categoryID) {
    return categories.firstWhere((c) {
      return c[2] == categoryID;
    }, orElse: () => null);
  }
}
