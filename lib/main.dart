import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Chrono your time manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chrono your time manager'),
      ),
      body: TableCalendar(
        locale: 'pl_PL',
        firstDay: DateTime.utc(2010, 10, 20),
        lastDay: DateTime.utc(2030, 10, 20),
        focusedDay: _focusedDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },

        // Calendar Header Styling
        headerStyle: const HeaderStyle(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          formatButtonTextStyle: TextStyle(color: Colors.red, fontSize: 16.0),
          formatButtonDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 28,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 28,
          ),
        ),

        // Calendar Days Styling
        daysOfWeekStyle: const DaysOfWeekStyle(
          // Weekend days color (Sat,Sun)
          weekendStyle: TextStyle(color: Colors.red),
        ),

        // Calendar Dates styling
        calendarStyle: const CalendarStyle(
          // Weekend dates color (Sat & Sun Column)
          weekendTextStyle: TextStyle(color: Colors.red),
          // highlighted color for today
          todayDecoration: BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
          // highlighted color for selected day
          selectedDecoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),

        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _calendarController = CalendarController();

  //   // Today
  //   final _selectedDay = DateTime.now();
  // }

  // // Basic interface
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //     ),
  //     body: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         _buildTableCalendar(),
  //         // Expanded(child: _buildEventList()),
  //       ],
  //     ),
  //   );
  // }

  // void _onDaySelected(DateTime day, DateTime day2) {
  //   print("CALLBACK: _onDaySelected");
  //   setState(() {
  //     // _selectedEvents = events;
  //   });
  // }

  // // Simple TableCalendar configuration (using Style)
  // Widget _buildTableCalendar() {
  //   return TableCalendar(
  //     focusedDay: DateTime.now(),
  //     firstDay: DateTime.utc(2010, 10, 20),
  //     lastDay: DateTime.utc(2030, 10, 20),
  //     calendarController: _calendarController,
  //     // events: _events,
  //     // holidays: _holidays,
  //     startingDayOfWeek: StartingDayOfWeek.monday,

  //     // Calendar Header Styling
  //     headerStyle: const HeaderStyle(
  //       titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
  //       decoration: BoxDecoration(
  //           color: Colors.deepPurple,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(10), topRight: Radius.circular(10))),
  //       formatButtonTextStyle: TextStyle(color: Colors.red, fontSize: 16.0),
  //       formatButtonDecoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(5.0),
  //         ),
  //       ),
  //       leftChevronIcon: Icon(
  //         Icons.chevron_left,
  //         color: Colors.white,
  //         size: 28,
  //       ),
  //       rightChevronIcon: Icon(
  //         Icons.chevron_right,
  //         color: Colors.white,
  //         size: 28,
  //       ),
  //     ),

  //     // Calendar Days Styling
  //     daysOfWeekStyle: const DaysOfWeekStyle(
  //       // Weekend days color (Sat,Sun)
  //       weekendStyle: TextStyle(color: Colors.red),
  //     ),

  //     // Calendar Dates styling
  //     calendarStyle: const CalendarStyle(
  //       // Weekend dates color (Sat & Sun Column)
  //       weekendTextStyle: TextStyle(color: Colors.red),
  //       // highlighted color for today
  //       todayDecoration: BoxDecoration(
  //         color: Colors.deepPurple,
  //         shape: BoxShape.circle,
  //       ),
  //       // highlighted color for selected day
  //       selectedDecoration: BoxDecoration(
  //         color: Colors.black,
  //         shape: BoxShape.circle,
  //       ),
  //     ),

  //     // Operating
  //     onDaySelected: _onDaySelected,
  //     // onVisibleDaysChanged: _onVisibleDaysChanged,
  //     // onCalendarCreated: _onCalendarCreated,
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.title),
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Card(
  //             margin: const EdgeInsets.all(10.0),
  //             elevation: 5.0,
  //             shape: const RoundedRectangleBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(10),
  //               ),
  //               side: BorderSide(color: Colors.black, width: 2.0),
  //             ),
  //             child: TableCalendar(
  //               focusedDay: DateTime.now(),
  //               firstDay: DateTime.utc(2010, 10, 20),
  //               lastDay: DateTime.utc(2030, 10, 20),
  //               calendarFormat: CalendarFormat.month,
  //               weekendDays: const [DateTime.sunday, 6],
  //               startingDayOfWeek: StartingDayOfWeek.monday,
  //               daysOfWeekHeight: 20.0,
  //               rowHeight: 40.0,
  //               // Calendar Header Styling
  //               headerStyle: const HeaderStyle(
  //                 titleTextStyle:
  //                     TextStyle(color: Colors.white, fontSize: 20.0),
  //                 decoration: BoxDecoration(
  //                     color: Colors.deepPurple,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(10),
  //                         topRight: Radius.circular(10))),
  //                 formatButtonTextStyle:
  //                     TextStyle(color: Colors.red, fontSize: 16.0),
  //                 formatButtonDecoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.all(
  //                     Radius.circular(5.0),
  //                   ),
  //                 ),
  //                 leftChevronIcon: Icon(
  //                   Icons.chevron_left,
  //                   color: Colors.white,
  //                   size: 28,
  //                 ),
  //                 rightChevronIcon: Icon(
  //                   Icons.chevron_right,
  //                   color: Colors.white,
  //                   size: 28,
  //                 ),
  //               ),
  //               // Calendar Days Styling
  //               daysOfWeekStyle: const DaysOfWeekStyle(
  //                 // Weekend days color (Sat,Sun)
  //                 weekendStyle: TextStyle(color: Colors.red),
  //               ),
  //               // Calendar Dates styling
  //               calendarStyle: const CalendarStyle(
  //                 // Weekend dates color (Sat & Sun Column)
  //                 weekendTextStyle: TextStyle(color: Colors.red),
  //                 // highlighted color for today
  //                 todayDecoration: BoxDecoration(
  //                   color: Colors.deepPurple,
  //                   shape: BoxShape.circle,
  //                 ),
  //                 // highlighted color for selected day
  //                 selectedDecoration: BoxDecoration(
  //                   color: Colors.black,
  //                   shape: BoxShape.circle,
  //                 ),
  //               ),
  //               selectedDayPredicate: (day) {
  //                 // as per the documentation 'selectedDayPredicate' needs to determine current selected day.
  //                 return (isSameDay(_selectedDay, day));
  //               },
  //               onDaySelected: (selectedDay, focusedDay) {
  //                 // as per the documentation
  //                 if (!isSameDay(selectedDay, focusedDay)) {
  //                   setState(() {
  //                     _selectedDay  = selectedDay;
  //                     _focusedDay  = focusedDay;
  //                   });
  //                 }
  //               },
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
