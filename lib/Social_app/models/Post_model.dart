class PostModel
{
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  PostModel({
    this.name,
    this.image,
    this.uid,
    this.dateTime,
    this.text,
    this.postImage,
  });
  PostModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    dateTime=json['dateTime'];
    text=json['text'];
    uid=json['uid'];
    image=json['image'];
    postImage=json['postImage'];
  }
  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'dateTime':dateTime,
      'text':text,
      'uid':uid,
      'image':image,
      'postImage':postImage,
    };
  }
}