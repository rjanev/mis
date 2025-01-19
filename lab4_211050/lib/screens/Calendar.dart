import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../models/Exam.dart';
import 'addExam.dart';
import 'map.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<Exam>> _dailyExams;
  DateTime _currentDay = DateTime.now();
  DateTime? _highlightedDay;
  CalendarFormat _calendarView = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _highlightedDay = _currentDay;
    _dailyExams = ValueNotifier(_fetchExamsForDay(_highlightedDay!));
  }

  @override
  void dispose() {
    _dailyExams.dispose();
    super.dispose();
  }

  List<Exam> _fetchExamsForDay(DateTime day) {
    return examSchedule[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _onDayPicked(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_highlightedDay, selectedDay)) {
      setState(() {
        _highlightedDay = selectedDay;
        _currentDay = focusedDay;
      });
      _dailyExams.value = _fetchExamsForDay(selectedDay);
    }
  }

  void _addNewExam(Exam exam) {
    setState(() {
      final key = DateTime(exam.dateTime.year, exam.dateTime.month, exam.dateTime.day);
      if (examSchedule[key] == null) {
        examSchedule[key] = [];
      }
      examSchedule[key]!.add(exam);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exam Schedule',
          style: TextStyle(fontSize: 20.0),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExam(onAddExam: _addNewExam),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              final allExams = examSchedule.values.expand((examList) => examList).toList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationMapScreen(
                    exams: allExams,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar<Exam>(
            firstDay: startDay,
            lastDay: endDay,
            focusedDay: _currentDay,
            calendarFormat: _calendarView,
            eventLoader: _fetchExamsForDay,
            selectedDayPredicate: (day) => isSameDay(_highlightedDay, day),
            onDaySelected: _onDayPicked,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onFormatChanged: (format) {
              if (_calendarView != format) {
                setState(() {
                  _calendarView = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _currentDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Exam>>(
              valueListenable: _dailyExams,
              builder: (context, exams, _) {
                if (exams.isEmpty) {
                  return const Center(
                    child: Text('No exams scheduled for this day.', style: TextStyle(fontSize: 16.0),),
                  );
                }
                return ListView.builder(
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            exam.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Location: ${exam.location}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Time: ${DateFormat.Hm().format(exam.dateTime)}',
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final startDay = DateTime(2000, 1, 1);
final endDay = DateTime(2025, 12, 31);

final Map<DateTime, List<Exam>> examSchedule = {
  DateTime(2025, 1, 20): [
    Exam(id: '1', name: 'Introduction to Data Science', location: 'Lab 12', dateTime: DateTime(2025, 1, 20, 12, 0), latitude: 42.0045, longitude: 21.4105,
    ),
    Exam(id: '2', name: 'Calculus', location: 'Lab 138', dateTime: DateTime(2025, 1, 20, 11, 0), latitude: 42.0039, longitude: 21.4093,
    ),
  ],
};
