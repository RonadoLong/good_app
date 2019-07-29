// POST /customer/search/list

import 'package:good_app/api/HttpUtils.dart';

Future<Map> GetCustomerList(params) async {
  var url = "/customer/search/list";
  var response = await Http().post(url, data: params);
  // var res = Response.fromJson(response);
  return response;
}
