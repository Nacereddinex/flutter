class reminder {
  int? id;
  String? name;
  String? type;
  String? note;
  String? dosage;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;

  reminder(
      {this.id,
      this.name,
      this.note,
      this.type,
      this.dosage,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.remind,
      this.repeat});

  reminder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    note = json['note'];
    type = json['type'];
    dosage = json['dosage'];
    date = json['date'];
    startTime = json['startTime'];

    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    data['name'] = this.name;
    data['type'] = this.type;

    data['dosage'] = this.dosage;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remind'] = this.remind;
    data['repeat'] = this.repeat;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}
