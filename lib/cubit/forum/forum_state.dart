part of 'forum_cubit.dart';

@immutable
abstract class ForumState {}

class ForumInitial extends ForumState {}

class ChangeTabBarItem extends ForumState {}

class ForumGetAllForumsLoadingState extends ForumState {}
class ForumGetAllForumsSuccessState extends ForumState {}
class ForumGetAllForumsErrorState extends ForumState {}

class ForumGetMyForumsLoadingState extends ForumState {}
class ForumGetMyForumsSuccessState extends ForumState {}
class ForumGetMyForumsErrorState extends ForumState {}

class ForumCreatePostLoadingState extends ForumState {}
class ForumCreatePostSuccessState extends ForumState {}
class ForumCreatePostErrorState extends ForumState {}

class ForumPickImageState extends ForumState {}

class ForumLikeLoadingState extends ForumState {}
class ForumLikeSuccessState extends ForumState {}
class ForumLikeErrorState extends ForumState {}

class CommentOnForumLoadingState extends ForumState {}
class CommentOnForumSuccessfulState extends ForumState {}
class CommentOnForumErrorState extends ForumState {}