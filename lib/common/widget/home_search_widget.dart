import 'package:flutter/material.dart';
import 'package:wzty/utils/jh_image_utils.dart';

enum HomeSearchType { live, match }

class HomeSearchWidget extends StatefulWidget {
  final HomeSearchType type;

  final VoidCallback searchTap;

  final VoidCallback? rightTap;

  const HomeSearchWidget(
      {super.key, required this.type, required this.searchTap, this.rightTap});

  @override
  State createState() => _HomeSearchWidgetState();
}

class _HomeSearchWidgetState extends State<HomeSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: widget.searchTap,
            child: Container(
              width: 108,
              height: 32,
              margin: const EdgeInsets.only(top: 4, bottom: 4, left: 12),
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: const Row(
                children: [
                  JhAssetImage("common/iconNavSousuo", width: 20),
                  Text("搜索",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.normal))
                ],
              ),
            )),
        InkWell(
            onTap: widget.rightTap,
            child: const Padding(
              padding: EdgeInsets.only(right: 22, left: 22),
              child: JhAssetImage("match/iconSaixuan", width: 24),
            )),
      ],
    );
  }
}
