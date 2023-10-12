import 'package:flutter/material.dart';
import 'package:wzty/modules/chat/entity/chat_entity.dart';
import 'package:wzty/modules/chat/widget/chat_cell_widget.dart';



class ChatPage extends StatefulWidget {
  final String roomId;
  final String chatRoomId;
  final bool isMatch;

  const ChatPage({
    super.key,
    required this.roomId,
    required this.chatRoomId,
    this.isMatch = false,
  });

  @override
  State createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  double _msgStartTime = 0;
  int _msgCnt = 0;

  double _alreadyJoinRoom = 0;

  List<ChatMsgModel> _msgList = [];

  // ChatUserInfo? chatInfoSelf = 0;
  bool forbidChat = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 3),
        itemCount: _msgList.length,
        itemBuilder: (context, index) {
          return ChatCellWidget(model: _msgList[index]);
        });
  }
}
