class DownloadVideoModel {
  String title;
  String file;

  DownloadVideoModel({this.title, this.file});

  factory DownloadVideoModel.fromDatabaseJson(Map<String, dynamic> data) => DownloadVideoModel(
        title: data['title'],
        file: data['file'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "title": this.title,
        "file": this.file,
      };
}
