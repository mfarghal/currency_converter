import 'dart:io';

class NetworkConstants {
  static const baseURL = "https://free.currconv.com";

  static const Map<String, String> headers = {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
  };
}
