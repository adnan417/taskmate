import 'package:bloc/bloc.dart';
import 'package:taskmate/models/posts_response_model.dart';
import 'package:taskmate/networkmanager/api_client.dart';
import 'package:taskmate/screens/api_demo/bloc/posts_event.dart';
import 'package:taskmate/screens/api_demo/bloc/posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitialState()) {
    on<PostsEvent>((event, emit) async {
      if (event is PostsListGetEvent) {
        try {
          emit(PostsLoadingState());

          List<PostsResponseModel> postsList =
              await ApiClient().getPosts(event.userId);

          emit(PostsListingSuccessState(postsList: postsList));
        } catch (error) {
          emit(PostsErrorState(error: error.toString()));
        }
      }
    });
  }
}
