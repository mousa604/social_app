class PostModel {
  String? name;
  String? image;
  String? uid;
  String? text;
  String? dateTime;
  String? postImage;


  PostModel({this.uid, this.text, this.name, this.dateTime, this.postImage,this.image,});

  PostModel.fromJson(Map<String,dynamic> json){

    name=json['name'];
    image=json['image'];
    uid=json['uid'];
    text=json['text'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];


  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'image':image,
      'uid':uid,
      'text':text,
      'postImage':postImage,
      'dateTime':dateTime,
    };
  }

}