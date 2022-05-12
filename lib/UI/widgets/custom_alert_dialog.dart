import 'package:customers_phones_kev/const/const.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    required this.buttonColor,
    this.info = "",
  }) : super(key: key);

  final String title;
  final String description;
  final Icon icon;
  final Color buttonColor;
  String? info;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actionsAlignment:
            MainAxisAlignment
                .spaceEvenly,
        shape:
            RoundedRectangleBorder(
                borderRadius:
                    BorderRadius
                        .circular(
                            10)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: primaryWhiteColor),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                  "Cancelar", style: TextStyle(color: Colors.black54),)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: buttonColor
            ),
              onPressed: () {
                onTap();
                Navigator.pop(context);
              },
              child: Text(
                  title)),
        ],
        content: Column(
          mainAxisSize:
              MainAxisSize.min,
          children: [
            icon,
            Text(
              title,
              style:
                  titleStyle,
              textAlign: TextAlign
                  .center,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey.shade700),
                  children: [
                    TextSpan(
                        text:
                            "\n"+description +" ",),
                    TextSpan(
                        text:
                            title.toLowerCase()+(info==""?"":" ")+(info??"")+"?" ,style: subTitleStyle),
                  ]),
              textAlign: TextAlign
                  .center,
            )
          ],
        ));
  }
}