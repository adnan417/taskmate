import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmate/screens/api_demo/bloc/posts_bloc.dart';
import 'package:taskmate/screens/api_demo/view/posts_screen.dart';
import 'package:taskmate/screens/home_screen.dart';
import 'package:taskmate/widgets/screen_transition.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
          transitionsBuilder: slideTransitionBuilder,
        );
      case "/posts":
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BlocProvider<PostsBloc>(
            create: (context) => PostsBloc(),
            child: const PostsScreen(),
          ),
          transitionsBuilder: slideTransitionBuilder,
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text('Page not found'),
              ),
            );
          },
        );
    }
  }
}
