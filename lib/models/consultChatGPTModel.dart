// ignore_for_file: file_names

class ConsultChatGPTModel {
  late final int chatGPTId;
  late final String diseaseName;
  late final String description;
  late bool selected;

  set setSelected(bool value) {
    selected = value;
  }

  ConsultChatGPTModel({
    required this.chatGPTId,
    required this.diseaseName,
    required this.description,
    required this.selected,
  });

  factory ConsultChatGPTModel.fromJson(Map<String, dynamic> json) {
    return ConsultChatGPTModel(
      chatGPTId: json['chatGPTId'],
      diseaseName: json['diseaseName'],
      description: json['description'],
      selected: json['selected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatGPTId': chatGPTId,
      'diseaseName': diseaseName,
      'description': description,
      'selected': selected,
    };
  }
}
