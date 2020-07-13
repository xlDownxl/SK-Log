class UserPairs {
  var _pairs = {};

  Map getPairs() {
    return _pairs;
  }

  void add(String pair) {
      _pairs[pair]=1;
  }
}
