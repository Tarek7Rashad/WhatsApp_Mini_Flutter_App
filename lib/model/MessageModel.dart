import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/shared/constant.dart';

class MessageModel {
  final String message;
  final String id;
  final Timestamp time;
  MessageModel({required this.message, required this.id, required this.time});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
        message: jsonData[kMessage], id: jsonData[kId2], time: jsonData[kAt2]);
  }
}
