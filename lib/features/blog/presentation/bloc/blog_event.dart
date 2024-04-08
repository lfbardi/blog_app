part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String title;
  final String content;
  final String posterId;
  final List<String> topics;
  final File image;

  BlogUploadEvent({
    required this.title,
    required this.content,
    required this.posterId,
    required this.topics,
    required this.image,
  });
}

final class GetAllBlogsEvent extends BlogEvent {}
