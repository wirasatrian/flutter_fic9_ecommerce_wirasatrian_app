import 'package:fic9_ecommerce_template_app/common/constants/colors.dart';
import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final FontWeight fontWeight;

  const RowText({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = ColorName.black,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: fontWeight,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: fontWeight,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
