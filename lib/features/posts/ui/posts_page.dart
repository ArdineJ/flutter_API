import 'package:flutter/material.dart';
import 'package:flutter_api/features/posts/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final PostBloc postsBloc = PostBloc();

  @override
  void initState() {
    super.initState();
    postsBloc.add(PostInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts Pages'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            postsBloc.add(PostAddEvent());
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<PostBloc, PostState>(
          bloc: postsBloc,
          listenWhen: ((previous, current) => current is PostActionState),
          buildWhen: ((previous, current) => current is! PostActionState),
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostFetchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case PostFetchingSuccessfulState:
                final successState = state as PostFetchingSuccessfulState;
                return ListView.builder(
                  itemBuilder: ((context, index) {
                    return Container(
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.posts[index].title),
                          Text(successState.posts[index].body),
                        ],
                      ),
                    );
                  }),
                );
              default:
                return const SizedBox(
                  child: Center(child: Text('Not Found')),
                );
            }
          },
        ));
  }
}
