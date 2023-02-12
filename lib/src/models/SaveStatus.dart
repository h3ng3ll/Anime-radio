

class SaveStatus {

  final bool isSaved;
  final String path;

  String? error  ;

  SaveStatus(this.isSaved, this.path , [this.error]);
}