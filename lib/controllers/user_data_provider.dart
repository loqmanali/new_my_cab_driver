import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  int _id;
  String _name,
      _phone,
      _token,
      _gender,
      _imageUrl,
      _imgUrlId,
      _imgUrlCar,
      _brand,
      _type,
      _color,
      _number;

  get imgUrlId => _imgUrlId;
  bool _inside, _activeNow, _wasActive, _activeStatusPicked;

  void initialData(Map<String, dynamic> data) {
    print("Data in SharedPreference : $data");
    this._id = data['id'];
    this._name = data['name'];
    this._phone = data['phone'];
    this._token = data['token'];
    this._gender = data['gender'];
    this._imageUrl = data['img_url'];
    this.setCarImages(data);
    this.insertCartData(data);
    notifyListeners();
  }

  void insertCartData(Map<String, dynamic> data) {
    print("insertCartData : $data");
    this._brand = data["brand"];
    this._type = data["type"];
    this._color = data["color"];
    this._number = data["number"];

    notifyListeners();
  }

  void setCarImages(Map<String, dynamic> data) {
    print("setCarImages : $data");
    this._imgUrlId = data["img_url_id"];
    this._imgUrlCar = data["img_url_car"];

    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return Map<String, dynamic>.from({
      "id": this._id,
      "name": this._name,
      "phone": this._phone,
      "token": this._token,
      "gender": "${this._gender}",
      'img_url': this._imageUrl,
      "brand": this._brand,
      "type": this._type,
      "color": this._color,
      "number": this._number,
      "img_url_id": this._imgUrlId,
      "img_url_car": this._imgUrlId,
    });
  }

  String get imageUrl => this._imageUrl;

  set imageUrl(String image) {
    this._imageUrl = image;
    notifyListeners();
  }

  bool get activeStatusPicked => this._activeStatusPicked ?? false;

  set activeStatusPicked(bool activeStatusPicked) {
    this._activeStatusPicked = activeStatusPicked;
    notifyListeners();
  }

  bool get wasActive => this._wasActive ?? false;

  set wasActive(bool wasActive) {
    this._wasActive = wasActive;
    notifyListeners();
  }

  bool get inSide => this._inside ?? false;

  set inSide(bool inSide) {
    this._inside = inSide;
    notifyListeners();
  }

  bool get activeNow => this._activeNow ?? false;

  set activeNow(bool activeNow) {
    this._activeNow = activeNow;
    notifyListeners();
  }

  int get id => this._id;

  String get name => this._name;

  String get token => this._token;

  String get gender => this._gender;

  String get nativeGender {
    if (this._gender == "m")
      return "Male";
    else
      return "Female";
  }

  String get phone => this._phone;

  String get imgUrlCar => this._imgUrlCar;

  String get brand => this._brand;

  String get type => this._type;

  String get color => this._color;

  String get number => this._number;

  bool get inside => this._inside;
}
