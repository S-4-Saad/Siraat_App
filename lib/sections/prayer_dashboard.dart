import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import '../Themes/app_colors.dart';

class PrayerSection extends StatefulWidget {
  const PrayerSection({super.key});

  @override
  State<PrayerSection> createState() => _PrayerSectionState();
}

class _PrayerSectionState extends State<PrayerSection> {
  Set<int> selectedIndexes = {};

  final List<Map<String, dynamic>> prayers = [
    {'name': 'Fajr', 'time': '04:36', 'image': 'assets/icons/prayer.png'},
    {'name': 'Dhuhr', 'time': '12:15', 'image': 'assets/icons/prayer.png'},
    {'name': 'Asr', 'time': '15:45', 'image': 'assets/icons/prayer.png'},
    {'name': 'Maghrib', 'time': '18:32', 'image': 'assets/icons/prayer.png'},
    {'name': 'Isha', 'time': '20:00', 'image': 'assets/icons/prayer.png'},
  ];

  Widget buildPrayerTile({
    required String name,
    required String time,
    required String image,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.darkgreen : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Image.asset(image, height: 28, width: 28),
                Text(time, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM,yyyy').format(now);
    var hijriDate = HijriCalendar.now();
    String hijriMonthName = hijriDate.getLongMonthName();
    String hijriDateString = "$hijriMonthName ${hijriDate.hDay} AH";

    return Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.only(top: 6, left: 6, right: 6),
            decoration: BoxDecoration(
              color: AppColors.darkgreen,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.calendar_month, color: Colors.white, size: 20),
                Text(formattedDate, style: const TextStyle(fontSize: 18, color: Colors.white)),
                const SizedBox(width: 10),
                const Icon(Icons.shield_moon_outlined, color: Colors.white, size: 20),
                Text(hijriDateString, style: const TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(prayers.length, (index) {
              final prayer = prayers[index];
              return buildPrayerTile(
                name: prayer['name'],
                time: prayer['time'],
                image: prayer['image'],
                isSelected: selectedIndexes.contains(index),
                onTap: () {
                  setState(() {
                    if (selectedIndexes.contains(index)) {
                      selectedIndexes.remove(index);
                    } else {
                      selectedIndexes.add(index);
                    }
                  });
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
