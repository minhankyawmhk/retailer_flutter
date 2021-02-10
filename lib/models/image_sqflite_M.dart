class Photo {
  int _id;
  String _photo;
  String _shopSysKey;
  String _activeTaskCode;
  String _remark;

  Photo(this._photo, this._shopSysKey, this._activeTaskCode,this._remark);

  Photo.withId(this._id, this._photo, this._shopSysKey, this._activeTaskCode,this._remark);

  int get id => _id;

  String get photo => _photo;

  String get shopSysKey => _shopSysKey;

  String get testCode => _activeTaskCode;

  String get remark => _remark;

  set getPhoto(String newPhoto) {
    this._photo = newPhoto;
  }

  set getTestCode(String newTestCode) {
    this._activeTaskCode = newTestCode;
  }

  set getshopSysKey(String newshopSysKey) {
    this._shopSysKey = newshopSysKey;
  }

  set getremark(String newremark){
    this._remark = newremark;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['photo'] = _photo;
    map['shopSysKey'] = _shopSysKey;
    map['activeTaskCode'] = _activeTaskCode;
    map['remark'] = _remark;
    return map;
  }

  Photo.formMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._photo = map['photo'];
    this._shopSysKey = map['shopSysKey'];
    this._activeTaskCode = map['activeTaskCode'];
    this._remark = map['remark'];
  }
}
