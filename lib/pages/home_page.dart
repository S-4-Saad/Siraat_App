import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:siraat/Themes/app_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


// 👇 Prayer data
final List<Map<String, dynamic>> prayers = [
  {
    'name': 'Fajr',
    'time': '04:36',
    'image': 'assets/icons/prayer.png',
  },
  {
    'name': 'Dhuhr',
    'time': '12:15',
    'image': 'assets/icons/prayer.png',
  },
  {
    'name': 'Asr',
    'time': '15:45',
    'image': 'assets/icons/prayer.png',
  },
  {
    'name': 'Maghrib',
    'time': '18:32',
    'image': 'assets/icons/prayer.png',
  },
  {
    'name': 'Isha',
    'time': '20:00',
    'image': 'assets/icons/prayer.png',
  },
];

class _MyHomePageState extends State<MyHomePage> {
  Set<int> selectedIndexes = {}; // ✅ Multi-selection support

  Widget buildPrayerTile({
    required String name,
    required String time,
    required String image,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  image,
                  height: 28,
                  width: 28,
                  fit: BoxFit.contain,
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
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
    String today = DateFormat('EEEE').format(now);
    var hijriDate = HijriCalendar.now();
    String hijriMonthName = hijriDate.getLongMonthName();
    String hijriDateString = "$hijriMonthName ${hijriDate.hDay} AH";
    String arabicDua = "اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا";

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                color: AppColors.darkgreen,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/design.png'),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Text(
                          today,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          hijriDateString,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .70,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            arabicDua,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: flutter.TextDirection.rtl,
                            softWrap: true,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 170,
            margin:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
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
                      const Icon(Icons.calendar_month,
                          color: Colors.white, size: 20),
                      Text(
                        formattedDate,
                        style:
                        const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.shield_moon_outlined,
                          color: Colors.white, size: 20),
                      Text(
                        hijriDateString,
                        style:
                        const TextStyle(fontSize: 18, color: Colors.white),
                      ),
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
          ),
        ],
      ),
    );
  }
}
