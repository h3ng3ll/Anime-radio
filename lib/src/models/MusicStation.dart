

/// Describe any translated music address
///
///

class MusicStation {


  String? imgAddress ;

  String address ;
  final String name ;

  bool favorite ;

  /// basic check if site accessible to connect
  final String validateUrl ;


  /// fetch unfiltered metadata about playing song and
  /// for every case must be initialized
  final List<String>? Function (String? , String) metaFormat;


  MusicStation({
    required this.validateUrl,
    required  this.metaFormat ,
    required this.address ,
    required this.name ,
    this.imgAddress,
    this.favorite = false  ,
  });


}