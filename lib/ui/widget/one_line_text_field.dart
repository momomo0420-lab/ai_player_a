import 'package:flutter/material.dart';

Widget oneLineTextField({
  required TextEditingController controller,
  String? hint,
  bool isLoading = false,
  bool isSendable = true,
  Function(String)? onChanged,
  Function(String)? onSend,
}) => Container(
  color: Colors.white,
  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 4,
          controller: controller,
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),

      (isLoading)? const CircularProgressIndicator() :
      IconButton(
        icon: const Icon(
          Icons.send,
          size: 20,
        ),
        color: Colors.blue,
        onPressed: (isSendable) ? () {
          if(onSend == null) return;

          onSend(controller.text);
          controller.clear();
        } : null,
      ),
    ],
  ),
);
