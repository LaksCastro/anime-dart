import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class Utils {
  static int randomInt(int min, int max) {
    final random = Random();

    return random.nextInt(max - min) + min;
  }

  static double randomDouble(double min, double max) {
    final random = Random();

    return ((max - min) * random.nextDouble()) + min;
  }

  static double Function(double xA) interpolate(
      {List<double> xInterval, List<double> yInterval}) {
    double x0 = xInterval[0];
    double x1 = xInterval[1];

    double y0 = yInterval[0];
    double y1 = yInterval[1];

    double getValueOfInterpolatioAt(double xA) {
      if (xA > x1) {
        xA = x1;
      } else if (xA < x0) {
        xA = x0;
      }

      double yA = y0 + (y1 - y0) * ((xA - x0) / (x1 - x0));

      return yA;
    }

    return getValueOfInterpolatioAt;
  }

  static Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  static const simpleHttpHeaders = <String, String>{
    "User-Agent":
        "Mozilla/5.0 (Linux; Android 5.1.1; SM-G928X Build/LMY47X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.83 Mobile Safari/537.36",
    "accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
  };

  static const completeHttpHeaders = <String, String>{
    ...simpleHttpHeaders,
    "X-Auth":
        "VnM4ejB1dElLajZDZDhiSU02aGF0RmdDQWxXNDl3SEQzWjE2Ulg1K3ZOWjZkbjJXZjBqT2xnT0FVdnVwd2VjTE4rbmM2WnoxSTRLZmUyRGlBc1FCd0MrbzJiamNGajRLMitjSFhnOEU5YnVRbDZGbitzelBwb2UyTmFHYXZXSTNmK09MdVNTMG91bEhrZEZnb29SQ082SmVXM2Y2ZlNwQWVFeTRaSXpORjhFTzBpaTgxL2pUNkVDVGh1M0ZqZUZxWElZTGt1dGpOSmhNMC9WK3JEWjFBdkk2b2ZmK0Rkc1IybkJYWHUwa2hTTnlzZ0lDb3RqbklGTEpFcnB0azVBYmZ6MkRuUHpzdzNrZ0NaR1VyYkVxMEExTTVUTU9qcTg4T2xTNkJueWVlcG1ic1cvZ3V4Y1pwUlllU1RPNE50OEZCczJZWmlQd3VVODQzL1Z0a2dxR0p3PT0=",
    "X-Requested-With": "br.com.meuanimetv",
  };

  static Dio dio = (() {
    final dio = Dio();

    // NOTE: uncomment this lines if proxy is needed to fetch API Data
    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 45.33.32.179:3128";
    //   };
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    // };

    dio.options.headers = completeHttpHeaders;

    return dio;
  })();
}
