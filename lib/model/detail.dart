class ModelDetailMovie {
  ModelDetailMovie({
    required this.movie,
    required this.credit,
    required this.review,
    required this.video,
  });
  late Map movie;
  late Map credit;
  late Map review;
  late Map video;
}

class ModelDetailTv {
  ModelDetailTv({
    required this.tv,
    required this.credit,
    required this.review,
    required this.video,
    required this.session,
  });
  late Map tv;
  late Map credit;
  late Map review;
  late Map video;
  late List session;
}
