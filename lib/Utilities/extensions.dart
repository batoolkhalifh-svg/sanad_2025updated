extension SwappableList<T> on List<T> {
  void swap(int first, int second) {
    final temp = this[first];
    this[first] = this[second];
    this[second] = temp;
  }

  bool containsAll(List<T> sublist) {
    return sublist.every((element) => contains(element));
  }
}

extension ExtractObject on Map {
  void removeAllEmpty() {
    removeWhere((key, value) => (value == null || (value is List && value.isEmpty) || (value is String && value.isEmpty)));
  }

  Map<String, dynamic> extractJsonFromObject() {
    Map<String, dynamic> body = {};
    forEach((key, value) {
      if (value != null &&
          ([int, double, String, bool, Map, List<int>, List<double>, List<String>, List<bool>, List<Map>].contains(value.runtimeType))) {
        body[key] = value;
      } else if (value is List) {
        body[key] = value.map((e) => (e.toJson() as Map).extractJsonFromObject()).toList();
      } else if (value != null) {
        body[key] = value.toJson();
      }
    });
    return body;
  }

  Map<String, String> dynamicMapToString() {
    Map<String, String> body = {};
    forEach((key, value) {
      if (value is List) {
        body.addAll(_mapListValueHandler(key, value));
      } else if (value is Map) {
        body.addAll(value.dynamicMapToString());
      } else if (value != null) {
        body[key] = value.toString();
      }
    });
    return body;
  }

  Map<String, String> _mapListValueHandler(String key, List iterator) {
    Map<String, String> result = {};
    for (var item in iterator) {
      result["$key[${iterator.indexOf(item)}]"] = item.toString();
    }
    return result;
  }
}

extension DateTimeExtensions on DateTime {
  bool isInTheSameDay(DateTime date) {
    if (year != date.year) return false;
    if (month != date.month) return false;
    if (day != date.day) return false;
    return true;
  }

  static DateTime? tryParseDmy(String ymd) {
    if (ymd.split("/").length != 3) return null;
    try {
      return DateTime(int.parse(ymd.split('/')[2]), int.parse(ymd.split('/')[1]), int.parse(ymd.split('/')[0]));
    } catch (e) {
      return null;
    }
  }
}
