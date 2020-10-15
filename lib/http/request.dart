import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:template/utils/path_provider_utils.dart';

class DioHttp {
  DioHttp._internal();

  /// 定义请求基本参数
  static final Dio dio = Dio(BaseOptions(
    baseUrl: "", // 后端请求接口地址
    connectTimeout: 5000, // 接口请求超时时间
    receiveTimeout: 3000, // 响应流上前后两次接受到数据的间隔,单位为毫秒
  ));

  /// 初始化
  static init() {
    /// 初始化Cookie
    PathProviderUtils.getDocumentsDirPath().then((value) {
      var cookieJar = PersistCookieJar(dir: value + "/.cookies/");
      dio.interceptors.add(CookieManager(cookieJar));
    });

    /// 添加dio拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions requestOptions) {
      requestOptions.headers.addAll({ // 添加一些头部信息用于接口验签/公共参数
        'X-Token': '',
        'User-Token': '',
        'language': ''
      });
      return requestOptions;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError dioError) {
      handleError(dioError);
      return dioError;
    }));
  }

  /// get请求
  static Future get(String url, [Map<String, dynamic> params]) async {
    Response response;
    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  /// post 表单请求
  static Future post(String url, [Map<String, dynamic> params]) async {
    Response response = await dio.post(url, queryParameters: params);
    return response.data;
  }

  /// 上传头像请求 传入一个FormData对象
  static Future postFile(String url, FormData data) async {
    Response response = await dio.post<String>(url, data: data);
    return response.data;
  }

  /// 错误统一处理
  static void handleError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        print(">>>>>>>>>>>>>> 连接超时");
        break;
      case DioErrorType.SEND_TIMEOUT:
        print(">>>>>>>>>>>>>> 请求超时");
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        print(">>>>>>>>>>>>>> 响应超时");
        break;
      case DioErrorType.RESPONSE:
        print(">>>>>>>>>>>>>> 出现异常");
        break;
      case DioErrorType.CANCEL:
        print(">>>>>>>>>>>>>> 请求取消");
        break;
      default:
        print(">>>>>>>>>>>>>> 未知错误");
        break;
    }
  }
}
