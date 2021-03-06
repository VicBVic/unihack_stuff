import 'package:flutter/material.dart';
import 'package:clean_our_cities/share_button.dart';
import 'package:clean_our_cities/going_button.dart';

import '../like_button.dart';


class PostButtons extends StatelessWidget {
  const PostButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).colorScheme.background,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          LikeButton(),
          GoingButton(),
          ShareButton(),
        ],
      ),
    );
  }
}
