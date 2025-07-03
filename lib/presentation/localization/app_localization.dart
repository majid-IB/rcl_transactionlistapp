// lib/presentation/localization/app_localizations.dart
class AppLocalizations {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'title': 'Transactions',
      'transaction_details': 'Transaction Details',
      'offline': 'Offline',
      'online': 'Online',
      'language': 'Language',
      'theme': 'Dark Theme',
      'amount': 'Amount',
      'type': 'Type',
      'merchant': 'Merchant',
      'date': 'Date',
      'error': 'Error',
      'loading': 'Loading...',
      'loading_more': 'Loading more...',
      'no_data': 'No transactions found',
    },
    'ur': {
      'title': 'لین دین',
      'transaction_details': 'لین دین کی تفصیلات',
      'offline': 'آف لائن',
      'online': 'آن لائن',
      'language': 'زبان',
      'theme': 'ڈارک تھیم',
      'amount': 'رقم',
      'type': 'قسم',
      'merchant': 'تاجر',
      'date': 'تاریخ',
      'error': 'خرابی',
      'loading': 'لوڈ ہو رہا ہے...',
      'loading_more': 'مزید لوڈ ہو رہا ہے...',
      'no_data': 'کوئی لین دین نہیں ملا',
    },
  };

  static String translate(String key, String language) {
    return _localizedStrings[language]?[key] ?? key;
  }
}