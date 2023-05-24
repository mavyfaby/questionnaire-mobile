import 'dart:async';

import 'package:get/get.dart';
import 'package:mavy_exam/utils/dialog.dart';

final _connect = GetConnect();
const host = "http://172.19.130.139:5000";

class APIServer {
  static Future<List?> fetchQuestions() async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get("$host/getquestions");

      /// If the response is successful
      if (response.statusCode == 200) {
        return response.body;
      }

      return null;
    } on TimeoutException {
      return null;
    }
  }

  static Future<bool> login(String id) async {
    try {
      /// Get the config from the server.
      Response response = await _connect.get("$host/login?password=$id");

      /// If the response is successful
      if (response.statusCode == 200) {
        return response.body != "INVALID USER";
      }

      return false;
    } on TimeoutException {
      return false;
    }
  }

  static Future<String> passAnswer(String username, int questionID, String answer) async {    try {
    print("Username: $username, QID: $questionID, ANS: $answer");

    if (answer.isEmpty) {
      return "-1";
    }

      /// Get the config from the server.
      Response response = await _connect.get("$host/passanswer?username=$username&questionno=$questionID&answer=$answer");

      /// If the response is successful
      if (response.statusCode == 200) {
        return response.body;
      }

      return "";
    } on TimeoutException {
      return "";
    }
  }
}