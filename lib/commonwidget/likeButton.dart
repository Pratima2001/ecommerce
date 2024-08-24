import 'package:ecommerce1/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../data/models/productModule.dart';

class LikeButton extends StatefulWidget {
  Product product;

  LikeButton({super.key, required this.product});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<Color?>? _colorAnimation;
  ProductServices productServices = ProductServices();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    _colorAnimation =
        ColorTween(begin: Colors.grey, end: const Color(0xffFF6E6E)).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );
    getLike();
  }

  getLike() async {
    bool like =
        await productServices.checkDocumentExists(widget.product.id.toString());
    if (like) _toggleLike();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _animationController?.forward();
      } else {
        _animationController?.reverse();
      }
    });
    if (_isLiked) {
      productServices.addProductsInLike(widget.product);
    } else {
      productServices.removeProductFromLike(widget.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
        onPressed: () {},
        style: const NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
        ),
        padding: const EdgeInsets.all(7.0),
        child: GestureDetector(
          onTap: _toggleLike,
          child: Transform.scale(
            scale: _scaleAnimation?.value ?? 1.0,
            child: Icon(
              Icons.favorite,
              color: _colorAnimation?.value ?? Colors.grey,
              size: 20.0,
            ),
          ),
        ));
  }
}
