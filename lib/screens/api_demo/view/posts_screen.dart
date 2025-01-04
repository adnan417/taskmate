import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmate/models/posts_response_model.dart';
import 'package:taskmate/screens/api_demo/bloc/posts_bloc.dart';
import 'package:taskmate/screens/api_demo/bloc/posts_event.dart';
import 'package:taskmate/screens/api_demo/bloc/posts_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskmate/widgets/custom_widgets.dart';

//Used Bloc to separate business logic and data

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  void searchPosts(
      BuildContext context, TextEditingController searchController) {
    final postsBloc = context.read<PostsBloc>();
    int? userId = int.tryParse(searchController.text.trim());
    postsBloc.add(PostsListGetEvent(userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            _widgetSearchBox(context, searchController),
            const SizedBox(height: 16),
            _widgetPostsBody(context),
          ],
        ),
      ),
    );
  }

  Widget _widgetSearchBox(
      BuildContext context, TextEditingController searchController) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.withOpacity(0.4)
                : Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextField(
        controller: searchController,
        hintText: 'Search by User ID',
        textInputType: TextInputType.number,
        suffixIcon: GestureDetector(
          onTap: () => searchPosts(context, searchController),
          child: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onChanged: (value) => searchPosts(context, searchController),
        onSubmitted: (value) => searchPosts(context, searchController),
      ),
    );
  }

  Widget _widgetPostsBody(BuildContext context) {
    return Expanded(
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          print("Current state is $state");

          if (state is PostsInitialState) {
            context.read<PostsBloc>().add(PostsListGetEvent());
          } else if (state is PostsLoadingState) {
            return Skeletonizer(
              enabled: true,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _listItem(
                    context,
                    PostsResponseModel(
                      userId: null,
                      id: null,
                      title: null,
                      body: null,
                    ),
                  );
                },
              ),
            );
          } else if (state is PostsListingSuccessState) {
            final posts = state.postsList;

            return ListView.separated(
              itemBuilder: (context, index) => _listItem(context, posts[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: posts.length,
            );
          } else if (state is PostsErrorState) {
            return Expanded(child: Center(child: Text(state.error.toString())));
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _listItem(BuildContext context, PostsResponseModel post) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title ?? "No Title",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              post.body ?? "No Content",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("User ID: ${post.userId ?? "N/A"}",
                    style: Theme.of(context).textTheme.labelSmall),
                Text("Post ID: ${post.id ?? "N/A"}",
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
