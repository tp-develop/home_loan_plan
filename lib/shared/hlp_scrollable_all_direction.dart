import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';

class HlpScrollableAllDirection extends StatefulWidget {
  final Widget? child;
  const HlpScrollableAllDirection({Key? key, this.child}) : super(key: key);

  @override
  _HlpScrollableAllDirectionState createState() => _HlpScrollableAllDirectionState();
}

class _HlpScrollableAllDirectionState extends State<HlpScrollableAllDirection> {
  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController();
  final double width = 10;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AdaptiveScrollbar(
        controller: verticalScroll,
        width: width,
        scrollToClickDelta: 75,
        scrollToClickFirstDelay: 200,
        scrollToClickOtherDelay: 50,
        sliderDecoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
        sliderActiveDecoration: BoxDecoration(
            color: Color.fromRGBO(206, 206, 206, 100), borderRadius: BorderRadius.all(Radius.circular(12.0))),
        underColor: Colors.transparent,
        child: AdaptiveScrollbar(
          underSpacing: EdgeInsets.only(bottom: width),
          controller: horizontalScroll,
          width: width,
          position: ScrollbarPosition.bottom,
          sliderDecoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(12.0))),
          sliderActiveDecoration: BoxDecoration(
              color: Color.fromRGBO(206, 206, 206, 100), borderRadius: BorderRadius.all(Radius.circular(12.0))),
          underColor: Colors.transparent,
          child: SingleChildScrollView(
            controller: horizontalScroll,
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Container(
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
