import 'package:flutter/material.dart';

Widget recvMessageContainer(
  BuildContext context,
  String message,
) => Container(
  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const CircleAvatar(
        child: Text('AI'),
      ),
      const SizedBox(width: 5),

      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
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
