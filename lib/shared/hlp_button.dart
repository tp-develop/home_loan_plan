import 'package:flutter/material.dart';

class HlpButton extends StatelessWidget {
  final String label;
  final Color? color;
  final void Function()? onPress;
  final bool? topLeftBorder;
  final bool? topRightBorder;
  final bool? bottomLeftBorder;
  final bool? bottomRightBorder;

  const HlpButton({
    Key? key,
    required this.label,
    this.color,
    this.onPress,
    this.bottomLeftBorder,
    this.bottomRightBorder,
    this.topLeftBorder,
    this.topRightBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftBorder == true ? 12 : 0),
              bottomLeft: Radius.circular(bottomLeftBorder == true ? 12 : 0),
              topRight: Radius.circular(topRightBorder == true ? 12 : 0),
              bottomRight: Radius.circular(bottomRightBorder == true ? 12 : 0),
            ),
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPress,
    );
  }
}
