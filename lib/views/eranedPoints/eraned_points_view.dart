import 'package:flutter/material.dart';
import 'widgets/points_balance_card.dart';
import 'widgets/points_history_item.dart';

class EranedPointsView extends StatelessWidget {
  const EranedPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {
        'title': 'Purchase from "Living Room" collection',
        'date': '10/20/2025',
        'points': 500,
      },
      {
        'title': 'Discount on "Azure Blue" paint',
        'date': '10/18/2025',
        'points': -250,
      },
      {'title': 'Welcome Bonus', 'date': '10/16/2025', 'points': 1000},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Earned Points'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const PointsBalanceCard(balance: 1250),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'POINTS HISTORY',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return PointsHistoryItem(
                  title: item['title'] as String,
                  date: item['date'] as String,
                  points: item['points'] as int,
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
