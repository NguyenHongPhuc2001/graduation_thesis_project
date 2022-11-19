import 'package:graduation_thesis_project/models/base/base_model.dart';

class Token extends BaseModel {

  String token;

  Token({
    required this.token
  });

  Token.fromJson(Map<String, dynamic> data) : token = data['token'];

  Map<String, dynamic> toJson () => {
      'token' : token
  };

}