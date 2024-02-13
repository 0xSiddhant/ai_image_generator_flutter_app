import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class HomeRepo {
  static Future<Uint8List?> fetchGeneratedImageFrom(String prompt) async {
    try {
      String url = 'https://api.vyro.ai/v1/imagine/api/generations';
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer vk-${const String.fromEnvironment("API_KEY")}'
      };

      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '34',
        'aspect_ratio': '16:9',
        'cfg': '5',
        'seed': '1',
        'high_res_results': '0'
      };

      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options =
          BaseOptions(headers: headers, responseType: ResponseType.bytes);

      final response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        Uint8List uint8List = Uint8List.fromList(response.data);
        return uint8List;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
