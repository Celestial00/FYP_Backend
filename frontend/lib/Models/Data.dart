class Data {
  static final Data _instance = Data._internal();

  factory Data() {
    return _instance;
  }

  Data._internal();

  var FavList = [];
  var CartList = [];

  List getData() {
    return FavList;
  }

  void setData({required String Name}) {
    FavList.add(Name);
  }

  void removeData({required String Name}) {
    FavList.remove(Name);
  }

  List getCartData() {
    return CartList;
  }

  void setCartData({required String Name}) {
    CartList.add(Name);
  }

  void removeCartData({required String Name}) {
    CartList.remove(Name);
  }
}
