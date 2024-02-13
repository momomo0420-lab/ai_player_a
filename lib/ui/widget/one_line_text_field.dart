import 'package:flutter/material.dart';

enum SendButtonState {
  isLoading,
  isWaitingText,
  isWaitingRec,
  isRecording,
}

class OneLineTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String? _hint;
  final SendButtonState _sendButtonState;
  final Function(String)? _onChanged;
  final Function(String)? _onSend;
  final Function()? _onRec;
  final Function()? _onStop;

  const OneLineTextField({
    super.key,
    required TextEditingController controller,
    String? hint,
    required sendButtonState,
    Function(String)? onChanged,
    Function(String)? onSend,
    Function()? onRec,
    Function()? onStop,
  }): _controller = controller,
        _hint = hint,
        _sendButtonState = sendButtonState,
        _onChanged = onChanged,
        _onSend = onSend,
        _onRec = onRec,
        _onStop = onStop;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              enabled: (_sendButtonState != SendButtonState.isRecording),
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 1,
              maxLines: 4,
              controller: _controller,
              cursorColor: Colors.black,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: _hint,
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
              onChanged: _onChanged,
            ),
          ),

          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildButton() {
    Widget widget;

    switch(_sendButtonState) {
      case SendButtonState.isWaitingRec:
        widget = _buildMicButton();
        break;
      case SendButtonState.isLoading:
        widget = const CircularProgressIndicator();
        break;
      case SendButtonState.isWaitingText:
        widget = _buildSendButton();
        break;
      case SendButtonState.isRecording:
        widget = _buildStopButton();
        break;
    }
    return widget;
  }

  IconButton _buildMicButton() {
    return IconButton(
      onPressed: () {
        if(_onRec != null) _onRec!();
      },
      color: Colors.blue,
      icon: const Icon(
        Icons.mic,
      ),
    );
  }

  IconButton _buildStopButton() {
    return IconButton(
      onPressed: () {
        if(_onStop != null) _onStop!();
      },
      color: Colors.red,
      icon: const Icon(
        Icons.stop,
      ),
    );
  }

  IconButton _buildSendButton() {
    return IconButton(
      onPressed: () {
        if(_onSend != null) _onSend!(_controller.text);
        _controller.clear();
      },
      color: Colors.blue,
      icon: const Icon(
        Icons.send,
      ),
    );
  }
}
