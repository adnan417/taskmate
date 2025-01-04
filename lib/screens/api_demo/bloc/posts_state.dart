import 'package:taskmate/models/posts_response_model.dart';

abstract class PostsState {}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsListingSuccessState extends PostsState {
  List<PostsResponseModel> postsList;
  PostsListingSuccessState({required this.postsList});
}

class PostsErrorState extends PostsState {
  String? error = "";
  PostsErrorState({this.error});
}

class PostsLastState extends PostsState {}
