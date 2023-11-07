import 'package:flutter/material.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchMenuWidget extends StatefulWidget {
  final bool selectAll;
  final WZAnyCallback<bool> callback;

  const MatchMenuWidget(
      {super.key, required this.selectAll, required this.callback});

  @override
  State createState() => _MatchMenuWidgetState();
}

class _MatchMenuWidgetState extends State<MatchMenuWidget> {
  int _selectIdx = 0;
  bool _showAll = false;

  @override
  void initState() {
    super.initState();
    _selectIdx = widget.selectAll ? 1 : 0;
  }

  _handleItemClick(String title) {
    if (_showAll) {
      if (title == "热门") {
        _selectIdx = 0;
        widget.callback(false);
      } else {
        _selectIdx = 1;
        widget.callback(true);
      }
    }
    _showAll = !_showAll;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_showAll) {
      return _showAllUI();
    } else {
      return _showOneUI();
    }
  }

  _showAllUI() {
    return Container(
        width: 44, // 52
        height: 88, // 90
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(255, 212, 212, 1),
                Color.fromRGBO(255, 212, 212, 0.8)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(width: 1.0, color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(26))),
        child: _showAll
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _selectIdx == 0 ? _buildSelectItem("热门") : _buildItem("热门"),
                  _selectIdx == 1 ? _buildSelectItem("全部") : _buildItem("全部")
                ],
              )
            : Column(
                children: [_buildSelectItem(_selectIdx == 0 ? "热门" : "全部")]));
  }

  _showOneUI() {
    return Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 44),
        child: _buildSelectItem(_selectIdx == 0 ? "热门" : "全部"));
  }

  _buildItem(String title) {
    return InkWell(
      onTap: () {
        _handleItemClick(title);
      },
      child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: TextStyleUtils.medium),
          )),
    );
  }

  _buildSelectItem(String title) {
    return InkWell(
      onTap: () {
        _handleItemClick(title);
      },
      child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ColorUtils.red233,
              border: Border.all(width: 1.0, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: TextStyleUtils.medium),
          )),
    );
  }
}
