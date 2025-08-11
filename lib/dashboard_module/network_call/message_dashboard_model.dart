class MessageDahsboardModel {
  dynamic description;
  dynamic timestamp;
  dynamic cameranum;
  dynamic store;

  MessageDahsboardModel({
    this.description,
    this.timestamp,
    this.cameranum,
    this.store,
  });

  MessageDahsboardModel.fromJson(Map<String, dynamic> json) {
    description = json['Description'];
    timestamp = json['Timestamp'];
    cameranum = json['cameranum'];
    store = json['store'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Description'] = this.description;
    data['Timestamp'] = this.timestamp;
    data['cameranum'] = this.cameranum;
    data['store'] = this.store;
    return data;
  }
}
