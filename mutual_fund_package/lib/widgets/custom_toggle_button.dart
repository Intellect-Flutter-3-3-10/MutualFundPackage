import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../my_app_exports.dart';

class CustomToggleButtons extends StatefulWidget {
  final List<String> buttonLabels;
  final ValueChanged<int>? onToggle;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final double borderRadius;
  final double spacing;
  final double buttonHeight;
  final double buttonWidth;
  final TextStyle? textStyle;
  final bool isOutlined;
  final bool isFittedBox;

  const CustomToggleButtons({
    Key? key,
    required this.buttonLabels,
    this.onToggle,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.black,
    this.borderRadius = AppDimens.appRadius6,
    this.spacing = 4.0,
    this.buttonHeight = 40.0,
    this.buttonWidth = 80.0,
    this.textStyle,
    this.isOutlined = false,
    this.isFittedBox = false,
  }) : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  int _selectedIndex = 0;

  void _onButtonTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onToggle != null) {
      widget.onToggle!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFittedBox
        ? FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.buttonLabels.length, (index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => _onButtonTap(index),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: widget.spacing / 1,
                    ),
                    height: widget.buttonHeight,
                    width: widget.buttonWidth,
                    decoration: BoxDecoration(
                        color: widget.isOutlined
                            ? Colors.transparent
                            : isSelected
                                ? widget.activeColor
                                : widget.inactiveColor,
                        borderRadius: BorderRadius.circular(widget.borderRadius),
                        border: Border.all(color: isSelected ? widget.activeColor : widget.inactiveColor)),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimens.appSpacing5,
                      ),
                      child: AutoSizeText(
                        widget.buttonLabels[index],
                        maxLines: 1,
                        style: widget.textStyle?.copyWith(
                              color: isSelected ? widget.activeTextColor : widget.inactiveTextColor,
                            ) ??
                            AppTextStyles.regular16(
                              color: isSelected ? widget.activeTextColor : widget.inactiveTextColor,
                            ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.buttonLabels.length, (index) {
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => _onButtonTap(index),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: widget.spacing / 1,
                  ),
                  height: widget.buttonHeight,
                  width: widget.buttonWidth,
                  decoration: BoxDecoration(
                      color: widget.isOutlined
                          ? Colors.transparent
                          : isSelected
                              ? widget.activeColor
                              : widget.inactiveColor,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      border: Border.all(color: isSelected ? widget.activeColor : widget.inactiveColor)),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimens.appSpacing5,
                    ),
                    child: AutoSizeText(
                      widget.buttonLabels[index],
                      maxLines: 1,
                      style: widget.textStyle?.copyWith(
                            color: isSelected ? widget.activeTextColor : widget.inactiveTextColor,
                          ) ??
                          AppTextStyles.regular16(
                            color: isSelected ? widget.activeTextColor : widget.inactiveTextColor,
                          ),
                    ),
                  ),
                ),
              );
            }),
          );
  }
}
