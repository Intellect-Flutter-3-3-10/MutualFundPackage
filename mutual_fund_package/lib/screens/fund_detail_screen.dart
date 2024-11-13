import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intellect_mutual_fund/my_app_exports.dart';
import 'package:intellect_mutual_fund/widgets/charts/simple_line_chart.dart';

class FundDetailScreen extends StatefulWidget {
  const FundDetailScreen({super.key});

  @override
  State<FundDetailScreen> createState() => _FundDetailScreenState();
}

class _FundDetailScreenState extends State<FundDetailScreen> with UtilsMethod {
  bool isSaved = false;

  // for sip calculation
  bool isSip = true;

  double _value = 0.0;
  bool isSipSelected = false;

  void toggleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: AppString.fundDetails,
        action: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoute.searchScreen);
            },
            icon: Icon(
              Icons.search,
              color: UtilsMethod().getColorBasedOnTheme(context),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, constraint) {
          Size size = MediaQuery.of(context).size;
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.appHPadding,
                vertical: AppDimens.appVPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// fund stats details
                  _fundStatsView(constraints: constraint, size: size),

                  ///line chart
                  _lineChart(constraint: constraint, size: size),

                  const SizedBox(height: AppDimens.appSpacing10),

                  /// chart view duration button
                  _chartViewDurationButton(constraint: constraint, size: size),

                  const SizedBox(height: AppDimens.appSpacing10),

                  /// schema details panel
                  _schemaDetailsPanel(constraint: constraint, size: size),

                  const SizedBox(height: AppDimens.appSpacing10),

                  /// returns calculator
                  _returnsCalculatorPanel(constraint: constraint, size: size),

                  const SizedBox(height: AppDimens.appSpacing10),

                  /// returns and rankings

                  CustomExpansionPanelList(
                    headerColor: Colors.transparent,
                    elevation: 0.0,
                    panels: [
                      CustomExpansionPanel(
                        header: AppString.returnsAndRankings,
                        body: StatefulBuilder(
                          builder: (context, setState) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FittedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.appSpacing10),
                                  child: RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                                      children: [
                                        TextSpan(
                                          text: 'Total Investments ',
                                          style: AppTextStyles.regular12(),
                                        ),
                                        TextSpan(
                                          text: 'Rs 15,441',
                                          style: AppTextStyles.regular12(color: AppColor.lightAmber),
                                        ),
                                        TextSpan(
                                          text: ' with return of ',
                                          style: AppTextStyles.regular12(),
                                        ),
                                        TextSpan(
                                          text: '42.54%',
                                          style: AppTextStyles.regular12(color: AppColor.green),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "",
                                          style: AppTextStyles.regular14(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Total Value",
                                          textAlign: TextAlign.end,
                                          style: AppTextStyles.regular14(),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "Annualised Rtn%",
                                          textAlign: TextAlign.end,
                                          style: AppTextStyles.regular12(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "This Fund",
                                              textAlign: TextAlign.end,
                                              style: AppTextStyles.regular12(),
                                            ),
                                            SizedBox(height: 4),
                                            LinearProgressIndicator(
                                              value: 3 / 4,
                                              color: AppColor.lightAmber,
                                              backgroundColor: AppColor.grey300,
                                              // borderRadius: BorderRadius.circular(25),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: RichText(
                                          textAlign: TextAlign.end,
                                          text: TextSpan(
                                            text: '₹ ',
                                            style: AppTextStyles.regular14(),
                                            children: [
                                              TextSpan(
                                                text: "28,508.00",
                                                style: AppTextStyles.regular14(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "42.54 %",
                                          textAlign: TextAlign.end,
                                          style: AppTextStyles.regular14(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Category Average",
                                              textAlign: TextAlign.end,
                                              style: AppTextStyles.regular12(),
                                            ),
                                            SizedBox(height: 4),
                                            LinearProgressIndicator(
                                              value: 2 / 4,
                                              color: Colors.orange,
                                              backgroundColor: AppColor.grey300,

                                              // borderRadius: BorderRadius.circular(25),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: RichText(
                                          textAlign: TextAlign.end,
                                          text: TextSpan(
                                            text: '₹ ',
                                            style: AppTextStyles.regular14(),
                                            children: [
                                              TextSpan(
                                                text: "28,508.00",
                                                style: AppTextStyles.regular12(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "42.54 %",
                                          textAlign: TextAlign.end,
                                          style: AppTextStyles.regular14(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Benchmark",
                                              textAlign: TextAlign.end,
                                              style: AppTextStyles.regular12(),
                                            ),
                                            SizedBox(height: 4),
                                            LinearProgressIndicator(
                                              value: 2.5 / 4,
                                              color: AppColor.lightAmber,
                                              backgroundColor: AppColor.grey300,
                                              // borderRadius: BorderRadius.circular(25),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: RichText(
                                          textAlign: TextAlign.end,
                                          text: TextSpan(
                                            text: '₹ ',
                                            style: AppTextStyles.regular14(),
                                            children: [
                                              TextSpan(
                                                text: "28,508.00",
                                                style: AppTextStyles.regular14(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "42.54 %",
                                          textAlign: TextAlign.end,
                                          style: AppTextStyles.regular14(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimens.appSpacing10),

                  /// invest button
                  CommonOutlinedButton(
                    // borderColor: AppColor.lightAmber,
                    btnText: AppString.investNow,
                    onTap: () {
                      _showBottomSheet();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// fund stats view
  Widget _fundStatsView({BoxConstraints? constraints, Size? size}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: size!.height * 0.080,
                  width: size.width * 0.15,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.greyLightest.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(AppDimens.appRadius6)),
                ),
                SizedBox(
                  width: size.height * 0.010,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      'LIC MF Infrastructure Fund',
                      style: AppTextStyles.regular15(),
                      maxLines: 1,
                    ),
                    AutoSizeText(
                      '- Growth Plan',
                      style: AppTextStyles.regular13(),
                      maxLines: 1,
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            CustomChip(
                              label: 'Equity',
                            ),
                            SizedBox(
                              width: AppDimens.appSpacing10,
                            ),
                            CustomChip(
                              label: 'Mid Cap',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonIconButton(
                  onTap: toggleSave,
                  isSvg: false,
                  icon: isSaved ? Icons.bookmark : Icons.bookmark_border_outlined,
                  pictureIcon: AppImage.all,
                  iconColor: AppColor.blue,
                ),
                const ShowRatingWidget(
                  rating: '4',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: AppDimens.appSpacing10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.nav,
                  style: AppTextStyles.regular12(color: AppColor.greyLightest),
                ),
                Row(
                  children: [
                    Text(
                      "154",
                      style: AppTextStyles.semiBold15(),
                    ),
                    Text(
                      " ${AppString.rupees}0.23 (0.45%) ",
                      style: AppTextStyles.regular15(color: AppColor.green),
                    ),
                  ],
                ),
              ],
            ),
            const TitleAndValueWidget(
              isHorizontal: false,
              crossAxisAlignment: CrossAxisAlignment.end,
              title: AppString.oneYearReturn,
              value: '18.3%',
              valueColor: Colors.green,
            ),
          ],
        ),
        const SizedBox(height: AppDimens.appSpacing10),
      ],
    );
  }

  /// line chart
  Widget _lineChart({BoxConstraints? constraint, Size? size}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: constraint!.maxHeight * 0.35,
      width: constraint.maxHeight,
      child: CustomLineChart(
        belowBarGradientColors: isDark
            ? [
                AppColor.lightAmber,
                AppColor.lightestAmber,
                AppColor.black.withOpacity(0.2),
                AppColor.black,
              ]
            : [
                AppColor.lightestAmber,
                AppColor.lightestAmber,
                AppColor.offWhite,
                AppColor.white,
              ],
        isCurved: true,
        spots: const [
          FlSpot(0, 1),
          FlSpot(1, 1.5),
          FlSpot(2, 1.4),
          FlSpot(3, 3.4),
          FlSpot(4, 2),
          FlSpot(5, 2.8),
          FlSpot(6, 3.0),
        ],
      ),
    );
  }

  /// chart view duration button
  Widget _chartViewDurationButton({BoxConstraints? constraint, Size? size}) {
    return CustomToggleButtons(
      buttonLabels: const ['1D', '1W', '1M', '1Y', 'All'],
      onToggle: (index) {
        debugPrint('Selected Button Index: $index');
      },

      activeColor: AppColor.lightestAmber,
      inactiveColor: AppColor.white,
      activeTextColor: AppColor.greyLight,
      inactiveTextColor: AppColor.greyLight,
      // borderRadius: 12.0,
      spacing: 8.0,
      buttonHeight: constraint!.maxHeight * 0.045,
      buttonWidth: constraint.maxHeight * 0.070,
    );
  }

  /// schema details panel
  Widget _schemaDetailsPanel({BoxConstraints? constraint, Size? size}) {
    return CustomExpansionPanelList(
      bodyColor: Theme.of(context).scaffoldBackgroundColor,

      panels: [
        CustomExpansionPanel(
          header: AppString.schemaDetails,
          body: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == 5 - 1) {
                return CommonHeader(
                  title: 'Exit Load',
                  titleStyle: AppTextStyles.regular12(),
                  labelColor: AppColor.lightAmber,
                  labelOnTap: () {},
                  actionLabel: 'Click Here',
                );
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TitleAndValueWidget(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            title: 'Fund Type',
                            value: 'Open Ended',
                            valueStyle: AppTextStyles.semiBold14(),
                            titleStyle: AppTextStyles.regular12(),
                          ),
                          const Divider(
                            thickness: 0.8,
                            color: AppColor.greyLightest,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                        child: VerticalDivider(
                          thickness: 0.5,
                          width: 0.5,
                          color: AppColor.greyLightest,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleAndValueWidget(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            title: 'Benchmark',
                            value: 'Nifty 100 TRI',
                            valueStyle: AppTextStyles.semiBold14(),
                            titleStyle: AppTextStyles.regular12(),
                          ),
                          const Divider(
                            thickness: 0.8,
                            color: AppColor.greyLightest,
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 0.5,
                    color: AppColor.grey300,
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppDimens.appSpacing10,
              ),
            ),
            itemCount: 5,
          ),
        ),
      ],
      expansionCallbackEnabled: true,
      headerColor: Colors.transparent,
      // bodyColor: Colors.white,
      elevation: 0.0,
      animationDuration: const Duration(milliseconds: 500),
      // headerTextStyle: TextStyle(color: Colors.white, fontSize: 18),
    );
  }

  /// returns calculator view
  Widget _returnsCalculatorPanel({BoxConstraints? constraint, Size? size}) {
    return CustomExpansionPanelList(
      expansionCallbackEnabled: true,
      headerColor: Colors.transparent,
      // bodyColor: Colors.white,
      elevation: 0.0,
      animationDuration: const Duration(milliseconds: 500),
      panels: [
        CustomExpansionPanel(
          header: AppString.returnsCalculator,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CommonOutlinedButton(
                          borderColor: AppColor.lightAmber,
                          fgColor: isSip ? AppColor.black : UtilsMethod().getColorBasedOnTheme(context),
                          bgColor: isSip ? AppColor.lightestAmber : Theme.of(context).scaffoldBackgroundColor,
                          // Highlight based on `isSip`
                          btnText: AppString.sip,
                          onTap: () {
                            debugPrint("SIP");
                            setState(() {
                              isSip = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: AppDimens.appSpacing20,
                      ),
                      Expanded(
                        child: CommonOutlinedButton(
                          fgColor: !isSip ? AppColor.black : UtilsMethod().getColorBasedOnTheme(context),
                          borderColor: AppColor.lightAmber,
                          bgColor: !isSip ? AppColor.lightestAmber : Theme.of(context).scaffoldBackgroundColor,
                          // Highlight when `isSip` is false
                          btnText: AppString.lumpSum,
                          onTap: () {
                            debugPrint("Lumpsum");
                            setState(() {
                              isSip = false;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppDimens.appSpacing10),
              StatefulBuilder(
                builder: (context, setState) => CommonHeader(
                  title: '${AppString.rupees} ${_value.toStringAsFixed(0)}',
                  titleStyle: AppTextStyles.semiBold14(),
                  labelColor: AppColor.greyLightest,
                  actionLabel: AppString.monthlyOrLumpSum,
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return Slider(
                    min: 0.0,
                    max: 10000,
                    value: _value,
                    activeColor: AppColor.lightAmber,
                    inactiveColor: AppColor.grey300,
                    onChanged: (dynamic value) {
                      setState(() {
                        _value = value;
                      });
                      debugPrint("$_value");
                    },
                  );
                },
              ),
              const SizedBox(
                width: AppDimens.appSpacing20,
              ),
              CommonHeader(
                title: AppString.selectDuration,
                titleStyle: AppTextStyles.regular12(),
                isActionLabel: false,
                labelColor: AppColor.greyLightest,
                actionLabel: AppString.monthlyOrLumpSum,
              ),
              const SizedBox(height: AppDimens.appSpacing10),
              CustomToggleButtons(
                buttonLabels: const ['1 M', '3 M', '6 M', '1 Y', '2 Y', '3 Y'],
                onToggle: (index) {
                  debugPrint('Selected Button Index: $index');
                },
                isOutlined: true,
                isFittedBox: true,

                activeColor: AppColor.lightestAmber,
                inactiveColor: AppColor.white,
                activeTextColor: UtilsMethod().getColorBasedOnTheme(context),
                inactiveTextColor: AppColor.greyLightest,
                // borderRadius: 12.0,
                spacing: 8.0,
                buttonHeight: constraint!.maxHeight * 0.045,
                buttonWidth: constraint.maxHeight * 0.070,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showBottomSheet() {
    debugPrint("bottom sheet");
    UtilsMethod().showBottomSheet(
        context: context,
        child: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CommonOutlinedButton(
                    btnText: AppString.investWithSip,
                    onTap: () {
                      debugPrint("SIP");
                      setState(() {
                        isSipSelected = true;
                      });
                      Get.back(closeOverlays: true);
                      Get.toNamed(
                        AppRoute.orderPlacementScreen,
                        arguments: OrderPlacementScreenArgs(isSip: isSipSelected),
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppDimens.appHPadding),
                Expanded(
                  child: CommonOutlinedButton(
                    btnText: AppString.lumpSum,
                    onTap: () {
                      debugPrint("Lumpsum");
                      setState(() {
                        isSipSelected = false;
                      });
                      Get.back(closeOverlays: true);
                      Get.toNamed(
                        AppRoute.orderPlacementScreen,
                        arguments: OrderPlacementScreenArgs(isSip: isSipSelected),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.appVPadding),
            AutoSizeText(
              AppString.sipDesc,
              style: AppTextStyles.regular13(),
            )
          ],
        ));
  }
}
