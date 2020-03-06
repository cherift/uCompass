class Token{

  String _id_token;

  Token(this._id_token);

  String get id_token => _id_token;

  set id_token(String value) {
    _id_token = value;
  }

  factory Token.fromJson(Map<String,dynamic> json){
    return Token(json["id_token"]);
  }


}