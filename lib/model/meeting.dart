class Meeting{
 
 int meetingID;
 String meetingDep;
 String meetingNote;
 String meetingDate;

Meeting(this.meetingDep,this.meetingNote,this.meetingDate); //verileri yazarken

Meeting.withID(this.meetingID,this.meetingDep,this.meetingNote,this.meetingDate);//verileri okurken

Map<String, dynamic> toMap(){
  var map =Map<String ,dynamic>();
  map['meetingID']= meetingID;
  map['meetingDep']= meetingDep;
  map['meetingNote']= meetingNote;
  map['meetingDate']= meetingDate;
  return map;
}
Meeting.fromMap(Map<String, dynamic> map){
  this.meetingID = map['meetingID'];
  this.meetingDep =  map['meetingDep'];
  this.meetingNote =  map['meetingNote'];
  this.meetingDate = map['meetingDate'];
}

@override
String toString(){
  return 'Meeting{meetingID: $meetingID,meetingDep: $meetingDep,meetingNote: $meetingNote,meetingDate: $meetingDate}';
}

}