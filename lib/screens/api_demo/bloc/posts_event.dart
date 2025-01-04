abstract class PostsEvent {}

class PostsListGetEvent extends PostsEvent {
  int? userId;
  PostsListGetEvent({this.userId});
}

class PostsLastEvent extends PostsEvent {}
