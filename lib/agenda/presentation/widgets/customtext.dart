import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String texto, infotext;
  const CustomText({Key? key, required this.texto, required this.infotext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: RichText(
          text: TextSpan(
            text: '$texto: ',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black87),
            children: <TextSpan>[
              TextSpan(
                text: infotext,
                style: DefaultTextStyle.of(context).style,
              ),
            ],
          ),
        ));
  }
}
