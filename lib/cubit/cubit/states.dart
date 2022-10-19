abstract class SocialStats{}
class SocialInitialStats extends SocialStats{}
class SocialGetUserLoadingStats extends SocialStats{}
class SocialGetUserSuccessStats extends SocialStats{}
class SocialGetUserErrorStats extends SocialStats{
  final String error;
  SocialGetUserErrorStats(this.error);

}


class SocialGetAllUsersLoadingStats extends SocialStats{}
class SocialGetAllUsersSuccessStats extends SocialStats{}
class SocialGetAllUsersErrorStats extends SocialStats{
  final String error;
  SocialGetAllUsersErrorStats(this.error);

}

class SocialGetPostsLoadingStats extends SocialStats{}
class SocialGetPostsSuccessStats extends SocialStats{}
class SocialGetPostsErrorStats extends SocialStats{
  final String error;
  SocialGetPostsErrorStats(this.error);

}

class SocialLikePostSuccessStats extends SocialStats{}
class SocialLikePostErrorStats extends SocialStats{
  final String error;
  SocialLikePostErrorStats(this.error);

}

class BottomNavBarState extends SocialStats{}
class NewPostState extends SocialStats{}
class SocialProfileImagePickedSuccessState extends SocialStats{}
class SocialProfileImagePickedErrorState extends SocialStats{}
class SocialCoverImagePickedSuccessState extends SocialStats{}
class SocialCoverImagePickedErrorState extends SocialStats{}
class UpLodeProfileImageSuccessState extends SocialStats{}
class UpLodeProfileImageErrorState extends SocialStats{}
class UpLodeCoverImageSuccessState extends SocialStats{}
class UpLodeCoverImageErrorState extends SocialStats{}
class UserUpDateErrorState extends SocialStats{}
class UserUpDateLoadingState extends SocialStats{}



class CreatePostLoadingState extends SocialStats{}
class CreatePostSuccessState extends SocialStats{}
class CreatePostErrorState extends SocialStats{}
class SocialPostImagePickedSuccessState extends SocialStats{}
class SocialPostImagePickedErrorState extends SocialStats{}
class RemovePostImageState extends SocialStats{}


class SocialSendMassageSuccessStats extends SocialStats{}
class SocialSendMassageErrorStats extends SocialStats{
  final String error;
  SocialSendMassageErrorStats(this.error);

}


class SocialGetMassageSuccessStats extends SocialStats{}
class SocialGetMassageErrorStats extends SocialStats{
  final String error;
  SocialGetMassageErrorStats(this.error);

}



class GetPostsLoadingState extends SocialStats{}
class GetPostsSuccessStats extends SocialStats{}
class GetPostsErrorStats extends SocialStats{
  final String error;
  GetPostsErrorStats(this.error);

}


