import 'package:flutter/material.dart';

class PromptBox extends StatefulWidget {
  Function(String) getPrompt;

  PromptBox({super.key, required this.getPrompt});

  @override
  State<PromptBox> createState() => _PromptBoxState();
}

class _PromptBoxState extends State<PromptBox> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            minLines: 1,
            maxLines: 5,
            autocorrect: false,
            style: const TextStyle(color: Colors.deepOrangeAccent),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                hintText: "Enter your prompt",
                hintStyle: TextStyle(
                    color: Colors.deepOrange.shade200,
                    fontSize: 18,
                    height: 0.9),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(19)))),
            onSubmitted: (value) {
              submitPrompt();
            },
          )),
          SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
                onPressed: () {
                  submitPrompt();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.deepPurpleAccent,
                )),
          )
        ],
      ),
    );
  }

  submitPrompt() {
    widget.getPrompt(_controller.text);
    _controller.text = "";
  }
}
