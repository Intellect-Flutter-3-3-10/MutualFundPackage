import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Define the CustomExpansionPanel class
class CustomExpansionPanel {
  final String header;
  final Widget body;
  final bool isExpanded;

  CustomExpansionPanel({
    required this.header,
    required this.body,
    this.isExpanded = true,
  });
}

class CustomExpansionPanelList extends StatefulWidget {
  final List<CustomExpansionPanel> panels;
  final bool expansionCallbackEnabled;
  final Color? headerColor;
  final Color? bodyColor;
  final double elevation;
  final Duration animationDuration;
  final TextStyle? headerTextStyle;

  const CustomExpansionPanelList({
    Key? key,
    required this.panels,
    this.expansionCallbackEnabled = true,
    this.headerColor,
    this.bodyColor,
    this.elevation = 2.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.headerTextStyle,
  }) : super(key: key);

  @override
  _CustomExpansionPanelListState createState() => _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  late List<CustomExpansionPanel> _panels;

  @override
  void initState() {
    super.initState();
    _panels = List<CustomExpansionPanel>.from(widget.panels);
  }

  @override
  void didUpdateWidget(CustomExpansionPanelList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.panels != oldWidget.panels) {
      _panels = List<CustomExpansionPanel>.from(widget.panels);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: widget.elevation,
      expandedHeaderPadding: EdgeInsets.zero,
      animationDuration: widget.animationDuration,
      expansionCallback: widget.expansionCallbackEnabled
          ? (int index, bool isExpanded) {
              setState(() {
                _panels[index] = CustomExpansionPanel(
                  header: _panels[index].header,
                  body: _panels[index].body,
                  isExpanded: !isExpanded,
                );
              });
            }
          : null,
      children: _panels.map<ExpansionPanel>(
        (CustomExpansionPanel panel) {
          return ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                color: widget.headerColor ?? Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.all(10.0), // Adjust padding as needed
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    panel.header,
                    style: widget.headerTextStyle ?? TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              );
            },
            body: Container(
              color: widget.bodyColor ?? Theme.of(context).scaffoldBackgroundColor,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(5.0), // Adjust padding as needed
              child: panel.body,
            ),
            isExpanded: panel.isExpanded,
          );
        },
      ).toList(),
    );
  }
}
