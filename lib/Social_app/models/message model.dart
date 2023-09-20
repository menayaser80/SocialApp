class MessageModel
{
  String? senderID;
  String? recieverID;
  String? dateTime;
  String? text;
  MessageModel({
    this.senderID,
    this.recieverID,
    this.dateTime,
    this.text,
  });
  MessageModel.fromJson(Map<String,dynamic>json)
  {
    senderID=json['senderID'];
    recieverID=json['recieverID'];
    dateTime=json['dateTime'];
    text=json['text'];
  }
  Map<String,dynamic>toMap()
  {
    return {
      'senderID':senderID,
      'recieverID':recieverID,
      'dateTime':dateTime,
      'text':text,
    };
  }
}