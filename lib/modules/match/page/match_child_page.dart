import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/main/lib/base_widget_state.dart';
import 'package:wzty/main/lib/load_state_widget.dart';
import 'package:wzty/main/user/user_manager.dart';
import 'package:wzty/modules/match/entity/match_info_entity.dart';
import 'package:wzty/modules/match/service/match_service.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/toast_utils.dart';
import 'package:wzty/utils/wz_date_utils.dart';
import 'package:wzty/utils/jh_image_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchChildPage extends StatefulWidget {
  final SportType sportType;
  final MatchStatus matchStatus;

  const MatchChildPage(
      {super.key, required this.sportType, required this.matchStatus});

  @override
  State<StatefulWidget> createState() {
    return _MatchChildPageState();
  }
}

class _MatchChildPageState extends BaseWidgetState<MatchChildPage> {
  LoadStatusType _layoutState = LoadStatusType.loading;
  List<MatchInfoModel> _dataArr = [];

  int selectIdx = 0;
  List<String> dateStrArr = [];

  @override
  void initState() {
    super.initState();

    _createData();
    _requestData(loading: true);
  }

  _createData() {
    DateTime nowDate = DateTime.now();
    String nowDateStr = DateFormat('yyyy-MM-dd').format(nowDate);

    if (widget.matchStatus == MatchStatus.finished ||
        widget.matchStatus == MatchStatus.uncoming) {
      List<String> titleArr = [];

      if (widget.matchStatus == MatchStatus.uncoming) {
        titleArr.add('今天');
        dateStrArr.add(nowDateStr);
      }

      DateTime tmpDate;
      String tmpDateStr;
      String tmpWeekStr;

      for (int idx = 1; idx < 7; idx++) {
        if (widget.matchStatus == MatchStatus.uncoming) {
          tmpDate = nowDate.add(Duration(days: idx));
        } else {
          tmpDate = nowDate.add(Duration(days: idx - 7));
        }

        tmpDateStr = DateFormat('yyyy-MM-dd').format(tmpDate);

        dateStrArr.add(tmpDateStr);

        String weekDesc = WZDateUtils.getWeekDay(tmpDate);
        tmpWeekStr = '${tmpDateStr.substring(5)}\n$weekDesc';
        titleArr.add(tmpWeekStr);
      }

      selectIdx = 0;

      if (widget.matchStatus == MatchStatus.finished) {
        titleArr.add('今天');
        dateStrArr.add(nowDateStr);

        selectIdx = titleArr.length - 1;
      }

      // headerView.selectIdx = selectIdx;
      // headerView.dateArr = titleArr;
    } else {
      dateStrArr.add(nowDateStr);
      selectIdx = 0;
    }
  }

  _requestData({bool loading = false, String calendarDate = ''}) async {
    // if (!domainOk()) {
    //   return;
    // }

    String userId = await UserManager.instance.obtainUseridOrDeviceid();
    Map<String, dynamic> params = {
      'isComplete': 1,
      'isFormated': 0,
      'isAll': 0,
      'userId': userId,
      'sportType': widget.sportType.value,
    };

    if (calendarDate.isNotEmpty) {
      params['date'] = calendarDate;
    } else if (dateStrArr.isNotEmpty) {
      params['date'] = dateStrArr[selectIdx];
    }

    // if (widget.matchStatus != MatchStatus.going) {
      params['status'] = matchStatusToServerValue(widget.matchStatus);
    // }

    // if (leagueIdArr.isNotEmpty) {
    //   params['leagueIds'] = leagueIdArr;
    //   params['filterType'] = conditionType.index;
    // } else if (conditionType != ConditionType.unknown) {
    //   params['filterType'] = conditionType.index;
    // }

    MatchStatus matchStatus = widget.matchStatus;

    if (loading) ToastUtils.showLoading();
    MatchService.requestMatchList(params, (success, result) {
      ToastUtils.hideLoading();

      if (success) {
        if (result != null) {
          var modelArrTmp = <MatchInfoModel>[];
          if (matchStatus == MatchStatus.uncoming) {
            modelArrTmp = result.uncoming?.matches ?? [];
          } else if (matchStatus == MatchStatus.finished) {
            modelArrTmp = result.finished?.matches ?? [];
          } else if (matchStatus == MatchStatus.going) {
            modelArrTmp = result.going?.matches ?? [];
          }

          // modelArr = processListCollectStatus(data: modelArrTmp);
          _dataArr = modelArrTmp;
        }
        if (_dataArr.isNotEmpty) {
          _layoutState = LoadStatusType.success;
        } else {
          _layoutState = LoadStatusType.empty;
        }
      } else {
        _layoutState = LoadStatusType.failure;
      }
      setState(() {});
    });
  }

  @override
  bool isAutomaticKeepAlive() {
    return true;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return LoadStateWidget(
        state: _layoutState,
        successWidget: ListView.builder(
            padding: const EdgeInsets.only(top: 3),
            itemCount: _dataArr.length,
            itemExtent: 105,
            itemBuilder: (context, index) {
              return _buildCellWidget(index);
            }));
  }

  _buildCellWidget(int idx) {
    MatchInfoModel model = _dataArr[idx];
    return Container(
      height: 105,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  model.leagueName,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 10.sp,
                      fontWeight: TextStyleUtils.medium),
                ),
              ),
              Text(
                "未",
                style: TextStyle(
                    color: ColorUtils.gray153,
                    fontSize: 10.sp,
                    fontWeight: TextStyleUtils.medium),
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  "02:30",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: ColorUtils.gray153,
                      fontSize: 10.sp,
                      fontWeight: TextStyleUtils.medium),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 0.5,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(253, 192, 200, 1.0),
                  Color.fromRGBO(200, 221, 253, 1.0),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.hostTeamName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 12.sp,
                          fontWeight: TextStyleUtils.semibold),
                    ),
                    Text(
                      model.guestTeamName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: ColorUtils.black34,
                          fontSize: 12.sp,
                          fontWeight: TextStyleUtils.semibold),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "-",
                    style: TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.medium),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: ColorUtils.gray153,
                        fontSize: 10.sp,
                        fontWeight: TextStyleUtils.medium),
                  ),
                ],
              ),
              SizedBox(
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    JhAssetImage("match/iconMatchVideo", width: 24.w),
                    SizedBox(width: 10.w),
                    Container(
                        width: 1,
                        height: 26,
                        color: Colors.black.withOpacity(0.1)),
                    SizedBox(width: 10.w),
                    JhAssetImage("match/iconMatchCollect", width: 20.w),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
