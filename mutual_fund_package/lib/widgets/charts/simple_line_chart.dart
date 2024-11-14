import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mutual_fund_package/my_app_exports.dart';

class CustomLineChart extends StatelessWidget {
  final List<FlSpot>? spots;
  final bool isCurved;
  final bool showDots;
  final Color? lineColor;
  final List<Color>? belowBarGradientColors;

  const CustomLineChart({
    super.key,
    this.spots,
    this.isCurved = false,
    this.showDots = false,
    this.lineColor = AppColor.lightAmber,
    this.belowBarGradientColors = const [
      AppColor.lightestAmber,
      AppColor.offWhite,
      AppColor.offWhite,
      AppColor.offWhite,
      AppColor.white,
    ],
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            dotData: FlDotData(show: showDots),
            spots: spots ??
                const [
                  FlSpot(0, 1),
                  FlSpot(1, 1.5),
                  FlSpot(2, 1.4),
                  FlSpot(3, 3.4),
                  FlSpot(4, 2),
                  FlSpot(5, 2.8),
                  FlSpot(6, 3.0),
                ],
            // Default spots if no spots are provided
            isCurved: isCurved,
            color: lineColor,
            barWidth: 1,
            isStrokeCapRound: true,
            belowBarData: BarAreaData(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: belowBarGradientColors ??
                    [
                      AppColor.lightestAmber,
                      AppColor.offWhite,
                      AppColor.offWhite,
                      AppColor.offWhite,
                      AppColor.white,
                    ], // Default gradient if not provided
              ),
              show: true,
            ),
          ),
        ],
        titlesData: FlTitlesData(show: false),
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.transparent,
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
