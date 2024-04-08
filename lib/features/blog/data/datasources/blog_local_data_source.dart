import 'dart:convert';

import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> getAllBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  List<BlogModel> getAllBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      final blog = box.get(i.toString());
      if (blog != null) {
        blogs.add(BlogModel.fromJson(jsonDecode(blog)));
      }
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();

    for (int i = 0; i < blogs.length; i++) {
      box.put(i.toString(), jsonEncode(blogs[i].toJson()));
    }
  }
}
