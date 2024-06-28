part of 'post_bloc.dart';

@immutable
sealed class PostState {}

sealed class PostActionState extends PostState {}

class PostInitial extends PostState {}

class PostFetchingSuccessfulState extends PostState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessfulState({required this.posts});
}

class PostFetchingLoadingState extends PostState {}

class PostFetchingErrorState extends PostState {}

class PostAdditionSuccessState extends PostActionState {}

class PostAdditionErrorState extends PostActionState {}
