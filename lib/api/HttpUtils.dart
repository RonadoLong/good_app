import 'package:dio/dio.dart';
import 'package:good_app/utils/SpUtil.dart';
const bool inProduction = const bool.fromEnvironment("dart.vm.product");
const PROHOST = "http://www.mateforce.cn";
const DEVHOST = "http://www.mateforce.cn";
String host = inProduction ? PROHOST : PROHOST;

class Http {
  static Http instance;
  static String token;
  static Dio _dio;
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  BaseOptions _options;

  // ignore: missing_return
  static Future<Http> getInstance() async {
    print("getInstance");
    if (instance == null) {
      instance = new Http();
    }
  }

  Http() {
    _options = new BaseOptions(
      baseUrl: "$host/",
      connectTimeout: 10000,
      receiveTimeout: 3000,
      headers: {},
    );

    _dio = new Dio(_options);

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      var user = SpUtil.getObject("userInfo");
      print(user);
      if (user != null) {
        options.headers["kp-token"] = user["token"];
      }
      return options;
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理
      // print("InterceptorsWrapper ===== $response.data ");
      return response; // continue
    }, onError: (DioError e) {
      print("InterceptorsWrapper ====== err $e");
      return e;
    }));
  }

  // get 请求封装
  get(url, {options, cancelToken, data}) async {
    print('get::: url：$url');
    Response response;
    try {
      response = await _dio.get(url, queryParameters: data, cancelToken: cancelToken);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    if (response != null){
      return response.data == null ? response : response.data;
    }
     if (response.statusCode != 200) {
          response.data = {"code": 200, "data":[], "msg": "网络出错"}; 
      }
  }

  // post请求封装
  post(url, {options, cancelToken, data}) async {
    print('post请求::: url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.post(url,
          data: data != null ? data : {}, cancelToken: cancelToken);
      print(response);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      } else {
        print('post请求发生错误：$e');
      }
    }
    return response.data;
  }

  // post请求封装
  put(url, {options, cancelToken, data}) async {
    print('put请求::: url：$url ,body: $data');
    Response response;
    try {
      response = await _dio.put(url,
          data: data != null ? data : {}, cancelToken: cancelToken);
      print(response);
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('put请求取消! ' + e.message);
      } else {
        print('put请求发生错误：$e');
      }
    }
    return response.data;
  }
}
