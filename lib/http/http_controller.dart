import 'package:http/http.dart' as http;

class HttpController {
  static void get(String url, Function callback, {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value){
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length -1);
      url += paramStr;
    }
    try {
      http.Response res = await http.get(url);
      if (callback != null && res.statusCode == 200) {
        callback(res.body);
      } else if (errorCallback != null) {
        errorCallback(res.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }
}