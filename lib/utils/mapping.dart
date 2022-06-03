class MappingMovie {
  List<Map> crew(List crew) {
    List<Map> data = [];
    crew.map((c) => {if (c["job"] == "Director") data.add(c)}).toList();
    return data;
  }

  List<Map> cast(List cast) {
    List<Map> data = [];
    cast
        .map((c) => {if (c["known_for_department"] == "Acting") data.add(c)})
        .toList();
    return data;
  }
}
