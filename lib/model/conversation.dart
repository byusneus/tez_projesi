class Conversation {
  int conversationID;
  String conversationUser;
  String conversationNote;
  String conversationDate;

  Conversation(this.conversationUser, this.conversationNote, this.conversationDate);

  Conversation.withID(this.conversationID, this.conversationUser, this.conversationNote,
      this.conversationDate);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['conversationID'] = conversationID;
    map['conversationUser'] = conversationUser;
    map['conversationNote'] = conversationNote;
     map['conversationDate'] = conversationDate;

    return map;
  }
  Conversation.fromMap(Map<String, dynamic> map){
    this.conversationID = map['conversationID'];
    this.conversationUser = map['conversationUser'];
    this.conversationNote = map['conversationNote'];
    this.conversationDate = map['conversationDate'];

  }
  @override
  String toString(){
    return 'Conversation{conversationID: $conversationID,conversationUser: $conversationUser,conversationNote: $conversationNote, conversationDate: $conversationDate}';
  }
}
