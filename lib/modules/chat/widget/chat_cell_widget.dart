import 'package:flutter/material.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/chat/entity/chat_entity.dart';
import 'package:wzty/utils/text_style_utils.dart';

class ChatCellWidget extends StatefulWidget {
  final ChatMsgModel model;

  const ChatCellWidget({super.key, required this.model});

  @override
  State createState() => _ChatCellWidgetState();
}

class _ChatCellWidgetState extends State<ChatCellWidget> {
  @override
  Widget build(BuildContext context) {
    ChatMsgModel model = widget.model;

    Color bgColor = const Color.fromRGBO(248, 248, 248, 1.0);
    Color nameColor = const Color.fromRGBO(91, 162, 214, 1.0);
    Color contentColor = const Color.fromRGBO(153, 153, 153, 1.0);

    if (model.type == ChatMsgType.local) {
    } else if (UserManager.isSelf(model.userId.toString()) ||
        model.nobleLevel > 0 ||
        model.wealthLevel > 0) {
      bgColor = const Color.fromRGBO(250, 240, 242, 1.0);
      contentColor = const Color.fromRGBO(233, 78, 78, 1.0);
    } else {
      if (model.type == ChatMsgType.enter) {
      } else {
        contentColor = const Color.fromRGBO(34, 34, 34, 1.0);
      }
    }

    String nickNameNew = model.nameNew;
    if (UserManager.isSelf(model.userId.toString())) {
      nickNameNew = "【我】$nickNameNew";
    }
    nickNameNew = "$nickNameNew : ";

    String contentNew = model.contentNew;
    if (model.type == ChatMsgType.local) {
      contentNew = "$nickNameNew: $contentNew";
    }

    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: bgColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nickNameNew,
                style: TextStyle(
                    color: nameColor,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.medium)),
            Text(contentNew,
                style: TextStyle(
                    color: contentColor,
                    fontSize: 12,
                    fontWeight: TextStyleUtils.medium)),
          ],
        ),
      ),
    );
  }
}
