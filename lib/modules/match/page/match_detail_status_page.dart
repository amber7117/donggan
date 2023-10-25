import 'package:flutter/material.dart';
import 'package:wzty/common/webview/wz_webview_page.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/modules/match/entity/detail/match_detail_entity.dart';
import 'package:wzty/modules/match/widget/detail/match_status_data_widget.dart';

class MatchDetailStatusPage extends StatefulWidget {
  final int matchId;

  final MatchDetailModel detailModel;

  const MatchDetailStatusPage({super.key, required this.matchId, required this.detailModel});

  @override
  State createState() => _MatchDetailStatusPageState();
}

class _MatchDetailStatusPageState
    extends KeepAliveWidgetState<MatchDetailStatusPage> {
  @override
  Widget buildWidget(BuildContext context) {
    MatchDetailModel model = widget.detailModel;
    return Expanded(
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            width: double.infinity,
            height: 110,
            child: WZWebviewPage(urlStr: model.trendAnim),
          ),
          MatchStatusDataWidget(),
          Container(height: 200,)
        ],
      ),
    );
  }
}
