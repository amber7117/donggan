import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wzty/app/app.dart';
import 'package:wzty/modules/match/widget/calendar/utils.dart';
import 'package:wzty/utils/color_utils.dart';
import 'package:wzty/utils/text_style_utils.dart';

class MatchCalendarWidget extends StatefulWidget {
  final WZAnyCallback<String> callback;

  const MatchCalendarWidget({super.key, required this.callback});

  @override
  State createState() => _MatchCalendarWidgetState();
}

class _MatchCalendarWidgetState extends State<MatchCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    double marginY = (popContentHeight() - 404.0) * 0.5;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: marginY),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(26))),
        child: Column(
          children: [
            TableCalendar(
              firstDay: kFirstDay,
              lastDay: kLastDay,
              // locale: Intl.defaultLocale,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
              },
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                todayTextStyle: const TextStyle(
                  color: ColorUtils.red233,
                  fontSize: 16.0,
                ),
                todayDecoration: const BoxDecoration(
                  color: Color.fromRGBO(250, 240, 242, 1),
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(
                  color: ColorUtils.red233,
                  fontSize: 16.0,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1.0,
                    color: ColorUtils.red233,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 122,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(250, 250, 250, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextButton(
                      child: const Text('取消',
                          style: TextStyle(
                              color: Color.fromRGBO(102, 102, 102, 1.0),
                              fontSize: 16,
                              fontWeight: TextStyleUtils.regual)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Container(
                  width: 122,
                  height: 40,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorUtils.red233,
                          ColorUtils.red217,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextButton(
                      child: const Text('确认',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: TextStyleUtils.regual)),
                      onPressed: () {
                        if (_selectedDay != null) {
                          String formattedTime =
                              DateFormat('yyyy-MM-dd').format(_selectedDay!);
                          widget.callback(formattedTime);

                          Navigator.pop(context);
                        }
                      }),
                ),
              ],
            ),
          ],
        ));
  }
}
