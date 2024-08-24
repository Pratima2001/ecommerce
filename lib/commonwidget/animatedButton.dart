import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  Function onTap;
  bool isCompleted;
  bool isProcessing;
  AnimatedButton(
      {super.key,
      required this.onTap,
      required this.isCompleted,
      required this.isProcessing});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        duration: const Duration(seconds: 1),
        width: widget.isProcessing
            ? 60.0
            : (widget.isCompleted ? 60.0 : 200.0), // Adjust width
        height: 50.0,
        decoration: BoxDecoration(
          color: widget.isProcessing
              ? Colors.black
              : (widget.isCompleted ? Colors.green : Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: widget.isProcessing
            ? const SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : widget.isCompleted
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40.0,
                  )
                : const Text(
                    'Continue to Payment',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
      ),
    );
  }
}
