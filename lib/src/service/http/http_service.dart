import 'dart:async';
import 'package:dio/dio.dart';

abstract class IHttpService<T> {
  Future<Response<T>> get(
    String path, {
    Options? options,
  });

  Future<Response<T>> post(
    String path,
    dynamic data, {
    ProgressCallback? onSendProgress,
  });

  Future<Response<T>> put(
    String path,
    dynamic data,
  );

  Future<Response<T>> patch(
    String path,
    dynamic data,
  );

  Future<Response<T>> delete(
    String path,
    dynamic data,
  );

  Future<Response<T>> fetch(
    RequestOptions requestOptions,
  );
}

class HttpService extends IHttpService {
  final Dio dio;

  HttpService(this.dio);

  @override
  Future<Response> get(
    String path, {
    Options? options,
  }) async {
    return await dio.get(
      path,
      options: options,
    );
  }

  @override
  Future<Response> post(
    String path,
    data, {
    ProgressCallback? onSendProgress,
  }) async {
    return await dio.post(
      path,
      data: data,
      onSendProgress: onSendProgress,
    );
  }

  @override
  Future<Response> put(
    String path,
    data,
  ) async {
    return await dio.put(
      path,
      data: data,
    );
  }

  @override
  Future<Response> patch(
    String path,
    data,
  ) async {
    return await dio.patch(
      path,
      data: data,
    );
  }

  @override
  Future<Response> delete(
    String path,
    data,
  ) async {
    return await dio.delete(
      path,
      data: data,
    );
  }

  @override
  Future<Response> fetch(RequestOptions requestOptions) async {
    return await dio.fetch(requestOptions);
  }
}
