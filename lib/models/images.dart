class Images {
  String _image_url = "";
  String _category = "";
  String _season = "";
  String _color = "";
  int _id;

  String get image_url => _image_url;

  String get color => _color;

  String get season => _season;

  String get category => _category;

  int get id =>_id;

  Images(this._image_url, this._category, this._season, this._color);
}
