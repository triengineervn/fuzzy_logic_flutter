import 'dart:convert';

import 'package:flutter_fuzzy/models/data_model.dart';
import 'package:http/http.dart' as http;

List<Data> listData = [];

Future<List<Data>> getData() async {
  final response = await http.get(Uri.parse(
      'https://script.google.com/macros/s/AKfycbyz3JE5FLwwcj0o2OMymEx5RAWoaehj4gi5OrQsOdKvHDwjVpBwwtHHT4o_vswPYDGt6g/exec'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map<String, dynamic> index in data) {
      listData.add(Data.fromJson(index));
    }
    return listData;
  } else {
    return listData;
  }
}
