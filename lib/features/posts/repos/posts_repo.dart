import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter_api/features/posts/models/post_data_ui_model.dart';

var client = http.Client();

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPost() async {
    // var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModel post =
            PostDataUiModel.fromjson(result[i] as Map<String, dynamic>);

        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString() as num);
      return [];
    }
  }

  static Future<bool> addPost() async {
    // var client = http.Client();
    try {
      var response = await client.post(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {"title": "MEACH", "body": "SKJHFSKHD", "userId": "69"});

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // log(e.toString() as num);
      print(e.toString());
      return false;
    }
  }
}
