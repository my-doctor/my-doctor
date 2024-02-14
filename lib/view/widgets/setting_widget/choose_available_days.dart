import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseAvailableDays extends StatefulWidget {
  final Function(List<String>) onChange;

  const ChooseAvailableDays({Key? key, required this.onChange}) : super(key: key);

  @override
  _ChooseAvailableDaysState createState() => _ChooseAvailableDaysState();
}

class _ChooseAvailableDaysState extends State<ChooseAvailableDays> {
  List<String> selectedDays = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Available Days:'.tr,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5,),
        Wrap(
          spacing: 8.0,runSpacing: 5,
          children: [
            _buildDayButton('Monday'.tr),
            _buildDayButton('Tuesday'.tr),
            _buildDayButton('Wednesday'.tr),
            _buildDayButton('Thursday'.tr),
            _buildDayButton('Friday'.tr),
            _buildDayButton('Saturday'.tr),
            _buildDayButton('Sunday'.tr),
          ],
        ),
      ],
    );
  }

  Widget _buildDayButton(String day) {
    bool isSelected = selectedDays.contains(day);

    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedDays.remove(day);
          } else {
            selectedDays.add(day);
          }
        });
        widget.onChange(selectedDays);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          day,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
