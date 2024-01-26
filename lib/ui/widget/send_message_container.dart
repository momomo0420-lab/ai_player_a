import 'package:flutter/material.dart';

Widget sendMessageContainer(
  BuildContext context,
  String message,
) => Container(
  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Column(
        children: [
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              message,
            ),
          ),
        ],
      ),
    ],
  ),
);