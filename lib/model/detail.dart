class ModelDetailMovie {
  ModelDetailMovie({
    required this.movie,
    required this.credit,
    required this.review,
    required this.video,
    required this.state,
  });
  late Map movie;
  late Map credit;
  late Map review;
  late Map video;
  late Map state;
}

class ModelDetailTv {
  ModelDetailTv({
    required this.tv,
    required this.credit,
    required this.review,
    required this.video,
    required this.session,
    required this.state,
  });
  late Map tv;
  late Map credit;
  late Map review;
  late Map video;
  late List session;
  late Map state;
}
