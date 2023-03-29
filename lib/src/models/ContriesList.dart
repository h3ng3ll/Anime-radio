


enum CountriesEnum {
  poland  ,
  england  ,
  japan  ,
  germany  ,
  usa  ,
  russian ,
  international,
}

class CountriesList {

  List<String> getCountry (String locale) {

    switch ( locale) {
      case "en" : return _en;
      case "ru" : return _ru;
      case "uk" : return _uk;

      default: throw Exception("Invalid locale code gave");
    }
  }

  /// This List will be extend as soon as new
  /// station will be added with
  /// other countries .

  final List<String> _en = [
    "Poland" ,
    "England" ,
    "Japan" ,
    "Germany" ,
    "USA" ,
    "Russian",
    "International"
  ];

  final List<String> _ru = [
    "Польша",
    "Англия",
    "Япония" ,
    "Германия" ,
    "США" ,
    "Россия",
    "Международный"
  ];

  final List<String> _uk = [
    "Польща",
    "Англія",
    "Японія",
    "Німеччина" ,
    "США" ,
    "Росія",
    "Міждународний"
  ];
  
  

}