class UserPairs {
  var _pairs = [];

  List getPairs() {
    return _pairs;
  }

  void add(String pair) {
    if (!_pairs.contains(pair)) {
      _pairs.add(pair);
    }
  }
}
