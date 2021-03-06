import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:todayfood/screens/history_view.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime(2020, 01, 07);
  EventList<Event> _markedDateMap = EventList()
    ..addAll(DateTime(2020, 01, 07), [
      Event(date: DateTime(2020, 01, 07), title: 'hi'),
      Event(date: DateTime(2020, 01, 07), title: 'hi')
    ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          if (_currentDate == date) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HistoryView();
            }));
          }
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        // customDayBuilder: (
        //   /// you can provide your own build function to make custom day containers
        //   bool isSelectable,
        //   int index,
        //   bool isSelectedDay,
        //   bool isToday,
        //   bool isPrevMonthDay,
        //   TextStyle textStyle,
        //   bool isNextMonthDay,
        //   bool isThisMonthDay,
        //   DateTime day,
        // ) {
        //   /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
        //   /// This way you can build custom containers for specific days only, leaving rest as default.

        //   // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
        //   // if (day.day == 15) {
        //   //   return Center(
        //   //     child: Icon(Icons.local_airport),
        //   //   );
        //   // } else {
        //   //   return null;
        //   // }
        // },
        isScrollable: false,
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }
}
