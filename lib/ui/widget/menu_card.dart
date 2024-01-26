import 'package:flutter/material.dart';

Widget menuCard(
  Image image,
  String title,
  String description,
  String text,
  Function()? onTap,
) => Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Column(
    children: [
      // 画像
      SizedBox(
        width: double.infinity,
        height: 200,
        child: image,
      ),

      // タイトル
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),

      // 説明
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),

      //ボタン
      Center(
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(text),
        ),
      ),
    ],
  ),
);