import 'package:good_app/api/HttpUtils.dart';

Future<Map> corpRegister(params) async {
  var url = "/corp/register";
  var response = await Http().post(url, data: params);
  // var res = Response.fromJson(response);
  return response;
}


Future<Map> accountLogin(params) async {
  var url = "/account/app/login";
  var response = await Http().post(url, data: params);
  // var res = Response.fromJson(response);
  return response;
}