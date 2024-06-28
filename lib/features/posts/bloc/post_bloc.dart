// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_api/features/posts/models/post_data_ui_model.dart';
import 'package:flutter_api/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostFetchingLoadingState());

    List<PostDataUiModel> posts = await PostsRepo.fetchPost();

    emit(PostFetchingSuccessfulState(posts: posts));

    // emit(PostFetchingErrorState());
  }

  Future<FutureOr<void>> postAddEvent(
      PostAddEvent event, Emitter<PostState> emit) async {
    bool success = await PostsRepo.addPost();
    print(success);
    if (success) {
      emit(PostAdditionSuccessState());
    } else {
      emit(PostAdditionErrorState());
    }
  }
}
