class UserModel {
   String? email;
   String? name;
   String? phone;
   String? image;
   String? cover;
   String? bio;
   String? uid;
   bool? isEmailVerified;


   UserModel({this.uid, this.phone, this.name, this.email, this.isEmailVerified,this.image,this.bio,this.cover});

   UserModel.fromJson(Map<String,dynamic> json){
      email=json['email'];
      name=json['name'];
      phone=json['phone'];
      image=json['image'];
      cover=json['cover'];
      bio=json['bio'];
      uid=json['uid'];
      isEmailVerified=json['isEmailVerified'];

   }

   Map<String,dynamic> toMap(){
     return{
        'email':email,
        'name':name,
        'phone':phone,
        'image':image,
        'cover':cover,
        'bio':bio,
        'uid':uid,
        'isEmailVerified':isEmailVerified,
     };
   }

}