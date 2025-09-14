import 'package:flutter/material.dart';

class AnimatedImage extends StatefulWidget {
  final String imagePath;
  const AnimatedImage({super.key, required this.imagePath});

  @override
  State<AnimatedImage> createState() => AnimatedImageState();
}

class AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust animation speed here
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Image.asset(
        widget.imagePath,
        height: 120,
        fit: BoxFit.contain,
      ),
    );
  }
}