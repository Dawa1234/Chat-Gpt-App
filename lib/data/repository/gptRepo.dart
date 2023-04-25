import 'dart:convert';
import 'package:chatgpt/constant/httpServices.dart';
import 'package:http/http.dart' as http;
import 'package:chatgpt/constant/constants.dart';
import 'package:chatgpt/data/models/response.dart';

class GptRepository {
  Future<ResponseModel?> getResponse(String inputMessage) async {
    var requestBody = jsonEncode({
      "model": "gpt-3.5-turbo-0301",
      "messages": [
        {"role": "user", "content": inputMessage}
      ]
    });
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl),
        headers: HttpServicesConfiguration.headers(Constants.token),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // since body response is in String so decode to json
        var data = jsonDecode(response.body);
        // then convert to dart object
        var responseModel = ResponseModel.fromJson(data);
        return responseModel;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
