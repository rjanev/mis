import 'package:flutter/material.dart';
import '../models/Exam.dart';

class AddExam extends StatefulWidget {
  final Function(Exam) onAddExam;

  const AddExam({Key? key, required this.onAddExam}) : super(key: key);

  @override
  State<AddExam> createState() => _AddExamState();
}

class _AddExamState extends State<AddExam> {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add exam'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(controller: nameController,
              label: 'Exam subject',
              icon: Icons.subject,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: locationController,
              label: 'Location',
              icon: Icons.location_on,
            ),
            const SizedBox(height: 10),
            CustomTextField(controller: latitudeController,
              label: 'Latitude',
              icon: Icons.explore,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomTextField(controller: longitudeController,
              label: 'Longitude',
              icon: Icons.map,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _dateTime,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDateTime == null ? 'Select Date & Time' : '${_selectedDateTime!.toLocal()}'.split('.')[0],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _addExam,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text(
                'Add Exam',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dateTime() async {
    try {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );

      if (pickedDate == null) return;

      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick date and time: $e')),
      );
    }
  }

  void _addExam() {
    final name = nameController.text.trim();
    final location = locationController.text.trim();
    final latitude = double.tryParse(latitudeController.text);
    final longitude = double.tryParse(longitudeController.text);

    if (name.isEmpty || location.isEmpty || latitude == null || longitude == null || _selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final exam = Exam(
      id: DateTime.now().toString(),
      name: name,
      location: location,
      dateTime: _selectedDateTime!,
      latitude: latitude,
      longitude: longitude,
    );

    widget.onAddExam(exam);
    Navigator.pop(context);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blue[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
        ),
      ),
    );
  }
}
